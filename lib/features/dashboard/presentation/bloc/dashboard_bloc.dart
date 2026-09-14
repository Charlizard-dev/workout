import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/load_dashboard.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

final class DashboardRefreshed extends DashboardEvent {
  const DashboardRefreshed();
}

sealed class DashboardState extends Equatable {
  const DashboardState();
}

final class DashboardLoading extends DashboardState {
  const DashboardLoading();

  @override
  List<Object?> get props => [];
}

final class DashboardReady extends DashboardState {
  const DashboardReady(this.data);

  final DashboardData data;

  @override
  List<Object?> get props => [data];
}

final class DashboardError extends DashboardState {
  const DashboardError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required LoadDashboard loadDashboard})
      : _load = loadDashboard,
        super(const DashboardLoading()) {
    on<DashboardRefreshed>(_onRefreshed);
    add(const DashboardRefreshed());
  }

  final LoadDashboard _load;

  Future<void> _onRefreshed(
      DashboardRefreshed event, Emitter<DashboardState> emit) async {
    final result = await _load();
    result.fold(
      (failure) => emit(DashboardError(failure.message)),
      (data) => emit(DashboardReady(data)),
    );
  }
}
