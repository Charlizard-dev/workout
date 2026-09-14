import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/theme/tokens.dart';
import '../../domain/entities/story_entities.dart';

/// Base layout + typography system for all 9:16 story cards.
/// Rendered inside a fixed 1080x1920 canvas; scaled down for preview.
class StoryCanvas extends StatelessWidget {
  const StoryCanvas({super.key, required this.child, this.style = StoryStyle.darkAthletic});

  final Widget child;
  final StoryStyle style;

  LinearGradient get _bg => switch (style) {
        StoryStyle.minimal => const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF101012), Color(0xFF08080A)]),
        StoryStyle.neon => const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF12043A), Color(0xFF07121A), Color(0xFF1A0530)]),
        StoryStyle.gradient => const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2A0B12), Color(0xFF14060B), Color(0xFF0A0A0D)]),
        StoryStyle.spotifyWorkout => const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D2818), Color(0xFF0A0F0C), Color(0xFF0A0A0D)]),
        _ => const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF15161A), Color(0xFF0C0D10), Color(0xFF0A0A0D)]),
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1080,
      height: 1920,
      decoration: BoxDecoration(gradient: _bg),
      child: Stack(
        children: [
          // Geometric fitness accents.
          Positioned(
            top: -120,
            right: -160,
            child: _glowCircle(420, AppPalette.ember.withValues(alpha: 0.05)),
          ),
          Positioned(
            bottom: -180,
            left: -140,
            child: _glowCircle(520, AppPalette.ember.withValues(alpha: 0.04)),
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }

  Widget _glowCircle(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      );
}

/// Brand footer shared by all story cards. Subtle by design.
class StoryFooter extends StatelessWidget {
  const StoryFooter({super.key, this.slogan = 'TRAIN • LEVEL • REPEAT'});

  final String slogan;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          slogan,
          style: const TextStyle(
            color: Color(0x66FFFFFF),
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: 8,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0x33FFFFFF)),
          ),
          child: const Text(
            'CHARLIZARD',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: 5,
            ),
          ),
        ),
      ],
    );
  }
}

/// Large centered story headline.
///
/// Set [scaleToFit] for user-driven text (names, numbers): the text shrinks
/// to fit instead of overflowing or wrapping. Static labels leave it off.
///
/// Only use inside vertical layout ([Column]); never as a direct child of
/// a [Row] (unbounded width).
class StoryHeadline extends StatelessWidget {
  const StoryHeadline(
      this.text, {
      super.key,
      this.color = Colors.white,
      this.size = 64,
      this.weight = FontWeight.w800,
      this.letterSpacing = 6,
      this.scaleToFit = false,
  });

  final String text;
  final Color color;
  final double size;
  final FontWeight weight;
  final double letterSpacing;
  final bool scaleToFit;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        letterSpacing: letterSpacing,
        height: 1.1,
      ),
      textAlign: TextAlign.center,
      maxLines: scaleToFit ? 1 : null,
      overflow: scaleToFit ? TextOverflow.visible : null,
    );

    if (!scaleToFit) return textWidget;

    // Full-width box so the text shrinks instead of wrapping/overflowing.
    return SizedBox(
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: textWidget,
      ),
    );
  }
}

/// Story-sized XP bar (static, no animation — exported as image).
class StoryXpBar extends StatelessWidget {
  const StoryXpBar({
    super.key,
    required this.progress,
    this.height = 26,
    this.color = AppPalette.ember,
  });

  final double progress;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0x14FFFFFF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          FractionallySizedBox(
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: LinearGradient(colors: [
                  color.withValues(alpha: 0.7),
                  color,
                ]),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.55),
                    blurRadius: 42,
                    spreadRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Avatar for story cards: real photo when available, initials fallback.
///
/// Local gallery paths render via [Image.file]; remote URLs via
/// [Image.network] (best effort — falls back to initials if the image
/// hasn't resolved by export time). Decorative: the card always carries
/// the name as text.
class StoryAvatar extends StatelessWidget {
  const StoryAvatar(
      {super.key, required this.initials, this.photoUrl, this.size = 200});

  final String initials;
  final String? photoUrl;
  final double size;

  bool get _isLocalFile {
    final url = photoUrl;
    if (url == null || url.isEmpty) return false;
    return url.startsWith('/') || url.startsWith('file://');
  }

  bool get _isRemote =>
      (photoUrl?.startsWith('http://') ?? false) ||
      (photoUrl?.startsWith('https://') ?? false);

  @override
  Widget build(BuildContext context) {
    if (photoUrl != null && (_isLocalFile || _isRemote)) {
      final image = _isLocalFile
          ? Image.file(
              File(_isLocalFile && photoUrl!.startsWith('file://')
                  ? Uri.parse(photoUrl!).toFilePath()
                  : photoUrl!),
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _initialsFallback(),
            )
          : Image.network(
              photoUrl!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _initialsFallback(),
            );
      return SizedBox(
        width: size,
        height: size,
        child: ClipOval(child: image),
      );
    }
    return _initialsFallback();
  }

  Widget _initialsFallback() => Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppPalette.emberSoft, AppPalette.emberDeep],
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.34,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
      );
}

/// Highlight stat row used inside story cards.
class StoryStatRow extends StatelessWidget {
  const StoryStatRow({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.color = Colors.white,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 52, color: color),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 62,
                fontWeight: FontWeight.w800,
                height: 1.0,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Color(0x99FFFFFF),
                fontSize: 26,
                fontWeight: FontWeight.w600,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Rank pill with the rank's signature color.
class StoryRankPill extends StatelessWidget {
  const StoryRankPill({super.key, required this.rankName});

  final String rankName;

  Color get color => switch (rankName.toUpperCase()) {
        'ROOKIE' => const Color(0xFF8D99AE),
        'BRONZE' => const Color(0xFFB08D57),
        'SILVER' => const Color(0xFFBFC9D9),
        'GOLD' => const Color(0xFFFFC940),
        'PLATINUM' => const Color(0xFF9AE6D8),
        'DIAMOND' => const Color(0xFF6FD3FF),
        'MASTER' => const Color(0xFFB39DFF),
        'ELITE' => const Color(0xFFFF7AB8),
        _ => const Color(0xFFFF4D2E),
      };

  @override
  Widget build(BuildContext context) {
    final c = color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: c.withValues(alpha: 0.12),
        border: Border.all(color: c.withValues(alpha: 0.7), width: 2.5),
      ),
      child: Text(
        rankName.toUpperCase(),
        style: TextStyle(
          color: c,
          fontSize: 40,
          fontWeight: FontWeight.w800,
          letterSpacing: 8,
        ),
      ),
    );
  }
}
