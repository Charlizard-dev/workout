import 'package:equatable/equatable.dart';

import '../../../exercises/domain/entities/exercise.dart';

/// High-level workout category for routines.
enum WorkoutCategory {
  strength,
  hypertrophy,
  endurance,
  cardio,
  mobility,
}

extension WorkoutCategoryX on WorkoutCategory {
  String get label => switch (this) {
        WorkoutCategory.strength => 'Strength',
        WorkoutCategory.hypertrophy => 'Hypertrophy',
        WorkoutCategory.endurance => 'Endurance',
        WorkoutCategory.cardio => 'Cardio',
        WorkoutCategory.mobility => 'Mobility',
      };
}

/// A user-built routine: an ordered list of configured exercises.
class WorkoutRoutine extends Equatable {
  const WorkoutRoutine({
    required this.id,
    required this.name,
    required this.exercises,
    this.description,
    this.category = WorkoutCategory.strength,
    this.restDuration = const Duration(seconds: 90),
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String? description;
  final WorkoutCategory category;
  final Duration restDuration;

  /// Ordered routine exercises.
  final List<WorkoutRoutineExercise> exercises;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  int get totalSets => exercises.fold(0, (sum, e) => sum + e.setCount);
  int get totalWarmUpSets =>
      exercises.fold(0, (sum, e) => sum + e.warmUpSetCount);

  List<MuscleGroup> get primaryMuscles {
    final set = <MuscleGroup>{};
    for (final e in exercises) {
      set.add(e.exercise.primaryMuscle);
    }
    return set.toList();
  }

  String get muscleSummary =>
      primaryMuscles.map((m) => m.label).join(' • ');

  /// Estimated session duration for planning display.
  Duration get estimatedDuration {
    if (exercises.isEmpty) return Duration.zero;
    final workingSeconds = exercises.fold<int>(0, (sum, e) {
      final setCount = e.setCount + e.warmUpSetCount;
      return sum + setCount * (e.setDuration.inSeconds + restDuration.inSeconds);
    });
    return Duration(seconds: workingSeconds + 180); // warm-up + transitions buffer
  }

  WorkoutRoutine copyWith({
    String? name,
    String? description,
    WorkoutCategory? category,
    Duration? restDuration,
    List<WorkoutRoutineExercise>? exercises,
    DateTime? updatedAt,
  }) =>
      WorkoutRoutine(
        id: id,
        name: name ?? this.name,
        description: description ?? this.description,
        category: category ?? this.category,
        restDuration: restDuration ?? this.restDuration,
        exercises: exercises ?? this.exercises,
        createdAt: createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [id, name, description, category, restDuration, exercises, createdAt, updatedAt];
}

/// An exercise configured inside a routine (sets × reps × weight × rest).
class WorkoutRoutineExercise extends Equatable {
  const WorkoutRoutineExercise({
    required this.id,
    required this.exercise,
    required this.position,
    this.setCount = 3,
    this.reps = 10,
    this.weightKg = 0,
    this.warmUpSetCount = 0,
    this.restDuration,
    this.notes,
  });

  final String id;
  final Exercise exercise;
  final int position;

  /// Working sets.
  final int setCount;
  final int reps;

  /// Target working weight in kilograms (0 = bodyweight/unset).
  final double weightKg;
  final int warmUpSetCount;

  /// Overrides routine default rest when set.
  final Duration? restDuration;
  final String? notes;

  /// Per-exercise duration used for time-based exercises (cardio).
  Duration get setDuration => const Duration(seconds: 45);

  Duration get effectiveRest => restDuration ?? const Duration(seconds: 90);

  WorkoutRoutineExercise copyWith({
    int? setCount,
    int? reps,
    double? weightKg,
    int? warmUpSetCount,
    Duration? restDuration,
    String? notes,
    int? position,
  }) =>
      WorkoutRoutineExercise(
        id: id,
        exercise: exercise,
        position: position ?? this.position,
        setCount: setCount ?? this.setCount,
        reps: reps ?? this.reps,
        weightKg: weightKg ?? this.weightKg,
        warmUpSetCount: warmUpSetCount ?? this.warmUpSetCount,
        restDuration: restDuration ?? this.restDuration,
        notes: notes ?? this.notes,
      );

  @override
  List<Object?> get props =>
      [id, exercise, position, setCount, reps, weightKg, warmUpSetCount, restDuration, notes];
}
