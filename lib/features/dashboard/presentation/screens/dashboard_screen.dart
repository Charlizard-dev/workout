import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/cards.dart';
import '../../../../core/widgets/feedback.dart';
import '../../../../core/widgets/progress.dart';
import '../../../../core/widgets/shell_chrome.dart';
import '../../../authentication/data/session_controller.dart';
import '../../data/repositories/load_dashboard.dart';
import '../bloc/dashboard_bloc.dart';

/// Home: greeting, level summary, today's workout, weekly progress,
/// stats grid, daily challenge teaser.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.onStartWorkout,
    required this.onOpenProgression,
    required this.onOpenChallenges,
    this.onOpenMusic,
  });

  final VoidCallback onStartWorkout;
  final VoidCallback onOpenProgression;
  final VoidCallback onOpenChallenges;
  final VoidCallback? onOpenMusic;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 18) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      color: AppPalette.ember,
      backgroundColor: AppPalette.surfaceHigh,
      onRefresh: () async {
        context.read<DashboardBloc>().add(const DashboardRefreshed());
        await Future<void>.delayed(const Duration(milliseconds: 400));
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            snap: true,
            floating: true,
            expandedHeight: 96,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('$_greeting, ${context.watch<SessionController>().displayName}',
                          style: theme.textTheme.headlineSmall),
                      const SizedBox(height: 2),
                      Text(
                        'Ready to crush today\u2019s workout?',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: AppPalette.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              ShellChrome.tabBottom(context),
            ),
            sliver: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is DashboardLoading) {
                  return const SliverFillRemaining(
                      child: _DashboardSkeleton());
                }
                if (state is DashboardError) {
                  return SliverFillRemaining(
                    child: ErrorState(
                      message: state.message,
                      onRetry: () => context
                          .read<DashboardBloc>()
                          .add(const DashboardRefreshed()),
                    ),
                  );
                }
                if (state is! DashboardReady) {
                  return const SliverFillRemaining(child: SizedBox.shrink());
                }
                final data = state.data;
                return SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    _LevelSummaryCard(
                      data: data,
                      onTap: onOpenProgression,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _TodayWorkoutCard(
                      data: data,
                      onStart: onStartWorkout,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _WeeklyProgressCard(data: data),
                    const SizedBox(height: AppSpacing.lg),
                    _StatsGrid(data: data),
                    const SizedBox(height: AppSpacing.lg),
                    if (data.dailyChallenge != null)
                      _ChallengeTeaserCard(
                        title: data.dailyChallenge!.$1,
                        current: data.dailyChallenge!.$2,
                        target: data.dailyChallenge!.$3,
                        onTap: onOpenChallenges,
                      ),
                  ]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardSkeleton extends StatelessWidget {
  const _DashboardSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: const [
        ShimmerBlock(height: 190, radius: AppRadius.lg),
        SizedBox(height: AppSpacing.md),
        ShimmerBlock(height: 210, radius: AppRadius.lg),
        SizedBox(height: AppSpacing.md),
        ShimmerBlock(height: 120, radius: AppRadius.lg),
        SizedBox(height: AppSpacing.md),
        ShimmerBlock(height: 170, radius: AppRadius.lg),
      ],
    );
  }
}

class _LevelSummaryCard extends StatelessWidget {
  const _LevelSummaryCard({required this.data, required this.onTap});

  final DashboardData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = data.progression;

    return AppCard(
      onTap: onTap,
      glowColor: AppPalette.ember,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RankBadge(rankName: p.rank.name),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('LEVEL ${p.level}',
                        style: theme.textTheme.headlineSmall),
                    Text(
                      p.title.name,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppPalette.textSecondary),
                    ),
                  ],
                ),
              ),
              const Icon(AppIcons.chevronRight, color: AppPalette.textTertiary),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          XpBar(progress: p.levelProgress),
          const SizedBox(height: AppSpacing.sm + 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_fmt(p.currentXp)} / ${_fmt(p.xpForNextLevel)} XP',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppPalette.textSecondary,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              Text(
                '${_fmt(p.xpUntilNextLevel)} XP to Level ${p.level + 1}',
                style: theme.textTheme.labelMedium
                    ?.copyWith(color: AppPalette.ember),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              const Icon(AppIcons.flame, size: 18, color: AppPalette.streak),
              const SizedBox(width: AppSpacing.xs + 2),
              Text(
                '${p.currentStreak} Day Streak',
                style: theme.textTheme.labelLarge
                    ?.copyWith(color: AppPalette.streak),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _fmt(int n) =>
      n.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
}

class _TodayWorkoutCard extends StatelessWidget {
  const _TodayWorkoutCard({required this.data, required this.onStart});

  final DashboardData data;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final routine = data.todayRoutine;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TODAY\'S WORKOUT',
            style: theme.textTheme.labelMedium?.copyWith(
                color: AppPalette.textSecondary, letterSpacing: 1.4),
          ),
          const SizedBox(height: AppSpacing.md),
          if (routine == null) ...[
            Text('No routine planned',
                style: theme.textTheme.titleMedium?.copyWith(
                    color: AppPalette.textSecondary)),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Create a routine in the Workouts tab to get started.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: AppPalette.textTertiary),
            ),
          ] else ...[
            Text(routine.name.toUpperCase(),
                style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.xs + 2),
            Text(
              routine.muscleSummary,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: AppPalette.textSecondary),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                _Meta(icon: AppIcons.dumbbell, label: '${routine.exercises.length} Exercises'),
                const SizedBox(width: AppSpacing.lg),
                _Meta(icon: AppIcons.repeat, label: '${routine.totalSets} Sets'),
                const SizedBox(width: AppSpacing.lg),
                _Meta(
                    icon: AppIcons.timer,
                    label:
                        '~${(routine.estimatedDuration.inMinutes / 5).round() * 5}m'),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              label: 'START WORKOUT',
              icon: AppIcons.play,
              onPressed: onStart,
            ),
          ],
        ],
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: AppPalette.textTertiary),
        const SizedBox(width: 5),
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: AppPalette.textSecondary)),
      ],
    );
  }
}

class _WeeklyProgressCard extends StatelessWidget {
  const _WeeklyProgressCard({required this.data});

  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${data.weekWorkouts} / ${data.weekGoal} Workouts',
                style: theme.textTheme.titleMedium,
              ),
              Text(
                data.weekWorkouts >= data.weekGoal ? 'GOAL HIT' : 'THIS WEEK',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: data.weekWorkouts >= data.weekGoal
                      ? AppPalette.success
                      : AppPalette.textTertiary,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: data.weekDays
                .map((d) => _WeekDayPill(day: d))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _WeekDayPill extends StatelessWidget {
  const _WeekDayPill({required this.day});

  final DayStatus day;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (day.state) {
      DayState.completed => AppPalette.success,
      DayState.rest => AppPalette.textTertiary,
      DayState.missed => AppPalette.danger.withValues(alpha: 0.5),
      DayState.planned => AppPalette.ember,
      DayState.future => AppPalette.textTertiary,
    };

    final symbol = switch (day.state) {
      DayState.completed => '✓',
      DayState.rest => '–',
      DayState.missed => '✕',
      _ => '·',
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          day.label,
          style: theme.textTheme.labelSmall
              ?.copyWith(color: AppPalette.textTertiary, letterSpacing: 0.5),
        ),
        const SizedBox(height: AppSpacing.xs + 2),
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.14),
            border: Border.all(color: color.withValues(alpha: 0.55), width: 1.4),
          ),
          alignment: Alignment.center,
          child: Text(
            symbol,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.data});

  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    final p = data.progression;
    final hours = data.totalTrainingSeconds ~/ 3600;
    final minutes = (data.totalTrainingSeconds % 3600) ~/ 60;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: _StatTile(
                    icon: AppIcons.dumbbell,
                    label: 'WORKOUTS',
                    value: '${p.totalWorkouts}')),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
                child: _StatTile(
                    icon: AppIcons.volume,
                    label: 'VOLUME',
                    value: _fmtVolume(data.totalVolumeKg))),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
                child: _StatTile(
                    icon: AppIcons.duration,
                    label: 'TRAINING TIME',
                    value: '${hours}h ${minutes}m')),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
                child: _StatTile(
                    icon: AppIcons.flame,
                    label: 'STREAK',
                    value: '${p.currentStreak} days',
                    tint: AppPalette.streak)),
          ],
        ),
      ],
    );
  }

  String _fmtVolume(double kg) {
    if (kg >= 1000) return '${(kg / 1000).toStringAsFixed(1)}t';
    return '${kg.round()} kg';
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    this.tint = AppPalette.ember,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tint.withValues(alpha: 0.12),
            ),
            child: Icon(icon, size: 18, color: tint),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  label,
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: AppPalette.textTertiary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallengeTeaserCard extends StatelessWidget {
  const _ChallengeTeaserCard({
    required this.title,
    required this.current,
    required this.target,
    required this.onTap,
  });

  final String title;
  final int current;
  final int target;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(AppIcons.target, size: 16, color: AppPalette.ember),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'DAILY CHALLENGE',
                style: theme.textTheme.labelMedium?.copyWith(
                    color: AppPalette.textSecondary, letterSpacing: 1.2),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: XpBar(
                  progress: target == 0 ? 0 : (current / target).clamp(0.0, 1.0),
                  height: 6,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                '$current / $target',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
