import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/tokens.dart';

/// Primary action button with ember gradient + glow. Athletic, not bubbly.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.enabled = true,
    this.expanded = true,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool enabled;
  final bool expanded;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final disabled = !enabled || onPressed == null;

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: disabled ? AppPalette.textTertiary : Colors.white),
          const SizedBox(width: AppSpacing.sm),
        ],
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              maxLines: 1,
              style: theme.textTheme.labelLarge?.copyWith(
                color: disabled ? AppPalette.textTertiary : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );

    return Semantics(
      button: true,
      enabled: !disabled,
      label: label,
      child: Opacity(
        opacity: disabled ? 0.6 : 1,
        child: Container(
          height: 52,
          constraints: const BoxConstraints(minWidth: double.infinity),
          width: expanded ? double.infinity : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.md),
            gradient: isDestructive
                ? null
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppPalette.ember, AppPalette.emberDeep],
                  ),
            color: isDestructive ? AppPalette.danger : null,
            boxShadow: disabled
                ? null
                : [
                    BoxShadow(
                      color: AppPalette.ember.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.md),
              onTap: disabled ? null : () { HapticFeedback.lightImpact(); onPressed?.call(); },
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}

/// Secondary ghost button on elevated surfaces.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.enabled = true,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool enabled;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final disabled = !enabled || onPressed == null;
    return Semantics(
      button: true,
      enabled: !disabled,
      label: label,
      child: Container(
        height: 48,
        width: expanded ? double.infinity : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.md),
          color: AppPalette.surfaceHighest,
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.md),
            onTap: disabled ? null : onPressed,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 18, color: AppPalette.textSecondary),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(
                              color: disabled
                                  ? AppPalette.textTertiary
                                  : AppPalette.textPrimary,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
