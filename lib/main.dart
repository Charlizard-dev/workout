import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/routing/app_router.dart';
import 'core/services/app_dependencies.dart';
import 'core/theme/app_theme.dart';
import 'features/spotify/presentation/bloc/spotify_auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Edge-to-edge dark chrome.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  final deps = await AppDependencies.init();
  initStoryOverlayAccess(rootNavigatorKey);

  _listenForSpotifyRedirect(deps);

  runApp(CharlizardApp(deps: deps));
}

/// Handles the OAuth redirect back from the browser:
/// charlizard://spotify-callback?code=...&state=...
void _listenForSpotifyRedirect(AppDependencies deps) {
  final appLinks = AppLinks();
  unawaited(
    appLinks.uriLinkStream.listen((uri) {
      if (uri.scheme != 'charlizard') return;
      final code = uri.queryParameters['code'];
      final state = uri.queryParameters['state'];
      final error = uri.queryParameters['error'];
      if (error != null) {
        deps.spotifyAuthBloc.add(
            const SpotifyAuthFailed('Spotify sign-in was cancelled.'));
        return;
      }
      if (code != null && state != null) {
        unawaited(deps.completeSpotifySignIn(code, state));
      }
    }).asFuture(),
  );
}

class CharlizardApp extends StatelessWidget {
  const CharlizardApp({super.key, required this.deps});

  final AppDependencies deps;

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(deps).build();

    return MultiProvider(
      providers: deps.providers,
      child: MaterialApp.router(
        title: 'Charlizard',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        routerConfig: router,
        builder: (context, child) {
          // Cap text scaling so the athletic layout never overflows.
          final media = MediaQuery.of(context);
          final capped = media.textScaler.clamp(
            minScaleFactor: 0.85,
            maxScaleFactor: 1.25,
          );
          return MediaQuery(
            data: media.copyWith(textScaler: capped),
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
