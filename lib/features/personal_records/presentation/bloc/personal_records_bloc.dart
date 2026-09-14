import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/personal_record_repository_impl.dart';
import '../../domain/entities/personal_record.dart';

sealed class PersonalRecordsEvent extends Equatable {
  const PersonalRecordsEvent();

  @override
  List<Object?> get props => [];
}

final class PersonalRecordsLoaded extends PersonalRecordsEvent {
  const PersonalRecordsLoaded();
}

sealed class PersonalRecordsState extends Equatable {
  const PersonalRecordsState();
}

final class PersonalRecordsLoading extends PersonalRecordsState {
  const PersonalRecordsLoading();

  @override
  List<Object?> get props => [];
}

final class PersonalRecordsReady extends PersonalRecordsState {
  const PersonalRecordsReady(this.records);

  final List<PersonalRecord> records;

  @override
  List<Object?> get props => [records];
}

final class PersonalRecordsError extends PersonalRecordsState {
  const PersonalRecordsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class PersonalRecordsBloc
    extends Bloc<PersonalRecordsEvent, PersonalRecordsState> {
  PersonalRecordsBloc({required PersonalRecordRepository repository})
      : _repository = repository, // ignore: prefer_initializing_formals
        super(const PersonalRecordsLoading()) {
    on<PersonalRecordsLoaded>(_onLoaded);
    add(const PersonalRecordsLoaded());
  }

  final PersonalRecordRepository _repository;

  Future<void> _onLoaded(
      PersonalRecordsLoaded event, Emitter<PersonalRecordsState> emit) async {
    final result = await _repository.getRecent(limit: 60);
    result.fold(
      (failure) => emit(PersonalRecordsError(failure.message)),
      (records) => emit(PersonalRecordsReady(records)),
    );
  }
}
