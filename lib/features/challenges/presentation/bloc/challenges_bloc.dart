import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/challenge_repository_impl.dart';

sealed class ChallengesEvent extends Equatable {
  const ChallengesEvent();

  @override
  List<Object?> get props => [];
}

final class ChallengesLoaded extends ChallengesEvent {
  const ChallengesLoaded();
}

sealed class ChallengesState extends Equatable {
  const ChallengesState();
}

final class ChallengesLoading extends ChallengesState {
  const ChallengesLoading();

  @override
  List<Object?> get props => [];
}

final class ChallengesReady extends ChallengesState {
  const ChallengesReady(this.current);

  final CurrentChallenges current;

  @override
  List<Object?> get props => [current];
}

final class ChallengesError extends ChallengesState {
  const ChallengesError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ChallengesBloc extends Bloc<ChallengesEvent, ChallengesState> {
  ChallengesBloc({required ChallengeRepository repository})
      : _repository = repository, // ignore: prefer_initializing_formals
        super(const ChallengesLoading()) {
    on<ChallengesLoaded>(_onLoaded);
    add(const ChallengesLoaded());
  }

  final ChallengeRepository _repository;

  Future<void> _onLoaded(
      ChallengesLoaded event, Emitter<ChallengesState> emit) async {
    final result = await _repository.getCurrent();
    result.fold(
      (failure) => emit(ChallengesError(failure.message)),
      (current) => emit(ChallengesReady(current)),
    );
  }
}
