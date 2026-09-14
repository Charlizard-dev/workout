import 'package:flutter/material.dart';

/// Centralized design tokens for the Charlizard design system.
///
/// All spacing, radii, and durations scale from a single source so the
/// product stays visually consistent as it grows.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
}

abstract final class AppRadius {
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double pill = 999;
}

abstract final class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration levelUp = Duration(milliseconds: 1400);
}

abstract final class AppPalette {
  // Backgrounds
  static const Color charcoal = Color(0xFF0A0B0D);
  static const Color surface = Color(0xFF121316);
  static const Color surfaceHigh = Color(0xFF1A1C21);
  static const Color surfaceHighest = Color(0xFF232630);

  // Text
  static const Color textPrimary = Color(0xFFF5F6FA);
  static const Color textSecondary = Color(0xFF9AA0B0);
  static const Color textTertiary = Color(0xFF6B7280);

  // Brand / fitness accent
  static const Color ember = Color(0xFFFF4D2E);
  static const Color emberDeep = Color(0xFFE03A1B);
  static const Color emberSoft = Color(0xFFFF7A5C);

  // Semantic
  static const Color success = Color(0xFF34D399);
  static const Color warning = Color(0xFFFBBF24);
  static const Color danger = Color(0xFFFF5A5F);
  static const Color info = Color(0xFF60A5FA);

  // Spotify (reserved exclusively for Spotify surfaces)
  static const Color spotify = Color(0xFF1DB954);
  static const Color spotifySurface = Color(0xFF121816);

  // Streak
  static const Color streak = Color(0xFFFF6B35);

  // Progress track
  static const Color track = Color(0xFF1F2127);
}
