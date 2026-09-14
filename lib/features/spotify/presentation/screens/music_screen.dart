import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/app_dependencies.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/avatars.dart';
import '../../../../core/widgets/cards.dart';
import '../../../../core/widgets/feedback.dart';
import '../../domain/entities/spotify_entities.dart';
import '../bloc/spotify_auth_bloc.dart';
import '../bloc/spotify_player_bloc.dart';
import '../widgets/now_playing_sheet.dart';

/// Workout Music: recently played, liked songs, playlists. Playlists start
/// playback on the user's active Spotify device (Premium required).
class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout Music')),
      body: BlocBuilder<SpotifyAuthBloc, SpotifyAuthState>(
        builder: (context, state) {
          return switch (state) {
            SpotifyConnected() => const _LibraryView(),
            SpotifyConnecting() => const Center(
                child:
                    CircularProgressIndicator(color: AppPalette.spotify),
              ),
            _ => SpotifyConnectPrompt(
                onConnect: () =>
                    context.read<SpotifyAuthBloc>().startSignIn(),
              ),
          };
        },
      ),
    );
  }
}

class _LibraryView extends StatefulWidget {
  const _LibraryView();

  @override
  State<_LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<_LibraryView> {
  late final Future<_Library> _future;

  @override
  void initState() {
    super.initState();
    final api = context.read<AppDependencies>().spotifyApi;
    _future = Future.wait([
      api.myPlaylists(),
      api.recentlyPlayed(),
      api.savedTracks(limit: 10),
    ]).then((results) => _Library(
          playlists: results[0].fold((_) => <SpotifyPlaylist>[], (v) => v as List<SpotifyPlaylist>),
          recent: results[1].fold((_) => <SpotifyTrack>[], (v) => v as List<SpotifyTrack>),
          liked: results[2].fold((_) => <SpotifyTrack>[], (v) => v as List<SpotifyTrack>),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_Library>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: const [
              ShimmerBlock(height: 120, radius: AppRadius.lg),
              SizedBox(height: AppSpacing.md),
              ShimmerBlock(height: 200, radius: AppRadius.lg),
            ],
          );
        }
        final library = snapshot.data;
        if (library == null) {
          return const ErrorState(
              message: 'Could not load your Spotify library.');
        }
        return RefreshIndicator(
          color: AppPalette.spotify,
          backgroundColor: AppPalette.surfaceHigh,
          onRefresh: () async => setState(() {
            final api = context.read<AppDependencies>().spotifyApi;
            _future = Future.wait([
              api.myPlaylists(),
              api.recentlyPlayed(),
              api.savedTracks(limit: 10),
            ]).then((results) => _Library(
                  playlists: results[0].fold((_) => <SpotifyPlaylist>[], (v) => v as List<SpotifyPlaylist>),
                  recent: results[1].fold((_) => <SpotifyTrack>[], (v) => v as List<SpotifyTrack>),
                  liked: results[2].fold((_) => <SpotifyTrack>[], (v) => v as List<SpotifyTrack>),
                ));
          }),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xxxl),
            children: [
              if (library.recent.isNotEmpty) ...[
                const SectionHeader(title: 'Recently Played'),
                SizedBox(
                  height: 176,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: library.recent.length,
                    itemBuilder: (context, index) => _TrackCard(
                      track: library.recent[index],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
              const SectionHeader(title: 'Your Playlists'),
              for (final playlist in library.playlists)
                _PlaylistRow(playlist: playlist),
              if (library.liked.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(title: 'Liked Songs'),
                for (final track in library.liked.take(5))
                  _LikedRow(track: track),
              ],
              if (library.playlists.isEmpty && library.recent.isEmpty)
                const EmptyState(
                  icon: AppIcons.playlist,
                  title: 'Nothing here yet',
                  message:
                      'Play something on Spotify and it will show up here.',
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Library {
  const _Library({
    required this.playlists,
    required this.recent,
    required this.liked,
  });

  final List<SpotifyPlaylist> playlists;
  final List<SpotifyTrack> recent;
  final List<SpotifyTrack> liked;
}

class _TrackCard extends StatelessWidget {
  const _TrackCard({required this.track});

  final SpotifyTrack track;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      margin: const EdgeInsets.only(right: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArtworkTile(url: track.imageUrl, size: 128, borderRadius: AppRadius.md),
          const SizedBox(height: AppSpacing.sm),
          Text(
            track.name,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            track.artistLine,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppPalette.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _PlaylistRow extends StatelessWidget {
  const _PlaylistRow({required this.playlist});

  final SpotifyPlaylist playlist;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        onTap: () {
          context
              .read<SpotifyPlayerBloc>()
              .add(PlayPlaylist(playlist.id));
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Playing ${playlist.name} on Spotify')),
            );
        },
        child: Row(
          children: [
            ArtworkTile(
                url: playlist.imageUrl, size: 56, borderRadius: AppRadius.sm),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(playlist.name,
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text(
                    '${playlist.trackCount} tracks'
                    '${playlist.owner == null ? '' : ' • ${playlist.owner}'}',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: AppPalette.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(AppIcons.play,
                size: 22, color: AppPalette.spotify),
          ],
        ),
      ),
    );
  }
}

class _LikedRow extends StatelessWidget {
  const _LikedRow({required this.track});

  final SpotifyTrack track;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm + 2),
      child: Row(
        children: [
          ArtworkTile(url: track.imageUrl, size: 44, borderRadius: 8),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(track.name,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(track.artistLine,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppPalette.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const Icon(AppIcons.favorite, size: 16, color: AppPalette.spotify),
        ],
      ),
    );
  }
}
