import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';
import 'package:bmi_calculator/features/bmi/domain/bmi_category.dart';

/// Animated BMI gauge with needle animation
class BMIGauge extends StatefulWidget {
  final double bmiValue;
  final BMICategory category;
  final Duration animationDuration;

  const BMIGauge({
    super.key,
    required this.bmiValue,
    required this.category,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  @override
  State<BMIGauge> createState() => _BMIGaugeState();
}

class _BMIGaugeState extends State<BMIGauge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _needleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    
    _needleAnimation = Tween<double>(
      begin: 0,
      end: _bmiToAngle(widget.bmiValue),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _bmiToAngle(double bmi) {
    // Map BMI 10-40 to angle -135 to +135 degrees
    final clampedBmi = bmi.clamp(10.0, 40.0);
    final normalized = (clampedBmi - 10) / 30;
    return -135 + (normalized * 270);
  }

  Color _getCategoryColor() {
    switch (widget.category) {
      case BMICategory.underweight:
        return AppColors.underweight;
      case BMICategory.normal:
        return AppColors.normal;
      case BMICategory.overweight:
        return AppColors.overweight;
      case BMICategory.obese:
        return AppColors.obese;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _needleAnimation,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(280, 180),
          painter: _BMIGaugePainter(
            needleAngle: _needleAnimation.value,
            categoryColor: _getCategoryColor(),
          ),
        );
      },
    )
        .animate()
        .fadeIn(duration: AppAnimations.slow)
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          curve: Curves.easeOutBack,
        );
  }
}

class _BMIGaugePainter extends CustomPainter {
  final double needleAngle;
  final Color categoryColor;

  _BMIGaugePainter({
    required this.needleAngle,
    required this.categoryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 20);
    final radius = size.width / 2 - 30;

    // Draw background arc
    _drawBackgroundArc(canvas, center, radius);
    
    // Draw colored segments
    _drawColoredSegments(canvas, center, radius);
    
    // Draw tick marks
    _drawTickMarks(canvas, center, radius);
    
    // Draw needle
    _drawNeedle(canvas, center, radius);
    
    // Draw center cap
    _drawCenterCap(canvas, center);
  }

  void _drawBackgroundArc(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 0.75,
      math.pi * 1.5,
      false,
      paint,
    );
  }

  void _drawColoredSegments(Canvas canvas, Offset center, double radius) {
    final segments = [
      (AppColors.underweight, 0.0, 0.25),
      (AppColors.normal, 0.25, 0.25),
      (AppColors.overweight, 0.5, 0.25),
      (AppColors.obese, 0.75, 0.25),
    ];

    for (final segment in segments) {
      final paint = Paint()
        ..color = segment.$1
        ..style = PaintingStyle.stroke
        ..strokeWidth = 15
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        math.pi * 0.75 + (math.pi * 1.5 * segment.$2),
        math.pi * 1.5 * segment.$3,
        false,
        paint,
      );
    }
  }

  void _drawTickMarks(Canvas canvas, Offset center, double radius) {
    final tickPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..strokeWidth = 2;

    for (int i = 0; i <= 6; i++) {
      final angle = math.pi * 0.75 + (math.pi * 1.5 * i / 6);
      final outer = center + Offset(
        math.cos(angle) * (radius + 15),
        math.sin(angle) * (radius + 15),
      );
      final inner = center + Offset(
        math.cos(angle) * (radius + 5),
        math.sin(angle) * (radius + 5),
      );
      canvas.drawLine(inner, outer, tickPaint);
    }
  }

  void _drawNeedle(Canvas canvas, Offset center, double radius) {
    final angle = (needleAngle - 90) * math.pi / 180;
    
    // Needle shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    
    final shadowEnd = center + Offset(
      math.cos(angle) * (radius - 10) + 3,
      math.sin(angle) * (radius - 10) + 3,
    );
    canvas.drawLine(center, shadowEnd, shadowPaint..strokeWidth = 4);
    
    // Needle glow
    final glowPaint = Paint()
      ..color = categoryColor.withValues(alpha: 0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)
      ..strokeWidth = 6;
    
    final needleEnd = center + Offset(
      math.cos(angle) * (radius - 10),
      math.sin(angle) * (radius - 10),
    );
    canvas.drawLine(center, needleEnd, glowPaint);
    
    // Main needle
    final needlePaint = Paint()
      ..color = AppColors.hotPink
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, needleEnd, needlePaint);
  }

  void _drawCenterCap(Canvas canvas, Offset center) {
    // Outer glow
    final glowPaint = Paint()
      ..color = AppColors.hotPink.withValues(alpha: 0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawCircle(center, 15, glowPaint);
    
    // Main cap
    final capPaint = Paint()
      ..color = AppColors.activeCard
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 12, capPaint);
    
    // Inner highlight
    final highlightPaint = Paint()
      ..color = AppColors.hotPink;
    canvas.drawCircle(center, 6, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant _BMIGaugePainter oldDelegate) {
    return oldDelegate.needleAngle != needleAngle ||
           oldDelegate.categoryColor != categoryColor;
  }
}
