import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/features/bmi/domain/input_validator.dart';
import 'package:bmi_calculator/features/bmi/domain/gender.dart';

void main() {
  group('InputValidator Tests', () {
    // Feature: bmi-app-enhancement, Property 7: Input Validator
    test('Valid inputs pass validation', () {
      final result = InputValidator.validate(
        gender: Gender.male,
        height: 180,
        weight: 75,
        age: 25,
      );
      expect(result.isValid, isTrue);
      expect(result.errorMessageKey, isNull);
    });

    test('Null gender fails validation', () {
      final result = InputValidator.validate(
        gender: null,
        height: 180,
        weight: 75,
        age: 25,
      );
      expect(result.isValid, isFalse);
      expect(result.errorMessageKey, equals('errorSelectGender'));
    });

    test('Invalid height fails validation', () {
      // Under bounds
      final resultUnder = InputValidator.validate(
        gender: Gender.female,
        height: 40,
        weight: 75,
        age: 25,
      );
      expect(resultUnder.isValid, isFalse);
      expect(resultUnder.errorMessageKey, equals('errorInvalidHeight'));

      // Over bounds
      final resultOver = InputValidator.validate(
        gender: Gender.female,
        height: 260,
        weight: 75,
        age: 25,
      );
      expect(resultOver.isValid, isFalse);
      expect(resultOver.errorMessageKey, equals('errorInvalidHeight'));
    });

    test('Invalid weight fails validation', () {
      // Under bounds
      final resultUnder = InputValidator.validate(
        gender: Gender.male,
        height: 180,
        weight: 5,
        age: 25,
      );
      expect(resultUnder.isValid, isFalse);
      expect(resultUnder.errorMessageKey, equals('errorInvalidWeight'));

      // Over bounds
      final resultOver = InputValidator.validate(
        gender: Gender.male,
        height: 180,
        weight: 350,
        age: 25,
      );
      expect(resultOver.isValid, isFalse);
      expect(resultOver.errorMessageKey, equals('errorInvalidWeight'));
    });

    test('Invalid age fails validation', () {
      // Under bounds
      final resultUnder = InputValidator.validate(
        gender: Gender.female,
        height: 180,
        weight: 75,
        age: 0,
      );
      expect(resultUnder.isValid, isFalse);
      expect(resultUnder.errorMessageKey, equals('errorInvalidAge'));

      // Over bounds
      final resultOver = InputValidator.validate(
        gender: Gender.female,
        height: 180,
        weight: 75,
        age: 130,
      );
      expect(resultOver.isValid, isFalse);
      expect(resultOver.errorMessageKey, equals('errorInvalidAge'));
    });
  });
}
