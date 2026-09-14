import 'package:charlizard/core/storage/app_database.dart';
import 'package:charlizard/core/theme/app_theme.dart';
import 'package:charlizard/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:charlizard/features/authentication/data/session_controller.dart';
import 'package:charlizard/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:charlizard/features/dashboard/data/repositories/load_dashboard.dart';
import 'package:charlizard/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:charlizard/features/exercises/data/repositories/exercise_library_repository_impl.dart';
import 'package:charlizard/features/leveling/data/repositories/progression_repository_impl.dart';
import 'package:charlizard/features/leveling/domain/services/progression_rules.dart';
import 'package:charlizard/features/challenges/data/repositories/challenge_repository_impl.dart';
import 'package:charlizard/features/splash/presentation/screens/splash_screen.dart';
import 'package:charlizard/features/workouts/data/repositories/workout_routine_repository_impl.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// Splash contract tests: brand renders, then gates on the session —
/// /home when signed in, /auth when signed out. Backed by an in-memory
/// database so the dashboard warm-up runs for real.
void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> pumpSplash(
    WidgetTester tester, {
    required SessionController session,
    required AuthBloc authBloc,
    required DashboardBloc dashboardBloc,
  }) async {
    final router = GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(
          path: '/splash',
          builder: (_, _) => const SplashScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (_, _) => const Scaffold(
            body: Text('HOME'),
          ),
        ),
        GoRoute(
          path: '/auth',
          builder: (_, _) => const Scaffold(
            body: Text('AUTH'),
          ),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SessionController>.value(value: session),
          BlocProvider<AuthBloc>.value(value: authBloc),
          BlocProvider<DashboardBloc>.value(value: dashboardBloc),
        ],
        child: MaterialApp.router(
          theme: AppTheme.dark,
          routerConfig: router,
        ),
      ),
    );
    await tester.pump();
  }

  DashboardBloc dashboardBloc() {
    final progressionRepository =
        ProgressionRepositoryImpl(db, const ProgressionRules());
    final loadDashboard = LoadDashboard(
      db: db,
      progressionRepository: progressionRepository,
      routineRepository: WorkoutRoutineRepositoryImpl(db),
      challengeRepository: ChallengeRepositoryImpl(db),
    );
    return DashboardBloc(loadDashboard: loadDashboard);
  }

  testWidgets('signed-out users land on auth', (tester) async {
    await ExerciseLibraryRepositoryImpl(db).seedIfEmpty();
    final session = SessionController(storage: _MemorySecureStorage());
    final bloc = dashboardBloc();
    addTearDown(bloc.close);
    final authBloc =
        AuthBloc(repository: AuthRepositoryImpl(db, session), session: session);
    addTearDown(authBloc.close);

    await pumpSplash(
        tester, session: session, authBloc: authBloc, dashboardBloc: bloc);

    // Brand moment.
    expect(find.text('CHARLIZARD'), findsOneWidget);
    expect(find.text('TRAIN • LEVEL • REPEAT'), findsOneWidget);
    expect(find.text('HOME'), findsNothing);

    // Advance past the brand hold.
    await tester
        .pump(SplashScreen.brandHold + const Duration(milliseconds: 300));
    await tester.pump();

    expect(find.text('AUTH'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('signed-in users land on home', (tester) async {
    await ExerciseLibraryRepositoryImpl(db).seedIfEmpty();
    final session = SessionController(storage: _MemorySecureStorage());
    final authRepo = AuthRepositoryImpl(db, session);
    await authRepo.register(
        name: 'Charly', email: 'a@b.com', password: 'password123');
    final bloc = dashboardBloc();
    addTearDown(bloc.close);
    final authBloc = AuthBloc(repository: authRepo, session: session);
    addTearDown(authBloc.close);

    await pumpSplash(
        tester, session: session, authBloc: authBloc, dashboardBloc: bloc);

    await tester
        .pump(SplashScreen.brandHold + const Duration(milliseconds: 300));
    await tester.pump();

    expect(find.text('HOME'), findsOneWidget);
    expect(tester.takeException(), isNull);
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
