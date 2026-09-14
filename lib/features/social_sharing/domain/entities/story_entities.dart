import 'package:equatable/equatable.dart';

/// Which story template to render.
enum StoryType {
  profile,
  workout,
  levelUp,
  rankUp,
  personalRecord,
  achievement,
  streak,
  challenge,
}

/// Visual style variants within the Charlizard design system.
enum StoryStyle { darkAthletic, minimal, neon, gradient, spotifyWorkout }

/// Where the story is being shared.
enum ShareTarget { instagramStory, facebookStory, systemShare, saveImage }

/// User-controlled privacy switches for story content.
class SharePrivacyConfig extends Equatable {
  const SharePrivacyConfig({
    this.showLevel = true,
    this.showRank = true,
    this.showXp = true,
    this.showStreak = true,
    this.showTotalWorkouts = true,
    this.showVolume = false,
    this.showPersonalRecords = false,
    this.showQrCode = false,
  });

  final bool showLevel;
  final bool showRank;
  final bool showXp;
  final bool showStreak;
  final bool showTotalWorkouts;
  final bool showVolume;
  final bool showPersonalRecords;
  final bool showQrCode;

  SharePrivacyConfig copyWith({
    bool? showLevel,
    bool? showRank,
    bool? showXp,
    bool? showStreak,
    bool? showTotalWorkouts,
    bool? showVolume,
    bool? showPersonalRecords,
    bool? showQrCode,
  }) =>
      SharePrivacyConfig(
        showLevel: showLevel ?? this.showLevel,
        showRank: showRank ?? this.showRank,
        showXp: showXp ?? this.showXp,
        showStreak: showStreak ?? this.showStreak,
        showTotalWorkouts: showTotalWorkouts ?? this.showTotalWorkouts,
        showVolume: showVolume ?? this.showVolume,
        showPersonalRecords: showPersonalRecords ?? this.showPersonalRecords,
        showQrCode: showQrCode ?? this.showQrCode,
      );

  @override
  List<Object?> get props => [
        showLevel, showRank, showXp, showStreak, showTotalWorkouts,
        showVolume, showPersonalRecords, showQrCode,
      ];
}

/// Everything the story generator needs to render a card. Fully typed —
/// no `Map<String, dynamic>`.
class StoryContent extends Equatable {
  const StoryContent({
    required this.type,
    required this.style,
    required this.privacy,
    this.userName,
    this.userInitials,
    this.photoUrl,
    this.level,
    this.rankName,
    this.titleName,
    this.currentXp,
    this.xpForNextLevel,
    this.lifetimeXp,
    this.streakDays,
    this.totalWorkouts,
    this.badgeCount,
    this.workoutName,
    this.workoutDuration,
    this.workoutSets,
    this.workoutVolumeKg,
    this.personalRecordCount,
    this.xpEarned,
    this.newLevel,
    this.oldLevel,
    this.oldRankName,
    this.exerciseName,
    this.prWeightKg,
    this.prReps,
    this.prPreviousWeightKg,
    this.achievementName,
    this.achievementEmoji,
    this.achievementDescription,
    this.challengeTitle,
    this.challengeTarget,
    this.challengeRewardXp,
    this.streakMilestoneDays,
  });

  final StoryType type;
  final StoryStyle style;
  final SharePrivacyConfig privacy;

  // Identity
  final String? userName;
  final String? userInitials;
  final String? photoUrl;

  // Progression
  final int? level;
  final String? rankName;
  final String? titleName;
  final int? currentXp;
  final int? xpForNextLevel;
  final int? lifetimeXp;
  final int? streakDays;
  final int? totalWorkouts;
  final int? badgeCount;

  // Workout
  final String? workoutName;
  final Duration? workoutDuration;
  final int? workoutSets;
  final double? workoutVolumeKg;
  final int? personalRecordCount;
  final int? xpEarned;

  // Level-up / rank-up
  final int? newLevel;
  final int? oldLevel;
  final String? oldRankName;

  // Personal record
  final String? exerciseName;
  final double? prWeightKg;
  final int? prReps;
  final double? prPreviousWeightKg;

  // Achievement
  final String? achievementName;
  final String? achievementEmoji;
  final String? achievementDescription;

  // Challenge
  final String? challengeTitle;
  final int? challengeTarget;
  final int? challengeRewardXp;

  // Streak
  final int? streakMilestoneDays;

  @override
  List<Object?> get props => [
        type, style, privacy, userName, userInitials, photoUrl,
        level, rankName, titleName, currentXp, xpForNextLevel, lifetimeXp,
        streakDays, totalWorkouts, badgeCount,
        workoutName, workoutDuration, workoutSets, workoutVolumeKg,
        personalRecordCount, xpEarned, newLevel, oldLevel, oldRankName,
        exerciseName, prWeightKg, prReps, prPreviousWeightKg,
        achievementName, achievementEmoji, achievementDescription,
        challengeTitle, challengeTarget, challengeRewardXp, streakMilestoneDays,
      ];
}

/// Outcome of a share flow.
class StoryShareResult extends Equatable {
  const StoryShareResult({
    required this.success,
    required this.target,
    this.filePath,
    this.usedFallback = false,
    this.errorMessage,
  });

  final bool success;
  final ShareTarget target;
  final String? filePath;
  final bool usedFallback;
  final String? errorMessage;

  @override
  List<Object?> get props => [success, target, filePath, usedFallback, errorMessage];
}
