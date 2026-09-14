import 'package:flutter/material.dart';

import '../theme/tokens.dart';

/// Geometry of the app shell chrome (bottom nav + mini-player slot +
/// system safe area) so tab scroll views always end above it.
///
/// Every scrollable rendered inside [AppShell] must use [tabPadding] (or
/// at least [tabBottom]) as its bottom inset — otherwise the last items
/// slide under the nav bar and can never be revealed.
abstract final class ShellChrome {
  /// Fixed height of the bottom navigation bar.
  static const double navHeight = 68;

  /// Reserved slot for the persistent mini player. Always reserved (even
  /// when nothing plays) so appearing/disappearing never shifts content.
  static const double playerSlotHeight = 64;

  /// Bottom inset for tab scroll views.
  static double tabBottom(BuildContext context) =>
      MediaQuery.paddingOf(context).bottom +
      navHeight +
      playerSlotHeight +
      AppSpacing.lg;

  /// Full list padding for tab scroll views.
  static EdgeInsets tabPadding(BuildContext context,
          {double top = AppSpacing.md}) =>
      EdgeInsets.fromLTRB(
        AppSpacing.lg,
        top,
        AppSpacing.lg,
        tabBottom(context),
      );
}
