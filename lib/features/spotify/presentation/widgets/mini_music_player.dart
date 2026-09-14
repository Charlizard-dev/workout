import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/avatars.dart';
import '../bloc/spotify_player_bloc.dart';

/// Persistent mini player shown above the bottom navigation.
class MiniMusicPlayer extends StatefulWidget {
  const MiniMusicPlayer({super.key, this.onTapOpen});

  final VoidCallback? onTapOpen;

  @override
  State<MiniMusicPlayer> createState() => _MiniMusicPlayerState();
}

class _MiniMusicPlayerState extends State<MiniMusicPlayer> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<SpotifyPlayerBloc, SpotifyPlayerState>(
      buildWhen: (prev, next) {
        if (prev is! PlayerLive || next is! PlayerLive) return true;
        return prev.playback.track?.id != next.playback.track?.id ||
            prev.playback.isPlaying != next.playback.isPlaying;
      },
      builder: (context, state) {
        if (state is! PlayerLive || state.playback.track == null) {
          return const SizedBox.shrink();
        }

        final track = state.playback.track!;
        final progress = state.effectiveProgressMs / (track.durationMs * 1.0);
        final progressPct = (progress.clamp(0.0, 1.0) * 100);

        return Material(
          color: AppPalette.spotifySurface,
          child: InkWell(
            onTap: widget.onTapOpen,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppPalette.spotify.withValues(alpha: 0.2)),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.sm + 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      ArtworkTile(url: track.imageUrl, size: 38, borderRadius: 6),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.name,
                              style: theme.textTheme.titleSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              track.artistLine,
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(color: AppPalette.textSecondary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      _TransportButton(
                        icon: state.playback.isPlaying
                            ? AppIcons.pause
                            : AppIcons.play,
                        iconColor: Colors.white,
                        onTap: () => context
                            .read<SpotifyPlayerBloc>()
                            .add(const TogglePlayPause()),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _TransportButton(
                        icon: AppIcons.skipNext,
                        onTap: () => context
                            .read<SpotifyPlayerBloc>()
                            .add(const SkipNext()),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs + 2),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: progressPct / 100,
                      minHeight: 2,
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      valueColor:
                          const AlwaysStoppedAnimation(AppPalette.spotify),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TransportButton extends StatelessWidget {
  const _TransportButton({
    required this.icon,
    required this.onTap,
    this.iconColor = AppPalette.textPrimary,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      icon: Icon(icon, size: 24, color: iconColor),
      onPressed: () {
        HapticFeedback.selectionClick();
        onTap();
      },
    );
  }
}
