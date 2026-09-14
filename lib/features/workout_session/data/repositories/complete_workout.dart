import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/app_database.dart';
import '../../../authentication/data/session_controller.dart';
import '../../../achievements/domain/entities/achievement.dart';
import '../../../achievements/domain/entities/badge.dart';
import '../../../challenges/domain/entities/challenge.dart';
import '../../../leveling/domain/entities/xp_transaction.dart';
import '../../../leveling/domain/repositories/progression_repository.dart';
import '../../../leveling/domain/services/progression_rules.dart';
import '../../../personal_records/domain/entities/personal_record.dart';
import '../../domain/entities/workout_completion.dart';
import '../../domain/entities/workout_session.dart';
import '../../domain/repositories/workout_session_repository.dart';
import '../../domain/services/xp_policy.dart';
import '../../../progress/data/datasources/daos.dart';
import '../../../workouts/data/models/workout_mappers.dart';

/// Finishing a workout triggers the whole progression cascade in one
/// atomic use case:
///
///   PR detection → streak update → challenge evaluation →
///   achievement evaluation → badge grants → XP ledger entries
///   (idempotent per workout+source) → level/rank snapshot.
///
/// The UI receives one typed [WorkoutCompletionResult] to render summary,
/// level-up, rank-up, achievement, and share flows.
class CompleteWorkout {
  CompleteWorkout({
    required WorkoutSessionRepository sessionRepository,
    required ProgressionRepository progressionRepository,
    required ProgressionWriteRepository progressionWriteRepository,
    required AppDatabase db,
    ProgressionRules rules = const ProgressionRules(),
    XpPolicy xpPolicy = const XpPolicy(),
    Uuid? uuid,
    SessionController? session,
  })  : _sessions = sessionRepository,
        _progression = progressionRepository,
        _progressionWrite = progressionWriteRepository,
        _db = db, // ignore: prefer_initializing_formals
        _rules = rules, // ignore: prefer_initializing_formals
        _xp = xpPolicy,
        _uuid = uuid ?? const Uuid(),
        _session = session; // ignore: prefer_initializing_formals

  final WorkoutSessionRepository _sessions;
  final ProgressionRepository _progression;
  final ProgressionWriteRepository _progressionWrite;
  final AppDatabase _db;
  final ProgressionRules _rules;
  final XpPolicy _xp;
  final Uuid _uuid;
  final SessionController? _session;

  /// Live user id; falls back to the legacy device row when signed out.
  String get _userId => _session?.userId ?? 'local-user';

  Future<Either<Failure, WorkoutCompletionResult>> call(WorkoutSession session) =>
      guard(() async {
        // Idempotency: if the base reward was already claimed for this
        // workout, return the recorded outcome without double-awarding.
        final alreadyClaimed = await _progression.isXpClaimed(
            session.id, XpSource.workoutCompleted);
        if (alreadyClaimed.getOrElse(() => false)) {
          return _replayCompletion(session);
        }

        final completed = await _sessions.complete(session).then(
              (r) => r.getOrElse(() => throw const CacheFailure('Could not save session')),
            );

        // 1. Personal records (before any rewards reference them).
        final newRecords = await _evaluatePersonalRecords(completed);

        // 2. Streak + training-day log.
        final streakInfo = await _updateStreakAndTrainingDay(completed);

        // 3. Challenges.
        final (challengeCompletions, challengeXp) = await _evaluateChallenges(completed, streakInfo);

        // 4. Achievements + badges.
        final (unlocked, newBadges) = await _evaluateAchievements(completed, newRecords, streakInfo);

        // 5. XP ledger — one entry per source, all tied to workoutId for
        //    idempotency.
        final lines = <XpLine>[];
        // `duplicate` is only true on replay path, where rewards were already claimed.
        const duplicate = false;

        Future<void> award(String label, int amount, XpSource source) async {
          if (amount <= 0) return;
          final txn = XpTransaction(
            id: _uuid.v4(),
            userId: _userId,
            amount: amount,
            source: source,
            description: label,
            workoutId: session.id,
            createdAt: DateTime.now(),
          );
          final result = await _progressionWrite.grantXp(txn);
          result.fold(
            (f) => throw f,
            (r) => lines.add(XpLine(label: label, amount: amount, source: source)),
          );
        }

        // Base rewards.
        await award('Workout Completed', _xp.workoutCompleted, XpSource.workoutCompleted);
        if (completed.wasScheduled == true) {
          await award('Scheduled Workout', _xp.scheduledWorkoutBonus, XpSource.scheduledWorkout);
        }
        if (completed.everyPlannedExerciseCompleted) {
          await award('Full Routine Completed', _xp.fullRoutineBonus, XpSource.workoutCompleted);
        }
        if (newRecords.isNotEmpty) {
          await award('Personal Record ×${newRecords.length}',
              _xp.personalRecordXp * newRecords.length, XpSource.personalRecord);
        }
        if (_xp.isLongWorkout(completed.duration.inMinutes)) {
          await award('Long Workout', _xp.longWorkoutBonus, XpSource.workoutCompleted);
        }
        for (final (title, reward) in challengeCompletions) {
          await award(title, reward, reward >= 750
              ? XpSource.monthlyChallenge
              : reward >= 250 ? XpSource.weeklyChallenge : XpSource.dailyChallenge);
        }
        if (streakInfo.milestone != null) {
          final reward = _xp.streakReward(streakInfo.milestone!) ?? 0;
          await award('${streakInfo.milestone}-Day Streak', reward, XpSource.streak);
        }
        for (final a in unlocked) {
          await award('Achievement: ${a.name}', a.xpReward, XpSource.achievement);
        }

        // 6. Final progression snapshot.
        final after = await _progression.getProgression().then(
              (r) => r.getOrElse(() => throw const CacheFailure()),
            );

        // Persist summary fields on the session row.
        final totalXp = lines.fold<int>(0, (sum, l) => sum + l.amount);
        await _sessions.save(completed.copyWith(
          xpEarned: totalXp,
          personalRecords: newRecords.length,
        ));

        return WorkoutCompletionResult(
          session: completed,
          xpLines: lines,
          totalXp: totalXp,
          progressionAfter: after,
          levelUps: _rules.levelForLifetimeXp(after.lifetimeXp - totalXp) != after.level
              ? after.level - _rules.levelForLifetimeXp(after.lifetimeXp - totalXp)
              : 0,
          rankBefore:
              _rules.rankForLevel(_rules.levelForLifetimeXp(after.lifetimeXp - totalXp)).name,
          rankAfter: after.rank.name,
          newRecords: newRecords,
          unlockedAchievements: unlocked,
          newBadges: newBadges,
          completedChallenges: const [],
          streakAfter: streakInfo.current,
          streakMilestone: streakInfo.milestone,
          duplicate: duplicate,
        );
      });

  // ---------------------------------------------------------------- PRs

  Future<List<PersonalRecord>> _evaluatePersonalRecords(WorkoutSession session) async {
    final newRecords = <PersonalRecord>[];
    for (final exercise in session.exercises) {
      final best = exercise.completedSets
          .where((s) => s.weightKg > 0)
          .fold<WorkoutSet?>(null, (best, s) {
        if (best == null) return s;
        // Heaviest set wins; ties broken by estimated 1RM.
        return s.weightKg > best.weightKg ? s : s.estimatedOneRm > best.estimatedOneRm ? s : best;
      });
      if (best == null) continue;

      final existing = await (_db.select(_db.personalRecords)
            ..where((p) =>
                p.userId.equals(_userId) &
                p.exerciseId.equals(exercise.exercise.id) &
                p.type.equals('heaviestWeight'))
            ..orderBy([(p) => OrderingTerm.desc(p.value)])
            ..limit(1))
          .getSingleOrNull();

      final newWeight = best.weightKg;
      final previous = existing?.value;

      if (existing == null || newWeight > existing.value) {
        final record = PersonalRecord(
          id: _uuid.v4(),
          userId: _userId,
          exerciseId: exercise.exercise.id,
          exerciseName: exercise.exercise.name,
          type: PersonalRecordType.heaviestWeight,
          value: newWeight,
          weightKg: newWeight,
          reps: best.reps,
          previousValue: previous,
          achievedAt: DateTime.now(),
          workoutSessionId: session.id,
        );
        await _db.into(_db.personalRecords).insert(record.toCompanion());
        newRecords.add(record);
        final user = await _db.userDao.getUser(_userId);
        await _db.userDao.applyWorkoutCompletion(
            user.copyWith(personalRecordsCount: user.personalRecordsCount + 1));
      }
    }
    return newRecords;
  }

  // ----------------------------------------------------------- Streaks

  Future<({int current, int? milestone, bool newLongest})> _updateStreakAndTrainingDay(
    WorkoutSession session,
  ) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final existingDay = await _db.trainingStatsDao.trainingDay(_userId, today);
    final volume = session.totalVolume;
    final sets = session.totalSets;
    final seconds = session.duration.inSeconds;

    final muscles = session.exercises
        .map((e) => e.exercise.primaryMuscle.name)
        .toSet()
        .join(',');

    final dayRow = TrainingDayRow(
      userId: _userId,
      date: today,
      workoutCount: (existingDay?.workoutCount ?? 0) + 1,
      setsCompleted: (existingDay?.setsCompleted ?? 0) + sets,
      volumeKg: (existingDay?.volumeKg ?? 0) + volume,
      trainingSeconds: (existingDay?.trainingSeconds ?? 0) + seconds,
      isScheduledRest: existingDay?.isScheduledRest ?? false,
      routineIdsCsv: '${existingDay?.routineIdsCsv ?? ''}${existingDay == null || existingDay.routineIdsCsv.isEmpty ? '' : ','}${session.routineId}',
      muscleGroupsCsv: existingDay?.muscleGroupsCsv == null || existingDay!.muscleGroupsCsv.isEmpty
          ? muscles
          : '${existingDay.muscleGroupsCsv},$muscles',
    );
    await _db.trainingStatsDao.upsertTrainingDay(dayRow);

    // Update denormalized user totals.
    final user = await _db.userDao.getUser(_userId);
    await _db.userDao.applyWorkoutCompletion(user.copyWith(
      totalWorkouts: user.totalWorkouts + 1,
      totalVolumeKg: user.totalVolumeKg + volume,
      totalTrainingSeconds: user.totalTrainingSeconds + seconds,
      
      spotifyWorkouts: user.spotifyWorkouts + (session.spotifyUsed ? 1 : 0),
      spotifyTracksPlayed:
          user.spotifyTracksPlayed + (session.spotifyTracksPlayed),
      playlistWorkouts: user.playlistWorkouts + (session.playlistUsed ? 1 : 0),
    ));

    // Recompute streak from the calendar.
    final state = await _db.trainingStatsDao.streakState(_userId);
    final userRow = await _db.userDao.getUser(_userId);
    await _db.userDao.applyWorkoutCompletion(userRow.copyWith(
      currentStreak: state.current,
      longestStreak: state.longest > userRow.longestStreak ? state.longest : userRow.longestStreak,
    ));

    final milestones = _xp.streakMilestones.keys.toList()..sort();
    final hit = milestones.contains(state.current) ? state.current : null;

    return (current: state.current, milestone: hit, newLongest: state.longest > userRow.longestStreak);
  }

  // ------------------------------------------------------- Challenges

  Future<(List<(String, int)>, int)> _evaluateChallenges(
    WorkoutSession session,
    StreakInfo streakInfo,
  ) async {
    final completions = <(String, int)>[];
    var totalChallengeXp = 0;

    final selections = _challengeSelection();
    for (final def in selections) {
      final periodKey = _periodKeyFor(def.period);
      final existing = await _db.challengeDao.activeForUser(_userId, periodKey);
      final row = existing.firstWhere(
        (c) => c.challengeId == def.id,
        orElse: () => ChallengeProgressRow(
          challengeId: def.id,
          userId: _userId,
          periodKey: periodKey,
          current: 0,
          claimed: false,
        ),
      );

      final progress = _challengeProgressFor(def, session, streakInfo, row.current);
      final nowClaimed = row.claimed || progress >= def.target;

      await _db.challengeDao.upsert(ChallengeProgressRow(
        challengeId: def.id,
        userId: _userId,
        periodKey: periodKey,
        current: progress,
        claimed: nowClaimed,
        completedAt: nowClaimed && !row.claimed ? DateTime.now() : row.completedAt,
      ));

      if (nowClaimed && !row.claimed) {
        completions.add((def.title, def.xpReward));
        totalChallengeXp += def.xpReward;
        // Count challenge completion on user row.
        final user = await _db.userDao.getUser(_userId);
        await _db.userDao.applyWorkoutCompletion(
            user.copyWith(challengesCompleted: user.challengesCompleted + 1));
      }
    }
    return (completions, totalChallengeXp);
  }

  int _challengeProgressFor(
    ChallengeDefinition def,
    WorkoutSession session,
    StreakInfo streakInfo,
    int current,
  ) {
    switch (def.metric) {
      case ChallengeMetric.completeWorkout:
      case ChallengeMetric.scheduledWorkoutsCompleted:
        return current + 1;
      case ChallengeMetric.totalSets:
        return current + session.totalSets;
      case ChallengeMetric.trainingMinutes:
        return current + session.duration.inMinutes;
      case ChallengeMetric.distinctExercises:
        return current +
            session.exercises.where((e) => e.completedSets.isNotEmpty).length;
      case ChallengeMetric.beatPreviousVolume:
        return current; // evaluated lazily by dashboard; keep as-is
      default:
        return current;
    }
  }

  List<ChallengeDefinition> _challengeSelection() {
    // Deterministic rotation: one per period, stable within its window.
    final now = DateTime.now();
    return [
      dailyChallenges[now.difference(DateTime(now.year)).inDays % dailyChallenges.length],
      weeklyChallenges[now.difference(DateTime(now.year, now.month, 1)).inDays ~/ 7 % weeklyChallenges.length],
      monthlyChallenges[now.month % monthlyChallenges.length],
    ];
  }

  String _periodKeyFor(ChallengePeriod period) {
    final now = DateTime.now();
    switch (period) {
      case ChallengePeriod.daily:
        return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      case ChallengePeriod.weekly:
        final monday = now.subtract(Duration(days: now.weekday - 1));
        return '${monday.year}-W${_weekNumber(monday).toString().padLeft(2, '0')}';
      case ChallengePeriod.monthly:
        return '${now.year}-${now.month.toString().padLeft(2, '0')}';
    }
  }

  int _weekNumber(DateTime date) {
    final jan1 = DateTime(date.year, 1, 1);
    return ((date.difference(jan1).inDays + jan1.weekday - 1) ~/ 7) + 1;
  }

  // ---------------------------------------------------- Achievements

  Future<(List<AchievementDefinition>, List<BadgeDefinition>)> _evaluateAchievements(
    WorkoutSession session,
    List<PersonalRecord> newRecords,
    StreakInfo streakInfo,
  ) async {
    final user = await _db.userDao.getUser(_userId);
    final unlocked = <AchievementDefinition>[];
    final newBadges = <BadgeDefinition>[];

    for (final def in defaultAchievements) {
      final value = switch (def.metric) {
        AchievementMetric.totalWorkouts => user.totalWorkouts,
        AchievementMetric.personalRecords => user.personalRecordsCount,
        AchievementMetric.longestStreak => user.longestStreak,
        AchievementMetric.currentStreak => user.currentStreak,
        AchievementMetric.spotifyWorkouts => user.spotifyWorkouts,
        AchievementMetric.tracksDuringWorkouts => user.spotifyTracksPlayed,
        AchievementMetric.playlistWorkouts => user.playlistWorkouts,
        AchievementMetric.totalVolumeKg => user.totalVolumeKg.toInt(),
        _ => 0,
      };

      final existing = await (_db.select(_db.userAchievements)
            ..where((a) => a.userId.equals(_userId) & a.achievementId.equals(def.id))
            ..limit(1))
          .getSingleOrNull();

      final nowUnlocked = existing?.unlocked ?? value >= def.threshold;
      final wasUnlocked = existing?.unlocked ?? false;

      if (existing == null) {
        await _db.into(_db.userAchievements).insert(UserAchievementsCompanion.insert(
              achievementId: def.id,
              userId: _userId,
              progress: Value(value),
              unlocked: Value(nowUnlocked),
              unlockedAt: Value(nowUnlocked ? DateTime.now() : null),
            ));
      } else {
        await (_db.update(_db.userAchievements)
              ..where((a) =>
                  a.userId.equals(_userId) & a.achievementId.equals(def.id)))
            .write(UserAchievementsCompanion(
              progress: Value(value),
              unlocked: Value(nowUnlocked),
              unlockedAt: Value(nowUnlocked && !wasUnlocked ? DateTime.now() : existing.unlockedAt),
            ));
      }

      if (nowUnlocked && !wasUnlocked) {
        unlocked.add(def);
        if (def.badgeId != null) {
          final badge = defaultBadges.firstWhere((b) => b.id == def.badgeId);
          final already = await (_db.select(_db.userBadges)
                ..where((b) => b.userId.equals(_userId) & b.badgeId.equals(badge.id))
                ..limit(1))
              .getSingleOrNull();
          if (already == null) {
            await _db.into(_db.userBadges).insert(UserBadgesCompanion.insert(
                  badgeId: badge.id,
                  userId: _userId,
                  earnedAt: DateTime.now(),
                ));
            newBadges.add(badge);
          }
        }
      }
    }

    // Rank/level badges.
    if (user.level >= 50) {
      await _grantBadge('badge_rank_diamond', newBadges);
    }
    if (user.level >= 100) {
      await _grantBadge('badge_rank_legend', newBadges);
    }

    return (unlocked, newBadges);
  }

  Future<void> _grantBadge(String badgeId, List<BadgeDefinition> newBadges) async {
    final already = await (_db.select(_db.userBadges)
          ..where((b) => b.userId.equals(_userId) & b.badgeId.equals(badgeId))
          ..limit(1))
        .getSingleOrNull();
    if (already == null) {
      await _db.into(_db.userBadges).insert(UserBadgesCompanion.insert(
            badgeId: badgeId,
            userId: _userId,
            earnedAt: DateTime.now(),
          ));
      newBadges.add(defaultBadges.firstWhere((b) => b.id == badgeId));
    }
  }

  // -------------------------------------------------------- Replay

  Future<WorkoutCompletionResult> _replayCompletion(WorkoutSession session) async {
    final after = await _progression.getProgression().then(
          (r) => r.getOrElse(() => throw const CacheFailure()),
        );
    return WorkoutCompletionResult(
      session: session,
      xpLines: const [],
      totalXp: session.xpEarned ?? 0,
      progressionAfter: after,
      levelUps: 0,
      rankBefore: after.rank.name,
      rankAfter: after.rank.name,
      newRecords: const [],
      unlockedAchievements: const [],
      newBadges: const [],
      completedChallenges: const [],
      streakAfter: after.currentStreak,
      streakMilestone: null,
      duplicate: true,
    );
  }
}

typedef StreakInfo = ({int current, int? milestone, bool newLongest});
