import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';

/// A premium button with continuous pulse animation and gradient
class PulseButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final double height;
  final double? width;
  final bool isPulsing;
  final Gradient? gradient;
  final Color? shadowColor;

  const PulseButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 80,
    this.width,
    this.isPulsing = true,
    this.gradient,
    this.shadowColor,
  });

  @override
  State<PulseButton> createState() => _PulseButtonState();
}

class _PulseButtonState extends State<PulseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    final isTesting = Platform.environment.containsKey('FLUTTER_TEST');
    if (widget.isPulsing && !isTesting) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(PulseButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    final isTesting = Platform.environment.containsKey('FLUTTER_TEST');
    if (widget.isPulsing && !_pulseController.isAnimating && !isTesting) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isPulsing && _pulseController.isAnimating) {
      _pulseController.stop();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final pulseValue = widget.isPulsing ? _pulseController.value : 0.0;
          
          return Container(
            height: widget.height,
            width: widget.width ?? double.infinity,
            decoration: BoxDecoration(
              gradient: widget.gradient ?? AppGradients.primaryButton,
              boxShadow: [
                BoxShadow(
                  color: (widget.shadowColor ?? AppColors.hotPink).withValues(alpha: 0.3 + pulseValue * 0.3),
                  blurRadius: 15 + pulseValue * 15,
                  spreadRadius: pulseValue * 3,
                  offset: const Offset(0, 5),
                ),
                BoxShadow(
                  color: (widget.shadowColor ?? AppColors.hotPink).withValues(alpha: 0.2),
                  blurRadius: 30,
                  spreadRadius: -5,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                widget.text.toUpperCase(),
                style: AppTextStyles.button,
              ),
            ),
          );
        },
      )
          .animate(target: _isPressed ? 1 : 0)
          .scale(
            begin: const Offset(1, 1),
            end: const Offset(0.95, 0.95),
            duration: AppAnimations.fast,
          ),
    );
  }
}

/// Animated gradient button with shimmer effect
class ShimmerButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final double height;
  final IconData? icon;

  const ShimmerButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 56,
    this.icon,
  });

  @override
  State<ShimmerButton> createState() => _ShimmerButtonState();
}

class _ShimmerButtonState extends State<ShimmerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    final isTesting = Platform.environment.containsKey('FLUTTER_TEST');
    if (!isTesting) {
      _shimmerController.repeat();
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _shimmerController,
        builder: (context, child) {
          return Container(
            height: widget.height,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.height / 2),
              color: AppColors.activeCard,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment(-1.0 + _shimmerController.value * 3, 0),
                  end: Alignment(_shimmerController.value * 3, 0),
                  colors: const [
                    Colors.white54,
                    Colors.white,
                    Colors.white54,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ).createShader(bounds);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, color: Colors.white),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.text,
                    style: AppTextStyles.titleLarge.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
