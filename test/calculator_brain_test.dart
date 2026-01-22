import 'package:bmi_calculator/features/bmi/domain/bmi_category.dart';
import 'package:bmi_calculator/features/bmi/domain/calculator_brain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalculatorBrain', () {
    test('calculates BMI correctly for normal weight', () {
      final calc = Calculate(height: 180, weight: 70);
      expect(calc.result(), '21.6');
      expect(calc.getCategory(), BMICategory.normal);
    });

    test('calculates BMI correctly for underweight', () {
      final calc = Calculate(height: 180, weight: 50);
      expect(calc.result(), '15.4');
      expect(calc.getCategory(), BMICategory.underweight);
    });

    test('calculates BMI correctly for overweight', () {
      final calc = Calculate(height: 180, weight: 90);
      expect(calc.result(), '27.8');
      expect(calc.getCategory(), BMICategory.overweight);
    });
  });
}
