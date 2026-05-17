import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bmi_calculator/features/bmi/domain/gender.dart';
import 'package:bmi_calculator/features/bmi/data/models/bmi_history.dart';
import 'package:bmi_calculator/features/bmi/data/repositories/history_repository.dart';
import 'package:bmi_calculator/core/data/preferences_repository.dart';

// Current Input States
final genderProvider = StateProvider<Gender?>((ref) => null);
final heightProvider = StateProvider<int>((ref) => 180);
final weightProvider = StateProvider<int>((ref) => 60);
final ageProvider = StateProvider<int>((ref) => 20);

// History Data Providers
final historyRepositoryProvider = Provider((ref) => HistoryRepository());

final historyProvider = FutureProvider<List<BMIHistory>>((ref) async {
  final repository = ref.watch(historyRepositoryProvider);
  return repository.getHistory();
});

// --- NEW THEME PROVIDER ---
class ThemeNotifier extends StateNotifier<ThemeMode> {
  final PreferencesRepository _repository;

  ThemeNotifier(this._repository) : super(_repository.getThemeMode());

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    state = newMode;
    await _repository.setThemeMode(newMode);
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    await _repository.setThemeMode(mode);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final repository = ref.watch(preferencesRepositoryProvider);
  return ThemeNotifier(repository);
});

// --- NEW LOCALE PROVIDER ---
class LocaleNotifier extends StateNotifier<Locale> {
  final PreferencesRepository _repository;

  LocaleNotifier(this._repository) : super(_repository.getLocale());

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await _repository.setLocale(locale);
  }

  Future<void> toggleLocale() async {
    final newLocale = state.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
    state = newLocale;
    await _repository.setLocale(newLocale);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  final repository = ref.watch(preferencesRepositoryProvider);
  return LocaleNotifier(repository);
});

// --- NEW GENERAL SETTINGS PROVIDER ---
class SettingsState {
  final bool soundEnabled;
  final bool hapticEnabled;
  final bool particlesEnabled;

  const SettingsState({
    required this.soundEnabled,
    required this.hapticEnabled,
    required this.particlesEnabled,
  });

  SettingsState copyWith({
    bool? soundEnabled,
    bool? hapticEnabled,
    bool? particlesEnabled,
  }) {
    return SettingsState(
      soundEnabled: soundEnabled ?? this.soundEnabled,
      hapticEnabled: hapticEnabled ?? this.hapticEnabled,
      particlesEnabled: particlesEnabled ?? this.particlesEnabled,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  final PreferencesRepository _repository;

  SettingsNotifier(this._repository)
      : super(SettingsState(
          soundEnabled: _repository.isSoundEnabled(),
          hapticEnabled: _repository.isHapticEnabled(),
          particlesEnabled: _repository.isParticlesEnabled(),
        ));

  Future<void> setSoundEnabled(bool enabled) async {
    state = state.copyWith(soundEnabled: enabled);
    await _repository.setSoundEnabled(enabled);
  }

  Future<void> setHapticEnabled(bool enabled) async {
    state = state.copyWith(hapticEnabled: enabled);
    await _repository.setHapticEnabled(enabled);
  }

  Future<void> setParticlesEnabled(bool enabled) async {
    state = state.copyWith(particlesEnabled: enabled);
    await _repository.setParticlesEnabled(enabled);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final repository = ref.watch(preferencesRepositoryProvider);
  return SettingsNotifier(repository);
});

// --- NEW BMI DYNAMIC STATISTICS PROVIDER ---
class BMIStatistics {
  final double averageBmi;
  final double maxBmi;
  final double minBmi;
  final int totalCount;
  final Map<String, int> categoryCounts;

  const BMIStatistics({
    required this.averageBmi,
    required this.maxBmi,
    required this.minBmi,
    required this.totalCount,
    required this.categoryCounts,
  });

  factory BMIStatistics.empty() {
    return const BMIStatistics(
      averageBmi: 0.0,
      maxBmi: 0.0,
      minBmi: 0.0,
      totalCount: 0,
      categoryCounts: {},
    );
  }
}

final bmiStatisticsProvider = Provider<BMIStatistics>((ref) {
  final historyAsync = ref.watch(historyProvider);
  return historyAsync.maybeWhen(
    data: (list) {
      if (list.isEmpty) return BMIStatistics.empty();
      
      final total = list.length;
      final sum = list.map((e) => e.bmi).reduce((a, b) => a + b);
      final average = sum / total;
      final max = list.map((e) => e.bmi).reduce((a, b) => a > b ? a : b);
      final min = list.map((e) => e.bmi).reduce((a, b) => a < b ? a : b);
      
      final categoryCounts = <String, int>{};
      for (final item in list) {
        final catName = item.category.name;
        categoryCounts[catName] = (categoryCounts[catName] ?? 0) + 1;
      }
      
      return BMIStatistics(
        averageBmi: average,
        maxBmi: max,
        minBmi: min,
        totalCount: total,
        categoryCounts: categoryCounts,
      );
    },
    orElse: () => BMIStatistics.empty(),
  );
});
