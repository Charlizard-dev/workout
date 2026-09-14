import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/cards.dart';
import '../../../../core/widgets/progress.dart';
import '../../domain/entities/workout_completion.dart';

/// Post-workout celebration: stats, XP breakdown with animated counting,
/// level-up/rank-up moments, and share CTA.
class WorkoutCompleteScreen extends StatefulWidget {
  const WorkoutCompleteScreen({
    super.key,
    required this.result,
    required this.onShareWorkout,
    this.onDone,
  });

  final WorkoutCompletionResult result;
  final VoidCallback onShareWorkout;
  final VoidCallback? onDone;

  @override
  State<WorkoutCompleteScreen> createState() => _WorkoutCompleteScreenState();
}

class _WorkoutCompleteScreenState extends State<WorkoutCompleteScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _reveal;
  late final Animation<double> _fade;

  static const _stagger = Duration(milliseconds: 450);

  @override
  void initState() {
    super.initState();
    _reveal = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600 + widget.result.xpLines.length * _stagger.inMilliseconds),
    )..forward();
    _fade = CurvedAnimation(parent: _reveal, curve: Curves.easeOut);
    if (widget.result.levelUps > 0) {
      HapticFeedback.heavyImpact();
    } else {
      HapticFeedback.mediumImpact();
    }
  }

  @override
  void dispose() {
    _reveal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = widget.result;
    final theme = Theme.of(context);
    final session = result.session;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Workout Complete 🎉'),
        actions: [
          TextButton(
            onPressed: widget.onDone ?? () => context.pop(),
            child: const Text('DONE'),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            // Headline
            Text(
              session.name.toUpperCase(),
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs + 2),
            Text(
              _formatDuration(session.duration),
              style: theme.textTheme.bodyLarge?.copyWith(color: AppPalette.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),

            // Stat grid
            Row(
              children: [
                Expanded(child: _StatTile(label: 'EXERCISES', value: '${session.exercises.length}')),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: _StatTile(label: 'SETS', value: '${session.totalSets}')),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: _StatTile(label: 'VOLUME', value: _formatVolume(session.totalVolume))),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            if (result.newRecords.isNotEmpty)
              _StatTile(
                label: 'PERSONAL RECORDS',
                value: '${result.newRecords.length}',
                highlight: true,
              ),
            const SizedBox(height: AppSpacing.xxl),

            // XP breakdown
            Text(
              'XP EARNED',
              style: theme.textTheme.labelMedium
                  ?.copyWith(color: AppPalette.textSecondary, letterSpacing: 1.4),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            AppCard(
              child: AnimatedBuilder(
                animation: _fade,
                builder: (context, child) {
                  final shown = (_fade.value * result.xpLines.length).ceil();
                  return Column(
                    children: [
                      for (var i = 0; i < shown && i < result.xpLines.length; i++)
                        _XpLineRow(line: result.xpLines[i]),
                      const Divider(height: AppSpacing.lg, color: Color(0x10FFFFFF)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TOTAL',
                              style: theme.textTheme.labelLarge
                                  ?.copyWith(color: AppPalette.textSecondary)),
                          Text(
                            '+${result.totalXp} XP',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: AppPalette.warning,
                              fontFeatures: const [FontFeature.tabularFigures()],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Level progress after award
            if (result.levelUps > 0) ...[
              _LevelUpCard(result: result),
              const SizedBox(height: AppSpacing.xl),
            ] else ...[
              _ProgressCard(result: result),
            ],

            if (result.unlockedAchievements.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xl),
              ...result.unlockedAchievements.map(
                (a) => _AchievementRow(name: a.name, description: a.description, xp: a.xpReward),
              ),
            ],

            const SizedBox(height: AppSpacing.xxxl),
            PrimaryButton(
              label: 'SHARE WORKOUT',
              icon: AppIcons.share,
              onPressed: widget.onShareWorkout,
            ),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(
              label: 'DONE',
              onPressed: widget.onDone ?? () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return h > 0 ? '$h h $m m'.replaceAll(' ', '') : '$m min';
  }

  String _formatVolume(double kg) {
    if (kg >= 1000) {
      final tons = kg / 1000;
      return '${tons.toStringAsFixed(1)}t';
    }
    return '${kg.round()}kg';
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value, this.highlight = false});

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = highlight ? AppPalette.warning : AppPalette.textPrimary;
    return AppCard(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.md),
      borderColor: highlight
          ? AppPalette.warning.withValues(alpha: 0.35)
          : null,
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: color,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(color: AppPalette.textTertiary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _XpLineRow extends StatelessWidget {
  const _XpLineRow({required this.line});

  final XpLine line;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
      child: Row(
        children: [
          Expanded(child: Text(line.label, style: theme.textTheme.bodyLarge)),
          Text(
            '+${line.amount} XP',
            style: theme.textTheme.titleSmall?.copyWith(
              color: AppPalette.warning,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.result});

  final WorkoutCompletionResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = result.progressionAfter;
    return AppCard(
      child: Column(
        children: [
          Text('LEVEL ${p.level}', style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(
            p.title.name,
            style: theme.textTheme.bodySmall?.copyWith(color: AppPalette.textSecondary),
          ),
          const SizedBox(height: AppSpacing.md),
          XpBar(progress: p.levelProgress),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${_fmt(p.currentXp)} / ${_fmt(p.xpForNextLevel)} XP',
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppPalette.textSecondary,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(int n) => n.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'), (Match m) => ',');
}

class _LevelUpCard extends StatelessWidget {
  const _LevelUpCard({required this.result});

  final WorkoutCompletionResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = result.progressionAfter;
    return AppCard(
      glowColor: AppPalette.ember,
      borderColor: AppPalette.ember.withValues(alpha: 0.5),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppPalette.emberSoft, AppPalette.ember, AppPalette.warning],
            ).createShader(bounds),
            child: Text(
              'LEVEL UP!',
              style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'YOU REACHED',
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppPalette.textSecondary, letterSpacing: 2),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'LEVEL ${p.level}',
            style: theme.textTheme.displaySmall?.copyWith(color: AppPalette.textPrimary),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            p.title.name.toUpperCase(),
            style: theme.textTheme.titleMedium?.copyWith(color: AppPalette.emberSoft),
          ),
          const SizedBox(height: AppSpacing.lg),
          XpBar(progress: p.levelProgress),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${p.currentXp} / ${p.xpForNextLevel} XP',
            style: theme.textTheme.labelMedium
                ?.copyWith(color: AppPalette.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _AchievementRow extends StatelessWidget {
  const _AchievementRow({
    required this.name,
    required this.description,
    required this.xp,
  });

  final String name;
  final String description;
  final int xp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        borderColor: AppPalette.warning.withValues(alpha: 0.3),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppPalette.warning.withValues(alpha: 0.12),
              ),
              child: const Icon(AppIcons.trophy, color: AppPalette.warning, size: 22),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ACHIEVEMENT UNLOCKED',
                      style: theme.textTheme.labelSmall
                          ?.copyWith(color: AppPalette.warning, letterSpacing: 1)),
                  const SizedBox(height: 2),
                  Text(name, style: theme.textTheme.titleSmall),
                  Text(description,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: AppPalette.textSecondary),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Text('+$xp XP',
                style: theme.textTheme.titleSmall?.copyWith(color: AppPalette.warning)),
          ],
        ),
      ),
    );
  }
}
