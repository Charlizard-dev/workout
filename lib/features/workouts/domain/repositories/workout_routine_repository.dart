import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/workout_routine.dart';

/// Contract for routine CRUD + ordering.
abstract class WorkoutRoutineRepository {
  Future<Either<Failure, List<WorkoutRoutine>>> getAll();
  Future<Either<Failure, WorkoutRoutine>> getById(String id);
  Future<Either<Failure, WorkoutRoutine>> save(WorkoutRoutine routine);
  Future<Either<Failure, void>> delete(String routineId);
  Future<Either<Failure, void>> duplicate(String routineId);
  Future<Either<Failure, void>> reorder(List<String> routineIdsInOrder);
  Future<Either<Failure, int>> countAll();
}
