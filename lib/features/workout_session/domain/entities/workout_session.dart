import 'package:equatable/equatable.dart';

import '../../../exercises/domain/entities/exercise.dart';

/// Lifecycle of a live session.
enum SessionStatus { active, completed, abandoned }

/// One performed set during a session.
class WorkoutSet extends Equatable {
  const WorkoutSet({
    required this.id,
    required this.exerciseId,
    required this.index,
    this.weightKg = 0,
    this.reps = 0,
    this.durationSeconds,
    this.completed = false,
    this.completedAt,
    this.isWarmUp = false,
  });

  final String id;
  final String exerciseId;
  final int index;

  final double weightKg;
  final int reps;
  final int? durationSeconds;
  final bool isWarmUp;
  final bool completed;
  final DateTime? completedAt;

  /// Volume = weight × reps (0 for bodyweight without logged weight).
  double get volume => weightKg * reps;

  /// Epley 1RM estimate, only meaningful for completed weighted sets.
  double get estimatedOneRm =>
      weightKg <= 0 || reps <= 0 ? 0 : weightKg * (1 + reps / 30);

  WorkoutSet copyWith({
    double? weightKg,
    int? reps,
    int? durationSeconds,
    bool? completed,
    DateTime? completedAt,
    bool? isWarmUp,
  }) =>
      WorkoutSet(
        id: id,
        exerciseId: exerciseId,
        index: index,
        weightKg: weightKg ?? this.weightKg,
        reps: reps ?? this.reps,
        durationSeconds: durationSeconds ?? this.durationSeconds,
        completed: completed ?? this.completed,
        completedAt: completedAt ?? this.completedAt,
        isWarmUp: isWarmUp ?? this.isWarmUp,
      );

  @override
  List<Object?> get props =>
      [id, exerciseId, index, weightKg, reps, durationSeconds, completed, completedAt, isWarmUp];
}

/// One performed exercise within a session (1..n sets).
class SessionExercise extends Equatable {
  const SessionExercise({
    required this.id,
    required this.exercise,
    required this.position,
    required this.sets,
    this.notes,
    this.isReplaced = false,
  });

  final String id;
  final Exercise exercise;
  final int position;
  final List<WorkoutSet> sets;
  final String? notes;
  final bool isReplaced;

  List<WorkoutSet> get completedSets => sets.where((s) => s.completed).toList();

  double get volume =>
      completedSets.fold(0, (sum, s) => sum + s.volume);

  @override
  List<Object?> get props => [id, exercise, position, sets, notes, isReplaced];
}

/// A live or historical workout session.
class WorkoutSession extends Equatable {
  const WorkoutSession({
    required this.id,
    required this.routineId,
    required this.name,
    required this.startedAt,
    required this.exercises,
    this.status = SessionStatus.active,
    this.completedAt,
    this.scheduledDate,
    this.wasScheduled,
    this.xpEarned,
    this.personalRecords,
    this.spotifyUsed = false,
    this.spotifyTracksPlayed = 0,
    this.playlistUsed = false,
  });

  final String id;
  final String routineId;
  final String name;
  final DateTime startedAt;
  final DateTime? completedAt;
  final SessionStatus status;

  /// Date this session was scheduled for (planning), if any.
  final DateTime? scheduledDate;
  final bool? wasScheduled;

  final List<SessionExercise> exercises;
  final int? xpEarned;
  final int? personalRecords;

  /// Spotify session context (music achievements are never exploitable
  /// for outsized XP; these only feed low-value achievements).
  final bool spotifyUsed;
  final int spotifyTracksPlayed;
  final bool playlistUsed;

  int get totalSets =>
      exercises.fold(0, (sum, e) => sum + e.completedSets.length);
  int get plannedSets => exercises.fold(0, (sum, e) => sum + e.sets.length);

  double get totalVolume =>
      exercises.fold(0, (sum, e) => sum + e.volume);

  Duration get duration =>
      completedAt?.difference(startedAt) ?? Duration.zero;

  bool get everyPlannedExerciseCompleted =>
      exercises.isNotEmpty &&
      exercises.every((e) => e.sets.isNotEmpty && e.sets.every((s) => s.completed));

  WorkoutSession copyWith({
    String? name,
    SessionStatus? status,
    DateTime? completedAt,
    List<SessionExercise>? exercises,
    int? xpEarned,
    int? personalRecords,
    bool? spotifyUsed,
    int? spotifyTracksPlayed,
    bool? playlistUsed,
  }) =>
      WorkoutSession(
        id: id,
        routineId: routineId,
        name: name ?? this.name,
        startedAt: startedAt,
        completedAt: completedAt ?? this.completedAt,
        status: status ?? this.status,
        scheduledDate: scheduledDate,
        wasScheduled: wasScheduled,
        exercises: exercises ?? this.exercises,
        xpEarned: xpEarned ?? this.xpEarned,
        personalRecords: personalRecords ?? this.personalRecords,
        spotifyUsed: spotifyUsed ?? this.spotifyUsed,
        spotifyTracksPlayed: spotifyTracksPlayed ?? this.spotifyTracksPlayed,
        playlistUsed: playlistUsed ?? this.playlistUsed,
      );

  @override
  List<Object?> get props => [id, routineId, name, startedAt, completedAt, status, scheduledDate, wasScheduled, exercises, xpEarned, personalRecords, spotifyUsed, spotifyTracksPlayed, playlistUsed];
}
