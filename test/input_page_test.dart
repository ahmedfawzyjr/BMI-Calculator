import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/core/data/preferences_repository.dart';
import 'package:bmi_calculator/features/bmi/presentation/screens/input_page.dart';
import 'package:bmi_calculator/features/bmi/presentation/providers/bmi_providers.dart';
import 'package:bmi_calculator/features/bmi/domain/gender.dart';
import 'package:bmi_calculator/l10n/generated/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('InputPage validation and selection tests', (WidgetTester tester) async {
    // Feature: bmi-app-enhancement, Property 9: Input Page Tests
    
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
          home: InputPage(),
        ),
      ),
    );

    // Verify default state has no gender selected (null)
    final container = ProviderScope.containerOf(tester.element(find.byType(InputPage)));
    expect(container.read(genderProvider), isNull);

    // Tap calculate without gender and verify validation warning SnackBar
    final calculateButton = find.text('CALCULATE');
    expect(calculateButton, findsOneWidget);
    await tester.tap(calculateButton);
    await tester.pump(const Duration(milliseconds: 500)); // Wait for SnackBar to appear

    // Verify a SnackBar is successfully popped to alert the user
    expect(find.byType(SnackBar), findsOneWidget);

    // Tap Male Card and verify selection updates
    final maleIcon = find.byIcon(FontAwesomeIcons.mars);
    expect(maleIcon, findsOneWidget);
    await tester.tap(maleIcon);
    await tester.pump(const Duration(milliseconds: 500));

    expect(container.read(genderProvider), equals(Gender.male));

    // Clear SnackBar timers to allow safe test teardown
    await tester.pump(const Duration(seconds: 5));
  });
}
