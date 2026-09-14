import 'package:dartz/dartz.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/errors/failures.dart';
import 'package:drift/drift.dart' hide Column;

import '../../../../core/storage/app_database.dart';
import '../../domain/entities/exercise.dart';
import '../datasources/seed_exercises.dart';
import '../../../workouts/data/models/workout_mappers.dart';

/// Contract for the exercise library.
abstract class ExerciseLibraryRepository {
  Future<Either<Failure, List<Exercise>>> getAll();
  Future<Either<Failure, List<Exercise>>> search(String query, {MuscleGroup? muscle});
  Future<Either<Failure, List<Exercise>>> favorites();
  Future<Either<Failure, List<Exercise>>> recent({int limit = 10});
  Future<Either<Failure, Exercise>> createCustom(Exercise exercise);
  Future<Either<Failure, void>> toggleFavorite(String exerciseId);
  Future<Either<Failure, void>> markUsed(List<String> exerciseIds);
  Future<Either<Failure, void>> seedIfEmpty();
}

class ExerciseLibraryRepositoryImpl implements ExerciseLibraryRepository {
  ExerciseLibraryRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Either<Failure, List<Exercise>>> getAll() => guard(() async {
        final rows = await (_db.select(_db.exercises)
              ..orderBy([
                (e) => OrderingTerm.asc(e.primaryMuscle),
                (e) => OrderingTerm.asc(e.name),
              ]))
            .get();
        return rows.map((r) => r.toDomain()).toList();
      });

  @override
  Future<Either<Failure, List<Exercise>>> search(String query, {MuscleGroup? muscle}) =>
      guard(() async {
        final q = query.trim();
        final rows = await (_db.select(_db.exercises)
              ..where((e) {
                final matchesQuery = q.isEmpty ? const Constant(true) : e.name.lower().like('%$q%');
                final matchesMuscle = muscle == null ? const Constant(true) : e.primaryMuscle.equals(muscle.name);
                return matchesQuery & matchesMuscle;
              })
              ..orderBy([(e) => OrderingTerm.asc(e.name)]))
            .get();
        return rows.map((r) => r.toDomain()).toList();
      });

  @override
  Future<Either<Failure, List<Exercise>>> favorites() => guard(() async {
        final rows = await (_db.select(_db.exercises)
              ..where((e) => e.isFavorite.equals(true))
              ..orderBy([(e) => OrderingTerm.desc(e.lastUsedAt)]))
            .get();
        return rows.map((r) => r.toDomain()).toList();
      });

  @override
  Future<Either<Failure, List<Exercise>>> recent({int limit = 10}) => guard(() async {
        final rows = await (_db.select(_db.exercises)
              ..where((e) => e.lastUsedAt.isNotNull())
              ..orderBy([(e) => OrderingTerm.desc(e.lastUsedAt)]))
            .get();
        return rows.take(limit).map((r) => r.toDomain()).toList();
      });

  @override
  Future<Either<Failure, Exercise>> createCustom(Exercise exercise) => guard(() async {
        await _db.into(_db.exercises).insertOnConflictUpdate(exercise.toCompanion());
        return exercise;
      });

  @override
  Future<Either<Failure, void>> toggleFavorite(String exerciseId) => guard(() async {
        final row = await (_db.select(_db.exercises)
              ..where((e) => e.id.equals(exerciseId))
              ..limit(1))
            .getSingle();
        await (_db.update(_db.exercises)..where((e) => e.id.equals(exerciseId)))
            .write(ExercisesCompanion(isFavorite: Value(!row.isFavorite)));
      });

  @override
  Future<Either<Failure, void>> markUsed(List<String> exerciseIds) => guard(() async {
        final now = DateTime.now();
        await (_db.update(_db.exercises)
              ..where((e) => e.id.isIn(exerciseIds)))
            .write(ExercisesCompanion(lastUsedAt: Value(now)));
      });

  @override
  Future<Either<Failure, void>> seedIfEmpty() => guard(() async {
        final count = await _db.exercises.count().getSingle();
        if (count > 0) return;
        await _db.batch((batch) {
          batch.insertAll(
            _db.exercises,
            seedExercises.map((e) => e.toCompanion()).toList(),
            mode: InsertMode.insertOrIgnore,
          );
        });
      });
}
