import 'package:equatable/equatable.dart';

/// Achievement families group the unlock list in UI.
enum AchievementFamily { workouts, strength, streaks, music, dedication }

extension AchievementFamilyX on AchievementFamily {
  String get label => switch (this) {
        AchievementFamily.workouts => 'Workouts',
        AchievementFamily.strength => 'Strength',
        AchievementFamily.streaks => 'Streaks',
        AchievementFamily.music => 'Music',
        AchievementFamily.dedication => 'Dedication',
      };
}

/// Metric an achievement is measured against.
enum AchievementMetric {
  totalWorkouts,
  personalRecords,
  currentStreak,
  longestStreak,
  spotifyWorkouts,
  tracksDuringWorkouts,
  playlistWorkouts,
  totalVolumeKg,
  distinctExercises,
  weeklyWorkouts,
}

/// Static definition of an achievement. Progress lives in [UserAchievement].
class AchievementDefinition extends Equatable {
  const AchievementDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.family,
    required this.metric,
    required this.threshold,
    required this.xpReward,
    this.icon,
    this.badgeId,
  });

  final String id;
  final String name;
  final String description;
  final AchievementFamily family;
  final AchievementMetric metric;
  final int threshold;
  final int xpReward;
  final String? icon;
  final String? badgeId;

  @override
  List<Object?> get props => [id, name, description, family, metric, threshold, xpReward, icon, badgeId];
}

/// A user's unlock state for an achievement.
class UserAchievement extends Equatable {
  const UserAchievement({
    required this.definition,
    required this.unlockedAt,
    required this.progress,
    required this.isUnlocked,
  });

  final AchievementDefinition definition;
  final DateTime? unlockedAt;
  final int progress;
  final bool isUnlocked;

  double get progressFraction =>
      definition.threshold == 0 ? 0 : (progress / definition.threshold).clamp(0.0, 1.0);

  UserAchievement copyWith({int? progress, bool? isUnlocked, DateTime? unlockedAt}) =>
      UserAchievement(
        definition: definition,
        progress: progress ?? this.progress,
        isUnlocked: isUnlocked ?? this.isUnlocked,
        unlockedAt: unlockedAt ?? this.unlockedAt,
      );

  @override
  List<Object?> get props => [definition, unlockedAt, progress, isUnlocked];
}

/// Shipped achievement catalog. Extend via config; UI reads, never invents.
const List<AchievementDefinition> defaultAchievements = [
  // Workouts
  AchievementDefinition(id: 'ach_first_workout', name: 'First Step', description: 'Complete your first workout', family: AchievementFamily.workouts, metric: AchievementMetric.totalWorkouts, threshold: 1, xpReward: 50, icon: 'fitness_center', badgeId: 'badge_first_workout'),
  AchievementDefinition(id: 'ach_5_workouts', name: 'Getting Started', description: 'Complete 5 workouts', family: AchievementFamily.workouts, metric: AchievementMetric.totalWorkouts, threshold: 5, xpReward: 100, icon: 'fitness_center'),
  AchievementDefinition(id: 'ach_25_workouts', name: 'Consistent', description: 'Complete 25 workouts', family: AchievementFamily.workouts, metric: AchievementMetric.totalWorkouts, threshold: 25, xpReward: 250, icon: 'fitness_center', badgeId: 'badge_25_workouts'),
  AchievementDefinition(id: 'ach_100_workouts', name: 'Dedicated', description: 'Complete 100 workouts', family: AchievementFamily.workouts, metric: AchievementMetric.totalWorkouts, threshold: 100, xpReward: 750, icon: 'emoji_events', badgeId: 'badge_100_workouts'),
  AchievementDefinition(id: 'ach_500_workouts', name: 'Unstoppable', description: 'Complete 500 workouts', family: AchievementFamily.workouts, metric: AchievementMetric.totalWorkouts, threshold: 500, xpReward: 3000, icon: 'emoji_events', badgeId: 'badge_500_workouts'),
  // Strength
  AchievementDefinition(id: 'ach_first_pr', name: 'Stronger Every Day', description: 'Set your first personal record', family: AchievementFamily.strength, metric: AchievementMetric.personalRecords, threshold: 1, xpReward: 50, icon: 'trending_up'),
  AchievementDefinition(id: 'ach_10_prs', name: 'PR Machine', description: 'Set 10 personal records', family: AchievementFamily.strength, metric: AchievementMetric.personalRecords, threshold: 10, xpReward: 200, icon: 'trending_up'),
  AchievementDefinition(id: 'ach_50_prs', name: 'Powerhouse', description: 'Set 50 personal records', family: AchievementFamily.strength, metric: AchievementMetric.personalRecords, threshold: 50, xpReward: 600, icon: 'trending_up', badgeId: 'badge_50_prs'),
  // Streaks
  AchievementDefinition(id: 'ach_streak_3', name: 'On Fire', description: 'Reach a 3-day workout streak', family: AchievementFamily.streaks, metric: AchievementMetric.longestStreak, threshold: 3, xpReward: 25, icon: 'local_fire_department'),
  AchievementDefinition(id: 'ach_streak_7', name: 'Week Warrior', description: 'Reach a 7-day workout streak', family: AchievementFamily.streaks, metric: AchievementMetric.longestStreak, threshold: 7, xpReward: 100, icon: 'local_fire_department', badgeId: 'badge_streak_7'),
  AchievementDefinition(id: 'ach_streak_30', name: 'Consistency King', description: 'Reach a 30-day workout streak', family: AchievementFamily.streaks, metric: AchievementMetric.longestStreak, threshold: 30, xpReward: 500, icon: 'local_fire_department', badgeId: 'badge_streak_30'),
  AchievementDefinition(id: 'ach_streak_100', name: 'Unbreakable', description: 'Reach a 100-day workout streak', family: AchievementFamily.streaks, metric: AchievementMetric.longestStreak, threshold: 100, xpReward: 2000, icon: 'local_fire_department', badgeId: 'badge_streak_100'),
  // Music
  AchievementDefinition(id: 'ach_spotify_10', name: 'Workout DJ', description: 'Complete 10 workouts while listening to Spotify', family: AchievementFamily.music, metric: AchievementMetric.spotifyWorkouts, threshold: 10, xpReward: 100, icon: 'music_note', badgeId: 'badge_workout_dj'),
  AchievementDefinition(id: 'ach_spotify_tracks_100', name: 'Music & Muscle', description: 'Play 100 tracks during workouts', family: AchievementFamily.music, metric: AchievementMetric.tracksDuringWorkouts, threshold: 100, xpReward: 150, icon: 'music_note'),
  AchievementDefinition(id: 'ach_spotify_playlist_25', name: 'Power Playlist', description: 'Complete 25 workouts using playlists', family: AchievementFamily.music, metric: AchievementMetric.playlistWorkouts, threshold: 25, xpReward: 200, icon: 'queue_music'),
  // Dedication
  AchievementDefinition(id: 'ach_volume_100k', name: 'Century Tonne', description: 'Lift 100,000 kg of total volume', family: AchievementFamily.dedication, metric: AchievementMetric.totalVolumeKg, threshold: 100000, xpReward: 500, icon: 'fitness_center', badgeId: 'badge_100k_volume'),
  AchievementDefinition(id: 'ach_exercises_20', name: 'Explorer', description: 'Train 20 different exercises', family: AchievementFamily.dedication, metric: AchievementMetric.distinctExercises, threshold: 20, xpReward: 150, icon: 'explore'),
  AchievementDefinition(id: 'ach_week_5', name: 'Full Week', description: 'Complete 5 workouts in one week', family: AchievementFamily.dedication, metric: AchievementMetric.weeklyWorkouts, threshold: 5, xpReward: 100, icon: 'date_range'),
];
