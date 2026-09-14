import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/buttons.dart';
import '../../data/datasources/story_datasources.dart';
import '../../domain/entities/story_entities.dart';
import '../bloc/social_share_bloc.dart';
import '../widgets/profile_story_card.dart';
import '../widgets/story_cards.dart';

/// Share flow: preview + style selection + privacy toggles + targets.
/// The preview renders the exact widget tree that will be exported.
class ShareStoryScreen extends StatelessWidget {
  const ShareStoryScreen({super.key, this.initialContent});

  /// Content to preview. When null the caller must dispatch
  /// [GenerateStoryPreview] — the view shows a loader until then.
  final StoryContent? initialContent;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SocialShareBloc(
        generator: context.read<StoryImageGenerator>(),
        shareService: context.read<StoryShareService>(),
      )..addMaybePreview(initialContent),
      child: const _ShareView(),
    );
  }
}

extension on SocialShareBloc {
  void addMaybePreview(StoryContent? content) {
    if (content != null) add(GenerateStoryPreview(content));
  }
}

class _ShareView extends StatelessWidget {
  const _ShareView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialShareBloc, SocialShareState>(
      listener: (context, state) {
        if (state is SocialShareSuccess) {
          final msg = switch (state.result.target) {
            ShareTarget.saveImage => 'Story saved to your photos.',
            ShareTarget.systemShare => 'Shared.',
            _ => state.result.usedFallback
                ? 'Opened the share sheet — pick Instagram or Facebook there.'
                : 'Shared to your story.',
          };
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(msg)));
          if (state.result.target == ShareTarget.saveImage) {
            context.pop();
          }
        } else if (state is SocialShareFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is! SocialSharePreviewReady) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final content = state.content;
        final busy = _isBusy(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Share Progress'),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => context.pop(),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    children: [
                      _StoryPreview(content: content),
                      const SizedBox(height: AppSpacing.xl),
                      const _StyleSelector(),
                      const SizedBox(height: AppSpacing.xl),
                      const _PrivacyToggles(),
                      const SizedBox(height: AppSpacing.xxl),
                    ],
                  ),
                ),
                _ShareActions(busy: busy),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isBusy(BuildContext context) {
    final state = context.watch<SocialShareBloc>().state;
    return state is SocialShareSharing || state is SocialShareSaving;
  }
}

class _StoryPreview extends StatelessWidget {
  const _StoryPreview({required this.content});

  final StoryContent content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: SizedBox(
          width: 270,
          height: 480,
          child: RepaintBoundary(
            child: _scaled(content),
          ),
        ),
      ),
    );
  }

  /// Scales the painted 1080x1920 card down to the preview box.
  ///
  /// The card is always laid out at its exact design size inside an
  /// [OverflowBox]; only the painted output is scaled. Scaling the layout
  /// itself (e.g. via FittedBox or loose constraints) clamps the
  /// fixed-pixel design and overflows.
  Widget _scaled(StoryContent content) {
    const previewWidth = 270.0;
    const previewHeight = 480.0;
    const scale = previewWidth / 1080;
    return SizedBox(
      width: previewWidth,
      height: previewHeight,
      child: ClipRect(
        child: OverflowBox(
          maxWidth: 1080,
          maxHeight: 1920,
          alignment: Alignment.topLeft,
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 1080,
              height: 1920,
              child: _card(content),
            ),
          ),
        ),
      ),
    );
  }

  Widget _card(StoryContent content) {
    return switch (content.type) {
      StoryType.profile => ProfileStoryCard(content: content),
      StoryType.workout => WorkoutStoryCard(content: content),
      StoryType.levelUp => LevelUpStoryCard(content: content),
      StoryType.rankUp => RankUpStoryCard(content: content),
      StoryType.personalRecord => PersonalRecordStoryCard(content: content),
      StoryType.achievement => AchievementStoryCard(content: content),
      StoryType.streak => StreakStoryCard(content: content),
      StoryType.challenge => ChallengeStoryCard(content: content),
    };
  }
}

class _StyleSelector extends StatelessWidget {
  const _StyleSelector();

  static const _styles = [
    (StoryStyle.darkAthletic, 'Dark Athletic'),
    (StoryStyle.minimal, 'Minimal'),
    (StoryStyle.neon, 'Neon'),
    (StoryStyle.gradient, 'Gradient'),
    (StoryStyle.spotifyWorkout, 'Spotify Workout'),
  ];

  @override
  Widget build(BuildContext context) {
    final content = (context.watch<SocialShareBloc>().state
            as SocialSharePreviewReady)
        .content;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STYLE',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: AppPalette.textSecondary, letterSpacing: 1.2),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _styles.map((entry) {
            final selected = content.style == entry.$1;
            return GestureDetector(
              onTap: () => context
                  .read<SocialShareBloc>()
                  .add(StoryStyleChanged(entry.$1)),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: selected
                      ? AppPalette.ember.withValues(alpha: 0.14)
                      : AppPalette.surface,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: Border.all(
                    color: selected
                        ? AppPalette.ember
                        : Colors.white.withValues(alpha: 0.07),
                  ),
                ),
                child: Text(
                  entry.$2,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color:
                            selected ? AppPalette.ember : AppPalette.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _PrivacyToggles extends StatelessWidget {
  const _PrivacyToggles();

  @override
  Widget build(BuildContext context) {
    final privacy = (context.watch<SocialShareBloc>().state
            as SocialSharePreviewReady)
        .content
        .privacy;

    final List<(String, bool, SharePrivacyConfig Function(bool))> options = [
      ('Level', privacy.showLevel, (v) => privacy.copyWith(showLevel: v)),
      ('Rank', privacy.showRank, (v) => privacy.copyWith(showRank: v)),
      ('XP', privacy.showXp, (v) => privacy.copyWith(showXp: v)),
      ('Workout Streak', privacy.showStreak,
          (v) => privacy.copyWith(showStreak: v)),
      ('Total Workouts', privacy.showTotalWorkouts,
          (v) => privacy.copyWith(showTotalWorkouts: v)),
      ('Workout Volume', privacy.showVolume,
          (v) => privacy.copyWith(showVolume: v)),
      ('Personal Records', privacy.showPersonalRecords,
          (v) => privacy.copyWith(showPersonalRecords: v)),
      ('QR Code', privacy.showQrCode, (v) => privacy.copyWith(showQrCode: v)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SHARE DETAILS',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: AppPalette.textSecondary, letterSpacing: 1.2),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...options.map(
          (o) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: CheckboxListTile(
              value: o.$2,
              onChanged: (v) => context
                  .read<SocialShareBloc>()
                  .add(StoryPrivacyChanged(o.$3(v ?? false))),
              title: Text(
                o.$1,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              activeColor: AppPalette.ember,
            ),
          ),
        ),
      ],
    );
  }
}

class _ShareActions extends StatelessWidget {
  const _ShareActions({required this.busy});

  final bool busy;

  @override
  Widget build(BuildContext context) {
    final share = context.read<SocialShareBloc>();
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: busy ? 'SHARING…' : 'SHARE',
            icon: Icons.ios_share_rounded,
            enabled: !busy,
            onPressed: () => share.add(const ShareStory(ShareTarget.systemShare)),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: 'INSTAGRAM',
                  onPressed: busy
                      ? null
                      : () => share
                          .add(const ShareStory(ShareTarget.instagramStory)),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: SecondaryButton(
                  label: 'FACEBOOK',
                  onPressed: busy
                      ? null
                      : () => share
                          .add(const ShareStory(ShareTarget.facebookStory)),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: SecondaryButton(
                  label: 'SAVE',
                  icon: Icons.save_alt_rounded,
                  onPressed: busy
                      ? null
                      : () => share.add(const ShareStory(ShareTarget.saveImage)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
