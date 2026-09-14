import '../domain/entities/story_entities.dart';
import '../../leveling/domain/entities/progression.dart';
import '../../workout_session/domain/entities/workout_completion.dart';

/// Builds typed [StoryContent] payloads for the share flow. Keeps the
/// mapping from domain results to story cards in one place so screens and
/// the router never hand-assemble story fields.
abstract final class StoryContentFactory {
  static String initialsFor(String name) {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return String.fromCharCode(parts.first.runes.first).toUpperCase();
    }
    return (String.fromCharCode(parts.first.runes.first) +
            String.fromCharCode(parts.last.runes.first))
        .toUpperCase();
  }

  static StoryContent profile({
    required String userName,
    required UserProgression progression,
    String? photoUrl,
    StoryStyle style = StoryStyle.darkAthletic,
    SharePrivacyConfig privacy = const SharePrivacyConfig(),
  }) =>
      StoryContent(
        type: StoryType.profile,
        style: style,
        privacy: privacy,
        userName: userName,
        userInitials: initialsFor(userName),
        photoUrl: photoUrl,
        level: progression.level,
        rankName: progression.rank.name,
        titleName: progression.title.name,
        currentXp: progression.currentXp,
        xpForNextLevel: progression.xpForNextLevel,
        lifetimeXp: progression.lifetimeXp,
        streakDays: progression.currentStreak,
        totalWorkouts: progression.totalWorkouts,
        badgeCount: progression.badgeCount,
      );

  static StoryContent workout({
    required WorkoutCompletionResult result,
    required String userName,
    String? photoUrl,
    StoryStyle style = StoryStyle.darkAthletic,
    SharePrivacyConfig privacy = const SharePrivacyConfig(),
  }) {
    final session = result.session;
    return StoryContent(
      type: StoryType.workout,
      style: style,
      privacy: privacy,
      userName: userName,
      userInitials: initialsFor(userName),
      photoUrl: photoUrl,
      level: result.progressionAfter.level,
      rankName: result.progressionAfter.rank.name,
      titleName: result.progressionAfter.title.name,
      workoutName: session.name,
      workoutDuration: session.duration,
      workoutSets: session.totalSets,
      workoutVolumeKg: session.totalVolume,
      personalRecordCount: result.newRecords.length,
      xpEarned: result.totalXp,
      streakDays: result.streakAfter,
    );
  }

  static StoryContent levelUp({
    required UserProgression after,
    required int oldLevel,
    required int xpEarned,
    required String userName,
    String? photoUrl,
    StoryStyle style = StoryStyle.darkAthletic,
    SharePrivacyConfig privacy = const SharePrivacyConfig(),
  }) =>
      StoryContent(
        type: StoryType.levelUp,
        style: style,
        privacy: privacy,
        userName: userName,
        photoUrl: photoUrl,
        userInitials: initialsFor(userName),
        level: after.level,
        newLevel: after.level,
        oldLevel: oldLevel,
        rankName: after.rank.name,
        titleName: after.title.name,
        xpEarned: xpEarned,
      );
}
