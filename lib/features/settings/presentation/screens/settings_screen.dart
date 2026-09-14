import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/app_dependencies.dart';
import '../../../authentication/data/session_controller.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/avatars.dart';
import '../../../../core/widgets/cards.dart';
import '../../../../core/widgets/shell_chrome.dart';
import '../../../spotify/domain/entities/spotify_entities.dart';
import '../../../spotify/presentation/bloc/spotify_auth_bloc.dart';

/// Settings: profile, Spotify connection, about.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          ShellChrome.tabBottom(context),
        ),
        children: [
          Text(
            'ACCOUNT',
            style: theme.textTheme.labelMedium?.copyWith(
                color: AppPalette.textSecondary, letterSpacing: 1.2),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Row(
              children: [
                UserAvatar(
                    name: context
                        .watch<SessionController>()
                        .displayName,
                    size: 44),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          context
                              .watch<SessionController>()
                              .displayName,
                          style: theme.textTheme.titleMedium),
                      Text(
                        'Local profile',
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: AppPalette.textTertiary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'MUSIC',
            style: theme.textTheme.labelMedium?.copyWith(
                color: AppPalette.textSecondary, letterSpacing: 1.2),
          ),
          const SizedBox(height: AppSpacing.sm),
          BlocBuilder<SpotifyAuthBloc, SpotifyAuthState>(
            builder: (context, state) {
              return switch (state) {
                SpotifyConnected(:final profile) => _SpotifyConnectedTile(
                    profile: profile,
                    onDisconnect: () => context
                        .read<SpotifyAuthBloc>()
                        .add(const DisconnectSpotify()),
                  ),
                SpotifyConnecting() => const AppCard(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.lg),
                        child: CircularProgressIndicator(color: AppPalette.spotify),
                      ),
                    ),
                  ),
                SpotifyAuthError(:final message) => AppCard(
                    child: Column(
                      children: [
                        Text(message,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: AppPalette.danger)),
                        const SizedBox(height: AppSpacing.md),
                        _ConnectButton(
                          onPressed: () => context
                              .read<SpotifyAuthBloc>()
                              .add(const RestoreSpotifySession()),
                        ),
                      ],
                    ),
                  ),
                _ => const AppCard(
                    child: _SpotifyConnectBody(),
                  ),
              };
            },
          ),
          const SizedBox(height: AppSpacing.md),
          const _MusicEntryRow(),
          const SizedBox(height: AppSpacing.md),
          const _SpotifyClientIdCard(),
          const SizedBox(height: AppSpacing.md),
          AppCard(
            onTap: () => _confirmLogout(context),
            child: Row(
              children: [
                const Icon(AppIcons.logout,
                    color: AppPalette.danger, size: 22),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Log Out',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: AppPalette.danger,
                          )),
                      Text(
                        'Your data stays on this device.',
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: AppPalette.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'ABOUT',
            style: theme.textTheme.labelMedium?.copyWith(
                color: AppPalette.textSecondary, letterSpacing: 1.2),
          ),
          const SizedBox(height: AppSpacing.sm),
          const AppCard(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.sm),
              child: ListTile(
                leading: Icon(AppIcons.dumbbell, color: AppPalette.ember),
                title: Text('Charlizard'),
                subtitle: Text('Train • Level • Repeat'),
                trailing: Text('v1.0.0'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _confirmLogout(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Log out?'),
      content: const Text(
          'You can log back in any time. Your workouts stay on this device.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: AppPalette.danger),
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Log Out'),
        ),
      ],
    ),
  );
  if (confirmed == true && context.mounted) {
    context.read<AuthBloc>().add(const AuthLoggedOut());
    context.go('/auth');
  }
}

class _MusicEntryRow extends StatelessWidget {
  const _MusicEntryRow();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: () => context.push('/music'),
      child: Row(
        children: [
          const Icon(AppIcons.playlist, color: AppPalette.spotify, size: 22),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Workout Music', style: theme.textTheme.titleSmall),
                Text(
                  'Playlists, recently played, liked songs',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: AppPalette.textSecondary),
                ),
              ],
            ),
          ),
          const Icon(AppIcons.chevronRight, color: AppPalette.textTertiary),
        ],
      ),
    );
  }
}

/// Spotify Client ID editor. The value from Settings is used when the
/// build flag is empty, so connecting never needs a rebuild.
class _SpotifyClientIdCard extends StatefulWidget {
  const _SpotifyClientIdCard();

  @override
  State<_SpotifyClientIdCard> createState() => _SpotifyClientIdCardState();
}

class _SpotifyClientIdCardState extends State<_SpotifyClientIdCard> {
  final _controller = TextEditingController();
  String? _stored;
  bool _loading = true;
  bool _saving = false;
  bool _showValue = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final store = context.read<AppDependencies>().spotifyTokenStore;
    final override = await store.readClientIdOverride();
    if (!mounted) return;
    setState(() {
      _stored = override?.isEmpty == true ? null : override;
      if (_stored != null) _controller.text = _stored!;
      _loading = false;
    });
  }

  bool get _hasBuildFlag =>
      AppDependencies.spotifyClientId.isNotEmpty;

  Future<void> _save() async {
    final value = _controller.text.trim();
    if (value.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
            content: Text('Paste your Spotify Client ID first.')));
      return;
    }
    setState(() => _saving = true);
    await context
        .read<AppDependencies>()
        .spotifyTokenStore
        .saveClientIdOverride(value);
    if (!mounted) return;
    setState(() {
      _saving = false;
      _stored = value;
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
          const SnackBar(content: Text('Client ID saved. Connect Spotify.')));
  }

  Future<void> _clear() async {
    await context
        .read<AppDependencies>()
        .spotifyTokenStore
        .clearClientIdOverride();
    if (!mounted) return;
    setState(() {
      _stored = null;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (_loading) {
      return const AppCard(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: AppPalette.spotify),
            ),
          ),
        ),
      );
    }
    final activeSource = _hasBuildFlag
        ? 'Using the ID from this build.'
        : _stored != null
            ? 'Using your saved ID.'
            : 'No Client ID yet — connecting will fail.';
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(AppIcons.spotify,
                  color: AppPalette.spotify, size: 20),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text('Spotify Client ID',
                    style: theme.textTheme.titleSmall),
              ),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (_hasBuildFlag || _stored != null)
                      ? AppPalette.spotify
                      : AppPalette.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            activeSource,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: AppPalette.textSecondary),
          ),
          if (!_hasBuildFlag) ...[
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _controller,
              obscureText: !_showValue,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                hintText: 'Paste from developer.spotify.com',
                suffixIcon: IconButton(
                  icon: Icon(
                    _showValue
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                    color: AppPalette.textTertiary,
                  ),
                  onPressed: () =>
                      setState(() => _showValue = !_showValue),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _ClientIdButton(
                    label: _saving ? 'SAVING…' : 'SAVE ID',
                    onPressed: _saving ? null : _save,
                  ),
                ),
                if (_stored != null) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _ClientIdButton(
                      label: 'CLEAR',
                      destructive: true,
                      onPressed: _clear,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ClientIdButton extends StatelessWidget {
  const _ClientIdButton({
    required this.label,
    this.onPressed,
    this.destructive = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: destructive
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppPalette.danger,
                side: BorderSide(
                    color: AppPalette.danger.withValues(alpha: 0.5)),
              ),
              onPressed: onPressed,
              child: Text(label),
            )
          : FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppPalette.spotify,
                foregroundColor: Colors.black,
              ),
              onPressed: onPressed,
              child: Text(label),
            ),
    );
  }
}

class _SpotifyConnectBody extends StatelessWidget {
  const _SpotifyConnectBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(AppIcons.spotify, color: AppPalette.spotify, size: 22),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Connect Spotify',
                      style: theme.textTheme.titleSmall),
                  Text(
                    'Bring your playlists into workouts',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: AppPalette.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _ConnectButton(
          onPressed: () => _startSignIn(context),
        ),
      ],
    );
  }

  Future<void> _startSignIn(BuildContext context) async {
    await context.read<SpotifyAuthBloc>().startSignIn();
  }
}

class _ConnectButton extends StatelessWidget {
  const _ConnectButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppPalette.spotify,
          foregroundColor: Colors.black,
          minimumSize: const Size.fromHeight(48),
        ),
        onPressed: onPressed,
        child: const Text('CONNECT'),
      ),
    );
  }
}

class _SpotifyConnectedTile extends StatelessWidget {
  const _SpotifyConnectedTile({
    required this.profile,
    required this.onDisconnect,
  });

  final SpotifyProfile profile;
  final VoidCallback onDisconnect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              UserAvatar(
                name: profile.displayName,
                photoUrl: profile.imageUrl,
                size: 40,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profile.displayName, style: theme.textTheme.titleSmall),
                    Text(
                      'Spotify connected',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: AppPalette.spotify),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppPalette.danger,
                    side: BorderSide(
                        color: AppPalette.danger.withValues(alpha: 0.5)),
                  ),
                  onPressed: onDisconnect,
                  child: const Text('DISCONNECT'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
