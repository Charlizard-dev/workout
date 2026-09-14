import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/spotify_entities.dart';

/// Tokens are kept in flutter_secure_storage (Keychain/Keystore) — never in
/// shared preferences or logs.
abstract class SpotifyTokenStore {
  Future<void> save({required String accessToken, required String refreshToken, required DateTime expiresAt});
  Future<SpotifyTokens?> read();
  Future<void> clear();
}

class SpotifyTokens {
  const SpotifyTokens({
    required this.accessToken,
    required this.expiresAt,
    this.refreshToken,
  });

  final String accessToken;
  final DateTime expiresAt;
  final String? refreshToken;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isExpiringSoon =>
      DateTime.now().isAfter(expiresAt.subtract(const Duration(seconds: 60)));
}

/// OAuth 2.0 + PKCE contract against Spotify Accounts.
abstract class SpotifyAuthDataSource {
  Uri buildAuthorizeUri(
      {required PkcePair pkce, required String state, String? clientId});
  /// Exchanges the authorization code for tokens.
  Future<Either<Failure, SpotifyTokens>> exchangeCode({
    required String code,
    required String verifier,
  });
  Future<Either<Failure, SpotifyTokens>> refresh(String refreshToken);
}

/// PKCE value pair.
class PkcePair {
  const PkcePair({required this.verifier, required this.challenge});

  final String verifier;
  final String challenge;
}

/// Web API contract (playback, playlists, profile).
abstract class SpotifyApiDataSource {
  Future<Either<Failure, SpotifyProfile>> me();
  Future<Either<Failure, List<SpotifyPlaylist>>> myPlaylists({int limit = 30});
  Future<Either<Failure, List<SpotifyTrack>>> playlistTracks(String playlistId, {int limit = 50});
  Future<Either<Failure, List<SpotifyTrack>>> savedTracks({int limit = 30});
  Future<Either<Failure, List<SpotifyTrack>>> recentlyPlayed({int limit = 20});
  Future<Either<Failure, SpotifyPlaybackState>> playbackState();
  Future<Either<Failure, List<SpotifyDevice>>> devices();
  Future<Either<Failure, void>> play({String? contextUri, List<String>? uris, String? deviceId});
  Future<Either<Failure, void>> pause();
  Future<Either<Failure, void>> next();
  Future<Either<Failure, void>> previous();
  Future<Either<Failure, void>> seek(int positionMs);
  Future<Either<Failure, void>> setShuffle(bool enabled);
  Future<Either<Failure, void>> setRepeat(int mode); // 0 off, 1 context, 2 track
  Future<Either<Failure, void>> setVolume(int percent);
  Future<Either<Failure, bool>> toggleSaveTrack(String trackId, bool currentlySaved);
  Future<Either<Failure, List<SpotifyTrack>>> searchTracks(String query, {int limit = 20});
}
