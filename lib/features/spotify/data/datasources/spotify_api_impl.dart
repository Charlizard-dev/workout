import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/spotify_entities.dart';
import 'spotify_datasources.dart';

const String _spotifyApiUrl = 'https://api.spotify.com/v1';

/// Exported for the auth datasource.
const List<String> spotifyScopes = [
  'user-read-email',
  'user-read-private',
  'streaming',
  'user-read-playback-state',
  'user-modify-playback-state',
  'user-read-currently-playing',
  'user-read-recently-played',
  'playlist-read-private',
  'playlist-read-collaborative',
  'user-library-read',
  'user-library-modify',
];

/// Secure token storage.
class SecureSpotifyTokenStore implements SpotifyTokenStore {
  SecureSpotifyTokenStore({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions.defaultOptions,
              iOptions: IOSOptions.defaultOptions,
            );

  final FlutterSecureStorage _storage;

  static const _keyAccess = 'spotify_access_token';
  static const _keyRefresh = 'spotify_refresh_token';
  static const _keyExpires = 'spotify_expires_at';
  static const _keyClientId = 'spotify_client_id_override';

  @override
  Future<void> save({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
  }) async {
    await _storage.write(key: _keyAccess, value: accessToken);
    if (refreshToken.isNotEmpty) {
      await _storage.write(key: _keyRefresh, value: refreshToken);
    }
    await _storage.write(
        key: _keyExpires, value: expiresAt.toIso8601String());
  }

  @override
  Future<SpotifyTokens?> read() async {
    final access = await _storage.read(key: _keyAccess);
    if (access == null) return null;
    final refresh = await _storage.read(key: _keyRefresh);
    final expiresRaw = await _storage.read(key: _keyExpires);
    final expiresAt =
        expiresRaw == null ? DateTime.now() : DateTime.tryParse(expiresRaw);
    return SpotifyTokens(
      accessToken: access,
      refreshToken: refresh,
      expiresAt: expiresAt ?? DateTime.now(),
    );
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _keyAccess);
    await _storage.delete(key: _keyRefresh);
    await _storage.delete(key: _keyExpires);
  }

  /// In-app Client ID override (Settings → Spotify), used when the build
  /// flag is empty. The client ID is public by design (it travels in the
  /// authorize URL), so storing it here is safe.
  Future<void> saveClientIdOverride(String clientId) =>
      _storage.write(key: _keyClientId, value: clientId.trim());

  Future<String?> readClientIdOverride() =>
      _storage.read(key: _keyClientId);

  Future<void> clearClientIdOverride() =>
      _storage.delete(key: _keyClientId);
}

/// Dio-backed Spotify Web API client with automatic token refresh.
class SpotifyApiDataSourceImpl implements SpotifyApiDataSource {
  SpotifyApiDataSourceImpl({
    required Dio dio,
    required SpotifyTokenStore tokenStore,
    required SpotifyAuthDataSource authDataSource,
  })  : _dio = dio, // ignore: prefer_initializing_formals
        _tokens = tokenStore,
        _auth = authDataSource;

  final Dio _dio;
  final SpotifyTokenStore _tokens;
  final SpotifyAuthDataSource _auth;

  Future<String?> _validAccessToken() async {
    final tokens = await _tokens.read();
    if (tokens == null) return null;

    if (tokens.isExpiringSoon && tokens.refreshToken != null) {
      final refreshed = await _auth.refresh(tokens.refreshToken!);
      return refreshed.fold(
        (_) => null,
        (fresh) => fresh.accessToken,
      );
    }
    return tokens.accessToken;
  }

  Future<Either<Failure, T>> _withToken<T>(
    Future<Either<Failure, T>> Function(String token) action,
  ) async {
    final token = await _validAccessToken();
    if (token == null) {
      return const Left(AuthFailure('Connect Spotify to continue.'));
    }
    return action(token);
  }

  Failure _failureFromDio(DioException e) {
    switch (e.response?.statusCode) {
      case 401:
        return const AuthFailure('Spotify session expired. Reconnect to continue.');
      case 403:
        return const PlaybackFailure(
            'Spotify Premium is required for playback control.');
      case 404:
        return const NotFoundFailure('Spotify content not found.');
      case 429:
        return const ServerFailure('Spotify is rate limiting. Try again shortly.');
      default:
        return e.type == DioExceptionType.connectionError ||
                e.type == DioExceptionType.connectionTimeout
            ? const NetworkFailure()
            : const ServerFailure('Spotify request failed.');
    }
  }

  @override
  Future<Either<Failure, SpotifyProfile>> me() => _withToken((token) async {
        try {
          final res = await _dio.get<Map<String, dynamic>>('$_spotifyApiUrl/me',
              options: Options(headers: {'Authorization': 'Bearer $token'}));
          final images = (res.data?['images'] as List?) ?? [];
          return Right(SpotifyProfile(
            id: res.data?['id'] as String? ?? '',
            displayName: res.data?['display_name'] as String? ?? 'Spotify User',
            imageUrl: images.isEmpty ? null : (images.first as Map)['url'] as String?,
            email: res.data?['email'] as String?,
          ));
        } on DioException catch (e) {
          return Left(_failureFromDio(e));
        }
      });

  @override
  Future<Either<Failure, List<SpotifyPlaylist>>> myPlaylists({int limit = 30}) =>
      _withToken((token) async {
        try {
          final res = await _dio.get<Map<String, dynamic>>(
            '$_spotifyApiUrl/me/playlists',
            queryParameters: {'limit': limit},
            options: Options(headers: {'Authorization': 'Bearer $token'}),
          );
          final items = (res.data?['items'] as List?) ?? [];
          return Right(items.map(_parsePlaylist).toList());
        } on DioException catch (e) {
          return Left(_failureFromDio(e));
        }
      });

  SpotifyPlaylist _parsePlaylist(dynamic raw) {
    final map = (raw as Map).cast<String, dynamic>();
    final images = ((map['images'] as List?) ?? []);
    String? imageUrl;
    if (images.isNotEmpty) {
      imageUrl = (images.first as Map)['url'] as String?;
    }
    final owner = map['owner'] as Map?;
    final tracks = map['tracks'] as Map?;
    return SpotifyPlaylist(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      imageUrl: imageUrl,
      owner: owner?['name'] as String?,
      description: map['description'] as String?,
      trackCount: tracks?['total'] as int? ?? 0,
    );
  }

  @override
  Future<Either<Failure, List<SpotifyTrack>>> playlistTracks(
          String playlistId, {int limit = 50}) =>
      _withToken((token) async {
        try {
          final res = await _dio.get<Map<String, dynamic>>(
            '$_spotifyApiUrl/playlists/$playlistId/tracks',
            queryParameters: {'limit': limit},
            options: Options(headers: {'Authorization': 'Bearer $token'}),
          );
          final items = (res.data?['items'] as List?) ?? [];
          return Right(
              items.map((i) => _parseTrack((i as Map)['track'])).toList());
        } on DioException catch (e) {
          return Left(_failureFromDio(e));
        }
      });

  SpotifyTrack _parseTrack(dynamic raw) {
    final map = (raw as Map).cast<String, dynamic>();
    final album = (map['album'] as Map?)?.cast<String, dynamic>();
    final albumImages = ((album?['images'] as List?) ?? []);
    final artists = (map['artists'] as List?) ?? [];
    return SpotifyTrack(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      artists: artists
          .map((a) {
              final artist = a as Map;
              return SpotifyArtist(
                  id: artist['id'] as String? ?? '',
                  name: artist['name'] as String? ?? '');
            })
          .toList(),
      album: album == null
          ? null
          : SpotifyAlbum(id: album['id'] as String? ?? '',
              name: album['name'] as String? ?? ''),
      imageUrl: albumImages.isEmpty ? null : (albumImages.first as Map)['url'] as String?,
      durationMs: map['duration_ms'] as int? ?? 0,
      uri: map['uri'] as String?,
    );
  }

  @override
  Future<Either<Failure, List<SpotifyTrack>>> savedTracks({int limit = 30}) =>
      _withToken((token) async {
        try {
          final res = await _dio.get<Map<String, dynamic>>(
            '$_spotifyApiUrl/me/tracks',
            queryParameters: {'limit': limit},
            options: Options(headers: {'Authorization': 'Bearer $token'}),
          );
          final items = (res.data?['items'] as List?) ?? [];
          return Right(
              items.map((i) => _parseTrack((i as Map)['track'])).toList());
        } on DioException catch (e) {
          return Left(_failureFromDio(e));
        }
      });

  @override
  Future<Either<Failure, List<SpotifyTrack>>> recentlyPlayed({int limit = 20}) =>
      _withToken((token) async {
        try {
          final res = await _dio.get<Map<String, dynamic>>(
            '$_spotifyApiUrl/me/player/recently-played',
            queryParameters: {'limit': limit},
            options: Options(headers: {'Authorization': 'Bearer $token'}),
          );
          final items = (res.data?['items'] as List?) ?? [];
          final out = <SpotifyTrack>[];
          final seen = <String>{};
          for (final item in items) {
            final track = _parseTrack((item as Map)['track']);
            if (seen.add(track.id)) out.add(track);
          }
          return Right(out.take(limit).toList());
        } on DioException catch (e) {
          return Left(_failureFromDio(e));
        }
      });

  @override
  Future<Either<Failure, SpotifyPlaybackState>> playbackState() =>
      _withToken((token) async {
        try {
          final res = await _dio.get<Map<String, dynamic>>(
            '$_spotifyApiUrl/me/player',
            options: Options(
              headers: {'Authorization': 'Bearer $token'},
              validateStatus: (status) => status == 200 || status == 204,
            ),
          );
          if (res.statusCode == 204 || res.data == null) {
            return const Right(SpotifyPlaybackState(
                isPlaying: false, progressMs: 0, repeatMode: 0));
          }
          final data = res.data!;
          final actions = (data['actions'] as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
          final trackRaw = data['item'];
          final track = trackRaw == null ? null : _parseTrack(trackRaw);
          return Right(SpotifyPlaybackState(
            isPlaying: data['is_playing'] as bool? ?? false,
            track: track,
            progressMs: data['progress_ms'] as int? ?? 0,
            shuffleEnabled: data['shuffle_state'] as bool? ?? false,
            repeatMode: switch (data['repeat_state'] as String?) {
              'track' => 2,
              'context' => 1,
              _ => 0,
            },
            deviceName: (data['device'] as Map?)?['name'] as String?,
            deviceId: (data['device'] as Map?)?['id'] as String?,
            isRestricted: actions['disallows'] != null,
          ));
        } on DioException catch (e) {
          return Left(_failureFromDio(e));
        }
      });

  @override
  Future<Either<Failure, List<SpotifyDevice>>> devices() => _withToken((token) async {
        try {
          final res = await _dio.get<Map<String, dynamic>>(
            '$_spotifyApiUrl/me/player/devices',
            options: Options(headers: {'Authorization': 'Bearer $token'}),
          );
          final items = (res.data?['devices'] as List?) ?? [];
          return Right(items
              .map((d) => SpotifyDevice(
                    id: (d as Map)['id'] as String? ?? '',
                    name: d['name'] as String? ?? '',
                    type: d['type'] as String? ?? '',
                    isActive: d['is_active'] as bool? ?? false,
                  ))
              .toList());
        } on DioException catch (e) {
          return Left(_failureFromDio(e));
        }
      });

  Future<Either<Failure, void>> _playerCommand(
    String method,
    String path, {
    Object? data,
  }) =>
      _withToken((token) async {
        try {
          await _dio.request<void>(
            '$_spotifyApiUrl$path',
            data: data,
            options: Options(
              method: method,
              headers: {'Authorization': 'Bearer $token'},
              // 404 => no active device; treat as graceful no-op.
              validateStatus: (status) =>
                  status != null && status < 300 || status == 404,
            ),
          );
          return const Right(null);
        } on DioException catch (e) {
          return Left(_failureFromDio(e));
        }
      });

  @override
  Future<Either<Failure, void>> play(
          {String? contextUri, List<String>? uris, String? deviceId}) =>
      // ignore: use_null_aware_elements
      _playerCommand('PUT', '/me/player/play',
          data: {
            'context_uri': ?contextUri,
            'uris': ?uris,
          });

  @override
  Future<Either<Failure, void>> pause() => _playerCommand('PUT', '/me/player/pause');

  @override
  Future<Either<Failure, void>> next() => _playerCommand('POST', '/me/player/next');

  @override
  Future<Either<Failure, void>> previous() =>
      _playerCommand('POST', '/me/player/previous');

  @override
  Future<Either<Failure, void>> seek(int positionMs) =>
      _playerCommand('PUT', '/me/player/seek?position_ms=$positionMs');

  @override
  Future<Either<Failure, void>> setShuffle(bool enabled) =>
      _playerCommand('PUT', '/me/player/shuffle?state=${enabled ? 'true' : 'false'}');

  @override
  Future<Either<Failure, void>> setRepeat(int mode) => _playerCommand(
      'PUT',
      '/me/player/repeat?repeat_state=${switch (mode) { 2 => 'track', 1 => 'context', _ => 'off' }}');

  @override
  Future<Either<Failure, void>> setVolume(int percent) =>
      _playerCommand('PUT', '/me/player/volume?volume_percent=${percent.clamp(0, 100)}');

  @override
  Future<Either<Failure, bool>> toggleSaveTrack(
      String trackId, bool currentlySaved) async {
    try {
      final token = await _validAccessToken();
      if (token == null) return const Left(AuthFailure());
      if (currentlySaved) {
        await _dio.delete<void>('$_spotifyApiUrl/me/tracks?ids=$trackId',
            options: Options(headers: {'Authorization': 'Bearer $token'}));
      } else {
        await _dio.put<void>('$_spotifyApiUrl/me/tracks?ids=$trackId',
            options: Options(headers: {'Authorization': 'Bearer $token'}));
      }
      return Right(!currentlySaved);
    } on DioException catch (e) {
      return Left(_failureFromDio(e));
    }
  }

  @override
  Future<Either<Failure, List<SpotifyTrack>>> searchTracks(String query,
          {int limit = 20}) =>
      _withToken((token) async {
        try {
          final res = await _dio.get<Map<String, dynamic>>(
            '$_spotifyApiUrl/search',
            queryParameters: {
              'q': query,
              'type': 'track',
              'limit': limit,
            },
            options: Options(headers: {'Authorization': 'Bearer $token'}),
          );
          final tracks =
              ((res.data?['tracks'] as Map?)?['items'] as List?) ?? [];
          return Right(tracks.map(_parseTrack).toList());
        } on DioException catch (e) {
          return Left(_failureFromDio(e));
        }
      });
}
