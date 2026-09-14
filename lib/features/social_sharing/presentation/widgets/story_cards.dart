import 'package:flutter/material.dart';

import '../../domain/entities/story_entities.dart';
import 'profile_story_card.dart';
import 'story_widgets.dart';

/// LEVEL-UP story: old → new level with celebration styling.
class LevelUpStoryCard extends StatelessWidget {
  const LevelUpStoryCard({super.key, required this.content});

  final StoryContent content;

  @override
  Widget build(BuildContext context) {
    return StoryCanvas(
      style: content.style,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90),
        child: Column(
          children: [
            const Spacer2(flex: 2),
            const StoryHeadline('I LEVELED UP', size: 54, letterSpacing: 8),
            const Spacer2(flex: 2, height: 72),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      'FROM',
                      style: TextStyle(
                          color: Color(0x66FFFFFF), fontSize: 22,
                          fontWeight: FontWeight.w700, letterSpacing: 4),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${content.oldLevel ?? 0}',
                      style: const TextStyle(
                          color: Color(0x66FFFFFF), fontSize: 88,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Icon(Icons.arrow_downward_rounded,
                      size: 64, color: AppColors.streak),
                ),
                Column(
                  children: [
                    const Text(
                      'TO',
                      style: TextStyle(
                          color: Color(0x66FFFFFF), fontSize: 22,
                          fontWeight: FontWeight.w700, letterSpacing: 4),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${content.newLevel ?? content.level ?? 0}',
                      style: const TextStyle(
                          color: Colors.white, fontSize: 150,
                          fontWeight: FontWeight.w800, height: 1.0),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer2(flex: 1, height: 64),
            StoryHeadline(
              'LEVEL ${content.newLevel ?? content.level ?? 0}',
              size: 44,
              letterSpacing: 8,
              scaleToFit: true,
            ),
            const Spacer2(flex: 1, height: 32),
            StoryRankPill(rankName: content.rankName ?? 'ROOKIE'),
            const Spacer2(flex: 1, height: 32),
            StoryHeadline(
              (content.titleName ?? 'ATHLETE').toUpperCase(),
              color: const Color(0x99FFFFFF),
              size: 36,
              letterSpacing: 6,
              scaleToFit: true,
            ),
            const Spacer2(flex: 2, height: 72),
            if ((content.xpEarned ?? 0) > 0)
              StoryHeadline(
                '+${content.xpEarned} XP',
                size: 84,
                letterSpacing: 2,
                color: const Color(0xFFFBBF24),
                scaleToFit: true,
              ),
            const Spacer2(flex: 3),
            const StoryFooter(slogan: 'TRAIN • LEVEL UP • REPEAT'),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

/// RANK-UP story: old rank → new rank, more monumental than level-up.
class RankUpStoryCard extends StatelessWidget {
  const RankUpStoryCard({super.key, required this.content});

  final StoryContent content;

  @override
  Widget build(BuildContext context) {
    return StoryCanvas(
      style: content.style,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90),
        child: Column(
          children: [
            const Spacer2(flex: 2),
            const StoryHeadline('RANK UP', size: 72, letterSpacing: 12),
            const Spacer2(flex: 3, height: 80),
            Text(
              (content.oldRankName ?? 'RANK').toUpperCase(),
              style: const TextStyle(
                color: Color(0x66FFFFFF),
                fontSize: 56,
                fontWeight: FontWeight.w800,
                letterSpacing: 10,
                decoration: TextDecoration.none,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Icon(Icons.south_rounded, size: 64, color: Color(0x66FFFFFF)),
            ),
            StoryRankPill(rankName: content.rankName ?? 'RANK'),
            const Spacer2(flex: 2, height: 96),
            StoryHeadline('LEVEL ${content.newLevel ?? content.level ?? 0}',
                size: 48, letterSpacing: 6, scaleToFit: true),
            const Spacer2(flex: 3),
            const StoryFooter(slogan: 'KEEP PUSHING.'),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

/// PERSONAL RECORD story.
class PersonalRecordStoryCard extends StatelessWidget {
  const PersonalRecordStoryCard({super.key, required this.content});

  final StoryContent content;

  @override
  Widget build(BuildContext context) {
    return StoryCanvas(
      style: content.style,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90),
        child: Column(
          children: [
            const Spacer2(flex: 2),
            const StoryHeadline('NEW PR ⚡', size: 64, letterSpacing: 8),
            const Spacer2(flex: 2, height: 80),
            StoryHeadline(
              (content.exerciseName ?? 'EXERCISE').toUpperCase(),
              size: 54,
              letterSpacing: 3,
              scaleToFit: true,
            ),
            const Spacer2(flex: 2, height: 64),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 36),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0x14FFC940),
                border: Border.all(color: const Color(0x66FFC940), width: 3),
              ),
              child: Column(
                children: [
                  Text(
                    '${_fmtWeight(content.prWeightKg ?? 0)} KG × ${content.prReps ?? 0}',
                    style: const TextStyle(
                      color: Color(0xFFFFC940),
                      fontSize: 92,
                      fontWeight: FontWeight.w800,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            if (content.prPreviousWeightKg != null &&
                content.prPreviousWeightKg! > 0) ...[
              const Spacer2(flex: 1, height: 48),
              const Text(
                'PREVIOUS',
                style: TextStyle(
                    color: Color(0x66FFFFFF), fontSize: 22,
                    fontWeight: FontWeight.w700, letterSpacing: 4),
              ),
              const SizedBox(height: 8),
              Text(
                '${_fmtWeight(content.prPreviousWeightKg!)} KG × ${content.prReps ?? 0}',
                style: const TextStyle(
                    color: Color(0x99FFFFFF), fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
            ],
            const Spacer2(flex: 2, height: 64),
            if ((content.xpEarned ?? 0) > 0)
              StoryHeadline(
                '+${content.xpEarned} XP',
                size: 72,
                color: const Color(0xFFFBBF24),
                letterSpacing: 2,
                scaleToFit: true,
              ),
            const Spacer2(flex: 3),
            const StoryFooter(slogan: 'STRONGER EVERY DAY'),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  static String _fmtWeight(double kg) {
    final rounded = (kg * 2).round() / 2;
    return rounded == rounded.roundToDouble()
        ? '${rounded.toInt()}'
        : rounded.toStringAsFixed(1);
  }
}

/// ACHIEVEMENT story.
class AchievementStoryCard extends StatelessWidget {
  const AchievementStoryCard({super.key, required this.content});

  final StoryContent content;

  @override
  Widget build(BuildContext context) {
    return StoryCanvas(
      style: content.style,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90),
        child: Column(
          children: [
            const Spacer2(flex: 2),
            const StoryHeadline('ACHIEVEMENT UNLOCKED',
                size: 42, letterSpacing: 8),
            const Spacer2(flex: 2, height: 72),
            Container(
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x1AFFFFC9),
              ),
              alignment: Alignment.center,
              child: Text(
                content.achievementEmoji ?? '🏆',
                style: const TextStyle(fontSize: 120),
              ),
            ),
            const Spacer2(flex: 1, height: 56),
            StoryHeadline(
              (content.achievementName ?? 'ACHIEVEMENT').toUpperCase(),
              size: 64,
              letterSpacing: 4,
              scaleToFit: true,
            ),
            const Spacer2(flex: 1, height: 40),
            StoryHeadline(
              content.achievementDescription ?? '',
              color: const Color(0x99FFFFFF),
              size: 32,
              letterSpacing: 2,
              weight: FontWeight.w600,
              scaleToFit: true,
            ),
            const Spacer2(flex: 2, height: 72),
            StoryHeadline(
              '+${content.xpEarned ?? content.challengeRewardXp ?? 0} XP',
              size: 76,
              color: const Color(0xFFFBBF24),
              letterSpacing: 2,
              scaleToFit: true,
            ),
            const Spacer2(flex: 3),
            const StoryFooter(slogan: 'EARNED. NOT GIVEN.'),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

/// STREAK story.
class StreakStoryCard extends StatelessWidget {
  const StreakStoryCard({super.key, required this.content});

  final StoryContent content;

  @override
  Widget build(BuildContext context) {
    final days = content.streakMilestoneDays ?? content.streakDays ?? 0;
    return StoryCanvas(
      style: content.style,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90),
        child: Column(
          children: [
            const Spacer2(flex: 2),
            const Text('🔥', style: TextStyle(fontSize: 200)),
            const Spacer2(flex: 2, height: 48),
            StoryHeadline('$days DAY',
                size: 120, letterSpacing: 4, scaleToFit: true),
            const StoryHeadline('WORKOUT STREAK',
                size: 56, letterSpacing: 10),
            const Spacer2(flex: 3),
            const StoryFooter(slogan: 'CONSISTENCY WINS.'),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

/// CHALLENGE story.
class ChallengeStoryCard extends StatelessWidget {
  const ChallengeStoryCard({super.key, required this.content});

  final StoryContent content;

  @override
  Widget build(BuildContext context) {
    return StoryCanvas(
      style: content.style,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90),
        child: Column(
          children: [
            const Spacer2(flex: 2),
            const StoryHeadline('CHALLENGE COMPLETE', size: 52, letterSpacing: 6),
            const Spacer2(flex: 2, height: 80),
            StoryHeadline(
              (content.challengeTitle ?? 'CHALLENGE').toUpperCase(),
              size: 66,
              letterSpacing: 3,
              scaleToFit: true,
            ),
            const Spacer2(flex: 1, height: 64),
            StoryHeadline(
              '${content.challengeTarget ?? 0}/${content.challengeTarget ?? 0}',
              size: 96,
              letterSpacing: 2,
              scaleToFit: true,
            ),
            const Spacer2(flex: 2, height: 72),
            StoryHeadline(
              '+${content.challengeRewardXp ?? 0} XP',
              size: 80,
              color: const Color(0xFFFBBF24),
              letterSpacing: 2,
              scaleToFit: true,
            ),
            const Spacer2(flex: 3),
            const StoryFooter(slogan: 'DONE.'),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

