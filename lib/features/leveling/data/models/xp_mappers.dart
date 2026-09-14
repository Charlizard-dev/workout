import 'package:drift/drift.dart' show Value;

import '../../../../core/storage/app_database.dart';
import '../../../leveling/domain/entities/xp_transaction.dart';

/// Row-level mappers for the leveling feature.
extension XpTransactionRowToDomain on XpTransactionRow {
  XpTransaction toDomain() => XpTransaction(
        id: id,
        userId: userId,
        amount: amount,
        source: switch (source) {
          'workoutCompleted' => XpSource.workoutCompleted,
          'scheduledWorkout' => XpSource.scheduledWorkout,
          'personalRecord' => XpSource.personalRecord,
          'streak' => XpSource.streak,
          'achievement' => XpSource.achievement,
          'dailyChallenge' => XpSource.dailyChallenge,
          'weeklyChallenge' => XpSource.weeklyChallenge,
          _ => XpSource.monthlyChallenge,
        },
        description: description,
        workoutId: workoutId,
        createdAt: createdAt,
      );
}

extension XpTransactionToRow on XpTransaction {
  XpTransactionRow toRow() => XpTransactionRow(
        id: id,
        userId: userId,
        amount: amount,
        source: source.name,
        description: description,
        workoutId: workoutId,
        createdAt: createdAt,
      );
}

extension XpTransactionCompanionExt on XpTransaction {
  XpTransactionsCompanion toCompanion() => XpTransactionsCompanion(
        id: Value(id),
        userId: Value(userId),
        amount: Value(amount),
        source: Value(source.name),
        description: Value(description),
        workoutId: Value(workoutId),
        createdAt: Value(createdAt),
      );
}
