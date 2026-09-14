import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../workout_session/domain/entities/workout_session.dart';
import '../../../workout_session/domain/repositories/workout_session_repository.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

final class HistoryLoaded extends HistoryEvent {
  const HistoryLoaded();
}

sealed class HistoryState extends Equatable {
  const HistoryState();
}

final class HistoryLoading extends HistoryState {
  const HistoryLoading();

  @override
  List<Object?> get props => [];
}

final class HistoryReady extends HistoryState {
  const HistoryReady(this.sessions);

  final List<WorkoutSession> sessions;

  @override
  List<Object?> get props => [sessions];
}

final class HistoryError extends HistoryState {
  const HistoryError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class WorkoutHistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  WorkoutHistoryBloc({required WorkoutSessionRepository repository})
      : _repository = repository, // ignore: prefer_initializing_formals
        super(const HistoryLoading()) {
    on<HistoryLoaded>(_onLoaded);
    add(const HistoryLoaded());
  }

  final WorkoutSessionRepository _repository;

  Future<void> _onLoaded(
      HistoryLoaded event, Emitter<HistoryState> emit) async {
    final result = await _repository.history(limit: 100);
    result.fold(
      (failure) => emit(HistoryError(failure.message)),
      (sessions) => emit(HistoryReady(sessions)),
    );
  }
}
