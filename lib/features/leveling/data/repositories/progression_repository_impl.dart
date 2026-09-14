import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart' show Variable;

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/app_database.dart';
import '../../../authentication/data/session_controller.dart';
import '../../../progress/data/datasources/daos.dart';
import '../../domain/entities/progression.dart';
import '../../domain/entities/xp_transaction.dart';
import '../../domain/repositories/progression_repository.dart';
import '../../domain/services/apply_xp.dart';
import '../../domain/services/progression_rules.dart';
import '../models/xp_mappers.dart';

/// Drift-backed progression store.
///
/// The XP ledger (xp_transactions) is the source of truth; user columns are
/// a denormalized snapshot updated atomically with each grant. The ledger's
/// (workoutId, source) uniqueness makes every award idempotent.
class ProgressionRepositoryImpl
    implements ProgressionRepository, ProgressionWriteRepository {
  ProgressionRepositoryImpl(
    this._db,
    this._rules, {
    SessionController? session,
  })  : _session = session, // ignore: prefer_initializing_formals
        _apply = ApplyXp(_rules);

  final AppDatabase _db;
  final ProgressionRules _rules;
  final ApplyXp _apply;
  final SessionController? _session;

  /// Live user id; falls back to the legacy device row when signed out.
  String get _userId => _session?.userId ?? 'local-user';

  @override
  Future<Either<Failure, UserProgression>> getProgression() => guard(() async {
        final user = await _db.userDao.getUser(_userId);
        final totals = await _db.trainingStatsDao.streakState(_userId);
        final achievements = await _achievementCounts();
        final challengesDone = user.challengesCompleted;
        final badges = await _badgeCount();

        final level = user.level;
        final lifetimeXp = user.lifetimeXp;
        final currentXp = lifetimeXp - _rules.lifetimeXpForLevel(level);

        return UserProgression(
          level: level,
          currentXp: currentXp,
          xpForNextLevel: _rules.xpRequiredForLevel(level),
          lifetimeXp: lifetimeXp,
          rank: _rules.rankForLevel(level),
          title: _rules.titleForLevel(level),
          currentStreak: totals.current,
          longestStreak: totals.longest,
          totalWorkouts: user.totalWorkouts,
          achievementsUnlocked: achievements.$1,
          achievementsTotal: achievements.$2,
          badgeCount: badges,
          challengesCompleted: challengesDone,
        );
      });

  @override
  Future<Either<Failure, List<XpTransaction>>> getXpHistory({int limit = 50}) =>
      guard(() async => (await _db.xpDao.recentFor(_userId, limit))
          .map((row) => row.toDomain())
          .toList());

  @override
  Future<Either<Failure, bool>> isXpClaimed(String workoutId, XpSource source) =>
      guard(() => _db.xpDao.existsForWorkout(_userId, workoutId, source.name));

  @override
  Future<Either<Failure, XpApplicationResult>> grantXp(XpTransaction transaction) =>
      guard(() async {
        // Idempotency gate — duplicates are silently accepted as no-ops,
        // mirroring server reconciliation semantics.
        if (transaction.workoutId != null &&
            await _db.xpDao.existsForWorkout(
                _userId, transaction.workoutId!, transaction.source.name)) {
          final current = await getProgression();
          return XpApplicationResult(
            before: current.getOrElse(() => throw const CacheFailure()),
            after: current.getOrElse(() => throw const CacheFailure()),
            levelsGained: 0,
          );
        }

        final user = await _db.userDao.getUser(_userId);

        final before = UserProgression(
          level: user.level,
          currentXp: user.lifetimeXp - _rules.lifetimeXpForLevel(user.level),
          xpForNextLevel: _rules.xpRequiredForLevel(user.level),
          lifetimeXp: user.lifetimeXp,
          rank: _rules.rankForLevel(user.level),
          title: _rules.titleForLevel(user.level),
          currentStreak: user.currentStreak,
          longestStreak: user.longestStreak,
          totalWorkouts: user.totalWorkouts,
          achievementsUnlocked: 0,
          achievementsTotal: defaultAchievementsCount,
          badgeCount: 0,
          challengesCompleted: user.challengesCompleted,
        );

        final result = _apply(before, transaction.amount);

        await _db.transaction(() async {
          await _db.xpDao.insert(transaction.toRow());
          await _db.userDao.applyWorkoutCompletion(user.copyWith(
            lifetimeXp: result.after.lifetimeXp,
            level: result.after.level,
          ));
        });

        return result;
      });

  Future<(int, int)> _achievementCounts() async {
    final unlocked = await _db.customSelect(
      'SELECT COUNT(*) AS n FROM user_achievements WHERE user_id = ? AND unlocked = 1',
      variables: [Variable.withString(_userId)],
      readsFrom: {_db.userAchievements},
    ).getSingle();
    return (unlocked.read<int>('n'), 18);
  }

  Future<int> _badgeCount() async {
    final row = await _db.customSelect(
      'SELECT COUNT(*) AS n FROM user_badges WHERE user_id = ?',
      variables: [Variable.withString(_userId)],
      readsFrom: {_db.userBadges},
    ).getSingle();
    return row.read<int>('n');
  }
}

const int defaultAchievementsCount = 18;
