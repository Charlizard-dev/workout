import 'package:drift/drift.dart';

/// Feature-grouped Drift table definitions. Entities stay in domain; these
/// tables are the persistence contract. Keep columns snake_case-friendly.

@DataClassName('UserRow')
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get photoUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  // Local-auth credentials (v2). Null for legacy device rows.
  TextColumn get passwordHash => text().nullable()();
  TextColumn get passwordSalt => text().nullable()();
  IntColumn get lifetimeXp => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastWorkoutAt => dateTime().nullable()();
  IntColumn get totalWorkouts => integer().withDefault(const Constant(0))();
  RealColumn get totalVolumeKg => real().withDefault(const Constant(0))();
  IntColumn get totalTrainingSeconds => integer().withDefault(const Constant(0))();
  IntColumn get spotifyWorkouts => integer().withDefault(const Constant(0))();
  IntColumn get spotifyTracksPlayed => integer().withDefault(const Constant(0))();
  IntColumn get playlistWorkouts => integer().withDefault(const Constant(0))();
  IntColumn get challengesCompleted => integer().withDefault(const Constant(0))();
  IntColumn get personalRecordsCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('XpTransactionRow')
class XpTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  IntColumn get amount => integer()();
  TextColumn get source => text()();
  TextColumn get description => text()();
  TextColumn get workoutId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutRoutineRow')
class WorkoutRoutines extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get category => text()();
  IntColumn get restDurationSeconds => integer().withDefault(const Constant(90))();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RoutineExerciseRow')
class RoutineExercises extends Table {
  TextColumn get id => text()();
  TextColumn get routineId => text()();
  TextColumn get exerciseId => text()();
  IntColumn get position => integer()();
  IntColumn get setCount => integer().withDefault(const Constant(3))();
  IntColumn get reps => integer().withDefault(const Constant(10))();
  RealColumn get weightKg => real().withDefault(const Constant(0))();
  IntColumn get warmUpSetCount => integer().withDefault(const Constant(0))();
  IntColumn get restDurationSeconds => integer().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ExerciseRow')
class Exercises extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get primaryMuscle => text()();
  TextColumn get secondaryMuscles => text().withDefault(const Constant(''))();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  TextColumn get equipment => text().nullable()();
  DateTimeColumn get lastUsedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutSessionRow')
class WorkoutSessions extends Table {
  TextColumn get id => text()();
  TextColumn get routineId => text()();
  TextColumn get name => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get status => text()();
  DateTimeColumn get scheduledDate => dateTime().nullable()();
  BoolColumn get wasScheduled => boolean().withDefault(const Constant(false))();
  IntColumn get xpEarned => integer().nullable()();
  IntColumn get personalRecords => integer().nullable()();
  BoolColumn get spotifyUsed => boolean().withDefault(const Constant(false))();
  IntColumn get spotifyTracksPlayed => integer().withDefault(const Constant(0))();
  BoolColumn get playlistUsed => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SessionExerciseRow')
class SessionExercises extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  TextColumn get exerciseId => text()();
  IntColumn get position => integer()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isReplaced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SessionSetRow')
class SessionSets extends Table {
  TextColumn get id => text()();
  TextColumn get sessionExerciseId => text()();
  TextColumn get exerciseId => text()();
  IntColumn get setIndex => integer()();
  RealColumn get weightKg => real().withDefault(const Constant(0))();
  IntColumn get reps => integer().withDefault(const Constant(0))();
  IntColumn get durationSeconds => integer().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  BoolColumn get isWarmUp => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ScheduleEntryRow')
class ScheduleEntries extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get routineId => text().nullable()();
  TextColumn get label => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PersonalRecordRow')
class PersonalRecords extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get exerciseId => text()();
  TextColumn get exerciseName => text()();
  TextColumn get type => text()();
  RealColumn get value => real()();
  RealColumn get weightKg => real().nullable()();
  IntColumn get reps => integer().nullable()();
  RealColumn get previousValue => real().nullable()();
  DateTimeColumn get achievedAt => dateTime()();
  TextColumn get workoutSessionId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AchievementRow')
class Achievements extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get family => text()();
  TextColumn get metric => text()();
  IntColumn get threshold => integer()();
  IntColumn get xpReward => integer()();
  TextColumn get icon => text().nullable()();
  TextColumn get badgeId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('UserAchievementRow')
class UserAchievements extends Table {
  TextColumn get achievementId => text()();
  TextColumn get userId => text()();
  IntColumn get progress => integer().withDefault(const Constant(0))();
  BoolColumn get unlocked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get unlockedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {achievementId, userId};
}

@DataClassName('BadgeRow')
class Badges extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get emoji => text()();
  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('UserBadgeRow')
class UserBadges extends Table {
  TextColumn get badgeId => text()();
  TextColumn get userId => text()();
  DateTimeColumn get earnedAt => dateTime()();
  BoolColumn get isShowcased => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {badgeId, userId};
}

@DataClassName('ChallengeRow')
class Challenges extends Table {
  TextColumn get id => text()();
  TextColumn get period => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get metric => text()();
  IntColumn get target => integer()();
  IntColumn get xpReward => integer()();
  TextColumn get icon => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ChallengeProgressRow')
class ChallengeProgress extends Table {
  TextColumn get challengeId => text()();
  TextColumn get userId => text()();
  TextColumn get periodKey => text()();
  IntColumn get current => integer().withDefault(const Constant(0))();
  BoolColumn get claimed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {challengeId, userId, periodKey};
}

@DataClassName('SpotifyAccountRow')
class SpotifyAccounts extends Table {
  TextColumn get userId => text()();
  TextColumn get spotifyUserId => text()();
  TextColumn get displayName => text()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get email => text().nullable()();
  DateTimeColumn get connectedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {userId};
}

/// Daily training log: one row per user per day with any activity.
/// Powers streaks, weekly charts, challenge "distinct days" metrics and
/// rest-day-aware streak logic.
@DataClassName('TrainingDayRow')
class TrainingDays extends Table {
  TextColumn get userId => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get workoutCount => integer().withDefault(const Constant(0))();
  IntColumn get setsCompleted => integer().withDefault(const Constant(0))();
  RealColumn get volumeKg => real().withDefault(const Constant(0))();
  IntColumn get trainingSeconds => integer().withDefault(const Constant(0))();
  BoolColumn get isScheduledRest => boolean().withDefault(const Constant(false))();
  TextColumn get routineIdsCsv => text().withDefault(const Constant(''))();
  TextColumn get muscleGroupsCsv => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {userId, date};
}
