import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../exercises/domain/entities/exercise.dart';
import '../../data/repositories/exercise_library_repository_impl.dart';

sealed class ExerciseLibraryEvent extends Equatable {
  const ExerciseLibraryEvent();

  @override
  List<Object?> get props => [];
}

final class LoadExerciseLibrary extends ExerciseLibraryEvent {
  const LoadExerciseLibrary();
}

final class SearchExercises extends ExerciseLibraryEvent {
  const SearchExercises(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class FilterByMuscle extends ExerciseLibraryEvent {
  const FilterByMuscle(this.muscle);

  final MuscleGroup? muscle;

  @override
  List<Object?> get props => [muscle];
}

final class ToggleExerciseFavorite extends ExerciseLibraryEvent {
  const ToggleExerciseFavorite(this.exerciseId);

  final String exerciseId;

  @override
  List<Object?> get props => [exerciseId];
}

final class CreateCustomExercise extends ExerciseLibraryEvent {
  const CreateCustomExercise(this.exercise);

  final Exercise exercise;

  @override
  List<Object?> get props => [exercise];
}

sealed class ExerciseLibraryState extends Equatable {
  const ExerciseLibraryState();

  @override
  List<Object?> get props => [];
}

final class ExerciseLibraryInitial extends ExerciseLibraryState {
  const ExerciseLibraryInitial();
}

/// Full library snapshot with active query/filter applied.
final class ExerciseLibraryReady extends ExerciseLibraryState {
  const ExerciseLibraryReady({
    required this.all,
    required this.query,
    required this.muscleFilter,
  });

  final List<Exercise> all;
  final String query;
  final MuscleGroup? muscleFilter;

  List<Exercise> get results => all.where((e) {
        final matchesMuscle = muscleFilter == null || e.primaryMuscle == muscleFilter;
        if (!matchesMuscle) return false;
        final q = query.trim().toLowerCase();
        return q.isEmpty || e.name.toLowerCase().contains(q);
      }).toList();

  List<Exercise> get favorites => all.where((e) => e.isFavorite).toList();

  List<Exercise> get recentlyUsed {
    final withDate = all.where((e) => e.lastUsedAt != null).toList()
      ..sort((a, b) => b.lastUsedAt!.compareTo(a.lastUsedAt!));
    return withDate.take(10).toList();
  }

  @override
  List<Object?> get props => [all, query, muscleFilter];
}

class ExerciseLibraryBloc
    extends Bloc<ExerciseLibraryEvent, ExerciseLibraryState> {
  ExerciseLibraryBloc({required ExerciseLibraryRepository repository})
      : _repository = repository, // ignore: prefer_initializing_formals
        super(const ExerciseLibraryInitial()) {
    on<LoadExerciseLibrary>(_onLoad);
    on<SearchExercises>(_onSearch);
    on<FilterByMuscle>(_onFilter);
    on<ToggleExerciseFavorite>(_onToggleFavorite);
    on<CreateCustomExercise>(_onCreateCustom);
  }

  final ExerciseLibraryRepository _repository;

  Future<void> _onLoad(
      LoadExerciseLibrary event, Emitter<ExerciseLibraryState> emit) async {
    final result = await _repository.getAll();
    result.fold(
      (_) => emit(const ExerciseLibraryReady(all: [], query: '', muscleFilter: null)),
      (all) => emit(ExerciseLibraryReady(
        all: all,
        query: state is ExerciseLibraryReady
            ? (state as ExerciseLibraryReady).query
            : '',
        muscleFilter: state is ExerciseLibraryReady
            ? (state as ExerciseLibraryReady).muscleFilter
            : null,
      )),
    );
  }

  void _onSearch(
      SearchExercises event, Emitter<ExerciseLibraryState> emit) {
    if (state is! ExerciseLibraryReady) return;
    emit((state as ExerciseLibraryReady).copyWith(query: event.query));
  }

  void _onFilter(
      FilterByMuscle event, Emitter<ExerciseLibraryState> emit) {
    if (state is! ExerciseLibraryReady) return;
    emit((state as ExerciseLibraryReady).copyWith(muscleFilter: event.muscle));
  }

  Future<void> _onToggleFavorite(
      ToggleExerciseFavorite event, Emitter<ExerciseLibraryState> emit) async {
    if (state is! ExerciseLibraryReady) return;
    await _repository.toggleFavorite(event.exerciseId);
    add(const LoadExerciseLibrary());
  }

  Future<void> _onCreateCustom(
      CreateCustomExercise event, Emitter<ExerciseLibraryState> emit) async {
    final result = await _repository.createCustom(event.exercise);
    result.fold(
      (_) {},
      (_) => add(const LoadExerciseLibrary()),
    );
  }
}

extension _ReadyCopy on ExerciseLibraryReady {
  ExerciseLibraryReady copyWith({
    List<Exercise>? all,
    String? query,
    MuscleGroup? muscleFilter,
    bool clearFilter = false,
  }) =>
      ExerciseLibraryReady(
        all: all ?? this.all,
        query: query ?? this.query,
        muscleFilter: clearFilter ? null : (muscleFilter ?? this.muscleFilter),
      );
}
