import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';

/// Animated counter button with bounce effect and glow
class CounterButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double size;

  const CounterButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size = 56,
  });

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.color ?? AppColors.hotPink;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isPressed 
              ? effectiveColor.withValues(alpha: 0.8) 
              : AppColors.inactiveCard,
          border: Border.all(
            color: effectiveColor.withValues(alpha: _isPressed ? 0.8 : 0.3),
            width: 2,
          ),
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: effectiveColor.withValues(alpha: 0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Icon(
          widget.icon,
          color: _isPressed ? Colors.white : effectiveColor,
          size: widget.size * 0.4,
        ),
      )
          .animate(target: _isPressed ? 1 : 0)
          .scale(
            begin: const Offset(1, 1),
            end: const Offset(0.9, 0.9),
            duration: const Duration(milliseconds: 100),
          ),
    );
  }
}

/// Animated number display with flip animation
class AnimatedCounter extends StatelessWidget {
  final int value;
  final TextStyle? style;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: value, end: value),
      duration: duration,
      builder: (context, animatedValue, child) {
        return Text(
          animatedValue.toString(),
          style: style ?? AppTextStyles.displayMedium,
        )
            .animate(
              onPlay: (controller) => controller.forward(from: 0),
            )
            .scale(
              begin: const Offset(1.2, 1.2),
              end: const Offset(1, 1),
              duration: const Duration(milliseconds: 150),
              curve: Curves.elasticOut,
            );
      },
    );
  }
}

/// Counter widget with +/- buttons and animated value
class AnimatedCounterWidget extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int minValue;
  final int maxValue;
  final Color? activeColor;

  const AnimatedCounterWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    this.minValue = 0,
    this.maxValue = 200,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(
          label,
          style: AppTextStyles.labelLarge,
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: value.toDouble(), end: value.toDouble()),
          duration: AppAnimations.fast,
          builder: (context, animValue, child) {
            return Text(
              value.toString(),
              style: AppTextStyles.displayMedium,
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CounterButton(
              icon: Icons.remove,
              onPressed: value > minValue ? onDecrement : () {},
              color: value > minValue 
                  ? (activeColor ?? AppColors.hotPink) 
                  : AppColors.sliderInactive,
            ),
            const SizedBox(width: 20),
            CounterButton(
              icon: Icons.add,
              onPressed: value < maxValue ? onIncrement : () {},
              color: value < maxValue 
                  ? (activeColor ?? AppColors.hotPink) 
                  : AppColors.sliderInactive,
            ),
          ],
        ),
      ],
    ),
  );
}
}
