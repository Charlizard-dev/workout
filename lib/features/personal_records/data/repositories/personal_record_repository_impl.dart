import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/app_database.dart';
import '../../../authentication/data/session_controller.dart';
import '../../../workouts/data/models/workout_mappers.dart';
import '../../domain/entities/personal_record.dart';

abstract class PersonalRecordRepository {
  Future<Either<Failure, List<PersonalRecord>>> getRecent({int limit = 30});
  Future<Either<Failure, List<PersonalRecord>>> getForExercise(String exerciseId);
}

class PersonalRecordRepositoryImpl implements PersonalRecordRepository {
  PersonalRecordRepositoryImpl(this._db, {SessionController? session})
      : _session = session; // ignore: prefer_initializing_formals

  final AppDatabase _db;
  final SessionController? _session;

  /// Live user id; falls back to the legacy device row when signed out.
  String get _userId => _session?.userId ?? 'local-user';

  @override
  Future<Either<Failure, List<PersonalRecord>>> getRecent({int limit = 30}) =>
      guard(() async {
        final rows = await (_db.select(_db.personalRecords)
              ..where((p) => p.userId.equals(_userId))
              ..orderBy([(p) => OrderingTerm.desc(p.achievedAt)])
              ..limit(limit))
            .get();
        return rows.map((r) => r.toDomain()).toList();
      });

  @override
  Future<Either<Failure, List<PersonalRecord>>> getForExercise(
          String exerciseId) =>
      guard(() async {
        final rows = await (_db.select(_db.personalRecords)
              ..where((p) =>
                  p.userId.equals(_userId) & p.exerciseId.equals(exerciseId))
              ..orderBy([(p) => OrderingTerm.desc(p.achievedAt)]))
            .get();
        return rows.map((r) => r.toDomain()).toList();
      });
}
