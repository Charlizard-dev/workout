import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/cards.dart';
import '../../../../core/widgets/feedback.dart';
import '../../../../core/widgets/progress.dart';
import '../../../../core/widgets/shell_chrome.dart';
import '../../../dashboard/data/repositories/load_dashboard.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../leveling/domain/entities/progression.dart';

/// Progress hub: level summary, XP history, achievements grid, weekly chart.
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
        if (state is DashboardLoading) {
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: const [
              ShimmerBlock(height: 200, radius: AppRadius.lg),
              SizedBox(height: AppSpacing.md),
              ShimmerBlock(height: 140, radius: AppRadius.lg),
              SizedBox(height: AppSpacing.md),
              ShimmerBlock(height: 260, radius: AppRadius.lg),
            ],
          );
        }
        if (state is DashboardError) {
          return ErrorState(
            message: state.message,
            onRetry: () =>
                context.read<DashboardBloc>().add(const DashboardRefreshed()),
          );
        }
        if (state is! DashboardReady) {
          return const SizedBox.shrink();
        }
        final p = state.data.progression;

        return ListView(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            ShellChrome.tabBottom(context),
          ),
          children: [
            _ProgressionSummary(p: p),
            const SizedBox(height: AppSpacing.lg),
            const _LifetimeStatsGrid(),
            const SizedBox(height: AppSpacing.lg),
            _WeeklyChartCard(weekDays: state.data.weekDays),
            const SizedBox(height: AppSpacing.lg),
            _AchievementsPreview(p: p),
            const SizedBox(height: AppSpacing.lg),
            const _ExploreGrid(),
            const SizedBox(height: AppSpacing.lg),
            _XpHistoryCard(xpUntilNext: p.xpUntilNextLevel),
          ],
        );
        },
      ),
    );
  }
}

class _ProgressionSummary extends StatelessWidget {
  const _ProgressionSummary({required this.p});

  final UserProgression p;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      glowColor: AppPalette.ember,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RankBadge(rankName: p.rank.name),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('LEVEL ${p.level}', style: theme.textTheme.headlineMedium),
                  Text(
                    p.title.name,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppPalette.textSecondary),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          XpBar(progress: p.levelProgress, height: 12),
          const SizedBox(height: AppSpacing.sm + 2),
          Text(
            '${_fmt(p.currentXp)} / ${_fmt(p.xpForNextLevel)} XP • ${_fmt(p.xpUntilNextLevel)} to next level',
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppPalette.textSecondary,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(int n) =>
      n.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
}

class _LifetimeStatsGrid extends StatelessWidget {
  const _LifetimeStatsGrid();

  @override
  Widget build(BuildContext context) {
    final state = (context.watch<DashboardBloc>().state as DashboardReady);
    final p = state.data.progression;
    final hours = state.data.totalTrainingSeconds ~/ 3600;

    final stats = [
      ('LIFETIME XP', _fmtRow(p.lifetimeXp)),
      ('TOTAL WORKOUTS', '${p.totalWorkouts}'),
      ('LONGEST STREAK', '${p.longestStreak} days'),
      ('TRAINING TIME', '${hours}h'),
    ];

    return Column(
      children: [
        for (var i = 0; i < stats.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                Expanded(
                  child: _StatBox(label: stats[i].$1, value: stats[i].$2),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _StatBox(
                      label: stats[i + 1].$1, value: stats[i + 1].$2),
                ),
              ],
            ),
          ),
      ],
    );
  }

  String _fmtRow(int n) =>
      n.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall
                ?.copyWith(color: AppPalette.textTertiary),
          ),
          const SizedBox(height: AppSpacing.xs + 2),
          Text(value, style: theme.textTheme.titleLarge),
        ],
      ),
    );
  }
}

class _WeeklyChartCard extends StatelessWidget {
  const _WeeklyChartCard({required this.weekDays});

  final List<DayStatus> weekDays;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('THIS WEEK', style: theme.textTheme.labelMedium
              ?.copyWith(color: AppPalette.textSecondary, letterSpacing: 1.2)),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 132,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < weekDays.length; i++) ...[
                  Expanded(child: _WeekBar(day: weekDays[i])),
                  if (i < weekDays.length - 1) const SizedBox(width: AppSpacing.sm),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekBar extends StatelessWidget {
  const _WeekBar({required this.day});

  final DayStatus day;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completed = day.state == DayState.completed;
    final isRest = day.state == DayState.rest;
    final color = completed
        ? AppPalette.ember
        : isRest
            ? AppPalette.textTertiary.withValues(alpha: 0.4)
            : AppPalette.track;

    // Heights derive from available space (label + gap reserved), so the
    // column can never overflow its parent at any text scale.
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxBarHeight = (constraints.maxHeight - 24).clamp(40.0, 200.0);
        final height = completed
            ? maxBarHeight
            : isRest
                ? maxBarHeight * 0.28
                : maxBarHeight * 0.18;
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.sm)),
              ),
            ),
            const SizedBox(height: AppSpacing.xs + 2),
            Text(
              day.label,
              style: theme.textTheme.labelSmall
                  ?.copyWith(color: AppPalette.textTertiary, fontSize: 9),
            ),
          ],
        );
      },
    );
  }
}

class _ExploreGrid extends StatelessWidget {
  const _ExploreGrid();

  @override
  Widget build(BuildContext context) {
    final tiles = [
      (AppIcons.trophy, 'Achievements', '/progress/achievements'),
      (AppIcons.target, 'Challenges', '/progress/challenges'),
      (AppIcons.history, 'History', '/progress/history'),
      (AppIcons.bolt, 'Records', '/progress/records'),
    ];
    return Column(
      children: [
        for (var i = 0; i < tiles.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                Expanded(
                  child: _ExploreTile(
                    icon: tiles[i].$1,
                    label: tiles[i].$2,
                    onTap: () => context.push(tiles[i].$3),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _ExploreTile(
                    icon: tiles[i + 1].$1,
                    label: tiles[i + 1].$2,
                    onTap: () => context.push(tiles[i + 1].$3),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ExploreTile extends StatelessWidget {
  const _ExploreTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.lg),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppPalette.ember),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(label,
                style: theme.textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ),
          const Icon(AppIcons.chevronRight,
              size: 18, color: AppPalette.textTertiary),
        ],
      ),
    );
  }
}

class _AchievementsPreview extends StatelessWidget {
  const _AchievementsPreview({required this.p});

  final UserProgression p;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              const Icon(AppIcons.trophy, size: 18, color: AppPalette.warning),
              const SizedBox(width: AppSpacing.sm),
              Text('ACHIEVEMENTS',
                  style: theme.textTheme.labelMedium?.copyWith(
                      color: AppPalette.textSecondary, letterSpacing: 1.2)),
              const Spacer(),
              Text('${p.achievementsUnlocked} / ${p.achievementsTotal}',
                  style: theme.textTheme.labelLarge
                      ?.copyWith(color: AppPalette.warning)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          XpBar(
            progress: p.achievementsTotal == 0
                ? 0
                : p.achievementsUnlocked / p.achievementsTotal,
            color: AppPalette.warning,
          ),
        ],
      ),
    );
  }
}

class _XpHistoryCard extends StatelessWidget {
  const _XpHistoryCard({required this.xpUntilNext});

  final int xpUntilNext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('NEXT MILESTONE',
              style: theme.textTheme.labelMedium?.copyWith(
                  color: AppPalette.textSecondary, letterSpacing: 1.2)),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              const Icon(AppIcons.bolt, color: AppPalette.warning, size: 20),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  '$xpUntilNext XP until your next level',
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
