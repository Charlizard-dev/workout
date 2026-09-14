import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/exercises/presentation/screens/exercise_picker_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/social_sharing/domain/entities/story_entities.dart';
import '../../features/social_sharing/presentation/screens/share_story_screen.dart';
import '../../features/authentication/presentation/screens/auth_screen.dart';
import '../../features/social_sharing/presentation/story_content_factory.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/spotify/presentation/screens/music_screen.dart';
import '../../features/spotify/presentation/widgets/mini_music_player.dart';
import '../../features/spotify/presentation/widgets/now_playing_sheet.dart';
import '../../features/achievements/presentation/bloc/achievements_bloc.dart';
import '../../features/achievements/presentation/screens/achievements_screen.dart';
import '../../features/challenges/presentation/bloc/challenges_bloc.dart';
import '../../features/challenges/presentation/screens/challenges_screen.dart';
import '../../features/personal_records/presentation/bloc/personal_records_bloc.dart';
import '../../features/personal_records/presentation/screens/personal_records_screen.dart';
import '../../features/workout_history/presentation/bloc/workout_history_bloc.dart';
import '../../features/workout_history/presentation/screens/workout_history_screen.dart';
import '../../features/workout_session/presentation/bloc/workout_session_bloc.dart';
import '../../features/workout_session/presentation/screens/active_workout_screen.dart';
import '../../features/workout_session/presentation/screens/workout_complete_screen.dart';
import '../../features/workouts/domain/entities/workout_routine.dart';
import '../../features/workouts/presentation/bloc/workout_routine_bloc.dart';
import '../../features/workouts/presentation/screens/routine_editor_screen.dart';
import '../../features/workouts/presentation/screens/routines_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../services/app_dependencies.dart';
import '../theme/app_icons.dart';
import '../theme/tokens.dart';

/// Root navigator key — used by the story exporter and Spotify redirect.
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter(this.deps);

  final AppDependencies deps;

  GoRouter build() => GoRouter(
        navigatorKey: rootNavigatorKey,
        initialLocation: '/splash',
        // Reactive auth guard: signed-out users can only reach
        // splash/auth (and the Spotify callback host, which needs no UI).
        refreshListenable: deps.session,
        redirect: (context, state) {
          final signedIn = deps.session.isSignedIn;
          final loc = state.uri.toString();
          final isPublic =
              loc.startsWith('/splash') || loc.startsWith('/auth');
          if (!signedIn && !isPublic) return '/auth';
          return null;
        },
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => AppShell(
              deps: deps,
              child: child,
            ),
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: _HomeTab()),
              ),
              GoRoute(
                path: '/workouts',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: _WorkoutsTab()),
                routes: [
                  GoRoute(
                    path: 'editor',
                    parentNavigatorKey: _shellNavigatorKey,
                    pageBuilder: (context, state) => _fadeInPage(
                      RoutineEditorScreen(
                        initial: state.extra as WorkoutRoutine?,
                        onSave: (updated) async {
                          final res = await deps.routineRepository.save(updated);
                          if (res.isRight()) {
                            // refresh list
                            return true;
                          }
                          return false;
                        },
                        onDelete: (routine) {
                          deps.routineRepository.delete(routine.id);
                        },
                        onAddExercises: () async {
                          final picked = await _shellNavigatorKey.currentState
                              ?.push<List<dynamic>>(
                            MaterialPageRoute(
                                builder: (_) => const ExercisePickerScreen()),
                          );
                          return picked?.cast();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: '/progress',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProgressScreen()),
                routes: [
                  GoRoute(
                    path: 'achievements',
                    parentNavigatorKey: _shellNavigatorKey,
                    pageBuilder: (context, state) => _fadeInPage(
                      BlocProvider(
                        create: (_) => AchievementsBloc(
                          repository: deps.achievementRepository,
                        ),
                        child: const AchievementsScreen(),
                      ),
                    ),
                  ),
                  GoRoute(
                    path: 'challenges',
                    parentNavigatorKey: _shellNavigatorKey,
                    pageBuilder: (context, state) => _fadeInPage(
                      BlocProvider(
                        create: (_) => ChallengesBloc(
                          repository: deps.challengeRepository,
                        ),
                        child: const ChallengesScreen(),
                      ),
                    ),
                  ),
                  GoRoute(
                    path: 'history',
                    parentNavigatorKey: _shellNavigatorKey,
                    pageBuilder: (context, state) => _fadeInPage(
                      BlocProvider(
                        create: (_) => WorkoutHistoryBloc(
                          repository: deps.sessionRepository,
                        ),
                        child: const WorkoutHistoryScreen(),
                      ),
                    ),
                  ),
                  GoRoute(
                    path: 'records',
                    parentNavigatorKey: _shellNavigatorKey,
                    pageBuilder: (context, state) => _fadeInPage(
                      BlocProvider(
                        create: (_) => PersonalRecordsBloc(
                          repository: deps.personalRecordRepository,
                        ),
                        child: const PersonalRecordsScreen(),
                      ),
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) => NoTransitionPage(
                  child: ProfileScreen(
                    onShareLevel: (content) =>
                        context.push('/share', extra: content),
                    onOpenSettings: () => context.push('/profile/settings'),
                  ),
                ),
                routes: [
                  GoRoute(
                    path: 'settings',
                    parentNavigatorKey: _shellNavigatorKey,
                    builder: (context, state) => const SettingsScreen(),
                  ),
                  GoRoute(
                    path: 'edit',
                    parentNavigatorKey: rootNavigatorKey,
                    pageBuilder: (context, state) =>
                        _fadeInPage(const EditProfileScreen()),
                  ),
                ],
              ),
            ],
          ),
          // Full-screen routes outside the shell.
          GoRoute(
            path: '/session',
            parentNavigatorKey: rootNavigatorKey,
            pageBuilder: (context, state) => _fadeInPage(
              ActiveWorkoutScreen(
                onWorkoutComplete: (completionContext) =>
                    context.push('/session/complete'),
                onExit: () => context.go('/home'),
              ),
            ),
            routes: [
              GoRoute(
                path: 'complete',
                parentNavigatorKey: rootNavigatorKey,
                pageBuilder: (context, state) {
                  final blocState =
                      context.read<WorkoutSessionBloc>().state;
                  return _fadeInPage(
                    blocState is SessionComplete
                        ? WorkoutCompleteScreen(
                            result: blocState.result,
                            onShareWorkout: () => context.push(
                              '/share',
                              extra: StoryContentFactory.workout(
                                result: blocState.result,
                                userName: deps.session.displayName,
                                photoUrl: deps.session.photoUrl,
                              ),
                            ),
                            onDone: () => context.go('/home'),
                          )
                        : const _SessionNotFound(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/splash',
            parentNavigatorKey: rootNavigatorKey,
            pageBuilder: (context, state) =>
                _fadeInPage(const SplashScreen()),
          ),
          GoRoute(
            path: '/auth',
            parentNavigatorKey: rootNavigatorKey,
            pageBuilder: (context, state) =>
                _fadeInPage(const AuthScreen()),
          ),
          GoRoute(
            path: '/share',
            parentNavigatorKey: rootNavigatorKey,
            pageBuilder: (context, state) => _fadeInPage(ShareStoryScreen(
              initialContent: state.extra as StoryContent?,
            )),
          ),
          GoRoute(
            path: '/music',
            parentNavigatorKey: rootNavigatorKey,
            pageBuilder: (context, state) =>
                _fadeInPage(const MusicScreen()),
          ),
        ],
      );

  static Page<void> _fadeInPage(Widget child) => CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 220),
        child: child,
        transitionsBuilder: (context, animation, secondary, child) =>
            FadeTransition(
          opacity: CurveTween(curve: Curves.easeOut).animate(animation),
          child: child,
        ),
      );
}

class _WorkoutsTab extends StatelessWidget {
  const _WorkoutsTab();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WorkoutRoutineBloc(
              repository: context.read<AppDependencies>().routineRepository)
          ..add(const LoadRoutines()),
      child: RoutinesScreen(
        onCreateRoutine: () => context.push('/workouts/editor'),
        onEditRoutine: (routine) =>
            context.push('/workouts/editor', extra: routine),
        onWorkoutStart: (routine) =>
            _launchSession(context, context.read<AppDependencies>(), routine),
      ),
    );
  }
}

class _SessionNotFound extends StatelessWidget {
  const _SessionNotFound();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Nothing to show here.'),
            TextButton(onPressed: () => context.go('/home'), child: const Text('Home')),
          ],
        ),
      ),
    );
  }
}

/// Premium bottom navigation shell: elevated center START action +
/// persistent mini player above the nav.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child, required this.deps});

  final Widget child;
  final AppDependencies deps;

  static int _locationToIndex(String location) {
    if (location.startsWith('/workouts')) return 1;
    if (location.startsWith('/progress')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex = _locationToIndex(location);
    final inSession = location.startsWith('/session');

    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: inSession
          ? null
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const MiniMusicPlayer(onTapOpen: _openNowPlaying),
                _BottomNav(
                  selectedIndex: selectedIndex,
                  onSelected: (i) => switch (i) {
                    0 => context.go('/home'),
                    1 => context.go('/workouts'),
                    2 => context.go('/progress'),
                    _ => context.go('/profile'),
                  },
                  onStartWorkout: () => _quickStart(context),
                ),
              ],
            ),
    );
  }

  Future<void> _quickStart(BuildContext context) async {
    final routines = await deps.routineRepository.getAll();
    if (!context.mounted) return;
    final list = routines.getOrElse(() => <WorkoutRoutine>[]);
    if (list.isEmpty) {
      context.go('/workouts');
      return;
    }
    await _launchSession(context, deps, list.first);
  }

  static void _openNowPlaying() {
    rootNavigatorKey.currentState?.push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: Colors.black54,
        pageBuilder: (context, _, _) => const _NowPlayingRoute(),
        transitionsBuilder: (context, animation, _, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
          child: child,
        ),
      ),
    );
  }
}

Future<void> _launchSession(
    BuildContext context, AppDependencies deps, WorkoutRoutine routine) async {
  final started = await deps.sessionRepository.startFromRoutine(routine);
  started.fold(
    (failure) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(failure.message)));
    },
    (session) {
      context.read<WorkoutSessionBloc>().add(SessionStarted(session));
      context.push('/session');
    },
  );
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.selectedIndex,
    required this.onSelected,
    required this.onStartWorkout,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final VoidCallback onStartWorkout;

  static const _labels = ['Home', 'Workouts', 'Progress', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.charcoal.withValues(alpha: 0.98),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 68,
          child: Row(
            children: [
              for (var i = 0; i < 4; i++) ...[
                if (i == 2) ...[
                  Expanded(
                    child: GestureDetector(
                      onTap: onStartWorkout,
                      child: Container(
                        height: 54,
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [AppPalette.ember, AppPalette.emberDeep],
                          ),
                        ),
                        child: const Icon(AppIcons.play,
                            color: Colors.white, size: 30),
                      ),
                    ),
                  ),
                ],
                Expanded(
                  child: _NavItem(
                    index: i,
                    icon: switch (i) {
                      0 => AppIcons.home,
                      1 => AppIcons.dumbbell,
                      2 => AppIcons.chart,
                      _ => AppIcons.person,
                    },
                    label: _labels[i],
                    selected: selectedIndex == i,
                    onTap: () => onSelected(i),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final int index;
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppPalette.ember : AppPalette.textTertiary;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 3),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: color, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class _NowPlayingRoute extends StatelessWidget {
  const _NowPlayingRoute();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.black.withValues(alpha: 0.4),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: const BoxDecoration(
                color: AppPalette.surfaceHigh,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
              ),
              child: const NowPlayingSheet(),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return DashboardScreen(
      onStartWorkout: () => _startFromDashboard(context),
      onOpenProgression: () => context.go('/progress'),
      onOpenChallenges: () => context.go('/progress'),
    );
  }

  Future<void> _startFromDashboard(BuildContext context) async {
    final sessionState = context.read<WorkoutSessionBloc>().state;
    if (sessionState is SessionActive) {
      unawaited(context.push('/session'));
      return;
    }
    final deps = context.read<AppDependencies>();
    final routines = await deps.routineRepository.getAll();
    if (!context.mounted) return;
    final list = routines.getOrElse(() => <WorkoutRoutine>[]);
    if (list.isEmpty) {
      context.go('/workouts');
      return;
    }
    await _launchSession(context, deps, list.first);
  }
}
