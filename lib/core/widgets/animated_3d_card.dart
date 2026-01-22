import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';

/// A card that responds to gestures with a 3D tilt effect
class Animated3DCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final Color? backgroundColor;
  final bool isSelected;
  final VoidCallback? onTap;
  final double maxTilt;
  final EdgeInsetsGeometry? margin;

  const Animated3DCard({
    super.key,
    required this.child,
    this.borderRadius = 15.0,
    this.backgroundColor,
    this.isSelected = false,
    this.onTap,
    this.maxTilt = 0.1,
    this.margin,
  });

  @override
  State<Animated3DCard> createState() => _Animated3DCardState();
}

class _Animated3DCardState extends State<Animated3DCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _rotateX = 0;
  double _rotateY = 0;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.normal,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final size = context.size;
    if (size == null) return;

    setState(() {
      _rotateY = (details.localPosition.dx - size.width / 2) / 
                 size.width * widget.maxTilt;
      _rotateX = -(details.localPosition.dy - size.height / 2) / 
                  size.height * widget.maxTilt;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _rotateX = 0;
      _rotateY = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.backgroundColor ?? 
        (widget.isSelected ? AppColors.activeCard : AppColors.inactiveCard);

    return GestureDetector(
      onTap: widget.onTap,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        margin: widget.margin ?? const EdgeInsets.all(16.0),
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_rotateX)
          ..rotateY(_rotateY),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(_rotateY * 20, _rotateX * -20 + 5),
            ),
            if (widget.isSelected)
              BoxShadow(
                color: AppColors.hotPink.withOpacity(0.3),
                blurRadius: 25,
                spreadRadius: 2,
              ),
          ],
          border: widget.isSelected
              ? Border.all(
                  color: AppColors.hotPink.withOpacity(0.5),
                  width: 2,
                )
              : null,
        ),
        child: widget.child,
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
