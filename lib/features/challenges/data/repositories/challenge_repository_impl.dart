import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/app_database.dart';
import '../../../authentication/data/session_controller.dart';
import '../../domain/entities/challenge.dart';

/// Current-period challenges with live progress, mirroring the selection
/// logic in [CompleteWorkout] so the UI and the engine can never disagree
/// about which challenges are active.
class CurrentChallenges {
  const CurrentChallenges({
    required this.daily,
    required this.weekly,
    required this.monthly,
  });

  final ChallengeProgress daily;
  final ChallengeProgress weekly;
  final ChallengeProgress monthly;
}

abstract class ChallengeRepository {
  Future<Either<Failure, CurrentChallenges>> getCurrent();
}

class ChallengeRepositoryImpl implements ChallengeRepository {
  ChallengeRepositoryImpl(this._db, {SessionController? session})
      : _session = session; // ignore: prefer_initializing_formals

  final AppDatabase _db;
  final SessionController? _session;

  /// Live user id; falls back to the legacy device row when signed out.
  String get _userId => _session?.userId ?? 'local-user';

  @override
  Future<Either<Failure, CurrentChallenges>> getCurrent() =>
      guard(() async {
        final now = DateTime.now();
        final dailyDef = dailyChallenges[
            now.difference(DateTime(now.year)).inDays % dailyChallenges.length];
        final weeklyDef = weeklyChallenges[
            now.difference(DateTime(now.year, now.month, 1)).inDays ~/
                    7 %
                weeklyChallenges.length];
        final monthlyDef =
            monthlyChallenges[now.month % monthlyChallenges.length];

        Future<ChallengeProgress> load(
            ChallengeDefinition def, String periodKey) async {
          final row = await (_db.select(_db.challengeProgress)
                ..where((c) =>
                    c.userId.equals(_userId) &
                    c.periodKey.equals(periodKey) &
                    c.challengeId.equals(def.id))
                ..limit(1))
              .getSingleOrNull();
          return ChallengeProgress(
            definition: def,
            periodKey: periodKey,
            current: row?.current ?? 0,
            claimed: row?.claimed ?? false,
            completedAt: row?.completedAt,
          );
        }

        return CurrentChallenges(
          daily: await load(dailyDef, _dayKey(now)),
          weekly: await load(weeklyDef, _weekKey(now)),
          monthly: await load(monthlyDef, _monthKey(now)),
        );
      });

  String _dayKey(DateTime now) =>
      '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

  String _weekKey(DateTime now) {
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final jan1 = DateTime(monday.year, 1, 1);
    final week = ((monday.difference(jan1).inDays + jan1.weekday - 1) ~/ 7) + 1;
    return '${monday.year}-W${week.toString().padLeft(2, '0')}';
  }

  String _monthKey(DateTime now) =>
      '${now.year}-${now.month.toString().padLeft(2, '0')}';
}
