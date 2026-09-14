import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/cards.dart';
import '../../../../core/widgets/feedback.dart';
import '../../../../core/widgets/progress.dart';
import '../../../../core/widgets/shell_chrome.dart';
import '../../data/repositories/achievement_repository_impl.dart';
import '../../domain/entities/achievement.dart';
import '../bloc/achievements_bloc.dart';

/// Achievements grouped by family with progress + unlock state.
class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Achievements')),
      body: BlocBuilder<AchievementsBloc, AchievementsState>(
        builder: (context, state) {
          if (state is AchievementsLoading) {
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: const [
                ShimmerBlock(height: 120, radius: AppRadius.lg),
                SizedBox(height: AppSpacing.md),
                ShimmerBlock(height: 120, radius: AppRadius.lg),
                SizedBox(height: AppSpacing.md),
                ShimmerBlock(height: 120, radius: AppRadius.lg),
              ],
            );
          }
          if (state is AchievementsError) {
            return ErrorState(message: state.message);
          }
          if (state is! AchievementsReady) {
            return const SizedBox.shrink();
          }
          if (state.items.isEmpty) {
            return const EmptyState(
              icon: AppIcons.trophy,
              title: 'No achievements yet',
              message: 'Complete your first workout to get started.',
            );
          }

          final unlocked =
              state.items.where((i) => i.unlocked).length;
          return ListView(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              ShellChrome.tabBottom(context),
            ),
            children: [
              _SummaryBar(unlocked: unlocked, total: state.items.length),
              const SizedBox(height: AppSpacing.lg),
              for (final family in AchievementFamily.values) ...[
                _FamilySection(
                  family: family,
                  items: state.items
                      .where((i) => i.definition.family == family)
                      .toList(),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _SummaryBar extends StatelessWidget {
  const _SummaryBar({required this.unlocked, required this.total});

  final int unlocked;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Row(
        children: [
          const Icon(AppIcons.trophy, color: AppPalette.warning, size: 22),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$unlocked / $total unlocked',
                    style: theme.textTheme.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                XpBar(
                  progress: total == 0 ? 0 : unlocked / total,
                  color: AppPalette.warning,
                  height: 6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilySection extends StatelessWidget {
  const _FamilySection({required this.family, required this.items});

  final AchievementFamily family;
  final List<AchievementWithState> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: family.label),
        for (final item in items) _AchievementRow(item: item),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

class _AchievementRow extends StatelessWidget {
  const _AchievementRow({required this.item});

  final AchievementWithState item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unlocked = item.unlocked;
    final tint = unlocked ? AppPalette.warning : AppPalette.textTertiary;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm + 2),
      child: Opacity(
        opacity: unlocked ? 1 : 0.55,
        child: AppCard(
          padding: const EdgeInsets.all(AppSpacing.md),
          borderColor: unlocked
              ? AppPalette.warning.withValues(alpha: 0.3)
              : null,
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tint.withValues(alpha: 0.12),
                ),
                child: Icon(
                  unlocked ? AppIcons.trophy : AppIcons.medal,
                  color: tint,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.definition.name,
                        style: theme.textTheme.titleSmall),
                    Text(item.definition.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: AppPalette.textSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    if (!unlocked) ...[
                      const SizedBox(height: AppSpacing.xs + 2),
                      XpBar(
                        progress: item.definition.threshold == 0
                            ? 0
                            : (item.progress /
                                    item.definition.threshold)
                                .clamp(0.0, 1.0),
                        color: AppPalette.textTertiary,
                        height: 4,
                        glow: false,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                unlocked
                    ? '✓'
                    : '${item.progress}/${item.definition.threshold}',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: tint,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
