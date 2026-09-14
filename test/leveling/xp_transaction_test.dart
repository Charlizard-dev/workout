import 'package:charlizard/features/leveling/domain/entities/xp_transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('XpTransaction idempotency keys', () {
    test('workout-bound transactions expose a (workoutId, source) key', () {
      final txn = XpTransaction(
        id: 't1',
        userId: 'u1',
        amount: 100,
        source: XpSource.workoutCompleted,
        description: 'Workout Completed',
        workoutId: 'w1',
        createdAt: DateTime(2026, 1, 1),
      );
      expect(txn.idempotencyKey, ('w1', XpSource.workoutCompleted));
    });

    test('distinct sources on the same workout have distinct keys', () {
      final a = XpTransaction(
        id: 't1',
        userId: 'u1',
        amount: 100,
        source: XpSource.workoutCompleted,
        description: 'Workout Completed',
        workoutId: 'w1',
        createdAt: DateTime(2026, 1, 1),
      );
      final b = XpTransaction(
        id: 't2',
        userId: 'u1',
        amount: 50,
        source: XpSource.personalRecord,
        description: 'PR',
        workoutId: 'w1',
        createdAt: DateTime(2026, 1, 1),
      );
      expect(a.idempotencyKey, isNot(equals(b.idempotencyKey)));
    });

    test('transactions without a workout have no idempotency key', () {
      final txn = XpTransaction(
        id: 't1',
        userId: 'u1',
        amount: 25,
        source: XpSource.streak,
        description: 'Streak',
        createdAt: DateTime(2026, 1, 1),
      );
      expect(txn.workoutId, isNull);
      expect(txn.idempotencyKey, isNull);
    });

    test('XpSource covers every legitimate reward channel', () {
      expect(
        XpSource.values,
        containsAll([
          XpSource.workoutCompleted,
          XpSource.scheduledWorkout,
          XpSource.personalRecord,
          XpSource.streak,
          XpSource.achievement,
          XpSource.dailyChallenge,
          XpSource.weeklyChallenge,
          XpSource.monthlyChallenge,
        ]),
      );
    });
  });
}
