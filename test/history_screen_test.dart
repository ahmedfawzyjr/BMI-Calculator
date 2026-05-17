import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bmi_calculator/core/data/preferences_repository.dart';
import 'package:bmi_calculator/features/bmi/presentation/screens/history_screen.dart';
import 'package:bmi_calculator/features/bmi/presentation/providers/bmi_providers.dart';
import 'package:bmi_calculator/features/bmi/data/models/bmi_history.dart';
import 'package:bmi_calculator/features/bmi/domain/bmi_category.dart';
import 'package:bmi_calculator/l10n/generated/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('HistoryScreen renders list and chart properly', (WidgetTester tester) async {
    // Feature: bmi-app-enhancement, Property 14: History Screen Tests
    
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

    // Seed mock history data
    final mockHistory = [
      BMIHistory(id: '1', bmi: 22.0, category: BMICategory.normal, date: DateTime.now().subtract(const Duration(days: 2))),
      BMIHistory(id: '2', bmi: 26.5, category: BMICategory.overweight, date: DateTime.now().subtract(const Duration(days: 1))),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          preferencesRepositoryProvider.overrideWithValue(repository),
          historyProvider.overrideWith((ref) => mockHistory),
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
          home: HistoryScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify history lists render both seeded records
    expect(find.text('NORMAL'), findsOneWidget);
    expect(find.text('OVERWEIGHT'), findsOneWidget);

    // Verify that the trends chart is drawn since there are 2 or more records
    expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
  });
}
