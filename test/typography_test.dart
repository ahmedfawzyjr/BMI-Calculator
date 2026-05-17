import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bmi_calculator/core/theme/app_typography.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  test('Typography levels exist and follow correct scale relations', () {
    // Feature: bmi-app-enhancement, Property 1: Typography Levels
    const color = Colors.black;
    
    // Arabic styles
    final displayLargeAr = AppTypography.displayLarge(true, color);
    final displayMediumAr = AppTypography.displayMedium(true, color);
    final headlineLargeAr = AppTypography.headlineLarge(true, color);
    final headlineMediumAr = AppTypography.headlineMedium(true, color);
    final titleLargeAr = AppTypography.titleLarge(true, color);
    final bodyLargeAr = AppTypography.bodyLarge(true, color);
    final bodyMediumAr = AppTypography.bodyMedium(true, color);
    final labelLargeAr = AppTypography.labelLarge(true, color);
    
    // English styles
    final displayLargeEn = AppTypography.displayLarge(false, color);
    final displayMediumEn = AppTypography.displayMedium(false, color);
    final headlineLargeEn = AppTypography.headlineLarge(false, color);
    final headlineMediumEn = AppTypography.headlineMedium(false, color);
    final titleLargeEn = AppTypography.titleLarge(false, color);
    final bodyLargeEn = AppTypography.bodyLarge(false, color);
    final bodyMediumEn = AppTypography.bodyMedium(false, color);
    final labelLargeEn = AppTypography.labelLarge(false, color);
    
    // Verify Arabic sizes are positive
    expect(displayLargeAr.fontSize, isPositive);
    expect(displayMediumAr.fontSize, isPositive);
    expect(headlineLargeAr.fontSize, isPositive);
    expect(headlineMediumAr.fontSize, isPositive);
    expect(titleLargeAr.fontSize, isPositive);
    expect(bodyLargeAr.fontSize, isPositive);
    expect(bodyMediumAr.fontSize, isPositive);
    expect(labelLargeAr.fontSize, isPositive);
    
    // Verify English sizes are positive
    expect(displayLargeEn.fontSize, isPositive);
    expect(displayMediumEn.fontSize, isPositive);
    expect(headlineLargeEn.fontSize, isPositive);
    expect(headlineMediumEn.fontSize, isPositive);
    expect(titleLargeEn.fontSize, isPositive);
    expect(bodyLargeEn.fontSize, isPositive);
    expect(bodyMediumEn.fontSize, isPositive);
    expect(labelLargeEn.fontSize, isPositive);
    
    // Verify scale order: Display Large > Display Medium > Headline Large > Headline Medium > Title Large > Body Large > Body Medium
    expect(displayLargeAr.fontSize!, greaterThan(displayMediumAr.fontSize!));
    expect(displayMediumAr.fontSize!, greaterThan(headlineLargeAr.fontSize!));
    expect(headlineLargeAr.fontSize!, greaterThan(headlineMediumAr.fontSize!));
    expect(headlineMediumAr.fontSize!, greaterThan(titleLargeAr.fontSize!));
    expect(titleLargeAr.fontSize!, greaterThan(bodyLargeAr.fontSize!));
    expect(bodyLargeAr.fontSize!, greaterThan(bodyMediumAr.fontSize!));
  });
}
