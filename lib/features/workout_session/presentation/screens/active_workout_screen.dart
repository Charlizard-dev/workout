import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/cards.dart';
import '../../../../core/widgets/muscle_art.dart';
import '../../../exercises/domain/entities/exercise.dart';
import '../bloc/workout_session_bloc.dart';
import '../../domain/entities/workout_session.dart';

/// Active workout: elapsed timer, current exercise, set table,
/// rest overlay, finish flow.
class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({
    super.key,
    required this.onWorkoutComplete,
    required this.onExit,
    this.musicBar,
  });

  /// Called with the completion result for the celebration flow.
  final void Function(BuildContext context) onWorkoutComplete;
  final VoidCallback onExit;
  final PreferredSizeWidget? musicBar;

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  Timer? _elapsedTicker;

  @override
  void initState() {
    super.initState();
    _elapsedTicker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _elapsedTicker?.cancel();
    super.dispose();
  }

  String _formatElapsed(DateTime startedAt) {
    final elapsed = DateTime.now().difference(startedAt);
    final h = elapsed.inHours;
    final m = elapsed.inMinutes % 60;
    final s = elapsed.inSeconds % 60;
    final mm = m.toString().padLeft(2, '0');
    final ss = s.toString().padLeft(2, '0');
    return h > 0 ? '$h:$mm:$ss' : '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<WorkoutSessionBloc, SessionState>(
      listener: (context, state) {
        if (state is SessionComplete) {
          widget.onWorkoutComplete(context);
        }
      },
      builder: (context, state) {
        if (state is SessionError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Workout')),
            body: ErrorRetryBody(
              message: state.message,
              onRetry: widget.onExit,
            ),
          );
        }
        if (state is! SessionActive) {
          return const Scaffold(body: SizedBox.shrink());
        }

        final session = state.session;
        final exercise = state.currentExercise;
        final resting = state is SessionResting;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              session.name.toUpperCase(),
              style: theme.textTheme.titleMedium?.copyWith(letterSpacing: 1.2),
            ),
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(AppIcons.close),
              onPressed: () => _confirmExit(context),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.lg),
                child: Center(
                  child: Text(
                    _formatElapsed(session.startedAt),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                      color: AppPalette.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              SafeArea(
                top: false,
                child: Column(
                  children: [
                    _SessionProgressHeader(state: state),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(
                            AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xxxl),
                        children: [
                          _ExerciseHeader(
                            exercise: exercise,
                            positionInSession:
                                state.currentExerciseIndex + 1,
                            totalExercises: session.exercises.length,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          _SetTable(
                            exercise: exercise,
                            spottingSetId: state.spottingSetId,
                            onSetCompleted: (set) {
                              HapticFeedback.mediumImpact();
                              context.read<WorkoutSessionBloc>().add(
                                    SetCompleted(exercise.id, set.id,
                                        weightKg: set.weightKg, reps: set.reps),
                                  );
                            },
                            onSetUpdated: (set, weight, reps) {
                              context.read<WorkoutSessionBloc>().add(
                                    SetUpdated(exercise.id, set.id,
                                        weightKg: weight, reps: reps),
                                  );
                            },
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            children: [
                              Expanded(
                                child: SecondaryButton(
                                  label: 'PREV',
                                  icon: AppIcons.chevronLeft,
                                  onPressed: state.currentExerciseIndex > 0
                                      ? () => context.read<WorkoutSessionBloc>().add(
                                            FocusExercise(
                                                state.currentExerciseIndex - 1),
                                          )
                                      : null,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: SecondaryButton(
                                  label: 'NEXT',
                                  icon: AppIcons.chevronRight,
                                  onPressed:
                                      state.currentExerciseIndex <
                                              session.exercises.length - 1
                                          ? () => context
                                              .read<WorkoutSessionBloc>()
                                              .add(FocusExercise(
                                                  state.currentExerciseIndex + 1))
                                          : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          PrimaryButton(
                            label: 'FINISH WORKOUT',
                            icon: AppIcons.check,
                            onPressed: () =>
                                context.read<WorkoutSessionBloc>().add(const WorkoutFinished()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (resting) _RestOverlay(state: state),
            ],
          ),
        );
      },
    );
  }

  void _confirmExit(BuildContext context) {
    final bloc = context.read<WorkoutSessionBloc>();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Leave workout?'),
        content: const Text(
            'Your progress so far will be discarded. Sets you completed will not be saved.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Keep Training'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppPalette.danger),
            onPressed: () {
              Navigator.pop(dialogContext);
              bloc.add(const WorkoutAbandoned());
              widget.onExit();
            },
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }
}

class ErrorRetryBody extends StatelessWidget {
  const ErrorRetryBody({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, textAlign: TextAlign.center),
          if (onRetry != null)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: SecondaryButton(label: 'BACK', onPressed: onRetry),
            ),
        ],
      ),
    );
  }
}



class _SessionProgressHeader extends StatelessWidget {
  const _SessionProgressHeader({required this.state});

  final SessionActive state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'SET ${state.completedSetCount}/${state.plannedSetCount}',
                      style: theme.textTheme.labelMedium
                          ?.copyWith(color: AppPalette.textSecondary, letterSpacing: 0.8),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      '+${state.sessionXpPreview} XP',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppPalette.warning,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: LinearProgressIndicator(
                    value: state.progress,
                    minHeight: 4,
                    backgroundColor: AppPalette.track,
                    valueColor: const AlwaysStoppedAnimation(AppPalette.ember),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseHeader extends StatelessWidget {
  const _ExerciseHeader({
    required this.exercise,
    required this.positionInSession,
    required this.totalExercises,
  });

  final SessionExercise exercise;
  final int positionInSession;
  final int totalExercises;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lastCompleted = exercise.completedSets.isNotEmpty
        ? exercise.completedSets.last
        : null;

    return AppCard(
      glowColor: AppPalette.ember,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'EXERCISE $positionInSession OF $totalExercises',
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: AppPalette.textTertiary, letterSpacing: 1.2),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs + 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MuscleArt(
                  muscle: exercise.exercise.primaryMuscle, size: 56),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.exercise.name.toUpperCase(),
                      style: theme.textTheme.headlineSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '${exercise.exercise.primaryMuscle.label}'
                      '${exercise.exercise.secondaryMuscles.isEmpty ? '' : ' • ${exercise.exercise.secondaryMuscles.map((m) => m.label).join(', ')}'}',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: AppPalette.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (lastCompleted != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              'Previous: ${lastCompleted.weightKg.toStringAsFixed(lastCompleted.weightKg.truncateToDouble() == lastCompleted.weightKg ? 0 : 1)}kg × ${lastCompleted.reps}',
              style: theme.textTheme.labelMedium
                  ?.copyWith(color: AppPalette.textTertiary),
            ),
          ],
        ],
      ),
    );
  }
}

class _SetTable extends StatelessWidget {
  const _SetTable({
    required this.exercise,
    required this.spottingSetId,
    required this.onSetCompleted,
    required this.onSetUpdated,
  });

  final SessionExercise exercise;
  final String? spottingSetId;
  final void Function(WorkoutSet set) onSetCompleted;
  final void Function(WorkoutSet set, double weight, int reps) onSetUpdated;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.md),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Row(
              children: [
                const SizedBox(width: 34),
                const Expanded(
                  flex: 2,
                  child: Text('SET', style: TextStyle(fontSize: 10.5, letterSpacing: 1, color: AppPalette.textTertiary, fontWeight: FontWeight.w700)),
                ),
                Expanded(
                  flex: 3,
                  child: Text('KG',
                      style: theme.textTheme.labelSmall
                          ?.copyWith(color: AppPalette.textTertiary),
                      textAlign: TextAlign.center),
                ),
                Expanded(
                  flex: 3,
                  child: Text('REPS',
                      style: theme.textTheme.labelSmall
                          ?.copyWith(color: AppPalette.textTertiary),
                      textAlign: TextAlign.center),
                ),
                const SizedBox(width: 44),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (var i = 0; i < exercise.sets.length; i++)
            _SetRow(
              set: exercise.sets[i],
              index: i,
              isNext: exercise.sets[i].id == spottingSetId,
              onCompleted: () => onSetCompleted(exercise.sets[i]),
              onUpdated: (w, r) => onSetUpdated(exercise.sets[i], w, r),
            ),
        ],
      ),
    );
  }
}

class _SetRow extends StatefulWidget {
  const _SetRow({
    required this.set,
    required this.index,
    required this.isNext,
    required this.onCompleted,
    required this.onUpdated,
  });

  final WorkoutSet set;
  final int index;
  final bool isNext;
  final VoidCallback onCompleted;
  final void Function(double weight, int reps) onUpdated;

  @override
  State<_SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<_SetRow> {
  late final TextEditingController _kg;
  late final TextEditingController _reps;

  @override
  void initState() {
    super.initState();
    final kg = widget.set.weightKg;
    _kg = TextEditingController(
        text: kg == 0 ? '' : (kg.truncateToDouble() == kg ? kg.toInt().toString() : kg.toStringAsFixed(1)));
    _reps = TextEditingController(text: widget.set.reps == 0 ? '' : widget.set.reps.toString());
  }

  @override
  void didUpdateWidget(_SetRow old) {
    super.didUpdateWidget(old);
    // Sync controller when the set becomes completed (routine defaults may change).
    if (widget.set.completed && !old.set.completed) {
      final kg = widget.set.weightKg;
      _kg.text = kg == 0 ? '' : (kg.truncateToDouble() == kg ? kg.toInt().toString() : kg.toStringAsFixed(1));
      _reps.text = widget.set.reps.toString();
    }
  }

  @override
  void dispose() {
    _kg.dispose();
    _reps.dispose();
    super.dispose();
  }

  void _commit() {
    final kg = double.tryParse(_kg.text.replaceAll(',', '.')) ?? widget.set.weightKg;
    final reps = int.tryParse(_reps.text) ?? widget.set.reps;
    widget.onUpdated(kg, reps);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completed = widget.set.completed;
    final isWarmUp = widget.set.isWarmUp;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs + 2),
      decoration: BoxDecoration(
        color: completed
            ? AppPalette.success.withValues(alpha: 0.06)
            : widget.isNext
                ? AppPalette.ember.withValues(alpha: 0.06)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(
          color: completed
              ? AppPalette.success.withValues(alpha: 0.25)
              : widget.isNext
                  ? AppPalette.ember.withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.04),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: AppSpacing.sm),
        child: Row(
          children: [
            SizedBox(
              width: 34,
              child: Column(
                children: [
                  Text(
                    '${widget.index + 1}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: completed
                          ? AppPalette.success
                          : AppPalette.textPrimary,
                    ),
                  ),
                  if (isWarmUp)
                    Text('WU',
                        style: theme.textTheme.labelSmall
                            ?.copyWith(color: AppPalette.textTertiary, fontSize: 8)),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                completed ? '✓' : isWarmUp ? 'warm' : 'work',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: completed ? AppPalette.success : AppPalette.textTertiary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: completed
                  ? Text(
                      widget.set.weightKg == 0 ? '—' : '${widget.set.weightKg % 1 == 0 ? widget.set.weightKg.toInt() : widget.set.weightKg}',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleSmall,
                    )
                  : _NumberInputField(controller: _kg, hint: '0', onCommit: _commit),
            ),
            Expanded(
              flex: 3,
              child: completed
                  ? Text('${widget.set.reps}',
                      textAlign: TextAlign.center, style: theme.textTheme.titleSmall)
                  : _NumberInputField(controller: _reps, hint: '0', onCommit: _commit),
            ),
            SizedBox(
              width: 44,
              child: completed
                  ? const Icon(AppIcons.check, color: AppPalette.success, size: 22)
                  : IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                      icon: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.isNext
                              ? AppPalette.ember
                              : AppPalette.surfaceHighest,
                          border: widget.isNext
                              ? null
                              : Border.all(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                        child: const Icon(AppIcons.check, size: 18, color: Colors.white),
                      ),
                      onPressed: () {
                        _commit();
                        widget.onCompleted();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NumberInputField extends StatelessWidget {
  const _NumberInputField({
    required this.controller,
    required this.hint,
    required this.onCommit,
  });

  final TextEditingController controller;
  final String hint;
  final VoidCallback onCommit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextField(
        controller: controller,
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: false),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall,
        onSubmitted: (_) => onCommit(),
        onChanged: (_) => onCommit(),
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            borderSide: const BorderSide(color: AppPalette.ember),
          ),
          counterText: '',
        ),
      ),
    );
  }
}

class _RestOverlay extends StatelessWidget {
  const _RestOverlay({required this.state});

  final SessionResting state;

  String get _remainingText {
    final m = state.remaining.inMinutes;
    final s = state.remaining.inSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Positioned.fill(
      child: Container(
        color: AppPalette.charcoal.withValues(alpha: 0.94),
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'REST',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppPalette.textSecondary,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: 220,
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: CircularProgressIndicator(
                        value: state.restProgress.clamp(0.0, 1.0),
                        strokeWidth: 6,
                        strokeCap: StrokeCap.round,
                        backgroundColor: AppPalette.track,
                        valueColor:
                            const AlwaysStoppedAnimation(AppPalette.ember),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _remainingText,
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SecondaryButton(
                    label: '-15s',
                    expanded: false,
                    onPressed: () => context.read<WorkoutSessionBloc>().add(
                          const RestAdjusted(Duration(seconds: -15)),
                        ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  SecondaryButton(
                    label: '+15s',
                    expanded: false,
                    onPressed: () => context.read<WorkoutSessionBloc>().add(
                          const RestAdjusted(Duration(seconds: 15)),
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                label: 'SKIP REST',
                onPressed: () =>
                    context.read<WorkoutSessionBloc>().add(const RestSkipped()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
