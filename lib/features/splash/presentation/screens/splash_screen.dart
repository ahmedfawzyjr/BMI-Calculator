import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';

/// Premium animated splash screen with particles and 3D effects
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.deepSpaceStart,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: AppGradients.background,
            ),
          ),
          
          // Particle effect background
          CircularParticle(
            width: size.width,
            height: size.height,
            particleColor: AppColors.hotPink.withOpacity(0.3),
            numberOfParticles: 80,
            speedOfParticles: 1.5,
            maxParticleSize: 4,
            awayRadius: 0,
            onTapAnimation: false,
            isRandom: true,
            isRandomColor: true,
            randColorList: [
              AppColors.hotPink.withOpacity(0.3),
              AppColors.electricCyan.withOpacity(0.3),
              AppColors.neonGreen.withOpacity(0.2),
              Colors.white.withOpacity(0.2),
            ],
            connectDots: true,
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
                            color: AppColors.hotPink.withOpacity(0.5),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                          BoxShadow(
                            color: AppColors.hotPink.withOpacity(0.3),
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
                  baseColor: Colors.white,
                  highlightColor: AppColors.electricCyan,
                  period: const Duration(milliseconds: 2000),
                  child: Text(
                    'BMI Calculator',
                    style: AppTextStyles.headlineLarge,
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
                    color: AppColors.textSecondary,
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
                      AppColors.hotPink.withOpacity(0.7),
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
