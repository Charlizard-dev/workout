import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/story_datasources.dart';
import '../../domain/entities/story_entities.dart';

sealed class SocialShareEvent extends Equatable {
  const SocialShareEvent();

  @override
  List<Object?> get props => [];
}

/// Generate a preview for the given content (updates style/privacy too).
final class GenerateStoryPreview extends SocialShareEvent {
  const GenerateStoryPreview(this.content);

  final StoryContent content;

  @override
  List<Object?> get props => [content];
}

final class StoryStyleChanged extends SocialShareEvent {
  const StoryStyleChanged(this.style);

  final StoryStyle style;

  @override
  List<Object?> get props => [style];
}

final class StoryPrivacyChanged extends SocialShareEvent {
  const StoryPrivacyChanged(this.privacy);

  final SharePrivacyConfig privacy;

  @override
  List<Object?> get props => [privacy];
}

final class ShareStory extends SocialShareEvent {
  const ShareStory(this.target);

  final ShareTarget target;

  @override
  List<Object?> get props => [target];
}

sealed class SocialShareState extends Equatable {
  const SocialShareState();

  @override
  List<Object?> get props => [];
}

final class SocialShareInitial extends SocialShareState {
  const SocialShareInitial();

  @override
  List<Object?> get props => [];
}

final class SocialShareGenerating extends SocialShareState {
  const SocialShareGenerating();

  @override
  List<Object?> get props => [];
}

/// Preview ready: widget visible; PNG generated lazily on share.
final class SocialSharePreviewReady extends SocialShareState {
  const SocialSharePreviewReady(this.content);

  final StoryContent content;

  @override
  List<Object?> get props => [content];
}

final class SocialShareSharing extends SocialShareState {
  const SocialShareSharing(this.target);

  final ShareTarget target;

  @override
  List<Object?> get props => [target];
}

final class SocialShareSaving extends SocialShareState {
  const SocialShareSaving();
}

final class SocialShareSuccess extends SocialShareState {
  const SocialShareSuccess(this.result);

  final StoryShareResult result;

  @override
  List<Object?> get props => [result];
}

final class SocialShareFailure extends SocialShareState {
  const SocialShareFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Drives the story sharing flow: preview → (style/privacy tweaks) →
/// generate PNG → share/save. All platform work lives in the service;
/// widgets only dispatch events.
class SocialShareBloc extends Bloc<SocialShareEvent, SocialShareState> {
  SocialShareBloc({
    required StoryImageGenerator generator,
    required StoryShareService shareService,
  })  : _generator = generator, // ignore: prefer_initializing_formals
        _share = shareService,
        super(const SocialShareInitial()) {
    on<GenerateStoryPreview>(_onGeneratePreview);
    on<StoryStyleChanged>(_onStyleChanged);
    on<StoryPrivacyChanged>(_onPrivacyChanged);
    on<ShareStory>(_onShare);
  }

  final StoryImageGenerator _generator;
  final StoryShareService _share;

  void _onGeneratePreview(
      GenerateStoryPreview event, Emitter<SocialShareState> emit) {
    emit(SocialSharePreviewReady(event.content));
  }

  void _onStyleChanged(
      StoryStyleChanged event, Emitter<SocialShareState> emit) {
    final state = this.state;
    if (state is! SocialSharePreviewReady) return;
    emit(SocialSharePreviewReady(
        state.content.copyWith(style: event.style)));
  }

  void _onPrivacyChanged(
      StoryPrivacyChanged event, Emitter<SocialShareState> emit) {
    final state = this.state;
    if (state is! SocialSharePreviewReady) return;
    emit(SocialSharePreviewReady(
        state.content.copyWith(privacy: event.privacy)));
  }

  Future<void> _onShare(ShareStory event, Emitter<SocialShareState> emit) async {
    final state = this.state;
    if (state is! SocialSharePreviewReady) return;

    emit(event.target == ShareTarget.saveImage
        ? const SocialShareSaving()
        : SocialShareSharing(event.target));

    // Rasterize the current preview content.
    final generated = await _generator.generate(state.content);

    await generated.fold(
      (failure) async => emit(SocialShareFailure(failure.message)),
      (image) async {
        final result = switch (event.target) {
          ShareTarget.instagramStory =>
            await _share.shareToInstagramStory(image),
          ShareTarget.facebookStory =>
            await _share.shareToFacebookStory(image),
          ShareTarget.systemShare => await _share.shareViaSystemSheet(image),
          ShareTarget.saveImage => await _share.saveToGallery(image),
        };

        result.fold(
          (failure) => emit(SocialShareFailure(failure.message)),
          (r) => emit(SocialShareSuccess(r)),
        );
      },
    );
  }
}

extension _ContentCopy on StoryContent {
  StoryContent copyWith({StoryStyle? style, SharePrivacyConfig? privacy}) =>
      StoryContent(
        type: type,
        style: style ?? this.style,
        privacy: privacy ?? this.privacy,
        userName: userName,
        userInitials: userInitials,
        photoUrl: photoUrl,
        level: level,
        rankName: rankName,
        titleName: titleName,
        currentXp: currentXp,
        xpForNextLevel: xpForNextLevel,
        lifetimeXp: lifetimeXp,
        streakDays: streakDays,
        totalWorkouts: totalWorkouts,
        badgeCount: badgeCount,
        workoutName: workoutName,
        workoutDuration: workoutDuration,
        workoutSets: workoutSets,
        workoutVolumeKg: workoutVolumeKg,
        personalRecordCount: personalRecordCount,
        xpEarned: xpEarned,
        newLevel: newLevel,
        oldLevel: oldLevel,
        oldRankName: oldRankName,
        exerciseName: exerciseName,
        prWeightKg: prWeightKg,
        prReps: prReps,
        prPreviousWeightKg: prPreviousWeightKg,
        achievementName: achievementName,
        achievementEmoji: achievementEmoji,
        achievementDescription: achievementDescription,
        challengeTitle: challengeTitle,
        challengeTarget: challengeTarget,
        challengeRewardXp: challengeRewardXp,
        streakMilestoneDays: streakMilestoneDays,
      );
}
