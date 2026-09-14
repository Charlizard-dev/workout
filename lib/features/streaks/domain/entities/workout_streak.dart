import 'package:equatable/equatable.dart';


/// A streak counts consecutive days with at least one completed workout,
/// where scheduled rest days do not break the chain.
class WorkoutStreak extends Equatable {
  const WorkoutStreak({
    required this.current,
    required this.longest,
    required this.lastWorkoutDate,
  });

  final int current;
  final int longest;
  final DateTime? lastWorkoutDate;

  bool get isActiveToday {
    final last = lastWorkoutDate;
    if (last == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastDay = DateTime(last.year, last.month, last.day);
    return today.difference(lastDay).inDays == 0;
  }

  WorkoutStreak copyWith({int? current, int? longest, DateTime? lastWorkoutDate}) =>
      WorkoutStreak(
        current: current ?? this.current,
        longest: longest ?? this.longest,
        lastWorkoutDate: lastWorkoutDate ?? this.lastWorkoutDate,
      );

  @override
  List<Object?> get props => [current, longest, lastWorkoutDate];
}

/// Outcome of evaluating a workout completion against the streak.
class StreakUpdateResult extends Equatable {
  const StreakUpdateResult({
    required this.streak,
    required this.incremented,
    required this.milestoneReached,
    this.newLongest = false,
  });

  final WorkoutStreak streak;
  final bool incremented;

  /// Milestone crossed this workout (3, 7, 14, 30, 100...), if any.
  final int? milestoneReached;
  final bool newLongest;

  @override
  List<Object?> get props => [streak, incremented, milestoneReached, newLongest];
}

/// Milestones with rewards. Config-driven, never hardcoded in UI.
class StreakMilestone {
  const StreakMilestone({required this.days, required this.xpReward, this.badgeId});

  final int days;
  final int xpReward;
  final String? badgeId;
}

const List<StreakMilestone> defaultStreakMilestones = [
  StreakMilestone(days: 3, xpReward: 25),
  StreakMilestone(days: 7, xpReward: 100),
  StreakMilestone(days: 14, xpReward: 250),
  StreakMilestone(days: 30, xpReward: 500),
  StreakMilestone(days: 100, xpReward: 1000, badgeId: 'badge_streak_100'),
];
