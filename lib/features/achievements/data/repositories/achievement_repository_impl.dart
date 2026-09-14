import 'package:dartz/dartz.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/errors/failures.dart';
import 'package:drift/drift.dart';

import '../../../../core/storage/app_database.dart';
import '../../../authentication/data/session_controller.dart';
import '../../domain/entities/achievement.dart';
import '../../domain/entities/badge.dart';

/// Read model combining catalog definitions with user unlock state.
class AchievementWithState {
  const AchievementWithState({
    required this.definition,
    required this.progress,
    required this.unlocked,
    this.unlockedAt,
  });

  final AchievementDefinition definition;
  final int progress;
  final bool unlocked;
  final DateTime? unlockedAt;
}

abstract class AchievementRepository {
  Future<Either<Failure, List<AchievementWithState>>> getAll();
  Future<Either<Failure, List<UserBadge>>> getBadges();
  Future<Either<Failure, void>> setShowcased(List<String> badgeIds);
}

class AchievementRepositoryImpl implements AchievementRepository {
  AchievementRepositoryImpl(this._db, {SessionController? session})
      : _session = session; // ignore: prefer_initializing_formals

  final AppDatabase _db;
  final SessionController? _session;

  /// Live user id; falls back to the legacy device row when signed out.
  String get _userId => _session?.userId ?? 'local-user';

  @override
  Future<Either<Failure, List<AchievementWithState>>> getAll() =>
      guard(() async {
        final rows = await (_db.select(_db.userAchievements)
              ..where((a) => a.userId.equals(_userId)))
            .get();
        final byId = {for (final r in rows) r.achievementId: r};
        return defaultAchievements
            .map((def) {
              final row = byId[def.id];
              return AchievementWithState(
                definition: def,
                progress: row?.progress ?? 0,
                unlocked: row?.unlocked ?? false,
                unlockedAt: row?.unlockedAt,
              );
            })
            .toList()
          ..sort((a, b) {
            if (a.unlocked != b.unlocked) return a.unlocked ? 1 : -1;
            return a.definition.family.index
                .compareTo(b.definition.family.index);
          });
      });

  @override
  Future<Either<Failure, List<UserBadge>>> getBadges() => guard(() async {
        final rows = await (_db.select(_db.userBadges)
              ..where((b) => b.userId.equals(_userId))
              ..orderBy([
                (b) => OrderingTerm.desc(b.earnedAt),
              ]))
            .get();
        final byId = {for (final d in defaultBadges) d.id: d};
        return rows
            .where((r) => byId.containsKey(r.badgeId))
            .map((r) => UserBadge(
                  definition: byId[r.badgeId]!,
                  earnedAt: r.earnedAt,
                  isShowcased: r.isShowcased,
                ))
            .toList();
      });

  @override
  Future<Either<Failure, void>> setShowcased(List<String> badgeIds) =>
      guard(() => _db.transaction(() async {
            await (_db.update(_db.userBadges)
                  ..where((b) => b.userId.equals(_userId)))
                .write(const UserBadgesCompanion(isShowcased: Value(false)));
            if (badgeIds.isNotEmpty) {
              await (_db.update(_db.userBadges)
                    ..where((b) =>
                        b.userId.equals(_userId) &
                        b.badgeId.isIn(badgeIds)))
                  .write(const UserBadgesCompanion(isShowcased: Value(true)));
            }
          }));
}
