import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/cards.dart';
import '../../../../core/widgets/feedback.dart';
import '../../../../core/widgets/progress.dart';
import '../../../../core/widgets/shell_chrome.dart';
import '../../domain/entities/challenge.dart';
import '../bloc/challenges_bloc.dart';

/// Daily / weekly / monthly challenges with live progress + rewards.
class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Challenges')),
      body: BlocBuilder<ChallengesBloc, ChallengesState>(
        builder: (context, state) {
          if (state is ChallengesLoading) {
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: const [
                ShimmerBlock(height: 170, radius: AppRadius.lg),
                SizedBox(height: AppSpacing.md),
                ShimmerBlock(height: 170, radius: AppRadius.lg),
                SizedBox(height: AppSpacing.md),
                ShimmerBlock(height: 170, radius: AppRadius.lg),
              ],
            );
          }
          if (state is ChallengesError) {
            return ErrorState(message: state.message);
          }
          if (state is! ChallengesReady) {
            return const SizedBox.shrink();
          }
          final current = state.current;
          return ListView(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              ShellChrome.tabBottom(context),
            ),
            children: [
              _ChallengeCard(
                progress: current.daily,
                accent: AppPalette.ember,
              ),
              const SizedBox(height: AppSpacing.md),
              _ChallengeCard(
                progress: current.weekly,
                accent: AppPalette.info,
              ),
              const SizedBox(height: AppSpacing.md),
              _ChallengeCard(
                progress: current.monthly,
                accent: AppPalette.warning,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({required this.progress, required this.accent});

  final ChallengeProgress progress;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final def = progress.definition;
    final done = progress.isComplete;

    return AppCard(
      glowColor: done ? accent : null,
      borderColor: done ? accent.withValues(alpha: 0.4) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withValues(alpha: 0.12),
                ),
                child: Icon(AppIcons.target, color: accent, size: 20),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      def.period.label.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                          color: AppPalette.textTertiary, letterSpacing: 1.2),
                    ),
                    Text(def.title, style: theme.textTheme.titleMedium),
                  ],
                ),
              ),
              if (done)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppPalette.success.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    progress.claimed ? 'CLAIMED' : 'COMPLETE',
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: AppPalette.success),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm + 2),
          Text(
            def.description,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: AppPalette.textSecondary),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: XpBar(
                  progress: progress.progressFraction,
                  color: accent,
                  height: 8,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                '${progress.current} / ${def.target}',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              const Icon(AppIcons.bolt, size: 15, color: AppPalette.warning),
              const SizedBox(width: 5),
              Text(
                '+${def.xpReward} XP',
                style: theme.textTheme.labelLarge
                    ?.copyWith(color: AppPalette.warning),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
