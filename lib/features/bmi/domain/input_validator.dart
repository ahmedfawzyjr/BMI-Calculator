import 'package:bmi_calculator/features/bmi/domain/gender.dart';

/// Result of input validation checks containing state and dynamic localization key
class InputValidationResult {
  final bool isValid;
  final String? errorMessageKey;

  const InputValidationResult({
    required this.isValid,
    this.errorMessageKey,
  });
}

/// Dynamic Input Validator to prevent unreasonable measurements or non-selection crashes
class InputValidator {
  /// Validate all inputs
  static InputValidationResult validate({
    required Gender? gender,
    required int height,
    required int weight,
    required int age,
  }) {
    if (gender == null) {
      return const InputValidationResult(
        isValid: false,
        errorMessageKey: 'errorSelectGender',
      );
    }
    
    if (height < 50 || height > 250) {
      return const InputValidationResult(
        isValid: false,
        errorMessageKey: 'errorInvalidHeight',
      );
    }
    
    if (weight < 10 || weight > 300) {
      return const InputValidationResult(
        isValid: false,
        errorMessageKey: 'errorInvalidWeight',
      );
    }
    
    if (age < 1 || age > 120) {
      return const InputValidationResult(
        isValid: false,
        errorMessageKey: 'errorInvalidAge',
      );
    }

    return const InputValidationResult(isValid: true);
  }
}
