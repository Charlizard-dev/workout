import 'package:charlizard/features/spotify/data/datasources/pkce.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pkce', () {
    test('generates a verifier and S256 challenge', () {
      final pkce = Pkce.generate();
      expect(pkce.verifier, isNotEmpty);
      expect(pkce.challenge, isNotEmpty);
      expect(pkce.verifier, isNot(equals(pkce.challenge)));
    });

    test('verifier uses only unreserved URL characters', () {
      final pkce = Pkce.generate();
      expect(
        RegExp(r'^[A-Za-z0-9\-._~]+$').hasMatch(pkce.verifier),
        isTrue,
        reason: 'verifier must be URL-safe without padding',
      );
      expect(pkce.verifier.contains('='), isFalse);
    });

    test('each generation is unique (CSRF + replay protection)', () {
      final a = Pkce.generate();
      final b = Pkce.generate();
      expect(a.verifier, isNot(equals(b.verifier)));
      expect(a.challenge, isNot(equals(b.challenge)));
    });

    test('challenge is a base64url SHA-256 (43 chars, no padding)', () {
      final pkce = Pkce.generate();
      expect(pkce.challenge.length, 43);
      expect(pkce.challenge.contains('='), isFalse);
      expect(pkce.challenge.contains('+'), isFalse);
      expect(pkce.challenge.contains('/'), isFalse);
    });
  });

  group('generateState', () {
    test('produces unique, URL-safe state strings', () {
      final a = generateState();
      final b = generateState();
      expect(a, isNotEmpty);
      expect(a, isNot(equals(b)));
      expect(RegExp(r'^[A-Za-z0-9\-_]+$').hasMatch(a), isTrue);
    });
  });
}
