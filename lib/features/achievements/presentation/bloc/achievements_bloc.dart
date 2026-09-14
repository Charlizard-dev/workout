import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/achievement_repository_impl.dart';

sealed class AchievementsEvent extends Equatable {
  const AchievementsEvent();

  @override
  List<Object?> get props => [];
}

final class AchievementsLoaded extends AchievementsEvent {
  const AchievementsLoaded();
}

sealed class AchievementsState extends Equatable {
  const AchievementsState();
}

final class AchievementsLoading extends AchievementsState {
  const AchievementsLoading();

  @override
  List<Object?> get props => [];
}

final class AchievementsReady extends AchievementsState {
  const AchievementsReady(this.items);

  final List<AchievementWithState> items;

  @override
  List<Object?> get props => [items];
}

final class AchievementsError extends AchievementsState {
  const AchievementsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class AchievementsBloc extends Bloc<AchievementsEvent, AchievementsState> {
  AchievementsBloc({required AchievementRepository repository})
      : _repository = repository, // ignore: prefer_initializing_formals
        super(const AchievementsLoading()) {
    on<AchievementsLoaded>(_onLoaded);
    add(const AchievementsLoaded());
  }

  final AchievementRepository _repository;

  Future<void> _onLoaded(
      AchievementsLoaded event, Emitter<AchievementsState> emit) async {
    final result = await _repository.getAll();
    result.fold(
      (failure) => emit(AchievementsError(failure.message)),
      (items) => emit(AchievementsReady(items)),
    );
  }
}
