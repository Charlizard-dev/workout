import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/tokens.dart';
import '../../../authentication/data/session_controller.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';

/// Brand splash: logo mark, wordmark, tagline. Holds for a short brand
/// moment while the dashboard warms its cache, then routes home.
///
/// Kept deliberately calm — one staggered entrance, no looping gimmicks.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  /// Minimum time the brand stays visible (brand moment, not a loader).
  static const brandHold = Duration(milliseconds: 1600);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _wordmarkFade;
  late final Animation<Offset> _wordmarkSlide;
  late final Animation<double> _taglineFade;
  Timer? _advanceTimer;

  @override
  void initState() {
    super.initState();
    final reduceMotion = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.first,
    ).disableAnimations;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    final eased = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _logoScale = Tween<double>(begin: 0.86, end: 1).animate(eased);
    _logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.55)),
    );
    _wordmarkFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.35, 0.8)),
    );
    _wordmarkSlide = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.35, 0.85)),
    );
    _taglineFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1)),
    );

    if (reduceMotion) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }

    // Restore the session, then route: home when signed in, auth when not.
    // The dashboard warms only for signed-in users.
    _advanceTimer = Timer(SplashScreen.brandHold, () async {
      if (!mounted) return;
      final session = context.read<SessionController>();
      await session.restore();
      if (!mounted) return;
      if (session.isSignedIn) {
        context.read<DashboardBloc>().add(const DashboardRefreshed());
        unawaited(HapticFeedback.selectionClick());
        context.go('/home');
      } else {
        // Prime the auth state machine for the login screen.
        context.read<AuthBloc>().add(const AuthSessionChecked());
        context.go('/auth');
      }
    });
  }

  @override
  void dispose() {
    _advanceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppPalette.charcoal,
      body: Semantics(
        label: 'Charlizard. Train, level, repeat.',
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(flex: 3),
                // Logo mark with a soft ember halo.
                FadeTransition(
                  opacity: _logoFade,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: Container(
                      width: 148,
                      height: 148,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppRadius.xl),
                        boxShadow: [
                          BoxShadow(
                            color: AppPalette.ember
                                .withValues(alpha: 0.35),
                            blurRadius: 48,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppRadius.xl),
                        child: SvgPicture.asset(
                          'assets/images/charlizard_logo.svg',
                          width: 148,
                          height: 148,
                          fit: BoxFit.cover,
                          semanticsLabel: 'Charlizard logo',
                          placeholderBuilder: (_) => Container(
                            width: 148,
                            height: 148,
                            color: AppPalette.surface,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.fitness_center_rounded,
                              size: 64,
                              color: AppPalette.ember,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                // Wordmark.
                FadeTransition(
                  opacity: _wordmarkFade,
                  child: SlideTransition(
                    position: _wordmarkSlide,
                    child: Text(
                      'CHARLIZARD',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        letterSpacing: 8,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                // Tagline.
                FadeTransition(
                  opacity: _taglineFade,
                  child: Text(
                    'TRAIN • LEVEL • REPEAT',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppPalette.textTertiary,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                const Spacer(flex: 4),
                // Version footer.
                FadeTransition(
                  opacity: _taglineFade,
                  child: Text(
                    'v1.0.0',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppPalette.textTertiary
                          .withValues(alpha: 0.6),
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
