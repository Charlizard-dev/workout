import 'package:charlizard/core/theme/app_theme.dart';
import 'package:charlizard/core/widgets/muscle_art.dart';
import 'package:charlizard/features/exercises/domain/entities/exercise.dart';
import 'package:charlizard/core/widgets/cards.dart';
import 'package:charlizard/core/widgets/progress.dart';
import 'package:charlizard/features/social_sharing/presentation/story_content_factory.dart';
import 'package:charlizard/features/social_sharing/presentation/widgets/profile_story_card.dart';
import 'package:charlizard/features/leveling/domain/entities/progression.dart';
import 'package:charlizard/features/leveling/domain/services/progression_rules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child) => MaterialApp(
      theme: AppTheme.dark,
      home: Scaffold(body: child),
    );

void main() {
  testWidgets('XpBar renders progress accessibly', (tester) async {
    await tester.pumpWidget(_app(const XpBar(progress: 0.5)));
    expect(find.bySemanticsLabel(RegExp('XP progress')), findsOneWidget);
  });

  testWidgets('MuscleArt renders every group without errors', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          body: Row(
            children: [
              for (final muscle in MuscleGroup.values)
                MuscleArt(muscle: muscle, size: 48),
            ],
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(MuscleArt), findsNWidgets(MuscleGroup.values.length));
    expect(tester.takeException(), isNull);
  });

  testWidgets('StatChip renders value and label', (tester) async {
    await tester.pumpWidget(_app(const StatChip(
      icon: Icons.local_fire_department_rounded,
      value: '6',
      label: 'DAY STREAK',
    )));
    expect(find.text('6'), findsOneWidget);
    expect(find.text('DAY STREAK'), findsOneWidget);
  });

  testWidgets('ProfileStoryCard builds the full 9:16 tree', (tester) async {
    const rules = ProgressionRules();
    final progression = UserProgression(
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
    final content = StoryContentFactory.profile(
      userName: 'Charly',
      progression: progression,
    );

    // Render at a scaled-down surface; overflow = failure.
    tester.view.physicalSize = const Size(540, 960);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(_app(
      FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: 1080,
          height: 1920,
          child: RepaintBoundary(child: ProfileStoryCard(content: content)),
        ),
      ),
    ));
    await tester.pump();

    expect(find.text('CHARLY'), findsOneWidget);
    expect(find.text('LEVEL 24'), findsOneWidget);
    expect(find.textContaining('2,480 / '), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
