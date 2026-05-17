import 'package:flutter/material.dart';

/// Premium color palettes for both light and dark modes
class AppColors {
  // BRAND & ACCENT COLORS (consistent across themes for identity)
  static const Color hotPink = Color(0xFFEB1555);
  static const Color electricCyan = Color(0xFF00D9FF);
  static const Color neonGreen = Color(0xFF24D876);
  
  // Gender visual systems
  static const Color maleBlue = Color(0xFF24D8E0);
  static const Color femalePink = Color(0xFFEB1555);
  static const Color femalepurple = Color(0xFF8C24E0);
  static const Color maleDarkBlue = Color(0xFF2465E0);
  static const Color warningOrange = Color(0xFFFF9500);
  static const Color errorRed = Color(0xFFFF3B30);
  
  // BMI Categories
  static const Color underweight = Color(0xFF5AC8FA);
  static const Color normal = Color(0xFF24D876);
  static const Color overweight = Color(0xFFFF9500);
  static const Color obese = Color(0xFFFF3B30);
  
  // General effects
  static const Color sliderGlow = Color(0x40EB1555);
  static const Color glassCard = Color(0x1AFFFFFF);

  // --- DARK MODE PALETTE ---
  static const Color deepSpaceStart = Color(0xFF0A0E21);
  static const Color deepSpaceEnd = Color(0xFF1D1E33);
  static const Color activeCard = Color(0xFF1D1E33);
  static const Color inactiveCard = Color(0xFF111328);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF8D8E98);
  static const Color textMuted = Color(0xFF6E6F78);
  static const Color sliderInactive = Color(0xFF8D8E98);

  // --- LIGHT MODE PALETTE ---
  static const Color lightBgStart = Color(0xFFF8FAFC);     // Slate 50
  static const Color lightBgEnd = Color(0xFFE2E8F0);       // Slate 200
  static const Color lightActiveCard = Colors.white;
  static const Color lightInactiveCard = Color(0xFFF1F5F9); // Slate 100
  static const Color lightTextPrimary = Color(0xFF0F172A);   // Slate 900
  static const Color lightTextSecondary = Color(0xFF475569); // Slate 600
  static const Color lightTextMuted = Color(0xFF94A3B8);     // Slate 400
  static const Color lightSliderInactive = Color(0xFFCBD5E1); // Slate 300

  // Dynamic helper methods to obtain colors based on active brightness
  static Color getBgStart(bool isDark) => isDark ? deepSpaceStart : lightBgStart;
  static Color getBgEnd(bool isDark) => isDark ? deepSpaceEnd : lightBgEnd;
  static Color getActiveCard(bool isDark) => isDark ? activeCard : lightActiveCard;
  static Color getInactiveCard(bool isDark) => isDark ? inactiveCard : lightInactiveCard;
  static Color getTextPrimary(bool isDark) => isDark ? textPrimary : lightTextPrimary;
  static Color getTextSecondary(bool isDark) => isDark ? textSecondary : lightTextSecondary;
  static Color getTextMuted(bool isDark) => isDark ? textMuted : lightTextMuted;
  static Color getSliderInactive(bool isDark) => isDark ? sliderInactive : lightSliderInactive;
}
