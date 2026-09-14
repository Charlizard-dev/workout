import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'tokens.dart';

/// Dark-first premium athletic theme.
///
/// The app is intentionally dark-primary; a light theme is not shipped in v1
/// to keep the visual identity focused and consistent.
abstract final class AppTheme {
  static const String _fontFamily = 'Inter';

  static ThemeData get dark {
    const ColorScheme scheme = ColorScheme.dark(
      primary: AppPalette.ember,
      onPrimary: Colors.white,
      secondary: AppPalette.emberSoft,
      onSecondary: Colors.black,
      error: AppPalette.danger,
      onError: Colors.white,
      surface: AppPalette.surface,
      onSurface: AppPalette.textPrimary,
      surfaceContainerHighest: AppPalette.surfaceHighest,
    );

    final ThemeData base = ThemeData(
      useMaterial3: true,
      fontFamily: _fontFamily,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppPalette.charcoal,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: AppPalette.textPrimary,
        ),
      ),
    );

    return base.copyWith(
      textTheme: _textTheme(base.textTheme),
      dividerTheme: const DividerThemeData(
        color: Color(0x0FFFFFFF),
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppPalette.surfaceHighest,
        contentTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: AppPalette.textPrimary,
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: AppPalette.surfaceHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.lg)),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppPalette.surfaceHigh,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: AppPalette.surfaceHigh,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
        ),
      ),
    );
  }

  /// Compact, athletic type ramp. Sizes are intentionally tighter than
  /// Material defaults to keep information density high.
  static TextTheme _textTheme(TextTheme base) {
    TextStyle styled(
      TextStyle? style, {
      FontWeight? weight,
      double? fontSize,
      double? letterSpacing,
      double? height,
    }) =>
        (style ?? const TextStyle()).copyWith(
          fontFamily: _fontFamily,
          fontWeight: weight,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          height: height,
        );

    return base
        .copyWith(
          displayLarge: styled(base.displayLarge, weight: FontWeight.w800, fontSize: 52, height: 1.05, letterSpacing: -1.5),
          displayMedium: styled(base.displayMedium, weight: FontWeight.w800, fontSize: 42, height: 1.1, letterSpacing: -1.2),
          displaySmall: styled(base.displaySmall, weight: FontWeight.w800, fontSize: 34, height: 1.15, letterSpacing: -0.8),
          headlineLarge: styled(base.headlineLarge, weight: FontWeight.w800, fontSize: 30, height: 1.2, letterSpacing: -0.5),
          headlineMedium: styled(base.headlineMedium, weight: FontWeight.w700, fontSize: 26, height: 1.2, letterSpacing: -0.4),
          headlineSmall: styled(base.headlineSmall, weight: FontWeight.w700, fontSize: 22, height: 1.25, letterSpacing: -0.3),
          titleLarge: styled(base.titleLarge, weight: FontWeight.w700, fontSize: 19, height: 1.3),
          titleMedium: styled(base.titleMedium, weight: FontWeight.w700, fontSize: 16, height: 1.35, letterSpacing: -0.2),
          titleSmall: styled(base.titleSmall, weight: FontWeight.w600, fontSize: 14, height: 1.35, letterSpacing: -0.1),
          bodyLarge: styled(base.bodyLarge, weight: FontWeight.w400, fontSize: 16, height: 1.5),
          bodyMedium: styled(base.bodyMedium, weight: FontWeight.w400, fontSize: 14, height: 1.5),
          bodySmall: styled(base.bodySmall, weight: FontWeight.w400, fontSize: 12, height: 1.45),
          labelLarge: styled(base.labelLarge, weight: FontWeight.w700, fontSize: 14, height: 1.3, letterSpacing: 0.2),
          labelMedium: styled(base.labelMedium, weight: FontWeight.w700, fontSize: 12, height: 1.3, letterSpacing: 0.4),
          labelSmall: styled(base.labelSmall, weight: FontWeight.w700, fontSize: 10.5, height: 1.3, letterSpacing: 0.6),
        )
        .apply(
          bodyColor: AppPalette.textPrimary,
          displayColor: AppPalette.textPrimary,
        );
  }
}
