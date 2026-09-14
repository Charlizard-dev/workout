import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entities/story_entities.dart';

/// Renders a [StoryContent] into a 1080x1920 PNG via the widget pipeline.
abstract class StoryImageGenerator {
  Future<Either<Failure, StoryImage>> generate(StoryContent content);
  /// Exposes the widget tree for in-app preview at logical size.
  WidgetBuilder previewBuilder(StoryContent content);
}

class StoryImage {
  const StoryImage({required this.bytes, required this.width, required this.height, required this.filePath});

  final Uint8List bytes;
  final int width;
  final int height;
  final String filePath;
}

/// Handles platform share/save destinations.
abstract class StoryShareService {
  /// Instagram Story background share; falls back to system sheet.
  Future<Either<Failure, StoryShareResult>> shareToInstagramStory(StoryImage image);
  /// Facebook Story share; falls back to system sheet.
  Future<Either<Failure, StoryShareResult>> shareToFacebookStory(StoryImage image);
  /// System share sheet.
  Future<Either<Failure, StoryShareResult>> shareViaSystemSheet(StoryImage image);
  /// Saves to the photo gallery (permissions handled internally).
  Future<Either<Failure, StoryShareResult>> saveToGallery(StoryImage image);
  /// Whether direct Instagram story sharing is available on this device.
  Future<bool> isInstagramAvailable();
  /// Whether direct Facebook story sharing is available on this device.
  Future<bool> isFacebookAvailable();
}
