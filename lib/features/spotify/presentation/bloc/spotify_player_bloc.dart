import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/spotify_datasources.dart';
import '../../domain/entities/spotify_entities.dart';

sealed class SpotifyPlayerEvent extends Equatable {
  const SpotifyPlayerEvent();

  @override
  List<Object?> get props => [];
}

final class PlayerPollStarted extends SpotifyPlayerEvent {
  const PlayerPollStarted();
}

final class PlayerPollStopped extends SpotifyPlayerEvent {
  const PlayerPollStopped();
}

final class _PlayerTicked extends SpotifyPlayerEvent {
  const _PlayerTicked();
}

final class RefreshPlayback extends SpotifyPlayerEvent {
  const RefreshPlayback();
}

final class TogglePlayPause extends SpotifyPlayerEvent {
  const TogglePlayPause();
}

final class SkipNext extends SpotifyPlayerEvent {
  const SkipNext();
}

final class SkipPrevious extends SpotifyPlayerEvent {
  const SkipPrevious();
}

final class ToggleShuffle extends SpotifyPlayerEvent {
  const ToggleShuffle();
}

final class CycleRepeat extends SpotifyPlayerEvent {
  const CycleRepeat();
}

final class SeekTo extends SpotifyPlayerEvent {
  const SeekTo(this.positionMs);

  final int positionMs;

  @override
  List<Object?> get props => [positionMs];
}

final class PlayContext extends SpotifyPlayerEvent {
  const PlayContext({this.contextUri, this.uris});

  final String? contextUri;
  final List<String>? uris;

  @override
  List<Object?> get props => [contextUri, uris];
}

/// Result of a playlist-load action, used by the music screen.
final class PlayPlaylist extends SpotifyPlayerEvent {
  const PlayPlaylist(this.playlistId);

  final String playlistId;

  @override
  List<Object?> get props => [playlistId];
}

sealed class SpotifyPlayerState extends Equatable {
  const SpotifyPlayerState();
}

final class PlayerIdle extends SpotifyPlayerState {
  const PlayerIdle();

  @override
  List<Object?> get props => [];
}

final class PlayerLoading extends SpotifyPlayerState {
  const PlayerLoading();

  @override
  List<Object?> get props => [];
}

/// Live playback snapshot with optimistic local progress ticking.
class PlayerLive extends SpotifyPlayerState {
  const PlayerLive({
    required this.playback,
    required this.lastSyncAt,
    this.optimistic = false,
  });

  final SpotifyPlaybackState playback;

  /// Wall-clock moment this snapshot came from the API.
  final DateTime lastSyncAt;
  final bool optimistic;

  /// Effective progress including time elapsed since last sync.
  int get effectiveProgressMs {
    if (!playback.isPlaying) return playback.progressMs;
    final drift = DateTime.now().difference(lastSyncAt).inMilliseconds;
    return (playback.progressMs + drift)
        .clamp(0, playback.track?.durationMs ?? playback.progressMs);
  }

  PlayerLive copyWith({SpotifyPlaybackState? playback, bool? optimistic}) =>
      PlayerLive(
        playback: playback ?? this.playback,
        lastSyncAt: DateTime.now(),
        optimistic: optimistic ?? false,
      );

  @override
  List<Object?> get props => [playback, lastSyncAt, optimistic];
}

final class PlayerError extends SpotifyPlayerState {
  const PlayerError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Polls playback state (3s cadence when playing, 10s when paused) and
/// dispatches transport commands. Optimistic updates keep the UI snappy;
/// the next poll reconciles.
class SpotifyPlayerBloc extends Bloc<SpotifyPlayerEvent, SpotifyPlayerState> {
  SpotifyPlayerBloc({required SpotifyApiDataSource api})
      : _api = api, // ignore: prefer_initializing_formals
        super(const PlayerIdle()) {
    on<PlayerPollStarted>(_onPollStarted);
    on<PlayerPollStopped>(_onPollStopped);
    on<RefreshPlayback>(_onRefresh);
    on<_PlayerTicked>(_onTicked);
    on<TogglePlayPause>(_onTogglePlayPause);
    on<SkipNext>(_onSkipNext);
    on<SkipPrevious>(_onSkipPrevious);
    on<ToggleShuffle>(_onToggleShuffle);
    on<CycleRepeat>(_onCycleRepeat);
    on<SeekTo>(_onSeek);
    on<PlayContext>(_onPlayContext);
    on<PlayPlaylist>(_onPlayPlaylist);
  }

  final SpotifyApiDataSource _api;
  Timer? _pollTimer;

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }

  void _onPollStarted(PlayerPollStarted event, Emitter<SpotifyPlayerState> emit) {
    _schedulePoll(emit, immediate: true);
  }

  void _onPollStopped(PlayerPollStopped event, Emitter<SpotifyPlayerState> emit) {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  Future<void> _onRefresh(RefreshPlayback event, Emitter<SpotifyPlayerState> emit) async {
    await _syncPlayback(emit);
  }

  void _onTicked(_PlayerTicked event, Emitter<SpotifyPlayerState> emit) async {
    await _syncPlayback(emit);
  }

  Future<void> _syncPlayback(Emitter<SpotifyPlayerState> emit) async {
    final result = await _api.playbackState();
    result.fold(
      (failure) {
        if (state is PlayerLive) {
          // Keep last good snapshot; transient failures shouldn't nuke UI.
        } else {
          emit(PlayerError(failure.message));
        }
      },
      (playback) => emit(PlayerLive(playback: playback, lastSyncAt: DateTime.now())),
    );
    _schedulePoll(emit);
  }

  void _schedulePoll(Emitter<SpotifyPlayerState> emit, {bool immediate = false}) {
    _pollTimer?.cancel();
    final live = state is PlayerLive ? (state as PlayerLive) : null;
    final playing = live?.playback.isPlaying ?? false;
    final delay = playing ? const Duration(seconds: 3) : const Duration(seconds: 10);
    _pollTimer = Timer(delay, () {
      if (!isClosed) add(const _PlayerTicked());
    });
  }

  Future<void> _onTogglePlayPause(
      TogglePlayPause event, Emitter<SpotifyPlayerState> emit) async {
    final live = state;
    if (live is! PlayerLive) return;
    final shouldPause = live.playback.isPlaying;

    // Optimistic flip.
    emit(live.copyWith(
      playback: live.playback.copyWith(isPlaying: !shouldPause),
      optimistic: true,
    ));

    final result =
        shouldPause ? await _api.pause() : await _api.play();
    result.fold(
      (_) => add(const RefreshPlayback()),
      (_) {},
    );
  }

  Future<void> _onSkipNext(SkipNext event, Emitter<SpotifyPlayerState> emit) async {
    final live = state;
    if (live is! PlayerLive) return;
    final result = await _api.next();
    result.fold(
      (_) {},
      (_) => add(const RefreshPlayback()),
    );
  }

  Future<void> _onSkipPrevious(
      SkipPrevious event, Emitter<SpotifyPlayerState> emit) async {
    final live = state;
    if (live is! PlayerLive) return;
    // Restart track when >3s in, otherwise true previous.
    if (live.effectiveProgressMs > 3000) {
      await _api.seek(0);
      emit(live.copyWith(playback: live.playback.copyWith(progressMs: 0)));
    } else {
      final result = await _api.previous();
      result.fold(
        (_) {},
        (_) => add(const RefreshPlayback()),
      );
    }
  }

  Future<void> _onToggleShuffle(
      ToggleShuffle event, Emitter<SpotifyPlayerState> emit) async {
    final live = state;
    if (live is! PlayerLive) return;
    final nextValue = !live.playback.shuffleEnabled;
    emit(live.copyWith(
      playback: live.playback.copyWith(shuffleEnabled: nextValue),
      optimistic: true,
    ));
    await _api.setShuffle(nextValue);
  }

  Future<void> _onCycleRepeat(CycleRepeat event, Emitter<SpotifyPlayerState> emit) async {
    final live = state;
    if (live is! PlayerLive) return;
    final nextMode = (live.playback.repeatMode + 1) % 3;
    emit(live.copyWith(
      playback: live.playback.copyWith(repeatMode: nextMode),
      optimistic: true,
    ));
    await _api.setRepeat(nextMode);
  }

  Future<void> _onSeek(SeekTo event, Emitter<SpotifyPlayerState> emit) async {
    final live = state;
    if (live is! PlayerLive) return;
    emit(live.copyWith(
      playback: live.playback.copyWith(progressMs: event.positionMs),
      optimistic: true,
    ));
    await _api.seek(event.positionMs);
  }

  Future<void> _onPlayContext(
      PlayContext event, Emitter<SpotifyPlayerState> emit) async {
    await _api.play(contextUri: event.contextUri, uris: event.uris);
    await _syncPlayback(emit);
  }

  Future<void> _onPlayPlaylist(
      PlayPlaylist event, Emitter<SpotifyPlayerState> emit) async {
    await _api.play(
        contextUri: 'spotify:playlist:${event.playlistId}');
    await _syncPlayback(emit);
  }
}
