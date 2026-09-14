import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../domain/entities/user.dart';

/// Minimal secure key-value contract. Keeps [SessionController] unit
/// testable without platform channels.
abstract class SecureStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

/// Production adapter over flutter_secure_storage.
class FlutterSecureStore implements SecureStore {
  FlutterSecureStore({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}

/// Holds the signed-in identity for the whole app. Backed by secure
/// storage so the session survives restarts; repositories read
/// [userId] dynamically, so login/logout instantly re-scopes all data.
class SessionController extends ChangeNotifier {
  SessionController({SecureStore? storage})
      : _storage = storage ?? FlutterSecureStore();

  static const _keyUserId = 'auth_user_id';
  static const _keyDisplayName = 'auth_display_name';
  static const _keyPhotoUrl = 'auth_photo_url';

  final SecureStore _storage;

  String? _userId;
  String? _displayName;
  String? _photoUrl;
  bool _restored = false;

  String? get userId => _userId;
  String get displayName => _displayName ?? 'Athlete';
  String? get photoUrl => _photoUrl;

  /// True once [restore] has run (splash waits for this).
  bool get restored => _restored;
  bool get isSignedIn => _userId != null;

  /// Loads the persisted session. Safe to call once at startup.
  Future<void> restore() async {
    if (_restored) return;
    _userId = await _storage.read(_keyUserId);
    _displayName = await _storage.read(_keyDisplayName);
    _photoUrl = await _storage.read(_keyPhotoUrl);
    _restored = true;
    notifyListeners();
  }

  Future<void> signIn(User user) async {
    _userId = user.id;
    _displayName = user.name;
    _photoUrl = user.photoUrl;
    await _storage.write(_keyUserId, user.id);
    await _storage.write(_keyDisplayName, user.name);
    if (user.photoUrl != null) {
      await _storage.write(_keyPhotoUrl, user.photoUrl!);
    } else {
      await _storage.delete(_keyPhotoUrl);
    }
    notifyListeners();
  }

  Future<void> updateDisplayName(String name) async {
    _displayName = name;
    await _storage.write(_keyDisplayName, name);
    notifyListeners();
  }

  Future<void> signOut() async {
    _userId = null;
    _displayName = null;
    _photoUrl = null;
    await _storage.delete(_keyUserId);
    await _storage.delete(_keyDisplayName);
    await _storage.delete(_keyPhotoUrl);
    notifyListeners();
  }
}
