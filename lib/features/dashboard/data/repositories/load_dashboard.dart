import 'package:drift/drift.dart' hide Column;

import 'package:dartz/dartz.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/app_database.dart';
import '../../../progress/data/datasources/daos.dart';
import '../../../leveling/domain/entities/progression.dart';
import '../../../authentication/data/session_controller.dart';
import '../../../challenges/data/repositories/challenge_repository_impl.dart';
import '../../../leveling/domain/repositories/progression_repository.dart';
import '../../../workouts/domain/entities/workout_routine.dart';
import '../../../workouts/domain/repositories/workout_routine_repository.dart';

/// Everything the home dashboard renders in one typed snapshot.
class DashboardData {
  const DashboardData({
    required this.progression,
    required this.weekWorkouts,
    required this.weekGoal,
    required this.todayRoutine,
    required this.weekDays,
    required this.dailyChallenge,
    required this.totalVolumeKg,
    required this.totalTrainingSeconds,
  });

  final UserProgression progression;

  /// 0..7 completed workouts this ISO week.
  final int weekWorkouts;
  final int weekGoal;

  /// Routine scheduled for today, if any.
  final WorkoutRoutine? todayRoutine;

  /// Per-weekday snapshot: completed / planned / rest.
  final List<DayStatus> weekDays;

  final (String, int, int)? dailyChallenge; // title, current, target

  final double totalVolumeKg;
  final int totalTrainingSeconds;
}

enum DayState { completed, planned, rest, missed, future }

class DayStatus {
  const DayStatus({
    required this.label,
    required this.date,
    required this.state,
  });

  final String label; // MON, TUE...
  final DateTime date;
  final DayState state;
}

/// Loads dashboard aggregates in one shot; pure read-side composition.
class LoadDashboard {
  LoadDashboard({
    required AppDatabase db,
    required ProgressionRepository progressionRepository,
    required WorkoutRoutineRepository routineRepository,
    required ChallengeRepository challengeRepository,
    SessionController? session,
  })  : _db = db, // ignore: prefer_initializing_formals
        _progression = progressionRepository,
        _routines = routineRepository,
        _challenges = challengeRepository,
        _session = session; // ignore: prefer_initializing_formals

  final AppDatabase _db;
  final ProgressionRepository _progression;
  final WorkoutRoutineRepository _routines;
  final ChallengeRepository _challenges;
  final SessionController? _session;

  /// Live user id; falls back to the legacy device row when signed out.
  String get _userId => _session?.userId ?? 'local-user';

  Future<Either<Failure, DashboardData>> call() => guard(() async {
        final progression = await _progression.getProgression().then(
              (r) => r.getOrElse(() => throw const CacheFailure()),
            );

        final now = DateTime.now();
        final monday = DateTime(now.year, now.month, now.day)
            .subtract(Duration(days: now.weekday - 1));

        // Weekday statuses from the training-day calendar.
        final weekRows = await (_db.select(_db.trainingDays)
              ..where((d) =>
                  d.userId.equals(_userId) &
                  d.date.isBiggerOrEqualValue(monday) &
                  d.date.isSmallerOrEqualValue(
                      monday.add(const Duration(days: 6)))))
            .get();

        final byDay = <DateTime, TrainingDayRow>{};
        for (final row in weekRows) {
          byDay[DateTime(row.date.year, row.date.month, row.date.day)] = row;
        }

        const labels = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
        final weekDays = <DayStatus>[];
        var weekWorkouts = 0;
        for (var i = 0; i < 7; i++) {
          final day = monday.add(Duration(days: i));
          final key = DateTime(day.year, day.month, day.day);
          final row = byDay[key];
          final isToday = key == DateTime(now.year, now.month, now.day);
          final isFuture = key.isAfter(DateTime(now.year, now.month, now.day));

          DayState state;
          if (row != null && row.workoutCount > 0) {
            state = DayState.completed;
            weekWorkouts += row.workoutCount > 0 ? 1 : 0;
          } else if (row != null && row.isScheduledRest) {
            state = DayState.rest;
          } else if (isFuture) {
            state = DayState.future;
          } else if (isToday) {
            state = DayState.planned;
          } else {
            state = DayState.missed;
          }
          weekDays.add(DayStatus(label: labels[i], date: day, state: state));
        }

        // Today's routine: first routine by default (schedule-aware later).
        final routines = await _routines.getAll().then(
              (r) => r.getOrElse(() => <WorkoutRoutine>[]),
            );
        final todayRoutine = routines.isNotEmpty ? routines.first : null;

        // Volume + time totals.
        final totals =
            await _db.trainingStatsDao.lifetimeTotals(_userId);

        return DashboardData(
          progression: progression,
          weekWorkouts: weekWorkouts,
          weekGoal: 5,
          todayRoutine: todayRoutine,
          weekDays: weekDays,
          dailyChallenge: await _dailyChallengeTeaser(),
          totalVolumeKg: totals.volumeKg,
          totalTrainingSeconds: totals.seconds,
        );
      });

  Future<(String, int, int)?> _dailyChallengeTeaser() async {
    final current = await _challenges.getCurrent();
    return current.fold(
      (_) => null,
      (c) => (
        c.daily.definition.title,
        c.daily.current,
        c.daily.definition.target
      ),
    );
  }
}
