import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/dashboard/data/repositories/load_dashboard.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/exercises/data/repositories/exercise_library_repository_impl.dart';
import '../../features/exercises/presentation/bloc/exercise_library_bloc.dart';
import '../../features/leveling/data/repositories/progression_repository_impl.dart';
import '../../features/leveling/domain/services/progression_rules.dart';
import '../../features/social_sharing/data/datasources/story_datasources.dart';
import '../../features/social_sharing/data/repositories/story_image_generator_impl.dart';
import '../../features/social_sharing/data/repositories/story_share_service_impl.dart';
import '../../features/spotify/data/datasources/pkce.dart';
import '../../features/spotify/data/datasources/spotify_api_impl.dart';
import '../../features/spotify/data/datasources/spotify_auth_impl.dart';
import '../../features/progress/data/datasources/daos.dart';
import '../../features/spotify/data/datasources/spotify_datasources.dart';
import '../../features/spotify/presentation/bloc/spotify_auth_bloc.dart';
import '../../features/spotify/presentation/bloc/spotify_player_bloc.dart';
import '../../features/workout_session/data/repositories/complete_workout.dart';
import '../../features/workout_session/data/repositories/workout_session_repository_impl.dart';
import '../../features/workout_session/domain/services/xp_policy.dart';
import '../../features/workout_session/presentation/bloc/workout_session_bloc.dart';
import '../../features/achievements/data/repositories/achievement_repository_impl.dart';
import '../../features/challenges/data/repositories/challenge_repository_impl.dart';
import '../../features/personal_records/data/repositories/personal_record_repository_impl.dart';
import '../../features/workouts/data/repositories/workout_routine_repository_impl.dart';
import '../../features/workouts/presentation/bloc/workout_routine_bloc.dart';
import '../storage/app_database.dart';
import 'rest_feedback_service.dart';
import '../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../features/authentication/data/session_controller.dart';
import '../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../../features/social_sharing/data/repositories/story_overlay_accessor.dart';

/// Composition root. Manual DI keeps the dependency graph explicit and
/// testable without a service-locator runtime cost.
class AppDependencies {
  AppDependencies._(this.db);

  static Future<AppDependencies> init() async {
    final db = openAppDatabase();
    final deps = AppDependencies._(db);

    await deps._seed();
    return deps;
  }

  final AppDatabase db;

  // Spotify config via --dart-define; graceful offline when absent.
  static const spotifyClientId = String.fromEnvironment(
    'SPOTIFY_CLIENT_ID',
    defaultValue: '',
  );
  static const spotifyRedirectUri = String.fromEnvironment(
    'SPOTIFY_REDIRECT_URI',
    defaultValue: 'charlizard://spotify-callback',
  );

  late final SessionController session = SessionController();

  late final AuthRepositoryImpl authRepository =
      AuthRepositoryImpl(db, session);

  late final AuthBloc authBloc = AuthBloc(
    repository: authRepository,
    session: session,
  );

  late final ProgressionRepositoryImpl progressionRepository =
      ProgressionRepositoryImpl(db, const ProgressionRules(),
          session: session);

  late final WorkoutRoutineRepositoryImpl routineRepository =
      WorkoutRoutineRepositoryImpl(db);

  late final ExerciseLibraryRepositoryImpl exerciseRepository =
      ExerciseLibraryRepositoryImpl(db);

  late final WorkoutSessionRepositoryImpl sessionRepository =
      WorkoutSessionRepositoryImpl(db);

  late final AchievementRepositoryImpl achievementRepository =
      AchievementRepositoryImpl(db, session: session);

  late final ChallengeRepositoryImpl challengeRepository =
      ChallengeRepositoryImpl(db, session: session);

  late final PersonalRecordRepositoryImpl personalRecordRepository =
      PersonalRecordRepositoryImpl(db, session: session);

  late final CompleteWorkout completeWorkout = CompleteWorkout(
    sessionRepository: sessionRepository,
    progressionRepository: progressionRepository,
    progressionWriteRepository: progressionRepository,
    db: db,
    rules: const ProgressionRules(),
    xpPolicy: const XpPolicy(),
    session: session,
  );

  late final LoadDashboard loadDashboard = LoadDashboard(
    db: db,
    progressionRepository: progressionRepository,
    routineRepository: routineRepository,
    challengeRepository: challengeRepository,
    session: session,
  );

  late final SecureSpotifyTokenStore spotifyTokenStore =
      SecureSpotifyTokenStore();

  late final SpotifyAuthDataSourceImpl spotifyAuth = SpotifyAuthDataSourceImpl(
    clientId: spotifyClientId,
    redirectUri: spotifyRedirectUri,
    clientIdOverride: spotifyTokenStore.readClientIdOverride,
  );

  late final SpotifyApiDataSourceImpl spotifyApi = SpotifyApiDataSourceImpl(
    dio: Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    )),
    tokenStore: spotifyTokenStore,
    authDataSource: spotifyAuth,
  );

  late final RestFeedbackService restFeedback = RestFeedbackService();

  late final StoryImageGeneratorImpl storyGenerator = StoryImageGeneratorImpl();
  late final StoryShareServiceImpl storyShareService = StoryShareServiceImpl();

  late final SpotifyAuthBloc spotifyAuthBloc = SpotifyAuthBloc(
    apiDataSource: spotifyApi,
    tokenStore: spotifyTokenStore,
    launchSignIn: _launchSpotifySignIn,
  );

  late final SpotifyPlayerBloc spotifyPlayerBloc = SpotifyPlayerBloc(
    api: spotifyApi,
  );

  /// PKCE sign-in launcher used by [SpotifyAuthBloc.startSignIn].
  Future<({String state, String verifier})> _launchSpotifySignIn() async {
    final clientId = await spotifyAuth.effectiveClientId();
    if (clientId.isEmpty) {
      // Fail fast with an actionable message instead of opening a broken
      // browser flow. Provide it via Settings → Spotify, or rebuild with:
      // --dart-define=SPOTIFY_CLIENT_ID=<your client id>
      // No throw: callers await this without try/catch, and no redirect
      // will ever arrive for the dummy values below.
      spotifyAuthBloc.add(const SpotifyAuthFailed(
          'Spotify needs a Client ID. '
          'Add it in Settings → Spotify, then connect.'));
      return (state: '', verifier: '');
    }
    final pkce = Pkce.generate();
    final state = generateState();
    final uri = spotifyAuth.buildAuthorizeUri(
      pkce: PkcePair(verifier: pkce.verifier, challenge: pkce.challenge),
      state: state,
      clientId: clientId,
    );
    // Exchange happens here (bloc validates state, persists via store).
    _pendingSpotifyVerifier = pkce.verifier;
    _pendingSpotifyState = state;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
    return (state: state, verifier: pkce.verifier);
  }

  String? _pendingSpotifyVerifier;
  String? _pendingSpotifyState;

  /// Called by the router when the redirect URI hits the app.
  Future<void> completeSpotifySignIn(String code, String state) async {
    if (_pendingSpotifyState != null && state != _pendingSpotifyState) {
      spotifyAuthBloc.add(const SpotifyAuthFailed(
          'Sign-in could not be verified. Please try again.'));
      return;
    }
    final tokens = await spotifyAuth.exchangeCode(
      code: code,
      verifier: _pendingSpotifyVerifier ?? '',
    );
    await tokens.fold(
      (failure) async =>
          spotifyAuthBloc.add(SpotifyAuthFailed(failure.message)),
      (fresh) async {
        await spotifyTokenStore.save(
          accessToken: fresh.accessToken,
          refreshToken: fresh.refreshToken ?? '',
          expiresAt: fresh.expiresAt,
        );
        spotifyAuthBloc
            .add(SpotifyCodeReceived(code, state, _pendingSpotifyVerifier ?? ''));
      },
    );
  }

  Future<void> _seed() async {
    await restFeedback.init();
    await exerciseRepository.seedIfEmpty();
    await db.userDao.getUser('local-user');
  }

  List<SingleChildWidget> get providers => [
        Provider<AppDependencies>.value(value: this),
        ChangeNotifierProvider<SessionController>.value(value: session),
        BlocProvider<AuthBloc>.value(value: authBloc),
        BlocProvider<DashboardBloc>(
          create: (_) => DashboardBloc(loadDashboard: loadDashboard),
        ),
        BlocProvider<WorkoutRoutineBloc>(
          create: (_) => WorkoutRoutineBloc(repository: routineRepository)
            ..add(const LoadRoutines()),
        ),
        BlocProvider<ExerciseLibraryBloc>(
          create: (_) =>
              ExerciseLibraryBloc(repository: exerciseRepository)..add(const LoadExerciseLibrary()),
        ),
        BlocProvider<WorkoutSessionBloc>(
          create: (_) => WorkoutSessionBloc(
            sessionRepository: sessionRepository,
            completeWorkout: completeWorkout,
            onRestComplete: restFeedback.onRestComplete,
          ),
        ),
        BlocProvider<SpotifyAuthBloc>.value(value: spotifyAuthBloc),
        BlocProvider<SpotifyPlayerBloc>.value(value: spotifyPlayerBloc),
        Provider<StoryImageGenerator>.value(value: storyGenerator),
        Provider<StoryShareService>.value(value: storyShareService),
      ];

  void dispose() {
    db.close();
  }
}

/// Wires the story exporter to the live navigator overlay.
void initStoryOverlayAccess(GlobalKey<NavigatorState> navigatorKey) {
  storyOverlayAccessor = () => navigatorKey.currentState?.overlay;
}
