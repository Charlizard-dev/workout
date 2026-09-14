import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/story_entities.dart';
import '../../presentation/widgets/profile_story_card.dart';
import '../../presentation/widgets/story_cards.dart';
import 'story_overlay_accessor.dart';
import '../datasources/story_datasources.dart';

/// Renders story widgets offscreen to 1080x1920 PNGs.
///
/// Pipeline: Story widget (exact 1080x1920, never scaled during layout) →
/// RepaintBoundary → RenderRepaintBoundary → ui.Image → PNG bytes → temp
/// file.
///
/// The card MUST be laid out with tight 1080x1920 constraints. Laying it
/// out smaller (e.g. inside a FittedBox or under loose constraints) clamps
/// the fixed-pixel design while fonts stay huge, which overflows.
class StoryImageGeneratorImpl implements StoryImageGenerator {
  /// Exact export canvas. Matches every StoryCanvas.
  static const Size exportSize = Size(1080, 1920);

  @override
  Future<Either<Failure, StoryImage>> generate(StoryContent content) => guard(
        () async {
          final repaintKey = GlobalKey();

          final overlayEntry = OverlayEntry(
            builder: (context) => Positioned(
              left: -2400,
              top: -2400,
              width: exportSize.width,
              height: exportSize.height,
              child: RepaintBoundary(
                key: repaintKey,
                child: MediaQuery(
                  data: const MediaQueryData(size: exportSize),
                  child: Material(
                    color: Colors.transparent,
                    child: SizedBox.fromSize(
                      size: exportSize,
                      child: _rawCardFor(content),
                    ),
                  ),
                ),
              ),
            ),
          );

          // We need an Overlay to insert into; the router's root overlay
          // is accessed through the navigatorKey registered in DI.
          final overlay = storyOverlayAccessor?.call();
          if (overlay == null) {
            throw const ImageExportFailure();
          }

          overlay.insert(overlayEntry);
          try {
            // Build offstage, wait a frame, rasterize.
            await Future<void>.delayed(const Duration(milliseconds: 120));

            var renderBoundary = repaintKey.currentContext
                ?.findRenderObject() as RenderRepaintBoundary?;
            if (renderBoundary == null || renderBoundary.debugNeedsPaint) {
              await Future<void>.delayed(const Duration(milliseconds: 120));
              renderBoundary = repaintKey.currentContext?.findRenderObject()
                  as RenderRepaintBoundary?;
            }

            if (renderBoundary == null) {
              throw const ImageExportFailure();
            }

            final ui.Image rawImage =
                await renderBoundary.toImage(pixelRatio: 1);
            final ByteData? data =
                await rawImage.toByteData(format: ui.ImageByteFormat.png);
            if (data == null) {
              rawImage.dispose();
              throw const ImageExportFailure();
            }

            final bytes = data.buffer.asUint8List();
            final image = StoryImage(
              bytes: bytes,
              width: rawImage.width,
              height: rawImage.height,
              filePath: await _writeTempFile(bytes),
            );
            rawImage.dispose();
            return image;
          } finally {
            overlayEntry.remove();
          }
        },
      );

  Future<String> _writeTempFile(Uint8List bytes) async {
    // Write to temp file for native share channels.
    final tempDir = await getTemporaryDirectory();
    final fileName =
        'charlizard_story_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(bytes);
    await file.length(); // flush
    return file.path;
  }

  @override
  WidgetBuilder previewBuilder(StoryContent content) {
    // Exact-size card; callers scale the painted output (never the layout).
    return (_) => SizedBox.fromSize(
          size: exportSize,
          child: _rawCardFor(content),
        );
  }

  Widget _rawCardFor(StoryContent content) {
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

