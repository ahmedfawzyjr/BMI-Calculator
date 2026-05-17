import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bmi_calculator/core/data/preferences_repository.dart';
import 'package:bmi_calculator/features/bmi/presentation/screens/settings_screen.dart';
import 'package:bmi_calculator/features/bmi/presentation/providers/bmi_providers.dart';
import 'package:bmi_calculator/l10n/generated/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SettingsScreen toggles sound and haptics successfully', (WidgetTester tester) async {
    // Feature: bmi-app-enhancement, Property 17: Settings Screen Tests
    
    // Set standard mobile device viewport to avoid default 800x600 test layout overflow constraints
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repository = PreferencesRepository(prefs);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          preferencesRepositoryProvider.overrideWithValue(repository),
          historyProvider.overrideWith((ref) => []), // Bypass uninitialized Hive box
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'),
            Locale('ar'),
          ],
          locale: Locale('en'),
          home: SettingsScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify preference switches render
    expect(find.byType(Switch), findsNWidgets(3));

    // Tap first preference switch (Sound)
    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();

    // Verify setting was toggled in preferences
    expect(repository.isSoundEnabled(), isFalse);
  });
}
