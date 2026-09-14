import 'package:equatable/equatable.dart';

/// Spotify connection status surfaced to the UI.
enum SpotifyConnectionStatus { disconnected, connecting, connected, expired }

/// Minimal Spotify user profile for display.
class SpotifyProfile extends Equatable {
  const SpotifyProfile({required this.id, required this.displayName, this.imageUrl, this.email});

  final String id;
  final String displayName;
  final String? imageUrl;
  final String? email;

  @override
  List<Object?> get props => [id, displayName, imageUrl, email];
}

class SpotifyPlaylist extends Equatable {
  const SpotifyPlaylist({
    required this.id,
    required this.name,
    required this.trackCount,
    this.imageUrl,
    this.owner,
    this.description,
    this.totalDurationMs,
  });

  final String id;
  final String name;
  final String? imageUrl;
  final String? owner;
  final String? description;
  final int trackCount;
  final int? totalDurationMs;

  @override
  List<Object?> get props => [id, name, imageUrl, owner, description, trackCount, totalDurationMs];
}

class SpotifyArtist extends Equatable {
  const SpotifyArtist({required this.id, required this.name, this.imageUrl});

  final String id;
  final String name;
  final String? imageUrl;

  @override
  List<Object?> get props => [id, name, imageUrl];
}

class SpotifyAlbum extends Equatable {
  const SpotifyAlbum({required this.id, required this.name, this.imageUrl});

  final String id;
  final String name;
  final String? imageUrl;

  @override
  List<Object?> get props => [id, name, imageUrl];
}

class SpotifyTrack extends Equatable {
  const SpotifyTrack({
    required this.id,
    required this.name,
    required this.artists,
    required this.durationMs,
    this.album,
    this.imageUrl,
    this.isLiked,
    this.uri,
  });

  final String id;
  final String name;
  final List<SpotifyArtist> artists;
  final SpotifyAlbum? album;
  final String? imageUrl;
  final int durationMs;
  final bool? isLiked;
  final String? uri;

  String get artistLine => artists.map((a) => a.name).join(', ');

  @override
  List<Object?> get props => [id, name, artists, album, imageUrl, durationMs, isLiked, uri];
}

/// Live playback snapshot from the Web API.
class SpotifyPlaybackState extends Equatable {
  const SpotifyPlaybackState({
    required this.isPlaying,
    required this.progressMs,
    required this.repeatMode,
    this.track,
    this.shuffleEnabled = false,
    this.deviceName,
    this.deviceId,
    this.isRestricted = false,
  });

  final bool isPlaying;
  final SpotifyTrack? track;
  final int progressMs;
  final bool shuffleEnabled;

  /// 0 = off, 1 = context, 2 = track.
  final int repeatMode;
  final String? deviceName;
  final String? deviceId;

  /// True when the active device restricts control (web player etc.).
  final bool isRestricted;

  SpotifyPlaybackState copyWith({
    bool? isPlaying,
    SpotifyTrack? track,
    int? progressMs,
    bool? shuffleEnabled,
    int? repeatMode,
    String? deviceName,
    String? deviceId,
    bool? isRestricted,
  }) =>
      SpotifyPlaybackState(
        isPlaying: isPlaying ?? this.isPlaying,
        track: track ?? this.track,
        progressMs: progressMs ?? this.progressMs,
        shuffleEnabled: shuffleEnabled ?? this.shuffleEnabled,
        repeatMode: repeatMode ?? this.repeatMode,
        deviceName: deviceName ?? this.deviceName,
        deviceId: deviceId ?? this.deviceId,
        isRestricted: isRestricted ?? this.isRestricted,
      );

  @override
  List<Object?> get props => [isPlaying, track, progressMs, shuffleEnabled, repeatMode, deviceName, deviceId, isRestricted];
}

/// A controllable Spotify device.
class SpotifyDevice extends Equatable {
  const SpotifyDevice({
    required this.id,
    required this.name,
    required this.type,
    required this.isActive,
  });

  final String id;
  final String name;
  final String type;
  final bool isActive;

  @override
  List<Object?> get props => [id, name, type, isActive];
}
