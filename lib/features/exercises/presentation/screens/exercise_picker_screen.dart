import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/feedback.dart';
import '../../../../core/widgets/muscle_art.dart';
import '../../../../core/widgets/shell_chrome.dart';
import '../../domain/entities/exercise.dart';
import '../bloc/exercise_library_bloc.dart';

/// Full-screen multi-select exercise picker.
/// Returns selected exercises via Navigator.pop.
class ExercisePickerScreen extends StatefulWidget {
  const ExercisePickerScreen({
    super.key,
    this.excludedIds = const {},
    this.allowCreate = true,
  });

  final Set<String> excludedIds;
  final bool allowCreate;

  @override
  State<ExercisePickerScreen> createState() => _ExercisePickerScreenState();
}

class _ExercisePickerScreenState extends State<ExercisePickerScreen> {
  final _search = TextEditingController();
  final _selected = <Exercise>{};
  final _nameFocus = FocusNode();

  @override
  void dispose() {
    _search.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  void _toggle(Exercise exercise) {
    HapticFeedback.selectionClick();
    setState(() {
      if (_selected.contains(exercise)) {
        _selected.remove(exercise);
      } else {
        _selected.add(exercise);
      }
    });
  }

  Future<void> _openCreateCustom() async {
    final bloc = context.read<ExerciseLibraryBloc>();
    final nameController = TextEditingController();
    MuscleGroup muscle = MuscleGroup.chest;

    final created = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, setSheetState) => Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.lg,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create Exercise', style: Theme.of(sheetContext).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: nameController,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(hintText: 'Exercise name'),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Primary muscle',
                  style: Theme.of(sheetContext)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: AppPalette.textSecondary)),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: MuscleGroup.values.map((m) {
                  final selected = m == muscle;
                  return ChoiceChip(
                    label: Text(m.label),
                    selected: selected,
                    onSelected: (_) => setSheetState(() => muscle = m),
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
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppPalette.ember,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (nameController.text.trim().isEmpty) return;
                    bloc.add(CreateCustomExercise(Exercise(
                      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
                      name: nameController.text.trim(),
                      primaryMuscle: muscle,
                      isCustom: true,
                    )));
                    Navigator.pop(sheetContext, true);
                  },
                  child: const Text('CREATE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (created == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Custom exercise created.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Exercises${_selected.isEmpty ? '' : ' (${_selected.length})'}'),
        leading: IconButton(
          icon: const Icon(AppIcons.close),
          onPressed: () => Navigator.pop(context, <Exercise>[]),
        ),
        actions: [
          if (widget.allowCreate)
            IconButton(
              icon: const Icon(AppIcons.add),
              tooltip: 'Create custom exercise',
              onPressed: _openCreateCustom,
            ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      bottomNavigationBar: _selected.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.lg),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppPalette.ember,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(52),
                  ),
                  onPressed: () => Navigator.pop(context, _selected.toList()),
                  child: Text(
                    'ADD ${_selected.length} EXERCISE${_selected.length == 1 ? '' : 'S'}',
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ),
            ),
      body: BlocBuilder<ExerciseLibraryBloc, ExerciseLibraryState>(
        builder: (context, state) {
          if (state is! ExerciseLibraryReady) {
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                for (var i = 0; i < 8; i++) ...[
                  const ShimmerBlock(height: 64, radius: AppRadius.md),
                  if (i < 7) const SizedBox(height: AppSpacing.md),
                ],
              ],
            );
          }

          final results = state.results
              .where((e) => !widget.excludedIds.contains(e.id))
              .toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
                child: TextField(
                  controller: _search,
                  onChanged: (q) =>
                      context.read<ExerciseLibraryBloc>().add(SearchExercises(q)),
                  decoration: InputDecoration(
                    hintText: 'Search exercises',
                    prefixIcon: const Icon(AppIcons.search, size: 20),
                    suffixIcon: _search.text.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(AppIcons.close, size: 18),
                            onPressed: () {
                              _search.clear();
                              context.read<ExerciseLibraryBloc>()
                                  .add(const SearchExercises(''));
                            },
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                  children: [
                    _MuscleChip(
                      label: 'All',
                      selected: state.muscleFilter == null,
                      onTap: () => context
                          .read<ExerciseLibraryBloc>()
                          .add(const FilterByMuscle(null)),
                    ),
                    for (final muscle in MuscleGroup.values)
                      _MuscleChip(
                        label: muscle.label,
                        selected: state.muscleFilter == muscle,
                        onTap: () => context
                            .read<ExerciseLibraryBloc>()
                            .add(FilterByMuscle(muscle)),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: results.isEmpty
                    ? const EmptyState(
                        icon: AppIcons.search,
                        title: 'No exercises found',
                        message: 'Try a different search or create a custom exercise.',
                      )
                    : ListView.builder(
                        padding: EdgeInsets.fromLTRB(
                            AppSpacing.lg,
                            AppSpacing.md,
                            AppSpacing.lg,
                            ShellChrome.tabBottom(context)),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final exercise = results[index];
                          final selected = _selected.contains(exercise);
                          return _ExercisePickRow(
                            exercise: exercise,
                            selected: selected,
                            onToggle: () => _toggle(exercise),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MuscleChip extends StatelessWidget {
  const _MuscleChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? AppPalette.ember : AppPalette.surfaceHigh,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: selected
                ? null
                : Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: selected ? Colors.white : AppPalette.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}

class _ExercisePickRow extends StatelessWidget {
  const _ExercisePickRow({
    required this.exercise,
    required this.selected,
    required this.onToggle,
  });

  final Exercise exercise;
  final bool selected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm + 2),
      child: Material(
        color: selected
            ? AppPalette.ember.withValues(alpha: 0.10)
            : AppPalette.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: AppSpacing.md),
            child: Row(
              children: [
                MuscleArt(muscle: exercise.primaryMuscle, size: 46),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exercise.name,
                          style: theme.textTheme.titleSmall, maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text(
                        exercise.secondaryMuscles.isEmpty
                            ? exercise.primaryMuscle.label
                            : '${exercise.primaryMuscle.label} • ${exercise.secondaryMuscles.map((m) => m.label).join(', ')}',
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: AppPalette.textTertiary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                if (exercise.isCustom)
                  const Padding(
                    padding: EdgeInsets.only(right: AppSpacing.sm),
                    child: Icon(AppIcons.edit, size: 14, color: AppPalette.textTertiary),
                  ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? AppPalette.ember : Colors.transparent,
                    border: Border.all(
                      color: selected ? AppPalette.ember : AppPalette.textTertiary,
                      width: 1.6,
                    ),
                  ),
                  child: selected
                      ? const Icon(AppIcons.check, size: 16, color: Colors.white)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
