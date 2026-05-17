import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bmi_calculator/core/data/preferences_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('PreferencesRepository Round Trip Tests', () {
    // Feature: bmi-app-enhancement, Property 2: Preferences Repository
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Round trip saving and loading theme mode', () async {
      final prefs = await SharedPreferences.getInstance();
      final repository = PreferencesRepository(prefs);

      // Default should be dark premium
      expect(repository.getThemeMode(), equals(ThemeMode.dark));

      // Set to light and load
      await repository.setThemeMode(ThemeMode.light);
      expect(repository.getThemeMode(), equals(ThemeMode.light));

      // Set to dark and load
      await repository.setThemeMode(ThemeMode.dark);
      expect(repository.getThemeMode(), equals(ThemeMode.dark));
    });

    test('Round trip saving and loading locale', () async {
      final prefs = await SharedPreferences.getInstance();
      final repository = PreferencesRepository(prefs);

      // Default should be English
      expect(repository.getLocale().languageCode, equals('en'));

      // Set to Arabic and load
      await repository.setLocale(const Locale('ar'));
      expect(repository.getLocale().languageCode, equals('ar'));
    });

    test('Round trip sound, haptic and particle settings', () async {
      final prefs = await SharedPreferences.getInstance();
      final repository = PreferencesRepository(prefs);

      // Defaults should be true
      expect(repository.isSoundEnabled(), isTrue);
      expect(repository.isHapticEnabled(), isTrue);
      expect(repository.isParticlesEnabled(), isTrue);

      // Change and check
      await repository.setSoundEnabled(false);
      await repository.setHapticEnabled(false);
      await repository.setParticlesEnabled(false);

      expect(repository.isSoundEnabled(), isFalse);
      expect(repository.isHapticEnabled(), isFalse);
      expect(repository.isParticlesEnabled(), isFalse);
    });
  });
}
