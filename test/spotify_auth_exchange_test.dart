import 'package:charlizard/features/spotify/data/datasources/spotify_auth_impl.dart';
import 'package:charlizard/features/spotify/data/datasources/spotify_datasources.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// Guards the Spotify token exchange contract:
/// correct endpoint, client_id always present, and Spotify's own error
/// reasons surfaced instead of generic messages.
void main() {
  Dio dioWithCapture(
    void Function(RequestOptions options) onRequest, {
    int statusCode = 200,
    Map<String, dynamic>? body,
  }) {
    final dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          onRequest(options);
          handler.resolve(
            Response<Map<String, dynamic>>(
              requestOptions: options,
              statusCode: statusCode,
              data: body ??
                  {
                    'access_token': 'access',
                    'refresh_token': 'refresh',
                    'expires_in': 3600,
                  },
            ),
          );
        },
      ),
    );
    return dio;
  }

  group('exchangeCode', () {
    test('posts to /api/token with client_id', () async {
      late Uri capturedUri;
      Map<String, dynamic>? capturedData;
      final auth = SpotifyAuthDataSourceImpl(
        clientId: 'test-client-id',
        redirectUri: 'charlizard://spotify-callback',
        dio: dioWithCapture((options) {
          capturedUri = options.uri;
          capturedData = Map<String, dynamic>.from(options.data as Map);
        }),
      );

      final result =
          await auth.exchangeCode(code: 'auth-code', verifier: 'verifier');
      expect(result.isRight(), isTrue);
      expect(capturedUri.path, '/api/token');
      expect(capturedUri.host, 'accounts.spotify.com');
      expect(capturedData!['client_id'], 'test-client-id');
      expect(capturedData!['grant_type'], 'authorization_code');
      expect(capturedData!['code'], 'auth-code');
      expect(capturedData!['code_verifier'], 'verifier');
      expect(capturedData!['redirect_uri'], 'charlizard://spotify-callback');
    });

    test('surfaces Spotify error_description on failure', () async {
      final auth = SpotifyAuthDataSourceImpl(
        clientId: 'test-client-id',
        redirectUri: 'charlizard://spotify-callback',
        dio: Dio()
          ..interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) {
                handler.reject(
                  DioException(
                    requestOptions: options,
                    response: Response<Map<String, dynamic>>(
                      requestOptions: options,
                      statusCode: 400,
                      data: {
                        'error': 'invalid_grant',
                        'error_description': 'Authorization code expired',
                      },
                    ),
                    type: DioExceptionType.badResponse,
                  ),
                );
              },
            ),
          ),
      );

      final result =
          await auth.exchangeCode(code: 'stale-code', verifier: 'verifier');
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(
          failure.message,
          contains('Authorization code expired'),
        ),
        (_) => fail('expected a failure'),
      );
    });

    test('empty client ID fails fast with guidance', () async {
      var called = false;
      final auth = SpotifyAuthDataSourceImpl(
        clientId: '',
        redirectUri: 'charlizard://spotify-callback',
        dio: dioWithCapture((_) => called = true),
      );

      final result =
          await auth.exchangeCode(code: 'code', verifier: 'verifier');
      expect(result.isLeft(), isTrue);
      expect(called, isFalse,
          reason: 'no network call should fire without a client ID');
    });
  });

  group('client id resolution', () {
    test('build flag wins over the Settings override', () async {
      final auth = SpotifyAuthDataSourceImpl(
        clientId: 'flag-id',
        redirectUri: 'charlizard://spotify-callback',
        clientIdOverride: () async => 'settings-id',
        dio: dioWithCapture((_) {}),
      );
      expect(await auth.effectiveClientId(), 'flag-id');
    });

    test('Settings override is used when the build flag is empty',
        () async {
      late Map<String, dynamic>? capturedData;
      final auth = SpotifyAuthDataSourceImpl(
        clientId: '',
        redirectUri: 'charlizard://spotify-callback',
        clientIdOverride: () async => 'settings-id',
        dio: dioWithCapture((options) {
          capturedData =
              Map<String, dynamic>.from(options.data as Map);
        }),
      );
      expect(await auth.effectiveClientId(), 'settings-id');
      final result =
          await auth.exchangeCode(code: 'code', verifier: 'verifier');
      expect(result.isRight(), isTrue);
      expect(capturedData!['client_id'], 'settings-id');
    });

    test('authorize URI carries the resolved client id', () async {
      final auth = SpotifyAuthDataSourceImpl(
        clientId: '',
        redirectUri: 'charlizard://spotify-callback',
        clientIdOverride: () async => 'settings-id',
        dio: dioWithCapture((_) {}),
      );
      final uri = auth.buildAuthorizeUri(
        pkce: const PkcePair(verifier: 'v', challenge: 'c'),
        state: 's',
        clientId: await auth.effectiveClientId(),
      );
      expect(uri.queryParameters['client_id'], 'settings-id');
    });
  });

  group('refresh', () {
    test('posts to /api/token with client_id', () async {
      late Uri capturedUri;
      Map<String, dynamic>? capturedData;
      final auth = SpotifyAuthDataSourceImpl(
        clientId: 'test-client-id',
        redirectUri: 'charlizard://spotify-callback',
        dio: dioWithCapture((options) {
          capturedUri = options.uri;
          capturedData = Map<String, dynamic>.from(options.data as Map);
        }),
      );

      final result = await auth.refresh('old-refresh');
      expect(result.isRight(), isTrue);
      expect(capturedUri.path, '/api/token');
      expect(capturedData!['client_id'], 'test-client-id');
      expect(capturedData!['grant_type'], 'refresh_token');
    });
  });
}
