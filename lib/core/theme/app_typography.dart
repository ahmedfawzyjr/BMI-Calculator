import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Premium typography system that adapts font family based on selected locale
/// Uses 'Cairo' for Arabic and 'Outfit/Inter' for English.
class AppTypography {
  static TextStyle getStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    required bool isArabic,
    double? letterSpacing,
  }) {
    final isTesting = Platform.environment.containsKey('FLUTTER_TEST');
    if (isTesting) {
      return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );
    }

    if (isArabic) {
      return GoogleFonts.cairo(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: 1.3, // Cairo works best with custom heights
      );
    } else {
      // Outfit is modern/geometric for titles/displays, Inter is extremely readable for body copy
      if (fontSize >= 24) {
        return GoogleFonts.outfit(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );
      } else {
        return GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );
      }
    }
  }

  // --- 8 STYLING LEVELS SPECIFIED IN TASKS ---
  
  // 1. Display Large (e.g. large BMI number)
  static TextStyle displayLarge(bool isArabic, Color color) => getStyle(
        fontSize: 100,
        fontWeight: FontWeight.bold,
        color: color,
        isArabic: isArabic,
      );

  // 2. Display Medium (e.g. large sliders or main stats)
  static TextStyle displayMedium(bool isArabic, Color color) => getStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
        color: color,
        isArabic: isArabic,
      );

  // 3. Headline Large (e.g. big titles, splash screen title)
  static TextStyle headlineLarge(bool isArabic, Color color) => getStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: color,
        isArabic: isArabic,
      );

  // 4. Headline Medium (e.g. result category name)
  static TextStyle headlineMedium(bool isArabic, Color color) => getStyle(
        fontSize: 27,
        fontWeight: FontWeight.bold,
        color: color,
        isArabic: isArabic,
      );

  // 5. Title Large (e.g. AppBar title, card titles)
  static TextStyle titleLarge(bool isArabic, Color color) => getStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: color,
        isArabic: isArabic,
      );

  // 6. Body Large (e.g. primary results advise, SnackBar content)
  static TextStyle bodyLarge(bool isArabic, Color color) => getStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: color,
        isArabic: isArabic,
      );

  // 7. Body Medium (e.g. secondary statistics, chart tooltips)
  static TextStyle bodyMedium(bool isArabic, Color color) => getStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: color,
        isArabic: isArabic,
      );

  // 8. Label Large (e.g. gender cards labels, slider unit labels)
  static TextStyle labelLarge(bool isArabic, Color color) => getStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: color,
        isArabic: isArabic,
      );

  // Button Style
  static TextStyle button(bool isArabic, Color color) => getStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: color,
        isArabic: isArabic,
        letterSpacing: isArabic ? null : 1.5,
      );
}
