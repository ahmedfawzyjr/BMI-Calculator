import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Premium color palette for BMI Calculator
class AppColors {
  // Primary gradient colors
  static const Color deepSpaceStart = Color(0xFF0A0E21);
  static const Color deepSpaceEnd = Color(0xFF1D1E33);
  
  // Accent colors
  static const Color hotPink = Color(0xFFEB1555);
  static const Color electricCyan = Color(0xFF00D9FF);
  static const Color neonGreen = Color(0xFF24D876);
  static const Color warningOrange = Color(0xFFFF9500);
  static const Color errorRed = Color(0xFFFF3B30);
  
  // Card colors
  static const Color activeCard = Color(0xFF1D1E33);
  static const Color inactiveCard = Color(0xFF111328);
  static const Color glassCard = Color(0x1AFFFFFF);
  
  // Slider colors
  static const Color sliderInactive = Color(0xFF8D8E98);
  static const Color sliderGlow = Color(0x40EB1555);
  
  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF8D8E98);
  static const Color textMuted = Color(0xFF6E6F78);
  
  // BMI Category colors
  static const Color underweight = Color(0xFF5AC8FA);
  static const Color normal = Color(0xFF24D876);
  static const Color overweight = Color(0xFFFF9500);
  static const Color obese = Color(0xFFFF3B30);
}

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

/// Premium text styles with Google Fonts
class AppTextStyles {
  static TextStyle get displayLarge => GoogleFonts.outfit(
    fontSize: 100,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get displayMedium => GoogleFonts.outfit(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get headlineLarge => GoogleFonts.outfit(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get headlineMedium => GoogleFonts.outfit(
    fontSize: 27,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get titleLarge => GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
  
  static TextStyle get button => GoogleFonts.outfit(
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

/// Premium theme data
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
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.titleLarge,
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.textPrimary,
      inactiveTrackColor: AppColors.sliderInactive,
      thumbColor: AppColors.hotPink,
      overlayColor: AppColors.sliderGlow,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15.0),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 35.0),
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
}
