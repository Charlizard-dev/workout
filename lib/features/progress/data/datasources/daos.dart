import 'package:drift/drift.dart';

import '../../../../core/storage/app_database.dart';

/// Single place for raw/aggregate queries. All SQL lives here, tested via
/// the repository layer. Tables are addressed through typed drift APIs
/// wherever possible; raw SQL only for aggregates.

extension AppDatabaseDaos on AppDatabase {
  XpDao get xpDao => XpDao(this);
  UserDao get userDao => UserDao(this);
  TrainingStatsDao get trainingStatsDao => TrainingStatsDao(this);
  ChallengeDao get challengeDao => ChallengeDao(this);
}

class XpDao {
  XpDao(this._db);

  final AppDatabase _db;

  Future<int> lifetimeXp(String userId) async {
    final row = await _db.customSelect(
      'SELECT COALESCE(SUM(amount), 0) AS total FROM xp_transactions WHERE user_id = ?',
      variables: [Variable.withString(userId)],
      readsFrom: {_db.xpTransactions},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<bool> existsForWorkout(String userId, String workoutId, String source) async {
    final row = await _db.customSelect(
      'SELECT COUNT(*) AS n FROM xp_transactions '
      'WHERE user_id = ? AND workout_id = ? AND source = ?',
      variables: [
        Variable.withString(userId),
        Variable.withString(workoutId),
        Variable.withString(source),
      ],
      readsFrom: {_db.xpTransactions},
    ).getSingle();
    return row.read<int>('n') > 0;
  }

  Future<void> insert(XpTransactionRow row) => _db
      .into(_db.xpTransactions)
      .insert(row, mode: InsertMode.insertOrIgnore);

  Future<List<XpTransactionRow>> recentFor(String userId, int limit) =>
      (_db.select(_db.xpTransactions)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
            ..limit(limit))
          .get();
}

class UserDao {
  UserDao(this._db);

  final AppDatabase _db;

  Future<UserRow> getUser(String id) async {
    final row = await (_db.select(_db.users)..where((u) => u.id.equals(id))).getSingleOrNull();
    if (row != null) return row;
    // First launch: create the local user lazily.
    final now = DateTime.now();
    await _db.into(_db.users).insert(UserRow(
          id: id,
          name: 'Athlete',
          createdAt: now,
          lifetimeXp: 0,
          level: 1,
          currentStreak: 0,
          longestStreak: 0,
          totalWorkouts: 0,
          totalVolumeKg: 0,
          totalTrainingSeconds: 0,
          spotifyWorkouts: 0,
          spotifyTracksPlayed: 0,
          playlistWorkouts: 0,
          challengesCompleted: 0,
          personalRecordsCount: 0,
        ));
    return (await (_db.select(_db.users)..where((u) => u.id.equals(id))).getSingle());
  }

  Future<void> updateXp(String userId, int lifetimeXp, int level) async {
    await (_db.update(_db.users)..where((u) => u.id.equals(userId))).write(
      UsersCompanion(lifetimeXp: Value(lifetimeXp), level: Value(level)),
    );
  }

  Future<void> rename(String userId, String name, {String? photoUrl}) async {
    await (_db.update(_db.users)..where((u) => u.id.equals(userId))).write(
      UsersCompanion(name: Value(name), photoUrl: Value(photoUrl)),
    );
  }

  Future<void> applyWorkoutCompletion(UserRow updated) => _db
      .into(_db.users)
      .insertOnConflictUpdate(updated);
}

/// Reads over training days + sessions for dashboards, streaks and charts.
class TrainingStatsDao {
  TrainingStatsDao(this._db);

  final AppDatabase _db;

  Future<TrainingDayRow?> trainingDay(String userId, DateTime day) async {
    final key = DateTime(day.year, day.month, day.day);
    return (_db.select(_db.trainingDays)
          ..where((d) => d.userId.equals(userId) & d.date.equals(key))
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> upsertTrainingDay(TrainingDayRow row) =>
      _db.into(_db.trainingDays).insertOnConflictUpdate(row);

  /// Streak state derived from the training-days calendar, rest-day aware.
  Future<({int current, int longest, DateTime? lastWorkout})> streakState(String userId) async {
    final days = await (_db.select(_db.trainingDays)
          ..where((d) => d.userId.equals(userId) & d.workoutCount.isBiggerThanValue(0))
          ..orderBy([(d) => OrderingTerm.desc(d.date)]))
        .get();

    if (days.isEmpty) return (current: 0, longest: 0, lastWorkout: null);

    // Longest streak: scan ascending workout days, allowing scheduled-rest
    // gaps (rest days never break the chain, they just don't extend it).
    final workoutDays = days.map((d) => d.date).toList()..sort();
    var longest = 1;
    var run = 1;
    for (var i = 1; i < workoutDays.length; i++) {
      final gap = workoutDays[i].difference(workoutDays[i - 1]).inDays;
      if (gap <= 1) {
        run++;
      } else if (await _allRestDaysBetween(userId, workoutDays[i - 1], workoutDays[i])) {
        run++; // rest gap keeps the chain alive
      } else {
        run = 1;
      }
      if (run > longest) longest = run;
    }

    // Current streak: walk back from the most recent workout day.
    var current = 1;
    var idx = days.length - 1;
    var cursor = workoutDays.last;
    while (idx > 0) {
      final prev = workoutDays[idx - 1];
      final gap = cursor.difference(prev).inDays;
      if (gap <= 1) {
        current++;
      } else if (!await _allRestDaysBetween(userId, prev, cursor)) {
        break;
      }
      cursor = prev;
      idx--;
    }

    // If the last workout was long ago (beyond rest-day forgiveness),
    // current streak resets unless today/yesterday plus rest coverage.
    final today = DateTime.now();
    final todayKey = DateTime(today.year, today.month, today.day);
    final daysSinceLast = todayKey.difference(workoutDays.last).inDays;
    if (daysSinceLast >= 1) {
      final restCovered = await _allRestDaysBetween(userId, workoutDays.last, todayKey.add(const Duration(days: 1)));
      if (!restCovered || daysSinceLast > 6) current = 0;
    }

    return (current: current, longest: longest, lastWorkout: workoutDays.last);
  }

  Future<bool> _allRestDaysBetween(String userId, DateTime from, DateTime to) async {
    final fromKey = DateTime(from.year, from.month, from.day).add(const Duration(days: 1));
    final toKey = DateTime(to.year, to.month, to.day);
    if (!toKey.isAfter(fromKey)) return true;
    final rows = await (_db.select(_db.trainingDays)
          ..where((d) =>
              d.userId.equals(userId) &
              d.date.isBiggerOrEqualValue(fromKey) &
              d.date.isSmallerThanValue(toKey)))
        .get();
    if (rows.isEmpty) return false;
    return rows.every((d) => d.isScheduledRest);
  }

  /// Totals for the profile screen.
  Future<({double volumeKg, int seconds, int workouts})> lifetimeTotals(String userId) async {
    final user = await (_db.select(_db.users)..where((u) => u.id.equals(userId))).getSingle();
    return (
      volumeKg: user.totalVolumeKg,
      seconds: user.totalTrainingSeconds,
      workouts: user.totalWorkouts,
    );
  }

  /// Weekly workout counts for the last [weeks] ISO weeks (Mon-based).
  Future<List<int>> weeklyWorkoutCounts(String userId, int weeks) async {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(monday.year, monday.month, monday.day)
        .subtract(Duration(days: 7 * (weeks - 1)));
    final rows = await (_db.select(_db.trainingDays)
          ..where((d) => d.userId.equals(userId) &
              d.date.isBiggerOrEqualValue(start) &
              d.workoutCount.isBiggerThanValue(0)))
        .get();
    final counts = List<int>.filled(weeks, 0);
    for (final row in rows) {
      final weekIndex = row.date.difference(start).inDays ~/ 7;
      if (weekIndex >= 0 && weekIndex < weeks) counts[weekIndex]++;
    }
    return counts;
  }

  /// Daily per-muscle volume over the trailing window, for charts.
  Future<Map<String, double>> muscleVolumeSince(String userId, DateTime since) async {
    final rows = await (_db.select(_db.trainingDays)
          ..where((d) => d.userId.equals(userId) & d.date.isBiggerOrEqualValue(since)))
        .get();
    final volumes = <String, double>{};
    for (final row in rows) {
      for (final muscle in row.muscleGroupsCsv.split(',')) {
        if (muscle.isEmpty) continue;
        volumes[muscle] = (volumes[muscle] ?? 0) + row.volumeKg;
      }
    }
    return volumes;
  }

  /// Volume by month for strength progression charts.
  Future<List<({String month, double volumeKg})>> monthlyVolume(String userId, int months) async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month - (months - 1));
    final rows = await (_db.select(_db.trainingDays)
          ..where((d) =>
              d.userId.equals(userId) & d.date.isBiggerOrEqualValue(start)))
        .get();
    final byMonth = <String, double>{};
    for (final row in rows) {
      final key = '${row.date.year}-${row.date.month.toString().padLeft(2, '0')}';
      byMonth[key] = (byMonth[key] ?? 0) + row.volumeKg;
    }
    final out = <({String month, double volumeKg})>[];
    for (var i = months - 1; i >= 0; i--) {
      final d = DateTime(now.year, now.month - i);
      final key = '${d.year}-${d.month.toString().padLeft(2, '0')}';
      out.add((month: key, volumeKg: byMonth[key] ?? 0));
    }
    return out;
  }
}

class ChallengeDao {
  ChallengeDao(this._db);

  final AppDatabase _db;

  Future<List<ChallengeProgressRow>> activeForUser(String userId, String periodKey) =>
      (_db.select(_db.challengeProgress)
            ..where((c) => c.userId.equals(userId) & c.periodKey.equals(periodKey)))
          .get();

  Future<void> upsert(ChallengeProgressRow row) =>
      _db.into(_db.challengeProgress).insertOnConflictUpdate(row);
}
