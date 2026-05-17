import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

export 'app_colors.dart';
export 'app_typography.dart';

/// Premium gradients for the app
class AppGradients {
  static const LinearGradient background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.deepSpaceStart,
      AppColors.deepSpaceEnd,
    ],
  );

  static const LinearGradient lightBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.lightBgStart,
      AppColors.lightBgEnd,
    ],
  );
  
  static const LinearGradient primaryButton = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFEB1555),
      Color(0xFFFF4081),
    ],
  );
  
  static const LinearGradient glassOverlay = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x20FFFFFF),
      Color(0x05FFFFFF),
    ],
  );

  static const LinearGradient lightGlassOverlay = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x40FFFFFF),
      Color(0x10FFFFFF),
    ],
  );
  
  static const LinearGradient cardGlow = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x40EB1555),
      Color(0x00EB1555),
    ],
  );
  
  static const LinearGradient gaugeGradient = LinearGradient(
    colors: [
      AppColors.underweight,
      AppColors.normal,
      AppColors.overweight,
      AppColors.obese,
    ],
    stops: [0.0, 0.35, 0.65, 1.0],
  );
}

/// Fallback AppTextStyles for backwards compatibility
class AppTextStyles {
  static TextStyle _font(TextStyle Function() getFont, {required double fontSize, required FontWeight fontWeight, required Color color}) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
    }
    return getFont();
  }

  static TextStyle get displayLarge => _font(
    () => GoogleFonts.outfit(
      fontSize: 100,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    fontSize: 100,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get displayMedium => _font(
    () => GoogleFonts.outfit(
      fontSize: 50,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get headlineLarge => _font(
    () => GoogleFonts.outfit(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get headlineMedium => _font(
    () => GoogleFonts.outfit(
      fontSize: 27,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    fontSize: 27,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get titleLarge => _font(
    () => GoogleFonts.inter(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get bodyLarge => _font(
    () => GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: AppColors.textSecondary,
    ),
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  static TextStyle get bodyMedium => _font(
    () => GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.textSecondary,
    ),
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  static TextStyle get labelLarge => _font(
    () => GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
  
  static TextStyle get button => _font(
    () => GoogleFonts.outfit(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
}

/// Animation durations and curves
class AppAnimations {
  // Durations
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration slower = Duration(milliseconds: 800);
  static const Duration splash = Duration(milliseconds: 2000);
  
  // Curves
  static const Curve defaultCurve = Curves.easeOutCubic;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve springCurve = Curves.easeOutBack;
  static const Curve smoothCurve = Curves.easeInOutCubic;
}

/// Premium theme data supporting Dark and Light Modes
class AppTheme {
  static ThemeData get darkTheme => ThemeData.dark().copyWith(
    primaryColor: AppColors.deepSpaceStart,
    scaffoldBackgroundColor: AppColors.deepSpaceStart,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.hotPink,
      secondary: AppColors.electricCyan,
      surface: AppColors.activeCard,
      error: AppColors.errorRed,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: AppColors.textPrimary,
      inactiveTrackColor: AppColors.sliderInactive,
      thumbColor: AppColors.hotPink,
      overlayColor: AppColors.sliderGlow,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 35.0),
      trackHeight: 4.0,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      titleLarge: AppTextStyles.titleLarge,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      labelLarge: AppTextStyles.labelLarge,
    ),
  );

  static ThemeData get lightTheme => ThemeData.light().copyWith(
    primaryColor: AppColors.lightBgStart,
    scaffoldBackgroundColor: AppColors.lightBgStart,
    colorScheme: const ColorScheme.light(
      primary: AppColors.hotPink,
      secondary: AppColors.electricCyan,
      surface: AppColors.lightActiveCard,
      error: AppColors.errorRed,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.lightTextPrimary,
      ),
      iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: AppColors.lightTextPrimary,
      inactiveTrackColor: AppColors.lightSliderInactive,
      thumbColor: AppColors.hotPink,
      overlayColor: AppColors.sliderGlow,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 35.0),
      trackHeight: 4.0,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.lightTextPrimary),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: AppColors.lightTextPrimary),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: AppColors.lightTextPrimary),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: AppColors.lightTextPrimary),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.lightTextPrimary),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.lightTextSecondary),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.lightTextSecondary),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.lightTextSecondary),
    ),
  );
}
