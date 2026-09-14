import 'package:flutter/material.dart';

import '../../domain/entities/story_entities.dart';
import 'story_widgets.dart';

/// PROFILE LEVEL story: avatar, level, rank, title, XP bar, streak, stats.
class ProfileStoryCard extends StatelessWidget {
  const ProfileStoryCard({super.key, required this.content});

  final StoryContent content;

  @override
  Widget build(BuildContext context) {
    final privacy = content.privacy;
    return StoryCanvas(
      style: content.style,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90),
        child: Column(
          children: [
            const Spacer2(flex: 2),
            const StoryHeadline(
              'WORKOUT PROGRESS',
              color: Color(0xB3FFFFFF),
              size: 34,
              letterSpacing: 10,
            ),
            const Spacer2(),
            StoryAvatar(
              initials: content.userInitials ?? '?',
              photoUrl: content.photoUrl,
            ),
            const Spacer2(),
            StoryHeadline(
              (content.userName ?? 'ATHLETE').toUpperCase(),
              size: 56,
              letterSpacing: 8,
              scaleToFit: true,
            ),
            const Spacer2(),
            if (privacy.showLevel)
              StoryHeadline(
                'LEVEL ${content.level ?? 1}',
                size: 110,
                scaleToFit: true,
              ),
            const Spacer2(flex: 1, height: 24),
            if (privacy.showRank)
              StoryRankPill(rankName: content.rankName ?? 'ROOKIE'),
            const Spacer2(flex: 1, height: 24),
            StoryHeadline(
              (content.titleName ?? 'Rookie').toUpperCase(),
              color: const Color(0x99FFFFFF),
              size: 34,
              letterSpacing: 6,
            ),
            const Spacer2(flex: 2, height: 40),
            if (privacy.showXp) ...[
              StoryXpBar(
                progress: content.xpForNextLevel == null || content.xpForNextLevel == 0
                    ? 0
                    : (content.currentXp! / content.xpForNextLevel!).clamp(0.0, 1.0),
              ),
              const SizedBox(height: 20),
              StoryHeadline(
                '${_fmt(content.currentXp ?? 0)} / ${_fmt(content.xpForNextLevel ?? 0)} XP',
                color: const Color(0x99FFFFFF),
                size: 30,
                letterSpacing: 3,
              ),
            ],
            const Spacer2(flex: 2, height: 48),
            if (privacy.showStreak)
              StoryStatRow(
                icon: Icons.local_fire_department_rounded,
                value: '${content.streakDays ?? 0}',
                label: 'DAY STREAK',
                color: AppColors.streak,
              ),
            if (privacy.showStreak && privacy.showTotalWorkouts)
              const SizedBox(height: 36),
            if (privacy.showTotalWorkouts)
              StoryStatRow(
                icon: Icons.fitness_center_rounded,
                value: '${content.totalWorkouts ?? 0}',
                label: 'WORKOUTS',
              ),
            const Spacer2(flex: 3),
            const StoryFooter(),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  String _fmt(int n) => n.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
}

/// Small spacing helper with flexible + fixed modes.
class Spacer2 extends StatelessWidget {
  const Spacer2({super.key, this.flex = 1, this.height});

  final int flex;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (height != null) {
      return SizedBox(height: height);
    }
    return Expanded(
      flex: flex,
      child: const SizedBox.expand(),
    );
  }
}

/// Palette alias kept local to story cards.
abstract final class AppColors {
  static const streak = Color(0xFFFF6B35);
}

/// WORKOUT COMPLETE story.
class WorkoutStoryCard extends StatelessWidget {
  const WorkoutStoryCard({super.key, required this.content});

  final StoryContent content;

  String get _duration {
    final d = content.workoutDuration ?? Duration.zero;
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return h > 0 ? '$h h $m m'.replaceAll(' ', '') : '$m min';
  }

  @override
  Widget build(BuildContext context) {
    return StoryCanvas(
      style: content.style,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90),
        child: Column(
          children: [
            const Spacer2(flex: 2),
            const StoryHeadline('WORKOUT COMPLETE', size: 58),
            const Spacer2(flex: 2, height: 48),
            StoryHeadline(
              (content.workoutName ?? 'WORKOUT').toUpperCase(),
              size: 88,
              letterSpacing: 4,
              scaleToFit: true,
            ),
            const Spacer2(flex: 1, height: 36),
            StoryAvatar(
              initials: content.userInitials ?? '?',
              photoUrl: content.photoUrl,
              size: 110,
            ),
            const SizedBox(height: 16),
            StoryHeadline(
              (content.userName ?? 'ATHLETE').toUpperCase(),
              size: 34,
              letterSpacing: 6,
              color: const Color(0x99FFFFFF),
              scaleToFit: true,
            ),
            const Spacer2(flex: 1, height: 56),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: _BigStat(value: _duration, label: 'DURATION'),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: _BigStat(
                        value: '${content.workoutSets ?? 0}',
                        label: 'SETS'),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: _BigStat(
                        value: _fmtVolume(content.workoutVolumeKg ?? 0),
                        label: 'VOLUME'),
                  ),
                ),
              ],
            ),
            const Spacer2(flex: 1, height: 56),
            if ((content.personalRecordCount ?? 0) > 0)
              StoryStatRow(
                icon: Icons.bolt_rounded,
                value: '${content.personalRecordCount}',
                label: 'PERSONAL RECORDS',
                color: const Color(0xFFFBBF24),
              ),
            const Spacer2(flex: 2, height: 48),
            if ((content.xpEarned ?? 0) > 0)
              StoryHeadline(
                '+${content.xpEarned} XP',
                size: 96,
                letterSpacing: 2,
                scaleToFit: true,
              ),
            if (content.privacy.showStreak) ...[
              const Spacer2(flex: 2, height: 40),
              StoryHeadline(
                '🔥 ${content.streakDays ?? 0} DAY STREAK',
                size: 40,
                letterSpacing: 3,
                scaleToFit: true,
              ),
            ],
            const Spacer2(flex: 3),
            const StoryFooter(),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  String _fmtVolume(double kg) {
    if (kg >= 1000) {
      return '${(kg / 1000).toStringAsFixed(1)}t';
    }
    return '${kg.round()}kg';
  }
}

class _BigStat extends StatelessWidget {
  const _BigStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 64,
            fontWeight: FontWeight.w800,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0x99FFFFFF),
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}
