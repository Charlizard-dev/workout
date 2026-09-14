import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/app_database.dart';
import '../../domain/entities/workout_routine.dart';
import '../../domain/repositories/workout_routine_repository.dart';
import '../../../workouts/data/models/workout_mappers.dart';

/// Drift-backed routine store. Saving a routine replaces its exercise list
/// atomically (delete + insert within one transaction).
class WorkoutRoutineRepositoryImpl implements WorkoutRoutineRepository {
  WorkoutRoutineRepositoryImpl(this._db, {Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  @override
  Future<Either<Failure, List<WorkoutRoutine>>> getAll() => guard(() async {
        final routines = await (_db.select(_db.workoutRoutines)
              ..orderBy([(r) => OrderingTerm.asc(r.sortOrder), (r) => OrderingTerm.asc(r.createdAt)]))
            .get();
        final out = <WorkoutRoutine>[];
        for (final r in routines) {
          out.add(await _hydrate(r));
        }
        return out;
      });

  @override
  Future<Either<Failure, WorkoutRoutine>> getById(String id) => guard(() async {
        final row = await (_db.select(_db.workoutRoutines)
              ..where((r) => r.id.equals(id))
              ..limit(1))
            .getSingleOrNull();
        if (row == null) throw const NotFoundFailure('Routine not found.');
        return _hydrate(row);
      });

  Future<WorkoutRoutine> _hydrate(WorkoutRoutineRow row) async {
    final configs = await (_db.select(_db.routineExercises)
          ..where((c) => c.routineId.equals(row.id))
          ..orderBy([(c) => OrderingTerm.asc(c.position)]))
        .get();
    final exerciseRows = await (_db.select(_db.exercises)
          ..where((e) => e.id.isIn(configs.map((c) => c.exerciseId).toList())))
        .get();
    return assembleRoutine(row, {for (final e in exerciseRows) e.id: e}, configs);
  }

  @override
  Future<Either<Failure, WorkoutRoutine>> save(WorkoutRoutine routine) => guard(() async {
        final now = DateTime.now();
        final toSave = routine.copyWith(updatedAt: now);

        await _db.transaction(() async {
          await _db
              .into(_db.workoutRoutines)
              .insertOnConflictUpdate(toSave.routineCompanion());
          // Replace exercise configs wholesale.
          await (_db.delete(_db.routineExercises)
                ..where((c) => c.routineId.equals(toSave.id)))
              .go();
          for (final companion in toSave.exerciseCompanions()) {
            await _db.into(_db.routineExercises).insert(companion);
          }
        });

        return toSave;
      });

  @override
  Future<Either<Failure, void>> delete(String routineId) => guard(() => _db.transaction(() async {
        await (_db.delete(_db.routineExercises)..where((c) => c.routineId.equals(routineId))).go();
        await (_db.delete(_db.workoutRoutines)..where((r) => r.id.equals(routineId))).go();
      }));

  @override
  Future<Either<Failure, void>> duplicate(String routineId) => guard(() async {
        final original = await getById(routineId);
        await original.fold(
          (f) => throw f,
          (routine) async {
            final copy = WorkoutRoutine(
              id: _uuid.v4(),
              name: '${routine.name} (Copy)',
              description: routine.description,
              category: routine.category,
              restDuration: routine.restDuration,
              exercises: routine.exercises
                  .map((e) => WorkoutRoutineExercise(
                        id: _uuid.v4(),
                        exercise: e.exercise,
                        position: e.position,
                        setCount: e.setCount,
                        reps: e.reps,
                        weightKg: e.weightKg,
                        warmUpSetCount: e.warmUpSetCount,
                        restDuration: e.restDuration,
                        notes: e.notes,
                      ))
                  .toList(),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            await save(copy);
          },
        );
      });

  @override
  Future<Either<Failure, void>> reorder(List<String> routineIdsInOrder) => guard(() => _db.transaction(() async {
        for (var i = 0; i < routineIdsInOrder.length; i++) {
          await (_db.update(_db.workoutRoutines)
                ..where((r) => r.id.equals(routineIdsInOrder[i])))
              .write(WorkoutRoutinesCompanion(sortOrder: Value(i)));
        }
      }));

  @override
  Future<Either<Failure, int>> countAll() =>
      guard(() async => await _db.workoutRoutines.count().getSingle());
}
