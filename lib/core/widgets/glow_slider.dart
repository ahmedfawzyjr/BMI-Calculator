import 'package:flutter/material.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';

/// A premium slider with neon glow trail effect
class GlowSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final Color? activeColor;
  final Color? glowColor;
  final String? label;
  final String? unit;

  const GlowSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.activeColor,
    this.glowColor,
    this.label,
    this.unit,
  });

  @override
  State<GlowSlider> createState() => _GlowSliderState();
}

class _GlowSliderState extends State<GlowSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = widget.activeColor ?? AppColors.hotPink;
    final effectiveGlowColor = widget.glowColor ?? effectiveActiveColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: AppTextStyles.labelLarge,
          ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            AnimatedDefaultTextStyle(
              duration: AppAnimations.fast,
              style: AppTextStyles.displayMedium.copyWith(
                color: _isDragging ? effectiveActiveColor : AppColors.textPrimary,
              ),
              child: Text(widget.value.round().toString()),
            ),
            if (widget.unit != null)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  widget.unit!,
                  style: AppTextStyles.labelLarge,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: _isDragging
                    ? [
                        BoxShadow(
                          color: effectiveGlowColor.withOpacity(
                            0.3 + _pulseController.value * 0.2,
                          ),
                          blurRadius: 20 + _pulseController.value * 10,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: child,
            );
          },
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: effectiveActiveColor,
              inactiveTrackColor: AppColors.sliderInactive.withOpacity(0.3),
              thumbColor: effectiveActiveColor,
              overlayColor: effectiveGlowColor.withOpacity(0.3),
              thumbShape: _GlowingThumbShape(
                enabledThumbRadius: _isDragging ? 18 : 15,
                glowColor: effectiveGlowColor,
                isActive: _isDragging,
              ),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 40),
              trackHeight: 6,
              trackShape: _GradientTrackShape(
                activeColor: effectiveActiveColor,
              ),
            ),
            child: Slider(
              value: widget.value,
              min: widget.min,
              max: widget.max,
              onChanged: widget.onChanged,
              onChangeStart: (_) => setState(() => _isDragging = true),
              onChangeEnd: (_) => setState(() => _isDragging = false),
            ),
          ),
        ),
      ],
    );
  }
}

class _GlowingThumbShape extends SliderComponentShape {
  final double enabledThumbRadius;
  final Color glowColor;
  final bool isActive;

  const _GlowingThumbShape({
    required this.enabledThumbRadius,
    required this.glowColor,
    required this.isActive,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    if (isActive) {
      // Outer glow
      final glowPaint = Paint()
        ..color = glowColor.withOpacity(0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
      canvas.drawCircle(center, enabledThumbRadius + 10, glowPaint);

      // Mid glow
      final midGlowPaint = Paint()
        ..color = glowColor.withOpacity(0.6)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(center, enabledThumbRadius + 5, midGlowPaint);
    }

    // Main thumb
    final thumbPaint = Paint()..color = sliderTheme.thumbColor!;
    canvas.drawCircle(center, enabledThumbRadius, thumbPaint);

    // Inner highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.3);
    canvas.drawCircle(
      center.translate(-2, -2),
      enabledThumbRadius * 0.5,
      highlightPaint,
    );
  }
}

class _GradientTrackShape extends SliderTrackShape {
  final Color activeColor;

  const _GradientTrackShape({required this.activeColor});

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight!;
    final trackLeft = offset.dx + 12;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width - 24;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final canvas = context.canvas;
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );

    // Inactive track
    final inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, Radius.circular(trackRect.height / 2)),
      inactivePaint,
    );

    // Active track with gradient
    final activeRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
    );
    
    final activePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          activeColor.withOpacity(0.7),
          activeColor,
        ],
      ).createShader(activeRect)
      ..style = PaintingStyle.fill;
    
    canvas.drawRRect(
      RRect.fromRectAndRadius(activeRect, Radius.circular(trackRect.height / 2)),
      activePaint,
    );
  }
}
