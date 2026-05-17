import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bmi_calculator/core/data/preferences_repository.dart';
import 'package:bmi_calculator/features/splash/presentation/screens/splash_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SplashScreen renders correct premium elements and navigates', (WidgetTester tester) async {
    // Feature: bmi-app-enhancement, Property 8: Splash Screen
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repository = PreferencesRepository(prefs);

    // Build a lightweight router for the test context
    final testRouter = GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: Text('Home')),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          preferencesRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp.router(
          routerConfig: testRouter,
        ),
      ),
    );

    // Verify it renders the weight icon
    expect(find.byIcon(Icons.monitor_weight_outlined), findsOneWidget);

    // Verify it renders the App title text
    expect(find.text('BMI Calculator'), findsOneWidget);

    // Verify it renders the premium tag
    expect(find.text('Premium Edition'), findsOneWidget);

    // Verify loading indicator is present
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
    // Pump enough duration for both startup sound/haptic and navigation timers to complete
    await tester.pump(const Duration(seconds: 4));
    await tester.pump(); // Render the routed page
    
    // Verify that we successfully navigated to the home screen
    expect(find.text('Home'), findsOneWidget);
  });
}
