import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/cards.dart';
import '../../../../core/widgets/feedback.dart';
import '../../../../core/widgets/shell_chrome.dart';
import '../../../workout_session/domain/entities/workout_session.dart';
import '../bloc/workout_history_bloc.dart';

/// Completed workouts grouped by month with volume + XP.
class WorkoutHistoryScreen extends StatelessWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout History')),
      body: BlocBuilder<WorkoutHistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
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
          if (state is HistoryError) {
            return ErrorState(message: state.message);
          }
          if (state is! HistoryReady) {
            return const SizedBox.shrink();
          }
          if (state.sessions.isEmpty) {
            return const EmptyState(
              icon: AppIcons.history,
              title: 'No workouts yet',
              message: 'Your completed workouts will appear here.',
            );
          }

          final groups = _groupByMonth(state.sessions);
          return ListView(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              ShellChrome.tabBottom(context),
            ),
            children: [
              for (final entry in groups.entries) ...[
                SectionHeader(title: entry.key),
                for (final session in entry.value)
                  _HistoryRow(session: session),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          );
        },
      ),
    );
  }

  Map<String, List<WorkoutSession>> _groupByMonth(
      List<WorkoutSession> sessions) {
    final groups = <String, List<WorkoutSession>>{};
    for (final session in sessions) {
      final date = session.completedAt ?? session.startedAt;
      final key = DateFormat('MMMM yyyy').format(date).toUpperCase();
      groups.putIfAbsent(key, () => []).add(session);
    }
    return groups;
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.session});

  final WorkoutSession session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = session.completedAt ?? session.startedAt;
    final day = DateFormat('MMM d').format(date).toUpperCase();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    session.name.toUpperCase(),
                    style: theme.textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  day,
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: AppPalette.textTertiary),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm + 2),
            Row(
              children: [
                _Meta(
                    icon: AppIcons.duration,
                    label: _formatDuration(session.duration)),
                const SizedBox(width: AppSpacing.lg),
                _Meta(
                    icon: AppIcons.repeat,
                    label: '${session.totalSets} sets'),
                const SizedBox(width: AppSpacing.lg),
                _Meta(
                    icon: AppIcons.volume,
                    label: _formatVolume(session.totalVolume)),
              ],
            ),
            if (session.xpEarned != null &&
                session.xpEarned! > 0) ...[
              const SizedBox(height: AppSpacing.sm + 2),
              Text(
                '+${session.xpEarned} XP'
                '${(session.personalRecords ?? 0) > 0 ? ' • ${session.personalRecords} PR${session.personalRecords == 1 ? '' : 's'}' : ''}',
                style: theme.textTheme.labelMedium
                    ?.copyWith(color: AppPalette.warning),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return h > 0 ? '${h}h ${m}m' : '${m}m';
  }

  String _formatVolume(double kg) {
    if (kg >= 1000) return '${(kg / 1000).toStringAsFixed(1)}t';
    return '${kg.round()}kg';
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
