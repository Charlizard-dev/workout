import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/cards.dart';
import '../../../../core/widgets/feedback.dart';
import '../../../../core/widgets/muscle_art.dart';
import '../../../../core/widgets/shell_chrome.dart';
import '../../../exercises/domain/entities/exercise.dart';
import '../../domain/entities/workout_routine.dart';

/// Result contract the editor returns to the caller.
class RoutineEditorResult {
  const RoutineEditorResult({required this.routine, required this.wasDeleted});
  final WorkoutRoutine routine;
  final bool wasDeleted;
}

/// Create / edit a routine: metadata + ordered exercise configs.
/// The screen is a pure form; persistence flows through the parent bloc
/// once the user confirms.
class RoutineEditorScreen extends StatefulWidget {
  const RoutineEditorScreen({
    super.key,
    required this.onSave,
    required this.onDelete,
    required this.onAddExercises,
    this.initial,
  });

  final WorkoutRoutine? initial;
  final Future<bool> Function(WorkoutRoutine routine) onSave;
  final void Function(WorkoutRoutine routine) onDelete;
  /// Opens the exercise picker; awaits selected exercises.
  final Future<List<Exercise>?> Function() onAddExercises;

  @override
  State<RoutineEditorScreen> createState() => _RoutineEditorScreenState();
}

class _RoutineEditorScreenState extends State<RoutineEditorScreen> {
  late final TextEditingController _name;
  late final TextEditingController _description;
  late WorkoutCategory _category;
  late int _restSeconds;
  late List<WorkoutRoutineExercise> _exercises;
  bool _saving = false;

  bool get _isNew => widget.initial == null;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _name = TextEditingController(text: initial?.name ?? '');
    _description = TextEditingController(text: initial?.description ?? '');
    _category = initial?.category ?? WorkoutCategory.strength;
    _restSeconds = initial?.restDuration.inSeconds ?? 90;
    _exercises = List.of(initial?.exercises ?? []);
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) {
      _showSnack('Give your routine a name first.');
      return;
    }
    if (_exercises.isEmpty) {
      _showSnack('Add at least one exercise.');
      return;
    }

    setState(() => _saving = true);
    final now = DateTime.now();
    final routine = WorkoutRoutine(
      id: widget.initial?.id ?? const Uuid().v4(),
      name: name,
      description: _description.text.trim().isEmpty ? null : _description.text.trim(),
      category: _category,
      restDuration: Duration(seconds: _restSeconds),
      exercises: _exercises,
      createdAt: widget.initial?.createdAt ?? now,
      updatedAt: now,
    );
    final ok = await widget.onSave(routine);
    if (!mounted) return;
    setState(() => _saving = false);
    if (ok) {
      Navigator.of(context).pop(true);
    } else {
      _showSnack('Could not save the routine. Try again.');
    }
  }

  void _showSnack(String message) {
    HapticFeedback.selectionClick();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _addExercises() async {
    final selected = await widget.onAddExercises();
    if (selected == null || selected.isEmpty) return;
    setState(() {
      final startPos = _exercises.length;
      _exercises.addAll(selected
          .map((e) => WorkoutRoutineExercise(
                id: const Uuid().v4(),
                exercise: e,
                position: startPos + _exercises.length,
              ))
          .toList());
    });
  }

  void _confirmDelete() {
    final initial = widget.initial;
    if (initial == null) return;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete routine?'),
        content: Text('"${initial.name}" and its exercise list will be removed. '
            'Completed workouts keep their history.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppPalette.danger),
            onPressed: () {
              Navigator.pop(dialogContext);
              widget.onDelete(initial);
              Navigator.of(context).pop(true);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? 'New Routine' : 'Edit Routine'),
        leading: IconButton(icon: const Icon(AppIcons.close), onPressed: () => Navigator.pop(context, false)),
        actions: [
          if (!_isNew)
            IconButton(icon: const Icon(AppIcons.delete), onPressed: _confirmDelete),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.lg),
          child: PrimaryButton(
            label: _saving ? 'SAVING…' : 'SAVE ROUTINE',
            onPressed: _saving ? null : _save,
          ),
        ),
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            ShellChrome.tabBottom(context),
          ),
          children: [
            const _FieldLabel(label: 'Routine Name'),
            TextField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              maxLength: 40,
              decoration: const InputDecoration(
                hintText: 'e.g. Push Day',
                counterText: '',
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const _FieldLabel(label: 'Description'),
            TextField(
              controller: _description,
              maxLines: 2,
              maxLength: 120,
              decoration: const InputDecoration(hintText: 'Optional notes', counterText: ''),
            ),
            const SizedBox(height: AppSpacing.xl),
            const _FieldLabel(label: 'Category'),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: WorkoutCategory.values.map((c) {
                final selected = c == _category;
                return ChoiceChip(
                  label: Text(c.label),
                  selected: selected,
                  onSelected: (_) => setState(() => _category = c),
                  selectedColor: AppPalette.ember.withValues(alpha: 0.9),
                  backgroundColor: AppPalette.surfaceHigh,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : AppPalette.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  showCheckmark: false,
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.xl),
            const _FieldLabel(label: 'Default Rest'),
            _RestStepper(
              seconds: _restSeconds,
              onChanged: (v) => setState(() => _restSeconds = v),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'EXERCISES',
                    style: theme.textTheme.labelMedium?.copyWith(
                        color: AppPalette.textSecondary, letterSpacing: 1.2),
                  ),
                ),
                GestureDetector(
                  onTap: _addExercises,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppPalette.ember.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(color: AppPalette.ember.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(AppIcons.add, size: 16, color: AppPalette.ember),
                        const SizedBox(width: 4),
                        Text('ADD EXERCISE',
                            style: theme.textTheme.labelSmall?.copyWith(color: AppPalette.ember)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            if (_exercises.isEmpty)
              const EmptyState(
                icon: AppIcons.addCircle,
                title: 'No exercises yet',
                message: 'Add exercises to build your routine.',
              )
            else
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _exercises.length,
                onReorderItem: (oldIndex, newIndex) {
                  setState(() {
                    final moved = _exercises.removeAt(oldIndex);
                    _exercises.insert(newIndex, moved);
                    for (var i = 0; i < _exercises.length; i++) {
                      _exercises[i] = _exercises[i].copyWith(position: i);
                    }
                  });
                },
                itemBuilder: (context, index) {
                  final exercise = _exercises[index];
                  return _ExerciseConfigCard(
                    key: ValueKey(exercise.id),
                    index: index,
                    item: exercise,
                    onChanged: (updated) => setState(() => _exercises[index] = updated),
                    onRemove: () => setState(() {
                      _exercises.removeAt(index);
                      for (var i = 0; i < _exercises.length; i++) {
                        _exercises[i] = _exercises[i].copyWith(position: i);
                      }
                    }),
                  );
                },
              ),
            const SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: AppPalette.textSecondary, letterSpacing: 1.2),
      ),
    );
  }
}

class _RestStepper extends StatelessWidget {
  const _RestStepper({required this.seconds, required this.onChanged});

  final int seconds;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(AppIcons.removeCircle),
            onPressed: seconds <= 30 ? null : () => onChanged((seconds - 15).clamp(30, 300)),
          ),
          Text('${Duration(seconds: seconds).inMinutes}:'
              '${(seconds % 60).toString().padLeft(2, '0')}',
              style: theme.textTheme.titleMedium),
          IconButton(
            icon: const Icon(AppIcons.addCircle),
            onPressed: seconds >= 300 ? null : () => onChanged((seconds + 15).clamp(30, 300)),
          ),
        ],
      ),
    );
  }
}

class _ExerciseConfigCard extends StatelessWidget {
  const _ExerciseConfigCard({
    super.key,
    required this.index,
    required this.item,
    required this.onChanged,
    required this.onRemove,
  });

  final int index;
  final WorkoutRoutineExercise item;
  final ValueChanged<WorkoutRoutineExercise> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MuscleArt(muscle: item.exercise.primaryMuscle, size: 40),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    item.exercise.name,
                    style: theme.textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(AppIcons.delete, size: 18, color: AppPalette.danger),
                  onPressed: onRemove,
                  tooltip: 'Remove exercise',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              item.exercise.primaryMuscle.label,
              style: theme.textTheme.labelSmall?.copyWith(color: AppPalette.textTertiary),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _NumberField(
                    label: 'SETS',
                    value: item.setCount,
                    min: 1,
                    max: 10,
                    onChanged: (v) => onChanged(item.copyWith(setCount: v.toInt())),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _NumberField(
                    label: 'REPS',
                    value: item.reps,
                    min: 1,
                    max: 50,
                    onChanged: (v) => onChanged(item.copyWith(reps: v.toInt())),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _NumberField(
                    label: 'KG',
                    value: item.weightKg,
                    min: 0,
                    max: 500,
                    step: 2.5,
                    isDouble: true,
                    onChanged: (v) => onChanged(item.copyWith(weightKg: v.toDouble())),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _NumberField(
                    label: 'REST',
                    value: (item.restDuration ?? const Duration(seconds: 90)).inSeconds,
                    min: 15,
                    max: 300,
                    step: 15,
                    onChanged: (v) => onChanged(
                        item.copyWith(restDuration: Duration(seconds: v.toInt()))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 99,
    this.step = 1,
    this.isDouble = false,
  });

  final String label;
  final num value;
  final ValueChanged<num> onChanged;
  final num min;
  final num max;
  final num step;
  final bool isDouble;

  String get display => isDouble
      ? (value == value.roundToDouble() ? value.toInt().toString() : value.toStringAsFixed(1))
      : value.toInt().toString();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label,
            style: theme.textTheme.labelSmall
                ?.copyWith(color: AppPalette.textTertiary, letterSpacing: 0.8)),
        const SizedBox(height: AppSpacing.xs),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                if (value - step >= min) onChanged(value - step);
              },
              child: const Icon(AppIcons.removeCircle, size: 20, color: AppPalette.textSecondary),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs + 2),
              child: Text(display,
                  style: theme.textTheme.titleSmall?.copyWith(color: AppPalette.textPrimary)),
            ),
            GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                if (value + step <= max) onChanged(value + step);
              },
              child: const Icon(AppIcons.addCircle, size: 20, color: AppPalette.ember),
            ),
          ],
        ),
      ],
    );
  }
}
