import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import 'spotify_api_impl.dart' show spotifyScopes;
import 'spotify_datasources.dart';

/// Spotify OAuth client. Client ID arrives via --dart-define; the secret
/// stays on a backend (Spotify PKCE avoids needing it on-device).
class SpotifyAuthDataSourceImpl implements SpotifyAuthDataSource {
  SpotifyAuthDataSourceImpl({
    required String clientId,
    required String redirectUri,
    Dio? dio,
    Future<String?> Function()? clientIdOverride,
  })  : _clientId = clientId, // ignore: prefer_initializing_formals
        _redirectUri = redirectUri, // ignore: prefer_initializing_formals
        _clientIdOverride = clientIdOverride, // ignore: prefer_initializing_formals
        _dio = dio ??
            Dio(BaseOptions(
              contentType: 'application/x-www-form-urlencoded',
              headers: {'Accept': 'application/json'},
            ));

  static const String _authorizeUrl = 'https://accounts.spotify.com/authorize';
  static const String _tokenUrl = 'https://accounts.spotify.com/api/token';

  final String _clientId;
  final String _redirectUri;
  final Future<String?> Function()? _clientIdOverride;
  final Dio _dio;

  /// Build flag wins; otherwise the in-app Settings override. Empty means
  /// Spotify cannot be used in this install.
  Future<String> effectiveClientId() async {
    if (_clientId.isNotEmpty) return _clientId;
    return (await _clientIdOverride?.call())?.trim() ?? '';
  }

  @override
  Uri buildAuthorizeUri(
      {required PkcePair pkce, required String state, String? clientId}) {
    return Uri.parse(_authorizeUrl).replace(queryParameters: {
      'response_type': 'code',
      'client_id': clientId ?? _clientId,
      'scope': spotifyScopes.join(' '),
      'redirect_uri': _redirectUri,
      'state': state,
      'code_challenge_method': 'S256',
      'code_challenge': pkce.challenge,
      'show_dialog': 'false',
    });
  }

  @override
  Future<Either<Failure, SpotifyTokens>> exchangeCode({
    required String code,
    required String verifier,
  }) async {
    final clientId = await effectiveClientId();
    if (clientId.isEmpty) {
      return const Left(AuthFailure(
          'Spotify is not configured. Add your Client ID in Settings → Spotify.'));
    }
    try {
      final response = await _dio.post<Map<String, dynamic>>(_tokenUrl, data: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': _redirectUri,
        'client_id': clientId,
        'code_verifier': verifier,
      });
      return Right(_parseTokens(response.data ?? {}));
    } on DioException catch (e) {
      return Left(_authFailureFrom(e));
    }
  }

  @override
  Future<Either<Failure, SpotifyTokens>> refresh(String refreshToken) async {
    final clientId = await effectiveClientId();
    if (clientId.isEmpty) {
      return const Left(AuthFailure('Spotify session expired. Reconnect to continue.'));
    }
    try {
      final response = await _dio.post<Map<String, dynamic>>(_tokenUrl, data: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
        'client_id': clientId,
      });
      return Right(_parseTokens(response.data ?? {}, fallbackRefresh: refreshToken));
    } on DioException catch (e) {
      return Left(_authFailureFrom(e));
    }
  }

  /// Surfaces Spotify's own error description (e.g. invalid_grant,
  /// invalid_client) instead of a generic message, so failures are
  /// diagnosable. Never exposes secrets — only Spotify's public reason.
  Failure _authFailureFrom(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final description = data['error_description'] as String?;
      final error = data['error'] as String?;
      final detail = (description ?? error ?? '').trim();
      if (detail.isNotEmpty) {
        return AuthFailure('Spotify sign-in failed: $detail');
      }
    }
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const NetworkFailure();
    }
    return const AuthFailure(
        'Spotify sign-in could not be completed. Please try again.');
  }

  SpotifyTokens _parseTokens(Map<String, dynamic> data,
      {String? fallbackRefresh}) {
    final expiresIn = data['expires_in'] as int? ?? 3600;
    return SpotifyTokens(
      accessToken: data['access_token'] as String? ?? '',
      refreshToken: data['refresh_token'] as String? ?? fallbackRefresh ?? '',
      expiresAt: DateTime.now().add(Duration(seconds: expiresIn)),
    );
  }
}
