import 'package:drift/drift.dart' show Value;

import '../../../../core/storage/app_database.dart';
import '../../../exercises/domain/entities/exercise.dart';
import '../../../workouts/domain/entities/workout_routine.dart';
import '../../../workout_session/domain/entities/workout_session.dart';
import '../../../personal_records/domain/entities/personal_record.dart';

/// exercise row -> domain
extension ExerciseRowMapper on ExerciseRow {
  Exercise toDomain() => Exercise(
        id: id,
        name: name,
        primaryMuscle: _muscleFrom(primaryMuscle),
        secondaryMuscles: secondaryMuscles
            .split(',')
            .where((s) => s.isNotEmpty)
            .map(_muscleFrom)
            .toList(),
        isCustom: isCustom,
        isFavorite: isFavorite,
        equipment: equipment,
        lastUsedAt: lastUsedAt,
      );
}

MuscleGroup _muscleFrom(String raw) => switch (raw) {
      'chest' => MuscleGroup.chest,
      'back' => MuscleGroup.back,
      'shoulders' => MuscleGroup.shoulders,
      'biceps' => MuscleGroup.biceps,
      'triceps' => MuscleGroup.triceps,
      'legs' => MuscleGroup.legs,
      'glutes' => MuscleGroup.glutes,
      'core' => MuscleGroup.core,
      'cardio' => MuscleGroup.cardio,
      _ => MuscleGroup.fullBody,
    };

String _muscleTo(MuscleGroup m) => m.name;

/// domain -> companion for insert/update
extension ExerciseDomainMapper on Exercise {
  ExercisesCompanion toCompanion() => ExercisesCompanion(
        id: Value(id),
        name: Value(name),
        primaryMuscle: Value(_muscleTo(primaryMuscle)),
        secondaryMuscles: Value(secondaryMuscles.map(_muscleTo).join(',')),
        isCustom: Value(isCustom),
        isFavorite: Value(isFavorite),
        equipment: Value(equipment),
        lastUsedAt: Value(lastUsedAt),
      );
}

/// Assembles a domain routine from its rows.
WorkoutRoutine assembleRoutine(
  WorkoutRoutineRow routine,
  Map<String, ExerciseRow> exerciseRows,
  List<RoutineExerciseRow> configs,
) {
  final exercises = configs
    ..sort((a, b) => a.position.compareTo(b.position));
  return WorkoutRoutine(
    id: routine.id,
    name: routine.name,
    description: routine.description,
    category: switch (routine.category) {
      'strength' => WorkoutCategory.strength,
      'hypertrophy' => WorkoutCategory.hypertrophy,
      'endurance' => WorkoutCategory.endurance,
      'cardio' => WorkoutCategory.cardio,
      _ => WorkoutCategory.mobility,
    },
    restDuration: Duration(seconds: routine.restDurationSeconds),
    createdAt: routine.createdAt,
    updatedAt: routine.updatedAt,
    exercises: exercises
        .where((c) => exerciseRows.containsKey(c.exerciseId))
        .map((c) => WorkoutRoutineExercise(
              id: c.id,
              exercise: exerciseRows[c.exerciseId]!.toDomain(),
              position: c.position,
              setCount: c.setCount,
              reps: c.reps,
              weightKg: c.weightKg,
              warmUpSetCount: c.warmUpSetCount,
              restDuration: c.restDurationSeconds == null
                  ? null
                  : Duration(seconds: c.restDurationSeconds!),
              notes: c.notes,
            ))
        .toList(),
  );
}

/// domain routine -> routine row companion
extension WorkoutRoutineRowMapper on WorkoutRoutine {
  WorkoutRoutinesCompanion routineCompanion() => WorkoutRoutinesCompanion(
        id: Value(id),
        name: Value(name),
        description: Value(description),
        category: Value(category.name),
        restDurationSeconds: Value(restDuration.inSeconds),
        createdAt: Value(createdAt),
        updatedAt: Value(updatedAt),
      );

  List<RoutineExercisesCompanion> exerciseCompanions() => exercises
      .map((e) => RoutineExercisesCompanion(
            id: Value(e.id),
            routineId: Value(id),
            exerciseId: Value(e.exercise.id),
            position: Value(e.position),
            setCount: Value(e.setCount),
            reps: Value(e.reps),
            weightKg: Value(e.weightKg),
            warmUpSetCount: Value(e.warmUpSetCount),
            restDurationSeconds: Value(e.restDuration?.inSeconds),
            notes: Value(e.notes),
          ))
      .toList();
}

extension SessionRowMapper on WorkoutSessionRow {
  WorkoutSession toDomain(List<SessionExercise> exercises) => WorkoutSession(
        id: id,
        routineId: routineId,
        name: name,
        startedAt: startedAt,
        completedAt: completedAt,
        status: switch (status) {
          'completed' => SessionStatus.completed,
          'abandoned' => SessionStatus.abandoned,
          _ => SessionStatus.active,
        },
        scheduledDate: scheduledDate,
        wasScheduled: wasScheduled,
        exercises: exercises,
        xpEarned: xpEarned,
        personalRecords: personalRecords,
      );
}

extension PersonalRecordRowMapper on PersonalRecordRow {
  PersonalRecord toDomain() => PersonalRecord(
        id: id,
        userId: userId,
        exerciseId: exerciseId,
        exerciseName: exerciseName,
        type: switch (type) {
          'heaviestWeight' => PersonalRecordType.heaviestWeight,
          'mostReps' => PersonalRecordType.mostReps,
          'bestSet' => PersonalRecordType.bestSet,
          'highestVolume' => PersonalRecordType.highestVolume,
          _ => PersonalRecordType.estimatedOneRm,
        },
        value: value,
        weightKg: weightKg,
        reps: reps,
        previousValue: previousValue,
        achievedAt: achievedAt,
        workoutSessionId: workoutSessionId,
      );
}

extension PersonalRecordDomainMapper on PersonalRecord {
  PersonalRecordsCompanion toCompanion() => PersonalRecordsCompanion(
        id: Value(id),
        userId: Value(userId),
        exerciseId: Value(exerciseId),
        exerciseName: Value(exerciseName),
        type: Value(type.name),
        value: Value(value),
        weightKg: Value(weightKg),
        reps: Value(reps),
        previousValue: Value(previousValue),
        achievedAt: Value(achievedAt),
        workoutSessionId: Value(workoutSessionId),
      );
}
