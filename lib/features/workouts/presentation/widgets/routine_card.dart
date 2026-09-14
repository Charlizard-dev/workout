import 'package:flutter/material.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/cards.dart';
import '../../domain/entities/workout_routine.dart';

/// A routine summary card in the routines list.
class RoutineCard extends StatelessWidget {
  const RoutineCard({
    super.key,
    required this.routine,
    this.onStart,
    this.onTap,
  });

  final WorkoutRoutine routine;
  final VoidCallback? onStart;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final minutes = (routine.estimatedDuration.inMinutes / 5).round() * 5;

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  routine.name,
                  style: theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(AppIcons.drag, size: 18, color: AppPalette.textTertiary),
            ],
          ),
          const SizedBox(height: AppSpacing.xs + 2),
          Text(
            routine.muscleSummary,
            style: theme.textTheme.bodySmall?.copyWith(color: AppPalette.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _Meta(
                icon: AppIcons.dumbbell,
                label: '${routine.exercises.length} exercises',
              ),
              const SizedBox(width: AppSpacing.md),
              _Meta(icon: AppIcons.repeat, label: '${routine.totalSets} sets'),
              const SizedBox(width: AppSpacing.md),
              _Meta(icon: AppIcons.timer, label: '~${minutes}m'),
              if (onStart != null) ...[
                const Spacer(),
                GestureDetector(
                  onTap: onStart,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      gradient: const LinearGradient(
                        colors: [AppPalette.ember, AppPalette.emberDeep],
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(AppIcons.play, size: 16, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          'START',
                          style: theme.textTheme.labelSmall?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
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
        Icon(icon, size: 14, color: AppPalette.textTertiary),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: AppPalette.textSecondary),
        ),
      ],
    );
  }
}
