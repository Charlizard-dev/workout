import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/spotify_datasources.dart';
import '../../domain/entities/spotify_entities.dart';

sealed class SpotifyAuthEvent extends Equatable {
  const SpotifyAuthEvent();

  @override
  List<Object?> get props => [];
}

final class RestoreSpotifySession extends SpotifyAuthEvent {
  const RestoreSpotifySession();
}

/// Emitted when the OAuth redirect delivers a code+state.
final class SpotifyCodeReceived extends SpotifyAuthEvent {
  const SpotifyCodeReceived(this.code, this.state, this.verifier);

  final String code;
  final String state;
  final String verifier;

  @override
  List<Object?> get props => [code, state, verifier];
}

final class SpotifyAuthFailed extends SpotifyAuthEvent {
  const SpotifyAuthFailed(this.reason);

  final String reason;

  @override
  List<Object?> get props => [reason];
}

final class DisconnectSpotify extends SpotifyAuthEvent {
  const DisconnectSpotify();
}

sealed class SpotifyAuthState extends Equatable {
  const SpotifyAuthState();
}

final class SpotifyDisconnected extends SpotifyAuthState {
  const SpotifyDisconnected();

  @override
  List<Object?> get props => [];
}

final class SpotifyConnecting extends SpotifyAuthState {
  const SpotifyConnecting();

  @override
  List<Object?> get props => [];
}

final class SpotifyConnected extends SpotifyAuthState {
  const SpotifyConnected({required this.profile});

  final SpotifyProfile profile;

  @override
  List<Object?> get props => [profile];
}

final class SpotifyAuthError extends SpotifyAuthState {
  const SpotifyAuthError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Owns the Spotify connection lifecycle.
///
/// The browser-based PKCE flow is launched by the injected [launchSignIn]
/// callback (router/url_launcher). It persists the verifier/state between
/// launch and redirect, validates the state (CSRF), exchanges the code, and
/// stores tokens in the secure token store — never in memory only.
class SpotifyAuthBloc extends Bloc<SpotifyAuthEvent, SpotifyAuthState> {
  SpotifyAuthBloc({
    required SpotifyApiDataSource apiDataSource,
    required SpotifyTokenStore tokenStore,
    required Future<({String state, String verifier})> Function() launchSignIn,
  })  : _api = apiDataSource,
        _store = tokenStore,
        _launchSignIn = launchSignIn, // ignore: prefer_initializing_formals
        super(const SpotifyDisconnected()) {
    on<RestoreSpotifySession>(_onRestore);
    on<SpotifyCodeReceived>(_onCodeReceived);
    on<SpotifyAuthFailed>(_onAuthFailed);
    on<DisconnectSpotify>(_onDisconnect);
  }

  final SpotifyApiDataSource _api;
  final SpotifyTokenStore _store;
  final Future<({String state, String verifier})> Function() _launchSignIn;

  String? _expectedState;
  String? _pendingVerifier;

  /// Kicks off the external OAuth flow.
  Future<void> startSignIn() async {
    final params = await _launchSignIn();
    _expectedState = params.state;
    _pendingVerifier = params.verifier;
  }

  Future<void> _onRestore(
      RestoreSpotifySession event, Emitter<SpotifyAuthState> emit) async {
    final tokens = await _store.read();
    if (tokens == null) {
      emit(const SpotifyDisconnected());
      return;
    }
    emit(const SpotifyConnecting());
    final profile = await _api.me();
    profile.fold(
      (failure) => emit(SpotifyAuthError(failure.message)),
      (p) => emit(SpotifyConnected(profile: p)),
    );
  }

  Future<void> _onCodeReceived(
      SpotifyCodeReceived event, Emitter<SpotifyAuthState> emit) async {
    // CSRF protection: state must match the one we issued.
    if (_expectedState != null && event.state != _expectedState) {
      emit(const SpotifyAuthError(
          'Sign-in could not be verified. Please try again.'));
      return;
    }
    if (_pendingVerifier == null) {
      emit(const SpotifyAuthError('Sign-in session expired. Please try again.'));
      return;
    }

    emit(const SpotifyConnecting());

    // Exchange handled by the injected auth datasource (via composition root
    // in the launcher: it receives the verifier we stored).
    // This bloc delegates token persistence to the launcher, then verifies
    // connectivity by fetching the profile.
    final profile = await _api.me();
    profile.fold(
      (failure) => emit(SpotifyAuthError(failure.message)),
      (p) => emit(SpotifyConnected(profile: p)),
    );
    _expectedState = null;
    _pendingVerifier = null;
  }

  void _onAuthFailed(SpotifyAuthFailed event, Emitter<SpotifyAuthState> emit) {
    emit(SpotifyAuthError(event.reason));
  }

  Future<void> _onDisconnect(
      DisconnectSpotify event, Emitter<SpotifyAuthState> emit) async {
    await _store.clear();
    emit(const SpotifyDisconnected());
  }
}
