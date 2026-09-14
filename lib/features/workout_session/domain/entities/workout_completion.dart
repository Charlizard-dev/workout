import 'package:equatable/equatable.dart';

import 'workout_session.dart';
import '../../../leveling/domain/entities/progression.dart';
import '../../../leveling/domain/entities/xp_transaction.dart';
import '../../../personal_records/domain/entities/personal_record.dart';
import '../../../achievements/domain/entities/achievement.dart';
import '../../../achievements/domain/entities/badge.dart';
import '../../../challenges/domain/entities/challenge.dart';

/// Single XP line item in a workout breakdown.
class XpLine extends Equatable {
  const XpLine({required this.label, required this.amount, required this.source});

  final String label;
  final int amount;
  final XpSource source;

  @override
  List<Object?> get props => [label, amount, source];
}

/// Complete outcome of finishing a workout: everything the summary screen,
/// animations, and share cards need. Fully typed.
class WorkoutCompletionResult extends Equatable {
  const WorkoutCompletionResult({
    required this.session,
    required this.xpLines,
    required this.totalXp,
    required this.progressionAfter,
    required this.levelUps,
    required this.rankBefore,
    required this.rankAfter,
    required this.newRecords,
    required this.unlockedAchievements,
    required this.newBadges,
    required this.completedChallenges,
    required this.streakAfter,
    required this.streakMilestone,
    required this.duplicate,
  });

  final WorkoutSession session;
  final List<XpLine> xpLines;
  final int totalXp;
  final UserProgression progressionAfter;
  final int levelUps;

  /// Rank name before/after for rank-up celebration (same when no rank-up).
  final String rankBefore;
  final String rankAfter;

  final List<PersonalRecord> newRecords;
  final List<AchievementDefinition> unlockedAchievements;
  final List<BadgeDefinition> newBadges;
  final List<ChallengeDefinition> completedChallenges;

  final int streakAfter;
  final int? streakMilestone;

  /// True when this workout's rewards were already claimed before
  /// (idempotent replay — UI shows a friendly note instead of re-awarding).
  final bool duplicate;

  @override
  List<Object?> get props => [
        session, xpLines, totalXp, progressionAfter, levelUps,
        rankBefore, rankAfter, newRecords, unlockedAchievements,
        newBadges, completedChallenges, streakAfter, streakMilestone, duplicate,
      ];
}
