import 'package:charlizard/core/storage/app_database.dart';
import 'package:charlizard/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:charlizard/features/authentication/data/session_controller.dart';
import 'package:charlizard/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Local auth contract tests: register → login → wrong password →
/// duplicates → validation → logout. Backed by an in-memory database and
/// an in-memory secure-storage fake.
void main() {
  late AppDatabase db;
  late SessionController session;
  late AuthRepositoryImpl repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    session = SessionController(storage: _MemorySecureStorage());
    repo = AuthRepositoryImpl(db, session);
  });

  tearDown(() async {
    await db.close();
  });

  group('register', () {
    test('creates an account and signs in', () async {
      final result = await repo.register(
        name: 'Charly',
        email: 'Charly@example.com',
        password: 'password123',
      );
      expect(result.isRight(), isTrue);
      final user = result.getOrElse(() => throw StateError('no user'));
      expect(user.name, 'Charly');
      expect(user.email, 'charly@example.com');
      expect(session.isSignedIn, isTrue);
      expect(session.userId, user.id);
      expect(session.displayName, 'Charly');
    });

    test('rejects duplicate emails (case-insensitive)', () async {
      await repo.register(
          name: 'Charly', email: 'a@b.com', password: 'password123');
      final second = await repo.register(
          name: 'Other', email: 'A@B.COM', password: 'password123');
      expect(second.isLeft(), isTrue);
    });

    test('validates name, email, and password', () async {
      expect(
        (await repo.register(name: 'X', email: 'a@b.com', password: 'password123'))
            .isLeft(),
        isTrue,
      );
      expect(
        (await repo.register(name: 'Charly', email: 'not-an-email', password: 'password123'))
            .isLeft(),
        isTrue,
      );
      expect(
        (await repo.register(name: 'Charly', email: 'a@b.com', password: 'short'))
            .isLeft(),
        isTrue,
      );
    });

    test('stores a salted hash, never the password', () async {
      await repo.register(
          name: 'Charly', email: 'a@b.com', password: 'password123');
      final row = await (db.select(db.users)).getSingle();
      expect(row.passwordHash, isNotNull);
      expect(row.passwordSalt, isNotNull);
      expect(row.passwordHash, isNot(contains('password123')));
    });

    test('distinct users get distinct hashes for the same password',
        () async {
      await repo.register(
          name: 'One', email: 'one@b.com', password: 'password123');
      await repo.register(
          name: 'Two', email: 'two@b.com', password: 'password123');
      final rows = await (db.select(db.users)).get();
      expect(rows[0].passwordHash, isNot(equals(rows[1].passwordHash)));
    });
  });

  group('login', () {
    test('succeeds with correct credentials', () async {
      await repo.register(
          name: 'Charly', email: 'a@b.com', password: 'password123');
      await repo.logout();
      expect(session.isSignedIn, isFalse);

      final result =
          await repo.login(email: 'a@b.com', password: 'password123');
      expect(result.isRight(), isTrue);
      expect(session.isSignedIn, isTrue);
    });

    test('rejects wrong passwords without revealing why', () async {
      await repo.register(
          name: 'Charly', email: 'a@b.com', password: 'password123');
      final result =
          await repo.login(email: 'a@b.com', password: 'wrong-pass');
      expect(result.isLeft(), isTrue);
    });

    test('rejects unknown emails with the same message', () async {
      final result =
          await repo.login(email: 'nobody@b.com', password: 'password123');
      expect(result.isLeft(), isTrue);
    });
  });

  group('session', () {
    test('currentUser resolves the signed-in account', () async {
      final registered = await repo.register(
          name: 'Charly', email: 'a@b.com', password: 'password123');
      final id = registered.getOrElse(() => throw StateError('no user')).id;
      final current = await repo.currentUser(id);
      expect(
        current.getOrElse(() => throw StateError('none'))?.name,
        'Charly',
      );
    });

    test('currentUser returns null when signed out or unknown', () async {
      expect((await repo.currentUser(null)).getOrElse(() => throw StateError('x')), isNull);
      expect(
          (await repo.currentUser('missing')).getOrElse(() => throw StateError('x')),
          isNull);
    });

    test('logout clears the session', () async {
      await repo.register(
          name: 'Charly', email: 'a@b.com', password: 'password123');
      await repo.logout();
      expect(session.isSignedIn, isFalse);
      expect(session.userId, isNull);
    });
  });

  group('updateProfile', () {
    test('renames the account and updates the session', () async {
      await repo.register(
          name: 'Charly', email: 'a@b.com', password: 'password123');
      final result = await repo.updateProfile(name: 'Charles Atlas');
      final user = result.getOrElse(() => throw StateError('no user'));
      expect(user.name, 'Charles Atlas');
      expect(session.displayName, 'Charles Atlas');

      final row = await (db.select(db.users)).getSingle();
      expect(row.name, 'Charles Atlas');
    });

    test('rejects blank and too-short names', () async {
      await repo.register(
          name: 'Charly', email: 'a@b.com', password: 'password123');
      expect((await repo.updateProfile(name: 'X')).isLeft(), isTrue);
      // Name unchanged after rejection.
      final row = await (db.select(db.users)).getSingle();
      expect(row.name, 'Charly');
    });

    test('stores a photo path on the user row', () async {
      await repo.register(
          name: 'Charly', email: 'a@b.com', password: 'password123');
      final result =
          await repo.updateProfile(photoPath: '/docs/avatar_1.jpg');
      expect(result.isRight(), isTrue);
      final row = await (db.select(db.users)).getSingle();
      expect(row.photoUrl, '/docs/avatar_1.jpg');
      expect(session.photoUrl, '/docs/avatar_1.jpg');
    });

    test('requires a signed-in user', () async {
      final signedOut = SessionController(storage: _MemorySecureStorage());
      final other = AuthRepositoryImpl(db, signedOut);
      expect(
          (await other.updateProfile(name: 'Nobody')).isLeft(), isTrue);
    });
  });

  group('AuthBloc', () {
    test('register flow emits submitting then authenticated', () async {
      final bloc = AuthBloc(repository: repo, session: session);
      addTearDown(bloc.close);

      final states = <AuthState>[];
      final sub = bloc.stream.listen(states.add);
      bloc.add(const AuthRegisterSubmitted(
          name: 'Charly', email: 'a@b.com', password: 'password123'));
      await Future<void>.delayed(const Duration(milliseconds: 300));
      await sub.cancel();

      expect(states.any((s) => s is AuthSubmitting), isTrue);
      expect(states.last, isA<AuthAuthenticated>());
    });

    test('failed login emits unauthenticated with a message', () async {
      final bloc = AuthBloc(repository: repo, session: session);
      addTearDown(bloc.close);

      final states = <AuthState>[];
      final sub = bloc.stream.listen(states.add);
      bloc.add(const AuthLoginSubmitted(
          email: 'nobody@b.com', password: 'password123'));
      await Future<void>.delayed(const Duration(milliseconds: 300));
      await sub.cancel();

      final last = states.last;
      expect(last, isA<AuthUnauthenticated>());
      expect((last as AuthUnauthenticated).message, isNotNull);
    });
  });
}

/// In-memory secure-storage fake so session tests run on the VM.
class _MemorySecureStorage implements SecureStore {
  final Map<String, String> _map = {};

  @override
  Future<String?> read(String key) async => _map[key];

  @override
  Future<void> write(String key, String value) async {
    _map[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _map.remove(key);
  }
}
