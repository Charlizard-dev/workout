import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/xp_transaction.dart';
import '../entities/progression.dart';

/// Read side of the progression store.
abstract class ProgressionRepository {
  Future<Either<Failure, UserProgression>> getProgression();
  Future<Either<Failure, List<XpTransaction>>> getXpHistory({int limit = 50});
  /// True when this workout+source XP was already granted (idempotency).
  Future<Either<Failure, bool>> isXpClaimed(String workoutId, XpSource source);
}

/// Write side. [grantXp] is atomic: transaction ledger + snapshot update.
abstract class ProgressionWriteRepository {
  Future<Either<Failure, XpApplicationResult>> grantXp(XpTransaction transaction);
}
