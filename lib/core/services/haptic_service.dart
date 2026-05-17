import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bmi_calculator/core/data/preferences_repository.dart';

/// Haptic Feedback service that respects user preferences from Settings
class HapticService {
  final Ref _ref;

  HapticService(this._ref);

  /// Check if haptics are enabled in user settings
  bool get _isEnabled {
    try {
      return _ref.read(preferencesRepositoryProvider).isHapticEnabled();
    } catch (_) {
      return true; // Default to true if preferences repository not initialized
    }
  }

  /// Light haptic impact (useful for card taps, minor toggles)
  Future<void> lightImpact() async {
    if (!_isEnabled) return;
    await HapticFeedback.lightImpact();
  }

  /// Medium haptic impact (useful for slider thumbs, increment/decrement)
  Future<void> mediumImpact() async {
    if (!_isEnabled) return;
    await HapticFeedback.mediumImpact();
  }

  /// Heavy haptic impact (useful for calculating button)
  Future<void> heavyImpact() async {
    if (!_isEnabled) return;
    await HapticFeedback.heavyImpact();
  }

  /// Success haptic pattern: 3 quick rising pulses (for healthy/ideal weight result)
  Future<void> successNotification() async {
    if (!_isEnabled) return;
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 80));
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 80));
    await HapticFeedback.mediumImpact();
  }

  /// Error/Warning haptic pattern: 2 rapid pulses (for incorrect entries or high obesity warning)
  Future<void> errorNotification() async {
    if (!_isEnabled) return;
    await HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
  }
}

/// Provider for HapticService
final hapticServiceProvider = Provider<HapticService>((ref) {
  return HapticService(ref);
});
