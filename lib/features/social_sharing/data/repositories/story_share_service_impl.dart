import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/story_entities.dart';
import '../datasources/story_datasources.dart';

/// Platform channel for native Instagram/Facebook story sharing where the
/// OS supports it. Registered by the app's composition root.
class StoryShareServiceImpl implements StoryShareService {
  StoryShareServiceImpl({MethodChannel? channel})
      : _channel = channel ?? const MethodChannel('charlizard/story_share');

  static const String _instagramPackage = 'com.instagram.android';
  static const String _facebookPackage = 'com.facebook.katana';

  final MethodChannel _channel;

  @override
  Future<bool> isInstagramAvailable() async {
    if (Platform.isIOS) {
      // iOS: UIActivityViewController lists Instagram stories when installed;
      // we attempt the native route and fall back gracefully.
      return true;
    }
    try {
      final installed = await _channel
          .invokeMethod<bool>('isAppInstalled', {'package': _instagramPackage});
      return installed ?? false;
    } on PlatformException {
      return false;
    }
  }

  @override
  Future<bool> isFacebookAvailable() async {
    if (Platform.isIOS) return true;
    try {
      final installed = await _channel
          .invokeMethod<bool>('isAppInstalled', {'package': _facebookPackage});
      return installed ?? false;
    } on PlatformException {
      return false;
    }
  }

  @override
  Future<Either<Failure, StoryShareResult>> shareToInstagramStory(
      StoryImage image) async {
    // Native story share first; ANY failure falls through to the system
    // sheet so the user never hits a dead end.
    try {
      final installed = await isInstagramAvailable();
      if (installed) {
        final ok = await _channel.invokeMethod<bool>('shareToInstagramStory', {
          'filePath': image.filePath,
          'applicationId': 'com.charlizard',
        });
        if (ok == true) {
          return const Right(StoryShareResult(
              success: true, target: ShareTarget.instagramStory));
        }
      }
    } catch (_) {
      // Fall through to the system share sheet.
    }
    try {
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(image.filePath, mimeType: 'image/png')],
          text: 'My workout progress — Charlizard',
        ),
      );
      return const Right(StoryShareResult(
        success: true,
        target: ShareTarget.instagramStory,
        usedFallback: true,
      ));
    } catch (_) {
      return const Left(
          ShareFailure('Could not share this story. Try saving it instead.'));
    }
  }

  @override
  Future<Either<Failure, StoryShareResult>> shareToFacebookStory(
      StoryImage image) async {
    try {
      final installed = await isFacebookAvailable();
      if (installed) {
        final ok = await _channel.invokeMethod<bool>('shareToFacebookStory', {
          'filePath': image.filePath,
          'applicationId': 'com.charlizard',
        });
        if (ok == true) {
          return const Right(StoryShareResult(
              success: true, target: ShareTarget.facebookStory));
        }
      }
    } catch (_) {
      // Fall through to the system share sheet.
    }
    try {
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(image.filePath, mimeType: 'image/png')],
          text: 'My workout progress — Charlizard',
        ),
      );
      return const Right(StoryShareResult(
        success: true,
        target: ShareTarget.facebookStory,
        usedFallback: true,
      ));
    } catch (_) {
      return const Left(
          ShareFailure('Could not share this story. Try saving it instead.'));
    }
  }

  @override
  Future<Either<Failure, StoryShareResult>> shareViaSystemSheet(
      StoryImage image) async {
    try {
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(image.filePath, mimeType: 'image/png')],
          text: 'My workout progress — Charlizard',
        ),
      );
      return const Right(StoryShareResult(
          success: true, target: ShareTarget.systemShare));
    } catch (_) {
      return const Left(ShareFailure('Could not open the share sheet.'));
    }
  }

  @override
  Future<Either<Failure, StoryShareResult>> saveToGallery(
      StoryImage image) async {
    try {
      final Object? saved =
          await ImageGallerySaver.saveFile(image.filePath);
      final isSuccess =
          saved is Map && saved['isSuccess'] == true;
      if (isSuccess) {
        return const Right(StoryShareResult(
            success: true, target: ShareTarget.saveImage));
      }
      return const Left(
          ShareFailure('Could not save to your photos. Check permissions.'));
    } catch (_) {
      return const Left(
          ShareFailure('Could not save to your photos. Check permissions.'));
    }
  }
}
