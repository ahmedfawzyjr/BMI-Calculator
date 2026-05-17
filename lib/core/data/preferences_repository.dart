import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Repository that handles persistence of all app preferences and settings
class PreferencesRepository {
  final SharedPreferences _prefs;

  static const String _keyThemeMode = 'theme_mode';
  static const String _keyLocale = 'locale';
  static const String _keySoundEnabled = 'sound_enabled';
  static const String _keyHapticEnabled = 'haptic_enabled';
  static const String _keyParticlesEnabled = 'particles_enabled';

  PreferencesRepository(this._prefs);

  /// Load ThemeMode (Defaults to Dark Theme for premium dark aesthetic)
  ThemeMode getThemeMode() {
    final value = _prefs.getString(_keyThemeMode);
    if (value == 'light') return ThemeMode.light;
    if (value == 'dark') return ThemeMode.dark;
    return ThemeMode.dark;
  }

  /// Save ThemeMode
  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(_keyThemeMode, mode.name);
  }

  /// Load Locale (Defaults to English)
  Locale getLocale() {
    final value = _prefs.getString(_keyLocale);
    if (value == 'ar') return const Locale('ar');
    return const Locale('en');
  }

  /// Save Locale
  Future<void> setLocale(Locale locale) async {
    await _prefs.setString(_keyLocale, locale.languageCode);
  }

  /// Check if sound effects are enabled
  bool isSoundEnabled() {
    return _prefs.getBool(_keySoundEnabled) ?? true;
  }

  /// Save sound effects preference
  Future<void> setSoundEnabled(bool enabled) async {
    await _prefs.setBool(_keySoundEnabled, enabled);
  }

  /// Check if haptic feedback is enabled
  bool isHapticEnabled() {
    return _prefs.getBool(_keyHapticEnabled) ?? true;
  }

  /// Save haptic feedback preference
  Future<void> setHapticEnabled(bool enabled) async {
    await _prefs.setBool(_keyHapticEnabled, enabled);
  }

  /// Check if particle backgrounds are enabled
  bool isParticlesEnabled() {
    return _prefs.getBool(_keyParticlesEnabled) ?? true;
  }

  /// Save particle backgrounds preference
  Future<void> setParticlesEnabled(bool enabled) async {
    await _prefs.setBool(_keyParticlesEnabled, enabled);
  }
}

/// Provider for PreferencesRepository (Overridden in main.dart after SharedPreferences initialization)
final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  throw UnimplementedError('PreferencesRepository has not been initialized. Overrides should be done in ProviderScope.');
});
