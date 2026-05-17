import 'package:flutter/material.dart';
import 'package:bmi_calculator/features/bmi/presentation/screens/input_page.dart';
import 'package:bmi_calculator/features/bmi/presentation/screens/result_page.dart';
import 'package:bmi_calculator/features/bmi/presentation/screens/history_screen.dart';
import 'package:bmi_calculator/features/bmi/presentation/screens/settings_screen.dart';
import 'package:bmi_calculator/features/splash/presentation/screens/splash_screen.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';

import 'package:go_router/go_router.dart';

/// Premium page transition with fade and scale
CustomTransitionPage<void> _buildPremiumTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: AppAnimations.normal,
    reverseTransitionDuration: AppAnimations.fast,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fadeAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      final scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      );
      
      return FadeTransition(
        opacity: fadeAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: child,
        ),
      );
    },
  );
}

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) => _buildPremiumTransition(
        context: context,
        state: state,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => _buildPremiumTransition(
        context: context,
        state: state,
        child: const InputPage(),
      ),
    ),
    GoRoute(
      path: '/result',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return _buildPremiumTransition(
          context: context,
          state: state,
          child: ResultPage(
            bmi: extra['bmi'],
            category: extra['category'],
            textColor: extra['textColor'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/history',
      pageBuilder: (context, state) => _buildPremiumTransition(
        context: context,
        state: state,
        child: const HistoryScreen(),
      ),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) => _buildPremiumTransition(
        context: context,
        state: state,
        child: const SettingsScreen(),
      ),
    ),
  ],
);
