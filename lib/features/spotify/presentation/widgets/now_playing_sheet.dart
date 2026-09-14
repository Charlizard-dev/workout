import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/avatars.dart';
import '../../../../core/widgets/feedback.dart';
import '../bloc/spotify_player_bloc.dart';

/// Premium full-height now-playing sheet.
class NowPlayingSheet extends StatefulWidget {
  const NowPlayingSheet({super.key});

  @override
  State<NowPlayingSheet> createState() => _NowPlayingSheetState();
}

class _NowPlayingSheetState extends State<NowPlayingSheet> {
  Timer? _ticker;
  bool _scrubbing = false;
  double _scrubValue = 0;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (mounted && !_scrubbing) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  String _fmt(int ms) {
    final s = ms ~/ 1000;
    return '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<SpotifyPlayerBloc, SpotifyPlayerState>(
      builder: (context, state) {
        if (state is! PlayerLive || state.playback.track == null) {
          return const SizedBox.shrink();
        }
        final playback = state.playback;
        final track = playback.track!;
        final progressMs = state.effectiveProgressMs;
        final totalMs = track.durationMs;
        final sliderValue = _scrubbing
            ? _scrubValue
            : (totalMs <= 0 ? 0 : (progressMs / totalMs).clamp(0.0, 1.0));

        return Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            top: AppSpacing.xl,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Spacer(),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppPalette.textTertiary.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
                    child: ArtworkTile(
                      url: track.imageUrl,
                      size: 300,
                      borderRadius: AppRadius.xl,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(track.name,
                            style: theme.textTheme.headlineSmall, maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          track.artistLine,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: AppPalette.textSecondary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (playback.deviceName != null) ...[
                    const SizedBox(width: AppSpacing.md),
                    const Icon(AppIcons.spotify, size: 18, color: AppPalette.spotify),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setSheetState) => SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    activeTrackColor: AppPalette.spotify,
                    inactiveTrackColor: Colors.white.withValues(alpha: 0.12),
                    thumbColor: Colors.white,
                    overlayColor: AppPalette.spotify.withValues(alpha: 0.15),
                  ),
                  child: Slider(
                    value: sliderValue.toDouble(),
                    onChanged: totalMs <= 0
                        ? null
                        : (v) {
                            _scrubbing = true;
                            _scrubValue = v;
                            setSheetState(() {});
                          },
                    onChangeEnd: (v) {
                      _scrubbing = false;
                      context
                          .read<SpotifyPlayerBloc>()
                          .add(SeekTo((v * totalMs).round()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_fmt(_scrubbing ? (_scrubValue * totalMs).round() : progressMs),
                        style: theme.textTheme.labelMedium?.copyWith(
                            color: AppPalette.textTertiary,
                            fontFeatures: const [FontFeature.tabularFigures()])),
                    Text(_fmt(totalMs),
                        style: theme.textTheme.labelMedium?.copyWith(
                            color: AppPalette.textTertiary,
                            fontFeatures: const [FontFeature.tabularFigures()])),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _RoundIcon(
                    icon: AppIcons.shuffle,
                    active: playback.shuffleEnabled,
                    activeColor: AppPalette.spotify,
                    onTap: () => context
                        .read<SpotifyPlayerBloc>()
                        .add(const ToggleShuffle()),
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  _RoundIcon(
                    icon: AppIcons.skipPrevious,
                    big: true,
                    onTap: () => context
                        .read<SpotifyPlayerBloc>()
                        .add(const SkipPrevious()),
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  _RoundIcon(
                    icon: playback.isPlaying ? AppIcons.pause : AppIcons.play,
                    big: true,
                    filled: true,
                    onTap: () => context
                        .read<SpotifyPlayerBloc>()
                        .add(const TogglePlayPause()),
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  _RoundIcon(
                    icon: AppIcons.skipNext,
                    big: true,
                    onTap: () =>
                        context.read<SpotifyPlayerBloc>().add(const SkipNext()),
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  _RoundIcon(
                    icon: AppIcons.repeat,
                    active: playback.repeatMode > 0,
                    activeColor: AppPalette.spotify,
                    onTap: () => context
                        .read<SpotifyPlayerBloc>()
                        .add(const CycleRepeat()),
                  ),
                ],
              ),
              if (playback.deviceName != null) ...[
                const SizedBox(height: AppSpacing.xl),
                Center(
                  child: Text(
                    'Playing on ${playback.deviceName}',
                    style: theme.textTheme.labelMedium
                        ?.copyWith(color: AppPalette.textTertiary),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        );
      },
    );
  }
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({
    required this.icon,
    required this.onTap,
    this.active = false,
    this.activeColor = AppPalette.textPrimary,
    this.big = false,
    this.filled = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool active;
  final Color activeColor;
  final bool big;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final size = big ? 30.0 : 22.0;
    final tint = active ? activeColor : AppPalette.textPrimary;

    if (!filled) {
      return IconButton(
        padding: EdgeInsets.all(big ? 14 : 10),
        icon: Icon(icon, size: size, color: tint),
        onPressed: () {
          HapticFeedback.selectionClick();
          onTap();
        },
      );
    }

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      child: Container(
        width: big ? 68 : 44,
        height: big ? 68 : 44,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppPalette.spotify,
        ),
        child: Icon(icon, size: size + 6, color: Colors.black),
      ),
    );
  }
}

/// Shown when Spotify is disconnected in the music surface.
class SpotifyConnectPrompt extends StatelessWidget {
  const SpotifyConnectPrompt({super.key, required this.onConnect});

  final VoidCallback onConnect;

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: AppIcons.spotify,
      title: 'Bring your music',
      message:
          'Connect Spotify to bring your favorite music into your workouts.',
      actionLabel: 'CONNECT SPOTIFY',
      onAction: onConnect,
    );
  }
}
