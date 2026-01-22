import 'dart:math';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/features/bmi/domain/bmi_category.dart';

class Calculate {
  Calculate({
    required this.height,
    required this.weight,
  });
  final int height;
  final int weight;
  double _bmi = 0;

  String result() {
    _bmi = (weight / pow(height / 100, 2));
    return _bmi.toStringAsFixed(1);
  }

  BMICategory getCategory() {
    if (_bmi >= 25) {
      return BMICategory.overweight;
    } else if (_bmi > 18.5) {
      return BMICategory.normal;
    } else {
      return BMICategory.underweight;
    }
  }

  Color getTextColor() {
    if (_bmi >= 25 || _bmi <= 18.5) {
      return Colors.deepOrangeAccent;
    } else {
      return const Color(0xFF24D876);
    }
  }
}

