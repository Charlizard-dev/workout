import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/app_database.dart';
import '../../../workouts/domain/entities/workout_routine.dart';
import '../../domain/entities/workout_session.dart';
import '../../domain/repositories/workout_session_repository.dart';
import '../../../workouts/data/models/workout_mappers.dart';

/// Drift-backed session store. A session and its exercises/sets are saved
/// with every mutation so an app kill never loses live progress.
class WorkoutSessionRepositoryImpl implements WorkoutSessionRepository {
  WorkoutSessionRepositoryImpl(this._db, {Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  @override
  Future<Either<Failure, WorkoutSession>> startFromRoutine(
    WorkoutRoutine routine, {
    DateTime? scheduledDate,
    bool wasScheduled = false,
  }) =>
      guard(() async {
        // Only one active session at a time.
        final active = await getActive();
        await active.fold(
          (_) async {},
          (session) async {
            if (session != null) await abandon(session.id);
          },
        );

        final sessionId = _uuid.v4();
        final now = DateTime.now();
        final exercises = <SessionExercise>[];
        var position = 0;

        await _db.transaction(() async {
          await _db.into(_db.workoutSessions).insert(WorkoutSessionsCompanion.insert(
                id: sessionId,
                routineId: routine.id,
                name: routine.name,
                startedAt: now,
                status: 'active',
                scheduledDate: Value(scheduledDate),
                wasScheduled: Value(wasScheduled),
              ));

          for (final routineExercise in routine.exercises) {
            final sessionExerciseId = _uuid.v4();
            await _db.into(_db.sessionExercises).insert(SessionExercisesCompanion.insert(
                  id: sessionExerciseId,
                  sessionId: sessionId,
                  exerciseId: routineExercise.exercise.id,
                  position: position++,
                  notes: Value(routineExercise.notes),
                ));

            final sets = <WorkoutSet>[];
            final totalSets = routineExercise.warmUpSetCount + routineExercise.setCount;
            for (var i = 0; i < totalSets; i++) {
              final setId = _uuid.v4();
              final isWarmUp = i < routineExercise.warmUpSetCount;
              await _db.into(_db.sessionSets).insert(SessionSetsCompanion.insert(
                    id: setId,
                    sessionExerciseId: sessionExerciseId,
                    exerciseId: routineExercise.exercise.id,
                    setIndex: i,
                    weightKg: Value(routineExercise.weightKg),
                    reps: Value(isWarmUp ? (routineExercise.reps - 2).clamp(1, 99) : routineExercise.reps),
                    isWarmUp: Value(isWarmUp),
                  ));
              sets.add(WorkoutSet(
                id: setId,
                exerciseId: routineExercise.exercise.id,
                index: i,
                weightKg: routineExercise.weightKg,
                reps: isWarmUp ? (routineExercise.reps - 2).clamp(1, 99) : routineExercise.reps,
                isWarmUp: isWarmUp,
              ));
            }

            exercises.add(SessionExercise(
              id: sessionExerciseId,
              exercise: routineExercise.exercise,
              position: position - 1,
              sets: sets,
              notes: routineExercise.notes,
            ));
          }
        });

        return WorkoutSession(
          id: sessionId,
          routineId: routine.id,
          name: routine.name,
          startedAt: now,
          scheduledDate: scheduledDate,
          wasScheduled: wasScheduled,
          exercises: exercises,
        );
      });

  @override
  Future<Either<Failure, WorkoutSession?>> getActive() => guard(() async {
        final rows = await (_db.select(_db.workoutSessions)
              ..where((s) => s.status.equals('active'))
              ..orderBy([(s) => OrderingTerm.desc(s.startedAt)])
              ..limit(1))
            .get();
        if (rows.isEmpty) return null;
        return _hydrate(rows.first);
      });

  @override
  Future<Either<Failure, WorkoutSession>> save(WorkoutSession session) => guard(() async {
        await _db.transaction(() async {
          await (_db.update(_db.workoutSessions)..where((s) => s.id.equals(session.id)))
              .write(WorkoutSessionsCompanion(
                name: Value(session.name),
                status: Value(session.status.name),
                completedAt: Value(session.completedAt),
                xpEarned: Value(session.xpEarned),
                personalRecords: Value(session.personalRecords),
              ));
          for (final exercise in session.exercises) {
            await _db
                .into(_db.sessionExercises)
                .insertOnConflictUpdate(SessionExercisesCompanion.insert(
              id: exercise.id,
              sessionId: session.id,
              exerciseId: exercise.exercise.id,
              position: exercise.position,
              notes: Value(exercise.notes),
              isReplaced: Value(exercise.isReplaced),
            ));
            for (final set in exercise.sets) {
              await _db.into(_db.sessionSets).insertOnConflictUpdate(SessionSetsCompanion.insert(
                    id: set.id,
                    sessionExerciseId: exercise.id,
                    exerciseId: set.exerciseId,
                    setIndex: set.index,
                    weightKg: Value(set.weightKg),
                    reps: Value(set.reps),
                    durationSeconds: Value(set.durationSeconds),
                    completed: Value(set.completed),
                    completedAt: Value(set.completedAt),
                    isWarmUp: Value(set.isWarmUp),
                  ));
            }
          }
        });
        return session;
      });

  @override
  Future<Either<Failure, WorkoutSession?>> getById(String sessionId) => guard(() async {
        final row = await (_db.select(_db.workoutSessions)
              ..where((s) => s.id.equals(sessionId))
              ..limit(1))
            .getSingleOrNull();
        if (row == null) return null;
        return _hydrate(row);
      });

  @override
  Future<Either<Failure, List<WorkoutSession>>> history({int limit = 100, int offset = 0}) =>
      guard(() async {
        final rows = await (_db.select(_db.workoutSessions)
              ..where((s) => s.status.equals('completed'))
              ..orderBy([(s) => OrderingTerm.desc(s.completedAt)])
              ..limit(limit, offset: offset))
            .get();
        final out = <WorkoutSession>[];
        for (final row in rows) {
          out.add(await _hydrate(row));
        }
        return out;
      });

  @override
  Future<Either<Failure, WorkoutSession>> complete(WorkoutSession session) => guard(() async {
        final completed = session.copyWith(
          status: SessionStatus.completed,
          completedAt: DateTime.now(),
        );
        await save(completed);
        return completed;
      });

  @override
  Future<Either<Failure, void>> abandon(String sessionId) => guard(() => _db.transaction(() async {
        await (_db.delete(_db.sessionSets)..where((s) => s.sessionExerciseId.isInQuery(
              _db.selectOnly(_db.sessionExercises)
                ..addColumns([_db.sessionExercises.id])
                ..where(_db.sessionExercises.sessionId.equals(sessionId)),
            ))).go();
        await (_db.delete(_db.sessionExercises)..where((e) => e.sessionId.equals(sessionId))).go();
        await (_db.delete(_db.workoutSessions)..where((s) => s.id.equals(sessionId))).go();
      }));

  Future<WorkoutSession> _hydrate(WorkoutSessionRow row) async {
    final exerciseRows = await (_db.select(_db.sessionExercises)
          ..where((e) => e.sessionId.equals(row.id))
          ..orderBy([(e) => OrderingTerm.asc(e.position)]))
        .get();

    final exercises = <SessionExercise>[];
    for (final exRow in exerciseRows) {
      final setRows = await (_db.select(_db.sessionSets)
            ..where((s) => s.sessionExerciseId.equals(exRow.id))
            ..orderBy([(s) => OrderingTerm.asc(s.setIndex)]))
          .get();
      final exercise = await (_db.select(_db.exercises)
            ..where((e) => e.id.equals(exRow.exerciseId))
            ..limit(1))
          .getSingleOrNull();
      if (exercise == null) continue;
      exercises.add(SessionExercise(
        id: exRow.id,
        exercise: exercise.toDomain(),
        position: exRow.position,
        notes: exRow.notes,
        isReplaced: exRow.isReplaced,
        sets: setRows
            .map((s) => WorkoutSet(
                  id: s.id,
                  exerciseId: s.exerciseId,
                  index: s.setIndex,
                  weightKg: s.weightKg,
                  reps: s.reps,
                  durationSeconds: s.durationSeconds,
                  completed: s.completed,
                  completedAt: s.completedAt,
                  isWarmUp: s.isWarmUp,
                ))
            .toList(),
      ));
    }

    return row.toDomain(exercises);
  }
}
