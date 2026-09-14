import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/avatars.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/cards.dart';
import '../../../../core/widgets/progress.dart';
import '../../../../core/widgets/shell_chrome.dart';
import '../../../authentication/data/session_controller.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../social_sharing/domain/entities/story_entities.dart';
import '../../../social_sharing/presentation/story_content_factory.dart';

/// Profile: level card + lifetime stats + share level CTA.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.onShareLevel,
    required this.onOpenSettings,
  });

  final void Function(StoryContent content) onShareLevel;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.settings),
            tooltip: 'Settings',
            onPressed: onOpenSettings,
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is! DashboardReady) {
            return const Center(child: CircularProgressIndicator());
          }
          final p = state.data.progression;
          final session = context.watch<SessionController>();
          final userName = session.displayName;

          return ListView(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              ShellChrome.tabBottom(context),
            ),
            children: [
              Row(
                children: [
                  UserAvatar(
                      name: userName,
                      photoUrl: session.photoUrl,
                      size: 56),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userName,
                            style:
                                Theme.of(context).textTheme.titleLarge),
                        Text(
                          'Level ${p.level} • ${p.rank.name.toLowerCase().capitalize()} Rank',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: AppPalette.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(AppIcons.edit),
                    tooltip: 'Edit profile',
                    onPressed: () => context.push('/profile/edit'),
                  ),
                ],
              ),
            const SizedBox(height: AppSpacing.xl),
            _LevelCard(
                userName: userName,
                photoUrl: session.photoUrl,
                onShareLevel: onShareLevel),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'LIFETIME STATS',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppPalette.textSecondary, letterSpacing: 1.4),
            ),
            const SizedBox(height: AppSpacing.md),
            _StatRow(
                icon: AppIcons.dumbbell,
                label: 'Total Workouts',
                value: '${p.totalWorkouts}'),
            _StatRow(
                icon: AppIcons.bolt,
                label: 'Lifetime XP',
                value: _fmt(p.lifetimeXp)),
            _StatRow(
                icon: AppIcons.flame,
                label: 'Longest Streak',
                value: '${p.longestStreak} days',
                tint: AppPalette.streak),
            _StatRow(
                icon: AppIcons.trophy,
                label: 'Achievements',
                value: '${p.achievementsUnlocked} / ${p.achievementsTotal}',
                tint: AppPalette.warning),
            _StatRow(
                icon: AppIcons.medal,
                label: 'Badges',
                value: '${p.badgeCount}',
                tint: const Color(0xFFB08D57)),
            _StatRow(
                icon: AppIcons.target,
                label: 'Challenges Completed',
                value: '${p.challengesCompleted}'),
          ],
        );
        },
      ),
    );
  }

  String _fmt(int n) =>
      n.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
}

extension on String {
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

class _LevelCard extends StatelessWidget {
  const _LevelCard(
      {required this.userName, this.photoUrl, required this.onShareLevel});

  final String userName;
  final String? photoUrl;
  final void Function(StoryContent content) onShareLevel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = (context.watch<DashboardBloc>().state as DashboardReady).data;
    final p = data.progression;

    return AppCard(
      glowColor: AppPalette.ember,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          UserAvatar(name: userName, photoUrl: photoUrl, size: 64),
          const SizedBox(height: AppSpacing.md),
          Text(userName.toUpperCase(), style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs + 2),
          Text('LEVEL ${p.level}', style: theme.textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.xs),
          RankBadge(rankName: p.rank.name, size: 46),
          const SizedBox(height: AppSpacing.xs + 2),
          Text(
            p.title.name,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: AppPalette.textSecondary),
          ),
          const SizedBox(height: AppSpacing.lg),
          XpBar(progress: p.levelProgress, height: 12),
          const SizedBox(height: AppSpacing.sm + 2),
          Text(
            '${p.currentXp} / ${p.xpForNextLevel} XP',
            style: theme.textTheme.labelMedium
                ?.copyWith(color: AppPalette.textSecondary),
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: 'SHARE LEVEL',
            icon: AppIcons.share,
            onPressed: () => onShareLevel(
              StoryContentFactory.profile(
                userName: userName,
                progression: p,
                photoUrl:
                    context.read<SessionController>().photoUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
    this.tint = AppPalette.textPrimary,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm + 2),
      child: AppCard(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.md),
        child: Row(
          children: [
            Icon(icon, size: 20, color: tint),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(label, style: theme.textTheme.bodyLarge),
            ),
            Text(
              value,
              style: theme.textTheme.titleSmall?.copyWith(
                color: tint,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
