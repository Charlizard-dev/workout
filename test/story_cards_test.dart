import 'package:charlizard/core/errors/failures.dart';
import 'package:charlizard/core/theme/app_theme.dart';
import 'package:charlizard/features/social_sharing/data/datasources/story_datasources.dart';
import 'package:charlizard/features/social_sharing/data/repositories/story_image_generator_impl.dart';
import 'package:charlizard/features/social_sharing/domain/entities/story_entities.dart';
import 'package:charlizard/features/social_sharing/presentation/screens/share_story_screen.dart';
import 'package:charlizard/features/social_sharing/presentation/widgets/profile_story_card.dart';
import 'package:charlizard/features/social_sharing/presentation/widgets/story_widgets.dart';
import 'package:charlizard/features/social_sharing/presentation/widgets/story_cards.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

/// Regression tests for the story share flow.
///
/// Every card is pumped at the EXACT 1080x1920 export size with adversarial
/// content (very long names, huge numbers). Any RenderFlex overflow throws
/// in debug mode and fails the test via [WidgetTester.takeException].
///
/// This guards the exact production bug class: cards rendered under
/// clamped/loose constraints (preview scaler, export pipeline) overflowing
/// when saving or sharing to Instagram/Facebook.
void main() {
  const exportSize = Size(1080, 1920);

  Widget cardFor(StoryContent content) => switch (content.type) {
        StoryType.profile => ProfileStoryCard(content: content),
        StoryType.workout => WorkoutStoryCard(content: content),
        StoryType.levelUp => LevelUpStoryCard(content: content),
        StoryType.rankUp => RankUpStoryCard(content: content),
        StoryType.personalRecord =>
          PersonalRecordStoryCard(content: content),
        StoryType.achievement => AchievementStoryCard(content: content),
        StoryType.streak => StreakStoryCard(content: content),
        StoryType.challenge => ChallengeStoryCard(content: content),
      };

  Future<void> pumpExact(
    WidgetTester tester,
    StoryContent content,
  ) async {
    tester.view.physicalSize = exportSize;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          body: SizedBox.fromSize(
            size: exportSize,
            child: cardFor(content),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  group('story cards never overflow at export size', () {
    testWidgets('profile with long name + huge numbers', (tester) async {
      await pumpExact(
        tester,
        const StoryContent(
          type: StoryType.profile,
          style: StoryStyle.darkAthletic,
          privacy: SharePrivacyConfig(),
          userName: 'Alexander Maximilian Thunderbolt the Third',
          userInitials: 'AT',
          level: 128,
          rankName: 'LEGEND',
          titleName: 'Elite Champion of the Iron Realm',
          currentXp: 99999,
          xpForNextLevel: 100000,
          lifetimeXp: 9876543,
          streakDays: 365,
          totalWorkouts: 9999,
          badgeCount: 250,
        ),
      );
      expect(find.textContaining('ALEXANDER'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('workout with long name + huge stats', (tester) async {
      await pumpExact(
        tester,
        const StoryContent(
          type: StoryType.workout,
          style: StoryStyle.darkAthletic,
          privacy: SharePrivacyConfig(),
          userName: 'Charly',
          workoutName: 'Barbell Bench Press Superset Armageddon Madness',
          workoutDuration: Duration(hours: 3, minutes: 42),
          workoutSets: 150,
          workoutVolumeKg: 125000.5,
          personalRecordCount: 12,
          xpEarned: 9999,
          streakDays: 365,
          level: 24,
          rankName: 'SILVER',
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('level-up card', (tester) async {
      await pumpExact(
        tester,
        const StoryContent(
          type: StoryType.levelUp,
          style: StoryStyle.neon,
          privacy: SharePrivacyConfig(),
          oldLevel: 99,
          newLevel: 100,
          level: 100,
          rankName: 'LEGEND',
          titleName: 'Legend',
          xpEarned: 4000,
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('rank-up card', (tester) async {
      await pumpExact(
        tester,
        const StoryContent(
          type: StoryType.rankUp,
          style: StoryStyle.gradient,
          privacy: SharePrivacyConfig(),
          oldRankName: 'GOLD',
          rankName: 'PLATINUM',
          newLevel: 40,
          level: 40,
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('personal record with long exercise name', (tester) async {
      await pumpExact(
        tester,
        const StoryContent(
          type: StoryType.personalRecord,
          style: StoryStyle.darkAthletic,
          privacy: SharePrivacyConfig(),
          exerciseName: 'Incline Dumbbell Bench Press with Pause',
          prWeightKg: 87.5,
          prReps: 12,
          prPreviousWeightKg: 85,
          xpEarned: 50,
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('achievement with long copy', (tester) async {
      await pumpExact(
        tester,
        const StoryContent(
          type: StoryType.achievement,
          style: StoryStyle.minimal,
          privacy: SharePrivacyConfig(),
          achievementName: 'Consistency King Supreme Overlord',
          achievementEmoji: '🔥',
          achievementDescription:
              'Reach an absolutely massive 30-day workout streak milestone',
          xpEarned: 500,
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('streak with huge milestone', (tester) async {
      await pumpExact(
        tester,
        const StoryContent(
          type: StoryType.streak,
          style: StoryStyle.darkAthletic,
          privacy: SharePrivacyConfig(),
          streakDays: 9999,
          streakMilestoneDays: 9999,
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('challenge with long title', (tester) async {
      await pumpExact(
        tester,
        const StoryContent(
          type: StoryType.challenge,
          style: StoryStyle.spotifyWorkout,
          privacy: SharePrivacyConfig(),
          challengeTitle: 'Complete an Enormous Number of Workouts',
          challengeTarget: 300,
          challengeRewardXp: 750,
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('story avatars', () {
    testWidgets('bogus photo falls back to initials', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const Scaffold(
            body: StoryAvatar(
              initials: 'CM',
              photoUrl: '/does/not/exist.png',
              size: 200,
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.text('CM'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('real photo file renders instead of initials', (tester) async {
      // 1x1 red PNG.
      const base64Png =
          'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==';
      final file = File(
          '\${Directory.systemTemp.path}/avatar_test_\${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(base64Decode(base64Png));
      addTearDown(() {
        if (file.existsSync()) file.deleteSync();
      });

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: Scaffold(
            body: StoryAvatar(
              initials: 'CM',
              photoUrl: file.path,
              size: 200,
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.text('CM'), findsNothing);
      expect(find.byType(Image), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('share preview screen', () {
    testWidgets('renders scaled preview without overflow', (tester) async {
      // Physical pixels = logical × DPR (390×844 logical iPhone frame).
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      const content = StoryContent(
        type: StoryType.workout,
        style: StoryStyle.darkAthletic,
        privacy: SharePrivacyConfig(),
        userName: 'Charly',
        workoutName: 'Push Day',
        workoutDuration: Duration(minutes: 78),
        workoutSets: 24,
        workoutVolumeKg: 9840,
        personalRecordCount: 3,
        xpEarned: 220,
        streakDays: 7,
        level: 24,
        rankName: 'SILVER',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: MultiProvider(
            providers: [
              Provider<StoryImageGenerator>.value(
                  value: StoryImageGeneratorImpl()),
              Provider<StoryShareService>.value(
                  value: const _FakeShareService()),
            ],
            child: const ShareStoryScreen(initialContent: content),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('SHARE'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}

class _FakeShareService implements StoryShareService {
  const _FakeShareService();

  @override
  Future<Either<Failure, StoryShareResult>> shareToInstagramStory(
          StoryImage image) async =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, StoryShareResult>> shareToFacebookStory(
          StoryImage image) async =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, StoryShareResult>> shareViaSystemSheet(
          StoryImage image) async =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, StoryShareResult>> saveToGallery(
          StoryImage image) async =>
      throw UnimplementedError();

  @override
  Future<bool> isInstagramAvailable() async => false;

  @override
  Future<bool> isFacebookAvailable() async => false;
}
