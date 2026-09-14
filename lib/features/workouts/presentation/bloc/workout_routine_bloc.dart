import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/workout_routine_repository.dart';
import '../../domain/entities/workout_routine.dart';

sealed class RoutineEvent extends Equatable {
  const RoutineEvent();

  @override
  List<Object?> get props => [];
}

final class LoadRoutines extends RoutineEvent {
  const LoadRoutines();
}

final class DeleteRoutine extends RoutineEvent {
  const DeleteRoutine(this.routineId);

  final String routineId;

  @override
  List<Object?> get props => [routineId];
}

final class DuplicateRoutine extends RoutineEvent {
  const DuplicateRoutine(this.routineId);

  final String routineId;

  @override
  List<Object?> get props => [routineId];
}

final class ReorderRoutines extends RoutineEvent {
  const ReorderRoutines(this.orderedIds);

  final List<String> orderedIds;

  @override
  List<Object?> get props => [orderedIds];
}

final class RoutineSaved extends RoutineEvent {
  const RoutineSaved(this.routine);

  final WorkoutRoutine routine;

  @override
  List<Object?> get props => [routine];
}

sealed class RoutineState extends Equatable {
  const RoutineState();

  @override
  List<Object?> get props => [];
}

final class RoutineInitial extends RoutineState {
  const RoutineInitial();
}

final class RoutineLoading extends RoutineState {
  const RoutineLoading();
}

final class RoutineLoaded extends RoutineState {
  const RoutineLoaded(this.routines, {this.pendingAction = false});

  final List<WorkoutRoutine> routines;
  final bool pendingAction;

  @override
  List<Object?> get props => [routines, pendingAction];
}

final class RoutineError extends RoutineState {
  const RoutineError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Orchestrates routine list CRUD. The editor screen saves through the
/// repository directly and dispatches [RoutineSaved] to refresh.
class WorkoutRoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  WorkoutRoutineBloc({required WorkoutRoutineRepository repository})
      : _repository = repository, // ignore: prefer_initializing_formals
        super(const RoutineInitial()) {
    on<LoadRoutines>(_onLoad);
    on<DeleteRoutine>(_onDelete);
    on<DuplicateRoutine>(_onDuplicate);
    on<ReorderRoutines>(_onReorder);
    on<RoutineSaved>(_onSaved);
  }

  final WorkoutRoutineRepository _repository;

  Future<void> _onLoad(LoadRoutines event, Emitter<RoutineState> emit) async {
    emit(const RoutineLoading());
    final result = await _repository.getAll();
    result.fold(
      (failure) => emit(RoutineError(failure.message)),
      (routines) => emit(RoutineLoaded(routines)),
    );
  }

  Future<void> _onDelete(DeleteRoutine event, Emitter<RoutineState> emit) async {
    final current = state;
    if (current is! RoutineLoaded) return;
    emit(RoutineLoaded(current.routines, pendingAction: true));

    final result = await _repository.delete(event.routineId);
    result.fold(
      (failure) => emit(RoutineError(failure.message)),
      (_) => add(const LoadRoutines()),
    );
  }

  Future<void> _onDuplicate(DuplicateRoutine event, Emitter<RoutineState> emit) async {
    final current = state;
    if (current is! RoutineLoaded) return;
    emit(RoutineLoaded(current.routines, pendingAction: true));

    final result = await _repository.duplicate(event.routineId);
    result.fold(
      (failure) => emit(RoutineError(failure.message)),
      (_) => add(const LoadRoutines()),
    );
  }

  Future<void> _onReorder(ReorderRoutines event, Emitter<RoutineState> emit) async {
    final current = state;
    if (current is! RoutineLoaded) return;

    // Optimistic reorder.
    final byId = {for (final r in current.routines) r.id: r};
    final reordered = event.orderedIds
        .where(byId.containsKey)
        .map((id) => byId[id]!)
        .toList();
    emit(RoutineLoaded(reordered));

    final result = await _repository.reorder(event.orderedIds);
    result.fold(
      (failure) => emit(RoutineError(failure.message)),
      (_) {},
    );
  }

  Future<void> _onSaved(RoutineSaved event, Emitter<RoutineState> emit) async {
    emit(const RoutineLoading());
    final result = await _repository.save(event.routine);
    result.fold(
      (failure) => emit(RoutineError(failure.message)),
      (_) => add(const LoadRoutines()),
    );
  }
}
