import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/app_database.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../session_controller.dart';

/// Drift-backed local auth: salted SHA-256 password hashes in the users
/// table, session tracked by [SessionController].
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._db,
    this._session, {
    Uuid? uuid,
    Random? random,
  })  : _uuid = uuid ?? const Uuid(),
        _random = random ?? Random.secure();

  final AppDatabase _db;
  final SessionController _session;
  final Uuid _uuid;
  final Random _random;

  static final _emailPattern =
      RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
  }) =>
      guard(() async {
        final cleanName = name.trim();
        final cleanEmail = email.trim().toLowerCase();
        _validate(cleanName, cleanEmail, password);

        final existing = await (_db.select(_db.users)
              ..where((u) => u.email.equals(cleanEmail))
              ..limit(1))
            .getSingleOrNull();
        if (existing != null) {
          throw const ValidationFailure(
              'An account with this email already exists. Try logging in.');
        }

        final salt = _newSalt();
        final user = User(
          id: 'user_${_uuid.v4()}',
          name: cleanName,
          email: cleanEmail,
          createdAt: DateTime.now(),
        );
        await _db.into(_db.users).insert(UsersCompanion.insert(
              id: user.id,
              name: user.name,
              email: Value(cleanEmail),
              createdAt: user.createdAt!,
              passwordHash: Value(_hash(password, salt)),
              passwordSalt: Value(salt),
            ));
        await _session.signIn(user);
        return user;
      });

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) =>
      guard(() async {
        final cleanEmail = email.trim().toLowerCase();
        if (cleanEmail.isEmpty || password.isEmpty) {
          throw const ValidationFailure(
              'Enter your email and password to continue.');
        }
        final row = await (_db.select(_db.users)
              ..where((u) => u.email.equals(cleanEmail))
              ..limit(1))
            .getSingleOrNull();
        if (row == null ||
            row.passwordHash == null ||
            row.passwordSalt == null ||
            _hash(password, row.passwordSalt!) != row.passwordHash) {
          // Generic message: never reveal whether the email exists.
          throw const AuthFailure(
              'Incorrect email or password. Please try again.');
        }
        final user = User(
          id: row.id,
          name: row.name,
          email: row.email,
          photoUrl: row.photoUrl,
          createdAt: row.createdAt,
        );
        await _session.signIn(user);
        return user;
      });

  @override
  Future<Either<Failure, User?>> currentUser(String? userId) =>
      guard(() async {
        if (userId == null) return null;
        final row = await (_db.select(_db.users)
              ..where((u) => u.id.equals(userId))
              ..limit(1))
            .getSingleOrNull();
        if (row == null) return null;
        return User(
          id: row.id,
          name: row.name,
          email: row.email,
          photoUrl: row.photoUrl,
          createdAt: row.createdAt,
        );
      });

  @override
  Future<Either<Failure, User>> updateProfile(
          {String? name, String? photoPath}) =>
      guard(() async {
        final userId = _session.userId;
        if (userId == null) throw const AuthFailure('Please log in again.');
        final cleanName = (name ?? '').trim();
        if (cleanName.isNotEmpty && cleanName.length < 2) {
          throw const ValidationFailure(
              'Please enter a name (2 or more characters).');
        }
        final row = await (_db.select(_db.users)
              ..where((u) => u.id.equals(userId))
              ..limit(1))
            .getSingleOrNull();
        if (row == null) throw const AuthFailure('Please log in again.');
        final nextName = cleanName.isEmpty ? row.name : cleanName;
        final nextPhoto = photoPath ?? row.photoUrl;
        await (_db.update(_db.users)..where((u) => u.id.equals(userId)))
            .write(UsersCompanion(name: Value(nextName), photoUrl: Value(nextPhoto)));
        final updated = User(
          id: row.id,
          name: nextName,
          email: row.email,
          photoUrl: nextPhoto,
          createdAt: row.createdAt,
        );
        await _session.signIn(updated);
        return updated;
      });

  @override
  Future<void> logout() => _session.signOut();

  void _validate(String name, String email, String password) {
    if (name.length < 2) {
      throw const ValidationFailure(
          'Please enter your name (2 or more characters).');
    }
    if (!_emailPattern.hasMatch(email)) {
      throw const ValidationFailure('That email address doesn’t look right.');
    }
    if (password.length < 8) {
      throw const ValidationFailure(
          'Use a password with at least 8 characters.');
    }
  }

  String _newSalt() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    return base64Url.encode(bytes);
  }

  String _hash(String password, String salt) {
    final bytes = utf8.encode('$salt::$password');
    return sha256.convert(bytes).toString();
  }
}
