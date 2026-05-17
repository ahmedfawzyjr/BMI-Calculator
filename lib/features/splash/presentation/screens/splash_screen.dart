import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';
import 'package:bmi_calculator/core/services/sound_service.dart';
import 'package:bmi_calculator/core/services/haptic_service.dart';

/// Premium animated splash screen with particles and 3D effects
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _scaleController.forward();
    
    // Play startup audio and haptic feedback
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        ref.read(soundServiceProvider).playLaunch();
        ref.read(hapticServiceProvider).successNotification();
      }
    });
    
    // Navigate to home after splash
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        context.go('/');
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic theme background checks
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.getBgStart(isDark),
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: isDark ? AppGradients.background : AppGradients.lightBackground,
            ),
          ),
          
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 3D rotating logo
                AnimatedBuilder(
                  animation: _rotationController,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(_rotationController.value * 2 * math.pi),
                      child: child,
                    );
                  },
                  child: ScaleTransition(
                    scale: CurvedAnimation(
                      parent: _scaleController,
                      curve: Curves.elasticOut,
                    ),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.hotPink,
                            Color(0xFFFF4081),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.hotPink.withValues(alpha: 0.5),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                          BoxShadow(
                            color: AppColors.hotPink.withValues(alpha: 0.3),
                            blurRadius: 60,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.monitor_weight_outlined,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 50),
                
                // Shimmer text
                Shimmer.fromColors(
                  baseColor: AppColors.getTextPrimary(isDark),
                  highlightColor: AppColors.electricCyan,
                  period: const Duration(milliseconds: 2000),
                  child: Text(
                    'BMI Calculator',
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: AppColors.getTextPrimary(isDark),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: const Duration(milliseconds: 500))
                    .slideY(begin: 0.3, end: 0),
                
                const SizedBox(height: 15),
                
                // Subtitle
                Text(
                  'Premium Edition',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.getTextSecondary(isDark),
                    letterSpacing: 3,
                  ),
                )
                    .animate()
                    .fadeIn(delay: const Duration(milliseconds: 800))
                    .slideY(begin: 0.3, end: 0),
                
                const SizedBox(height: 80),
                
                // Loading indicator
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.hotPink.withValues(alpha: 0.7),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: const Duration(milliseconds: 1200)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
