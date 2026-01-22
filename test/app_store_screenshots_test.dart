import 'package:bmi_calculator/core/router/app_router.dart';
import 'package:bmi_calculator/features/bmi/data/models/bmi_history.dart';
import 'package:bmi_calculator/features/bmi/domain/bmi_category.dart';
import 'package:bmi_calculator/features/bmi/presentation/providers/bmi_providers.dart';
import 'package:bmi_calculator/features/bmi/presentation/screens/history_screen.dart';
import 'package:bmi_calculator/features/bmi/presentation/screens/input_page.dart';
import 'package:bmi_calculator/features/bmi/presentation/screens/result_page.dart';
import 'package:bmi_calculator/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  testGoldens('App Store Screenshots', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
        const Device(name: 'iPhone 13 Pro Max', size: Size(1284, 2778), devicePixelRatio: 3.0),
        const Device(name: 'iPad Pro 12.9', size: Size(2048, 2732), devicePixelRatio: 2.0),
      ]);

    // Scenario 1: Input Page (Home)
    builder.addScenario(
      name: 'Input Page',
      widget: const ProviderScope(
        child: MyAppWrapper(child: InputPage()),
      ),
    );

    // Scenario 2: Result Page
    builder.addScenario(
      name: 'Result Page',
      widget: const ProviderScope(
        child: MyAppWrapper(
          child: ResultPage(
            bmi: '22.5',
            category: BMICategory.normal,
            textColor: Colors.green,
          ),
        ),
      ),
    );

    // Scenario 3: History Page
    builder.addScenario(
      name: 'History Page',
      widget: ProviderScope(
        overrides: [
          historyProvider.overrideWith((ref) => Future.value([
                BMIHistory(
                  id: '1',
                  bmi: 22.5,
                  category: BMICategory.normal,
                  date: DateTime(2023, 10, 25, 10, 30),
                ),
                BMIHistory(
                  id: '2',
                  bmi: 28.0,
                  category: BMICategory.overweight,
                  date: DateTime(2023, 10, 20, 15, 45),
                ),
              ])),
        ],
        child: const MyAppWrapper(child: HistoryScreen()),
      ),
    );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'app_store_screenshots');
  });
}

class MyAppWrapper extends StatelessWidget {
  final Widget child;

  const MyAppWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A0E21),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
      ),
      home: child,
    );
  }
}
