import 'package:equatable/equatable.dart';

/// Earned visual badge shown on profiles.
class BadgeDefinition extends Equatable {
  const BadgeDefinition({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
  });

  final String id;
  final String name;
  final String emoji;
  final String description;

  @override
  List<Object?> get props => [id, name, emoji, description];
}

/// A badge earned by the user.
class UserBadge extends Equatable {
  const UserBadge({required this.definition, required this.earnedAt, this.isShowcased = false});

  final BadgeDefinition definition;
  final DateTime earnedAt;
  final bool isShowcased;

  UserBadge copyWith({bool? isShowcased}) =>
      UserBadge(definition: definition, earnedAt: earnedAt, isShowcased: isShowcased ?? this.isShowcased);

  @override
  List<Object?> get props => [definition, earnedAt, isShowcased];
}

const List<BadgeDefinition> defaultBadges = [
  BadgeDefinition(id: 'badge_first_workout', name: 'First Rep', emoji: '🏋️', description: 'Completed your first workout'),
  BadgeDefinition(id: 'badge_25_workouts', name: '25 Club', emoji: '🏋️', description: 'Completed 25 workouts'),
  BadgeDefinition(id: 'badge_100_workouts', name: 'Centurion', emoji: '🏋️', description: 'Completed 100 workouts'),
  BadgeDefinition(id: 'badge_500_workouts', name: 'Iron Legend', emoji: '🏋️', description: 'Completed 500 workouts'),
  BadgeDefinition(id: 'badge_50_prs', name: 'PR Collector', emoji: '⚡', description: 'Set 50 personal records'),
  BadgeDefinition(id: 'badge_streak_7', name: 'Week Warrior', emoji: '🔥', description: '7-day workout streak'),
  BadgeDefinition(id: 'badge_streak_30', name: '30-Day Fire', emoji: '🔥', description: '30-day workout streak'),
  BadgeDefinition(id: 'badge_streak_100', name: 'Unbreakable', emoji: '🔥', description: '100-day workout streak'),
  BadgeDefinition(id: 'badge_workout_dj', name: 'Workout DJ', emoji: '🎵', description: '10 workouts with Spotify'),
  BadgeDefinition(id: 'badge_100k_volume', name: 'Century Tonne', emoji: '💯', description: '100,000 kg lifetime volume'),
  BadgeDefinition(id: 'badge_rank_diamond', name: 'Diamond', emoji: '💎', description: 'Reached Diamond rank'),
  BadgeDefinition(id: 'badge_rank_legend', name: 'Legend', emoji: '👑', description: 'Reached level 100'),
];
