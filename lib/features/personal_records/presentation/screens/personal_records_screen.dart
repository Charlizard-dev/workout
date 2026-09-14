import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/cards.dart';
import '../../../../core/widgets/feedback.dart';
import '../../../../core/widgets/shell_chrome.dart';
import '../../domain/entities/personal_record.dart';
import '../bloc/personal_records_bloc.dart';

/// Personal record feed, newest first.
class PersonalRecordsScreen extends StatelessWidget {
  const PersonalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Records')),
      body: BlocBuilder<PersonalRecordsBloc, PersonalRecordsState>(
        builder: (context, state) {
          if (state is PersonalRecordsLoading) {
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: const [
                ShimmerBlock(height: 96, radius: AppRadius.lg),
                SizedBox(height: AppSpacing.md),
                ShimmerBlock(height: 96, radius: AppRadius.lg),
                SizedBox(height: AppSpacing.md),
                ShimmerBlock(height: 96, radius: AppRadius.lg),
              ],
            );
          }
          if (state is PersonalRecordsError) {
            return ErrorState(message: state.message);
          }
          if (state is! PersonalRecordsReady) {
            return const SizedBox.shrink();
          }
          if (state.records.isEmpty) {
            return const EmptyState(
              icon: AppIcons.bolt,
              title: 'No records yet',
              message:
                  'Push a little heavier each session and your records will land here.',
            );
          }
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              ShellChrome.tabBottom(context),
            ),
            itemCount: state.records.length,
            itemBuilder: (context, index) {
              final record = state.records[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _RecordRow(record: record),
              );
            },
          );
        },
      ),
    );
  }
}

class _RecordRow extends StatelessWidget {
  const _RecordRow({required this.record});

  final PersonalRecord record;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      borderColor: AppPalette.warning.withValues(alpha: 0.25),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPalette.warning.withValues(alpha: 0.12),
            ),
            child: const Icon(AppIcons.bolt,
                color: AppPalette.warning, size: 22),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record.exerciseName,
                    style: theme.textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(
                  '${record.formatValue()} • ${DateFormat('MMM d').format(record.achievedAt)}',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: AppPalette.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            '+50 XP',
            style: theme.textTheme.labelLarge
                ?.copyWith(color: AppPalette.warning),
          ),
        ],
      ),
    );
  }
}
