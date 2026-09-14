import 'package:equatable/equatable.dart';

/// Cadence of a challenge.
enum ChallengePeriod { daily, weekly, monthly }

extension ChallengePeriodX on ChallengePeriod {
  String get label => switch (this) {
        ChallengePeriod.daily => 'Daily Challenge',
        ChallengePeriod.weekly => 'Weekly Challenge',
        ChallengePeriod.monthly => 'Monthly Challenge',
      };
}

/// What a challenge measures.
enum ChallengeMetric {
  completeWorkout,
  totalSets,
  totalVolume,
  trainingMinutes,
  distinctExercises,
  personalRecords,
  workoutsThisPeriod,
  scheduledWorkoutsCompleted,
  beatPreviousVolume,
  pushPullLegs,
  distinctDays,
}

/// Static challenge definition.
class ChallengeDefinition extends Equatable {
  const ChallengeDefinition({
    required this.id,
    required this.period,
    required this.title,
    required this.description,
    required this.metric,
    required this.target,
    required this.xpReward,
    this.icon,
  });

  final String id;
  final ChallengePeriod period;
  final String title;
  final String description;
  final ChallengeMetric metric;
  final int target;
  final int xpReward;
  final String? icon;

  @override
  List<Object?> get props => [id, period, title, description, metric, target, xpReward, icon];
}

/// Runtime state of a challenge within its period window.
class ChallengeProgress extends Equatable {
  const ChallengeProgress({
    required this.definition,
    required this.periodKey,
    required this.current,
    required this.claimed,
    this.completedAt,
  });

  /// Identifies the window, e.g. '2026-W37' or '2026-09-14' or '2026-09'.
  final String periodKey;
  final ChallengeDefinition definition;
  final int current;
  final bool claimed;
  final DateTime? completedAt;

  bool get isComplete => current >= definition.target;

  double get progressFraction =>
      definition.target == 0 ? 0 : (current / definition.target).clamp(0.0, 1.0);

  ChallengeProgress copyWith({int? current, bool? claimed, DateTime? completedAt}) =>
      ChallengeProgress(
        definition: definition,
        periodKey: periodKey,
        current: current ?? this.current,
        claimed: claimed ?? this.claimed,
        completedAt: completedAt ?? this.completedAt,
      );

  @override
  List<Object?> get props => [definition, periodKey, current, claimed, completedAt];
}

/// Rotating pools from which one challenge per period is drawn.
const List<ChallengeDefinition> dailyChallenges = [
  ChallengeDefinition(id: 'ch_daily_sets_15', period: ChallengePeriod.daily, title: 'Complete 15 Sets', description: 'Finish 15 working sets today', metric: ChallengeMetric.totalSets, target: 15, xpReward: 50, icon: 'repeats'),
  ChallengeDefinition(id: 'ch_daily_workout', period: ChallengePeriod.daily, title: 'Complete a Workout', description: 'Finish any workout today', metric: ChallengeMetric.completeWorkout, target: 1, xpReward: 50, icon: 'fitness_center'),
  ChallengeDefinition(id: 'ch_daily_30min', period: ChallengePeriod.daily, title: 'Train for 30 Minutes', description: 'Spend 30 minutes under the bar', metric: ChallengeMetric.trainingMinutes, target: 30, xpReward: 50, icon: 'schedule'),
  ChallengeDefinition(id: 'ch_daily_exercises_3', period: ChallengePeriod.daily, title: '3 Different Exercises', description: 'Complete sets on 3 distinct exercises', metric: ChallengeMetric.distinctExercises, target: 3, xpReward: 50, icon: 'category'),
  ChallengeDefinition(id: 'ch_daily_scheduled', period: ChallengePeriod.daily, title: 'Stick to the Plan', description: 'Complete today\u2019s scheduled workout', metric: ChallengeMetric.scheduledWorkoutsCompleted, target: 1, xpReward: 50, icon: 'event_available'),
  ChallengeDefinition(id: 'ch_daily_volume', period: ChallengePeriod.daily, title: 'Beat Yesterday', description: 'Beat your previous workout volume', metric: ChallengeMetric.beatPreviousVolume, target: 1, xpReward: 50, icon: 'trending_up'),
];

const List<ChallengeDefinition> weeklyChallenges = [
  ChallengeDefinition(id: 'ch_week_workouts_4', period: ChallengePeriod.weekly, title: 'Complete 4 Workouts', description: 'Four sessions this week', metric: ChallengeMetric.workoutsThisPeriod, target: 4, xpReward: 250, icon: 'fitness_center'),
  ChallengeDefinition(id: 'ch_week_minutes_180', period: ChallengePeriod.weekly, title: 'Train 180 Minutes', description: 'Three hours of training this week', metric: ChallengeMetric.trainingMinutes, target: 180, xpReward: 250, icon: 'schedule'),
  ChallengeDefinition(id: 'ch_week_sets_80', period: ChallengePeriod.weekly, title: 'Complete 80 Sets', description: 'Eighty working sets this week', metric: ChallengeMetric.totalSets, target: 80, xpReward: 250, icon: 'repeats'),
  ChallengeDefinition(id: 'ch_week_pr_2', period: ChallengePeriod.weekly, title: 'Beat 2 Records', description: 'Set 2 personal records this week', metric: ChallengeMetric.personalRecords, target: 2, xpReward: 250, icon: 'trending_up'),
  ChallengeDefinition(id: 'ch_week_ppl', period: ChallengePeriod.weekly, title: 'Push, Pull & Legs', description: 'Complete a push, pull and leg workout', metric: ChallengeMetric.pushPullLegs, target: 3, xpReward: 250, icon: 'category'),
  ChallengeDefinition(id: 'ch_week_days_4', period: ChallengePeriod.weekly, title: 'Train on 4 Days', description: 'Four different training days this week', metric: ChallengeMetric.distinctDays, target: 4, xpReward: 250, icon: 'calendar'),
];

const List<ChallengeDefinition> monthlyChallenges = [
  ChallengeDefinition(id: 'ch_month_workouts_16', period: ChallengePeriod.monthly, title: 'Complete 16 Workouts', description: 'Sixteen sessions this month', metric: ChallengeMetric.workoutsThisPeriod, target: 16, xpReward: 750, icon: 'fitness_center'),
  ChallengeDefinition(id: 'ch_month_sets_300', period: ChallengePeriod.monthly, title: '300 Sets', description: 'Three hundred working sets this month', metric: ChallengeMetric.totalSets, target: 300, xpReward: 750, icon: 'repeats'),
  ChallengeDefinition(id: 'ch_month_minutes_720', period: ChallengePeriod.monthly, title: '12 Hours of Training', description: '720 training minutes this month', metric: ChallengeMetric.trainingMinutes, target: 720, xpReward: 750, icon: 'schedule'),
  ChallengeDefinition(id: 'ch_month_pr_8', period: ChallengePeriod.monthly, title: '8 Personal Records', description: 'Set 8 PRs this month', metric: ChallengeMetric.personalRecords, target: 8, xpReward: 750, icon: 'trending_up'),
];
