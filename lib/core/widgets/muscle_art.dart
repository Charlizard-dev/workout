import 'package:flutter/material.dart';

import '../../features/exercises/domain/entities/exercise.dart';
import '../theme/tokens.dart';

/// Vector line-art tile identifying an exercise's primary muscle group.
///
/// Offline by design (no image assets or URLs): a cohesive stroke icon set
/// in the product palette. Decorative — rows already expose text semantics.
class MuscleArt extends StatelessWidget {
  const MuscleArt({super.key, required this.muscle, this.size = 48});

  final MuscleGroup muscle;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppPalette.surfaceHighest,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        alignment: Alignment.center,
        child: CustomPaint(
          size: Size.square(size * 0.68),
          painter: _painterFor(muscle),
        ),
      ),
    );
  }

  static CustomPainter _painterFor(MuscleGroup muscle) => switch (muscle) {
        MuscleGroup.chest => const _ChestGlyph(),
        MuscleGroup.back => const _BackGlyph(),
        MuscleGroup.shoulders => const _ShouldersGlyph(),
        MuscleGroup.biceps => const _BicepsGlyph(),
        MuscleGroup.triceps => const _TricepsGlyph(),
        MuscleGroup.legs => const _LegsGlyph(),
        MuscleGroup.glutes => const _GlutesGlyph(),
        MuscleGroup.core => const _CoreGlyph(),
        MuscleGroup.cardio => const _CardioGlyph(),
        MuscleGroup.fullBody => const _FullBodyGlyph(),
      };
}

/// Shared stroke setup: 96-unit canvas, round caps, product colors.
abstract class _Glyph extends CustomPainter {
  const _Glyph();

  Paint get bone => Paint()
    ..color = Colors.white.withValues(alpha: 0.92)
    ..strokeWidth = 6.5
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  Paint get ember => Paint()
    ..color = AppPalette.ember
    ..strokeWidth = 6.5
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  Paint get emberFill => Paint()
    ..color = AppPalette.ember
    ..style = PaintingStyle.fill;

  Paint get boneFill => Paint()
    ..color = Colors.white.withValues(alpha: 0.92)
    ..style = PaintingStyle.fill;

  void head(Canvas canvas, double x, double y, [double r = 6.5]) =>
      canvas.drawCircle(Offset(x, y), r, boneFill);

  void line(Canvas canvas, Paint paint, double x1, double y1, double x2, double y2) =>
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 96);
    draw(canvas);
    canvas.restore();
  }

  void draw(Canvas canvas);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Bench press: bar with plates over a bench.
class _ChestGlyph extends _Glyph {
  const _ChestGlyph();

  @override
  void draw(Canvas canvas) {
    line(canvas, bone, 8, 26, 88, 26);
    line(canvas, ember, 20, 15, 20, 37);
    line(canvas, ember, 76, 15, 76, 37);
    line(canvas, bone, 30, 66, 66, 66);
    line(canvas, bone, 36, 66, 36, 82);
    line(canvas, bone, 60, 66, 60, 82);
  }
}

/// Pull-up: figure hanging from a bar.
class _BackGlyph extends _Glyph {
  const _BackGlyph();

  @override
  void draw(Canvas canvas) {
    line(canvas, ember, 14, 18, 82, 18);
    head(canvas, 48, 34);
    line(canvas, bone, 48, 41, 48, 62);
    line(canvas, bone, 48, 47, 30, 20);
    line(canvas, bone, 48, 47, 66, 20);
    line(canvas, bone, 48, 62, 38, 84);
    line(canvas, bone, 48, 62, 58, 84);
  }
}

/// Overhead press: bar locked out above the head.
class _ShouldersGlyph extends _Glyph {
  const _ShouldersGlyph();

  @override
  void draw(Canvas canvas) {
    line(canvas, ember, 16, 20, 80, 20);
    line(canvas, bone, 26, 12, 26, 28);
    line(canvas, bone, 70, 12, 70, 28);
    head(canvas, 48, 40);
    line(canvas, bone, 48, 47, 48, 68);
    line(canvas, bone, 48, 52, 37, 24);
    line(canvas, bone, 48, 52, 59, 24);
    line(canvas, bone, 48, 68, 40, 86);
    line(canvas, bone, 48, 68, 56, 86);
  }
}

/// Flexed arm: fist curled toward the shoulder.
class _BicepsGlyph extends _Glyph {
  const _BicepsGlyph();

  @override
  void draw(Canvas canvas) {
    line(canvas, bone, 30, 78, 30, 46);
    line(canvas, bone, 30, 46, 56, 32);
    canvas.drawCircle(const Offset(62, 29), 8, emberFill);
    line(canvas, bone, 30, 78, 52, 78);
    line(canvas, ember, 44, 62, 52, 56);
  }
}

/// Dip: torso between parallel bars.
class _TricepsGlyph extends _Glyph {
  const _TricepsGlyph();

  @override
  void draw(Canvas canvas) {
    line(canvas, ember, 26, 14, 26, 82);
    line(canvas, ember, 70, 14, 70, 82);
    head(canvas, 48, 26);
    line(canvas, bone, 48, 33, 48, 58);
    line(canvas, bone, 48, 42, 28, 54);
    line(canvas, bone, 48, 42, 68, 54);
    line(canvas, bone, 48, 58, 42, 80);
    line(canvas, bone, 48, 58, 54, 80);
  }
}

/// Back squat: bar across the shoulders, knees bent.
class _LegsGlyph extends _Glyph {
  const _LegsGlyph();

  @override
  void draw(Canvas canvas) {
    line(canvas, bone, 24, 30, 72, 30);
    line(canvas, ember, 30, 21, 30, 39);
    line(canvas, ember, 66, 21, 66, 39);
    head(canvas, 48, 42);
    line(canvas, bone, 48, 49, 48, 62);
    line(canvas, bone, 48, 54, 32, 33);
    line(canvas, bone, 48, 54, 64, 33);
    line(canvas, bone, 48, 62, 36, 72);
    line(canvas, bone, 36, 72, 38, 86);
    line(canvas, bone, 48, 62, 60, 72);
    line(canvas, bone, 60, 72, 58, 86);
  }
}

/// Hip thrust: shoulders grounded, hips driven up under a bar.
class _GlutesGlyph extends _Glyph {
  const _GlutesGlyph();

  @override
  void draw(Canvas canvas) {
    line(canvas, bone, 10, 80, 86, 80);
    line(canvas, bone, 22, 78, 44, 60);
    head(canvas, 18, 70);
    line(canvas, ember, 34, 52, 66, 45);
    line(canvas, bone, 44, 60, 66, 64);
    line(canvas, bone, 66, 64, 70, 80);
  }
}

/// Plank: rigid diagonal line, arms stacked under shoulders.
class _CoreGlyph extends _Glyph {
  const _CoreGlyph();

  @override
  void draw(Canvas canvas) {
    head(canvas, 80, 40);
    line(canvas, bone, 74, 44, 24, 60);
    line(canvas, bone, 32, 57, 32, 80);
    line(canvas, ember, 14, 80, 82, 80);
  }
}

/// Heartbeat pulse line.
class _CardioGlyph extends _Glyph {
  const _CardioGlyph();

  @override
  void draw(Canvas canvas) {
    final path = Path()
      ..moveTo(6, 50)
      ..lineTo(28, 50)
      ..lineTo(37, 26)
      ..lineTo(47, 70)
      ..lineTo(57, 38)
      ..lineTo(64, 50)
      ..lineTo(90, 50);
    canvas.drawPath(path, ember);
  }
}

/// Kettlebell: handle arc over a round body.
class _FullBodyGlyph extends _Glyph {
  const _FullBodyGlyph();

  @override
  void draw(Canvas canvas) {
    final handle = Path()..moveTo(34, 46)..cubicTo(34, 20, 62, 20, 62, 46);
    canvas.drawPath(handle, bone);
    canvas.drawCircle(const Offset(48, 62), 16, bone);
    canvas.drawCircle(const Offset(48, 62), 10, Paint()..color = AppPalette.surfaceHighest);
    canvas.drawCircle(const Offset(48, 62), 4, emberFill);
  }
}
