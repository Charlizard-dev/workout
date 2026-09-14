import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/feedback.dart';
import '../../../../core/widgets/shell_chrome.dart';
import '../../domain/entities/workout_routine.dart';
import '../bloc/workout_routine_bloc.dart';
import '../widgets/routine_card.dart';

/// "MY ROUTINES" — manage and launch routines.
class RoutinesScreen extends StatelessWidget {
  const RoutinesScreen({
    super.key,
    required this.onCreateRoutine,
    required this.onEditRoutine,
    this.onWorkoutStart,
  });

  final VoidCallback onCreateRoutine;
  final void Function(WorkoutRoutine routine) onEditRoutine;
  final void Function(WorkoutRoutine routine)? onWorkoutStart;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutRoutineBloc, RoutineState>(
      buildWhen: (prev, next) => next is! RoutineLoaded || prev is! RoutineLoaded || prev != next,
      builder: (context, state) {
        final body = switch (state) {
          RoutineInitial() || RoutineLoading() => const _RoutinesSkeleton(),
          RoutineError(:final message) => ErrorState(message: message),
          RoutineLoaded(:final routines) => routines.isEmpty
              ? EmptyState(
                  icon: AppIcons.dumbbell,
                  title: 'No workout routines yet',
                  message: 'Create your first routine and start training.',
                  actionLabel: 'CREATE ROUTINE',
                  onAction: onCreateRoutine,
                )
              : _RoutineReorderList(
                  routines: routines,
                  pendingAction: state.pendingAction,
                  onEdit: onEditRoutine,
                  onWorkoutStart: onWorkoutStart,
                ),
        };

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              title: const Text('My Routines'),
              actions: [
                IconButton(
                  icon: const Icon(AppIcons.add),
                  tooltip: 'Create routine',
                  onPressed: onCreateRoutine,
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: body,
            ),
          ],
        );
      },
    );
  }
}

class _RoutineReorderList extends StatelessWidget {
  const _RoutineReorderList({
    required this.routines,
    required this.pendingAction,
    required this.onEdit,
    this.onWorkoutStart,
  });

  final List<WorkoutRoutine> routines;
  final bool pendingAction;
  final void Function(WorkoutRoutine) onEdit;
  final void Function(WorkoutRoutine)? onWorkoutStart;

  void _openActions(BuildContext context, WorkoutRoutine routine) {
    HapticFeedback.mediumImpact();
    final bloc = context.read<WorkoutRoutineBloc>();
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Text(
                routine.name,
                style: Theme.of(sheetContext).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ListTile(
              leading: const Icon(AppIcons.play, color: AppPalette.ember),
              title: const Text('Start Workout'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                onWorkoutStart?.call(routine);
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.edit),
              title: const Text('Edit Routine'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                onEdit(routine);
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.copy),
              title: const Text('Duplicate'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                bloc.add(DuplicateRoutine(routine.id));
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.delete, color: AppPalette.danger),
              title: const Text('Delete', style: TextStyle(color: AppPalette.danger)),
              onTap: () {
                Navigator.of(sheetContext).pop();
                bloc.add(DeleteRoutine(routine.id));
              },
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: pendingAction,
      child: ReorderableListView.builder(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          ShellChrome.tabBottom(context),
        ),
        itemCount: routines.length,
        onReorderItem: (oldIndex, newIndex) {
          final ids = routines.map((r) => r.id).toList();
          final moved = ids.removeAt(oldIndex);
          ids.insert(newIndex, moved);
          context.read<WorkoutRoutineBloc>().add(ReorderRoutines(ids));
        },
        proxyDecorator: (child, index, animation) => AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final scale = 1.03 + 0.02 * (1 - Curves.easeOut.transform(animation.value));
            return Transform.scale(scale: scale, child: child);
          },
          child: child,
        ),
        itemBuilder: (context, index) {
          final routine = routines[index];
          return Padding(
            key: ValueKey(routine.id),
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: RoutineCard(
              routine: routine,
              onTap: () => _openActions(context, routine),
              onStart: onWorkoutStart == null ? null : () => onWorkoutStart!(routine),
            ),
          );
        },
      ),
    );
  }
}

class _RoutinesSkeleton extends StatelessWidget {
  const _RoutinesSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (var i = 0; i < 4; i++) ...[
          const ShimmerBlock(height: 120, radius: AppRadius.md),
          if (i < 3) const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}
