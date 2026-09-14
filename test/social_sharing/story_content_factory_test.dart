import 'package:charlizard/features/social_sharing/domain/entities/story_entities.dart';
import 'package:charlizard/features/social_sharing/presentation/story_content_factory.dart';
import 'package:charlizard/features/leveling/domain/entities/progression.dart';
import 'package:charlizard/features/leveling/domain/entities/xp_transaction.dart';
import 'package:charlizard/features/leveling/domain/services/progression_rules.dart';
import 'package:charlizard/features/workout_session/domain/entities/workout_completion.dart';
import 'package:charlizard/features/workout_session/domain/entities/workout_session.dart';
import 'package:flutter_test/flutter_test.dart';

UserProgression _progression() {
  const rules = ProgressionRules();
  return UserProgression(
    level: 24,
    currentXp: 2480,
    xpForNextLevel: rules.xpRequiredForLevel(24),
    lifetimeXp: 100000,
    rank: rules.rankForLevel(24),
    title: rules.titleForLevel(24),
    currentStreak: 6,
    longestStreak: 18,
    totalWorkouts: 142,
    achievementsUnlocked: 32,
    achievementsTotal: 75,
    badgeCount: 12,
    challengesCompleted: 9,
  );
}

void main() {
  group('StoryContentFactory.initialsFor', () {
    test('two-word names produce two initials', () {
      expect(StoryContentFactory.initialsFor('Charly Mars'), 'CM');
    });

    test('single names produce one initial', () {
      expect(StoryContentFactory.initialsFor('Charly'), 'C');
    });

    test('blank names fall back to ?', () {
      expect(StoryContentFactory.initialsFor('   '), '?');
    });
  });

  group('StoryContentFactory.profile', () {
    test('maps real progression values (never fake data)', () {
      final content = StoryContentFactory.profile(
        userName: 'Charly',
        progression: _progression(),
      );

      expect(content.type, StoryType.profile);
      expect(content.level, 24);
      expect(content.rankName, 'SILVER');
      expect(content.titleName, 'Advanced Athlete');
      expect(content.currentXp, 2480);
      expect(content.streakDays, 6);
      expect(content.totalWorkouts, 142);
      expect(content.badgeCount, 12);
      expect(content.userInitials, 'C');
    });

    test('privacy defaults expose level/rank/xp/streak/workouts only', () {
      const privacy = SharePrivacyConfig();
      expect(privacy.showLevel, isTrue);
      expect(privacy.showRank, isTrue);
      expect(privacy.showXp, isTrue);
      expect(privacy.showStreak, isTrue);
      expect(privacy.showTotalWorkouts, isTrue);
      // Sensitive fields default OFF.
      expect(privacy.showVolume, isFalse);
      expect(privacy.showPersonalRecords, isFalse);
      expect(privacy.showQrCode, isFalse);
    });
  });

  group('StoryContentFactory.workout', () {
    test('maps a completed session to a workout story', () {
      final session = WorkoutSession(
        id: 's1',
        routineId: 'r1',
        name: 'Push Day',
        startedAt: DateTime(2026, 9, 14, 18),
        completedAt: DateTime(2026, 9, 14, 19, 18),
        status: SessionStatus.completed,
        exercises: const [],
        xpEarned: 220,
        personalRecords: 3,
      );
      final result = WorkoutCompletionResult(
        session: session,
        xpLines: const [
          XpLine(label: 'Workout Completed', amount: 100, source: XpSource.workoutCompleted),
        ],
        totalXp: 220,
        progressionAfter: _progression(),
        levelUps: 0,
        rankBefore: 'SILVER',
        rankAfter: 'SILVER',
        newRecords: const [],
        unlockedAchievements: const [],
        newBadges: const [],
        completedChallenges: const [],
        streakAfter: 7,
        streakMilestone: 7,
        duplicate: false,
      );

      final content = StoryContentFactory.workout(
        result: result,
        userName: 'Charly',
      );

      expect(content.type, StoryType.workout);
      expect(content.workoutName, 'Push Day');
      expect(content.workoutDuration, const Duration(hours: 1, minutes: 18));
      expect(content.xpEarned, 220);
      expect(content.streakDays, 7);
    });
  });
}
