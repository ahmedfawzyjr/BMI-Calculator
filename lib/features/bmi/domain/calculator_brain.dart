import 'dart:math';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/features/bmi/domain/bmi_category.dart';
import 'package:bmi_calculator/core/theme/app_colors.dart';
import 'package:bmi_calculator/l10n/generated/app_localizations.dart';

/// Business logic for BMI calculations and classification
class Calculate {
  final int height;
  final int weight;
  late final double _bmi;

  Calculate({
    required this.height,
    required this.weight,
  }) {
    // Avoid division by zero and perform standard BMI formula
    if (height <= 0) {
      _bmi = 0;
    } else {
      _bmi = weight / pow(height / 100, 2);
    }
  }

  /// Format BMI value as String (1 decimal place)
  String result() {
    return _bmi.toStringAsFixed(1);
  }

  /// Raw double BMI value
  double get bmiValue => _bmi;

  /// Classify BMI score into official category
  BMICategory getCategory() {
    if (_bmi >= 30.0) {
      return BMICategory.obese;
    } else if (_bmi >= 25.0) {
      return BMICategory.overweight;
    } else if (_bmi >= 18.5) {
      return BMICategory.normal;
    } else {
      return BMICategory.underweight;
    }
  }

  /// Get corresponding visual status color
  Color getTextColor() {
    switch (getCategory()) {
      case BMICategory.underweight:
        return AppColors.underweight;
      case BMICategory.normal:
        return AppColors.normal;
      case BMICategory.overweight:
        return AppColors.overweight;
      case BMICategory.obese:
        return AppColors.obese;
    }
  }

  /// Get localized dynamic advice based on classification
  String getAdvice(AppLocalizations l10n) {
    switch (getCategory()) {
      case BMICategory.underweight:
        return l10n.adviceUnderweight;
      case BMICategory.normal:
        return l10n.adviceNormal;
      case BMICategory.overweight:
        return l10n.adviceOverweight;
      case BMICategory.obese:
        return l10n.adviceObese;
    }
  }
}
