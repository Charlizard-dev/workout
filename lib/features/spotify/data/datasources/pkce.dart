import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// PKCE helpers for the Spotify OAuth 2.0 Authorization Code flow with
/// S256 challenge. The client secret is never present on-device.
class Pkce {
  const Pkce._(this.verifier, this.challenge);

  factory Pkce.generate([Random? secureRandom]) {
    final random = secureRandom ?? Random.secure();
    final values = List<int>.generate(64, (_) => random.nextInt(256));
    final verifier = _base64UrlNoPadding(Uint8List.fromList(values));
    final challenge =
        _base64UrlNoPadding(sha256.convert(asciiValues(verifier)).bytes);
    return Pkce._(verifier, challenge);
  }

  static List<int> asciiValues(String s) => s.codeUnits;

  static String _base64UrlNoPadding(List<int> bytes) {
    var base64 = Base64CodecUrl.encode(bytes);
    while (base64.endsWith('=')) {
      base64 = base64.substring(0, base64.length - 1);
    }
    return base64;
  }

  final String verifier;
  final String challenge;
}

/// URL-safe base64 codec without padding.
class Base64CodecUrl {
  static String encode(List<int> bytes) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';
    var result = '';
    var i = 0;
    while (i < bytes.length) {
      final b0 = bytes[i];
      final b1 = i + 1 < bytes.length ? bytes[i + 1] : -1;
      final b2 = i + 2 < bytes.length ? bytes[i + 2] : -1;

      result += chars[b0 >> 2];
      result += chars[((b0 & 0x03) << 4) | (b1 >= 0 ? b1 >> 4 : 0)];
      if (b1 < 0) break;
      result += chars[((b1 & 0x0F) << 2) | (b2 >= 0 ? b2 >> 6 : 0)];
      if (b2 < 0) break;
      result += chars[b2 & 0x3F];
      i += 3;
    }
    return result;
  }
}

/// Generates a cryptographically random state string for CSRF protection.
String generateState([Random? secureRandom]) {
  final random = secureRandom ?? Random.secure();
  final values = List<int>.generate(24, (_) => random.nextInt(256));
  return Base64CodecUrl.encode(values);
}
