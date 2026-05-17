import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bmi_calculator/core/data/preferences_repository.dart';

/// Premium audio feedback service linked directly to User Preferences
class SoundService {
  final Ref _ref;
  final AudioPlayer _player = AudioPlayer();

  SoundService(this._ref) {
    // Set default volume level
    _player.setVolume(0.3).catchError((_) {});
  }

  /// Check if sound is active in settings
  bool get _isEnabled {
    try {
      return _ref.read(preferencesRepositoryProvider).isSoundEnabled();
    } catch (_) {
      return true; // Default to true if provider not initialized
    }
  }

  /// Internal player helper with safety checks
  Future<void> _playSound(String assetPath) async {
    if (!_isEnabled) return;
    try {
      // Stop currently playing to avoid overlaps and play new sound
      await _player.stop();
      await _player.play(AssetSource(assetPath));
    } catch (e) {
      // Silently fail if audio system is not available or files are missing
    }
  }

  /// Play tap/click sound
  Future<void> playTap() async {
    await _playSound('sounds/tap.mp3');
  }

  /// Play success sound for healthy BMI (e.g. ideal outcome)
  Future<void> playSuccess() async {
    await _playSound('sounds/success.mp3');
  }

  /// Play warning sound for underweight, overweight, or obese results
  Future<void> playWarning() async {
    await _playSound('sounds/warning.mp3');
  }

  /// Play calculation/processing sequence sound
  Future<void> playCalculate() async {
    await _playSound('sounds/calculate.mp3');
  }

  /// Play slider tick sound on movement
  Future<void> playSlide() async {
    await _playSound('sounds/slide.mp3');
  }

  /// Play app launch fanfare sound
  Future<void> playLaunch() async {
    await _playSound('sounds/launch.mp3');
  }

  /// Play counter value increment sound
  Future<void> playIncrement() async {
    await _playSound('sounds/increment.mp3');
  }

  /// Play counter value decrement sound
  Future<void> playDecrement() async {
    await _playSound('sounds/decrement.mp3');
  }

  /// Free up media player resources
  void dispose() {
    _player.dispose();
  }
}

/// Provider for SoundService
final soundServiceProvider = Provider<SoundService>((ref) {
  final service = SoundService(ref);
  ref.onDispose(() => service.dispose());
  return service;
});
