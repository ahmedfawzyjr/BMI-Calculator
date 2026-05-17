import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/features/bmi/domain/calculator_brain.dart';
import 'package:bmi_calculator/features/bmi/domain/bmi_category.dart';

void main() {
  test('Property-based testing: BMI Classification matches bounds over 100 random values', () {
    // Feature: bmi-app-enhancement, Property 6: BMI Classification
    final random = math.Random();
    
    for (int i = 0; i < 100; i++) {
      // Generate a random height between 100 and 220 cm
      final height = 100 + random.nextInt(120); 
      
      // Calculate target weights for each class based on height
      final heightInMeters = height / 100.0;
      final heightSq = heightInMeters * heightInMeters;

      // 1. Underweight range (< 18.5)
      final underweightWeight = (18.4 * heightSq).floor();
      if (underweightWeight >= 10) {
        final calc = Calculate(height: height, weight: underweightWeight);
        expect(calc.getCategory(), equals(BMICategory.underweight), 
            reason: 'BMI ${calc.result()} should be underweight (Height: $height, Weight: $underweightWeight)');
      }

      // 2. Normal range (18.5 to 24.9)
      final normalWeight = (21.7 * heightSq).round();
      final calcNormal = Calculate(height: height, weight: normalWeight);
      expect(calcNormal.getCategory(), equals(BMICategory.normal), 
          reason: 'BMI ${calcNormal.result()} should be normal (Height: $height, Weight: $normalWeight)');

      // 3. Overweight range (25.0 to 29.9)
      final overweightWeight = (27.5 * heightSq).round();
      final calcOver = Calculate(height: height, weight: overweightWeight);
      expect(calcOver.getCategory(), equals(BMICategory.overweight), 
          reason: 'BMI ${calcOver.result()} should be overweight (Height: $height, Weight: $overweightWeight)');

      // 4. Obese range (>= 30.0)
      final obeseWeight = (35.0 * heightSq).round();
      final calcObese = Calculate(height: height, weight: obeseWeight);
      expect(calcObese.getCategory(), equals(BMICategory.obese), 
          reason: 'BMI ${calcObese.result()} should be obese (Height: $height, Weight: $obeseWeight)');
    }
  });
}
