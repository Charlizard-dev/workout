import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../workouts/domain/entities/workout_routine.dart';
import '../../domain/entities/workout_session.dart';

/// Contract for live workout sessions and history.
abstract class WorkoutSessionRepository {
  Future<Either<Failure, WorkoutSession>> startFromRoutine(WorkoutRoutine routine, {DateTime? scheduledDate, bool wasScheduled});
  Future<Either<Failure, WorkoutSession?>> getActive();
  Future<Either<Failure, WorkoutSession>> save(WorkoutSession session);
  Future<Either<Failure, List<WorkoutSession>>> history({int limit = 100, int offset = 0});
  Future<Either<Failure, WorkoutSession>> complete(WorkoutSession session);
  Future<Either<Failure, void>> abandon(String sessionId);
  Future<Either<Failure, WorkoutSession?>> getById(String sessionId);
}
