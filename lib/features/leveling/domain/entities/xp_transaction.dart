import 'package:equatable/equatable.dart';

/// Source of an XP grant. Typed, never free-form strings.
enum XpSource {
  workoutCompleted,
  scheduledWorkout,
  personalRecord,
  streak,
  achievement,
  dailyChallenge,
  weeklyChallenge,
  monthlyChallenge,
}

/// An immutable, auditable XP ledger entry.
///
/// Transactions are the only way XP ever changes hands. The ledger provides
/// audit history, duplicate prevention (idempotency key), and future sync.
class XpTransaction extends Equatable {
  const XpTransaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.source,
    required this.description,
    required this.createdAt,
    this.workoutId,
  });

  final String id;
  final String userId;

  /// Always positive. Deductions (if ever needed) would be a separate,
  /// explicitly-reviewed transaction type.
  final int amount;
  final XpSource source;
  final String description;
  final String? workoutId;

  /// Idempotency key: at most one XP grant per (workoutId, source).
  /// Prevents double-taps, retries, and offline-sync duplicates.
  (String, XpSource)? get idempotencyKey =>
      workoutId == null ? null : (workoutId!, source);

  final DateTime createdAt;

  @override
  List<Object?> get props => [id, userId, amount, source, description, workoutId, createdAt];
}
