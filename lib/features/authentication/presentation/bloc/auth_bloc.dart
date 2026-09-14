import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/session_controller.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Verifies the persisted session at startup.
final class AuthSessionChecked extends AuthEvent {
  const AuthSessionChecked();
}

final class AuthLoginSubmitted extends AuthEvent {
  const AuthLoginSubmitted({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

final class AuthRegisterSubmitted extends AuthEvent {
  const AuthRegisterSubmitted({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  @override
  List<Object?> get props => [name, email, password];
}

final class AuthLoggedOut extends AuthEvent {
  const AuthLoggedOut();
}

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthChecking extends AuthState {
  const AuthChecking();

  @override
  List<Object?> get props => [];
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

final class AuthSubmitting extends AuthState {
  const AuthSubmitting();

  @override
  List<Object?> get props => [];
}

/// Owns sign-in / sign-up / sign-out. The router observes [SessionController]
/// (not this bloc) for navigation, so deep links stay guarded even when
/// this bloc is out of scope.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository repository,
    required SessionController session,
  })  : _repository = repository, // ignore: prefer_initializing_formals
        _session = session, // ignore: prefer_initializing_formals
        super(const AuthChecking()) {
    on<AuthSessionChecked>(_onCheck);
    on<AuthLoginSubmitted>(_onLogin);
    on<AuthRegisterSubmitted>(_onRegister);
    on<AuthLoggedOut>(_onLogout);
    add(const AuthSessionChecked());
  }

  final AuthRepository _repository;
  final SessionController _session;

  Future<void> _onCheck(
      AuthSessionChecked event, Emitter<AuthState> emit) async {
    await _session.restore();
    final userId = _session.userId;
    if (userId == null) {
      emit(const AuthUnauthenticated());
      return;
    }
    final result = await _repository.currentUser(userId);
    result.fold(
      (_) => emit(const AuthUnauthenticated()),
      (user) {
        if (user == null) {
          emit(const AuthUnauthenticated());
        } else {
          emit(AuthAuthenticated(user));
        }
      },
    );
  }

  Future<void> _onLogin(
      AuthLoginSubmitted event, Emitter<AuthState> emit) async {
    emit(const AuthSubmitting());
    final result = await _repository.login(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (failure) => emit(AuthUnauthenticated(message: failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onRegister(
      AuthRegisterSubmitted event, Emitter<AuthState> emit) async {
    emit(const AuthSubmitting());
    final result = await _repository.register(
      name: event.name,
      email: event.email,
      password: event.password,
    );
    result.fold(
      (failure) => emit(AuthUnauthenticated(message: failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onLogout(
      AuthLoggedOut event, Emitter<AuthState> emit) async {
    await _repository.logout();
    emit(const AuthUnauthenticated());
  }
}
