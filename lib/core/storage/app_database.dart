import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../features/progress/data/datasources/progress_db.dart';

part 'app_database.g.dart';

/// Aggregate Drift database for all local features.
///
/// Tables are grouped by feature but share a single sqlite file so
/// cross-feature queries (dashboard, progression) stay cheap and
/// transactional.
@DriftDatabase(tables: [
  Users,
  XpTransactions,
  WorkoutRoutines,
  RoutineExercises,
  Exercises,
  WorkoutSessions,
  SessionExercises,
  SessionSets,
  ScheduleEntries,
  PersonalRecords,
  Achievements,
  UserAchievements,
  Badges,
  UserBadges,
  Challenges,
  ChallengeProgress,
  SpotifyAccounts,
  TrainingDays,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(users, users.passwordHash);
            await m.addColumn(users, users.passwordSalt);
          }
        },
      );

  /// Wipes all tables. Used by integration tests and "reset progress".
  Future<void> clearAll() async {
    await transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }
}

/// Opens the app database with sensible defaults for mobile.
AppDatabase openAppDatabase() => AppDatabase(
      driftDatabase(name: 'charlizard'),
    );
