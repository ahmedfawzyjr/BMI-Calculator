import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/features/bmi/presentation/widgets/bmi_gauge.dart';
import 'package:bmi_calculator/features/bmi/domain/bmi_category.dart';

void main() {
  testWidgets('BMIGauge renders CustomPaint successfully', (WidgetTester tester) async {
    // Feature: bmi-app-enhancement, Property 11: BMI Gauge Tests
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: BMIGauge(
              bmiValue: 22.5,
              category: BMICategory.normal,
            ),
          ),
        ),
      ),
    );

    // Verify at least one CustomPaint is present in the hierarchy to draw the gauge details
    expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
    
    // Tick the elastic needle animation to completion
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
}
