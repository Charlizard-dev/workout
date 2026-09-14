import 'package:flutter/material.dart';

import '../theme/tokens.dart';

/// Animated XP progress bar with glow. Used on dashboard, profile,
/// level-up, and story cards (static variant).
class XpBar extends StatefulWidget {
  const XpBar({
    super.key,
    required this.progress,
    this.height = 10,
    this.animate = true,
    this.glow = true,
    this.color,
  });

  final double progress;
  final double height;
  final bool animate;
  final bool glow;
  final Color? color;

  @override
  State<XpBar> createState() => _XpBarState();
}

class _XpBarState extends State<XpBar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _progressAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(XpBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress && widget.animate) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppPalette.ember;
    return Semantics(
      label: 'XP progress ${(widget.progress * 100).round()} percent',
      child: AnimatedBuilder(
        animation: _progressAnim,
        builder: (context, _) {
          final p = widget.animate
              ? widget.progress * _progressAnim.value
              : widget.progress;
          return Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: AppPalette.track,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                FractionallySizedBox(
                  widthFactor: p.clamp(0.0, 1.0),
                  child: Container(
                    height: widget.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [color.withValues(alpha: 0.75), color],
                      ),
                      boxShadow: widget.glow
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.5),
                                blurRadius: 12,
                                offset: const Offset(0, 0),
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Small circular rank badge.
class RankBadge extends StatelessWidget {
  const RankBadge({super.key, required this.rankName, this.size = 36});

  final String rankName;
  final double size;

  Color get _color => switch (rankName.toUpperCase()) {
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
    final c = _color;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [c.withValues(alpha: 0.28), c.withValues(alpha: 0.06)]),
        border: Border.all(color: c.withValues(alpha: 0.7), width: 1.4),
      ),
      alignment: Alignment.center,
      child: Text(
        rankName.isNotEmpty ? rankName[0].toUpperCase() : '?',
        style: TextStyle(
          color: c,
          fontWeight: FontWeight.w800,
          fontSize: size * 0.42,
        ),
      ),
    );
  }
}
