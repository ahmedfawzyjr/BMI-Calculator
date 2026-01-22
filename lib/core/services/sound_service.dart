import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Sound effects service for premium audio feedback
class SoundService {
  final AudioPlayer _player = AudioPlayer();
  bool _isMuted = false;

  /// Toggle mute state
  void toggleMute() {
    _isMuted = !_isMuted;
  }

  /// Get current mute state
  bool get isMuted => _isMuted;

  /// Play a tap/click sound
  Future<void> playTap() async {
    if (_isMuted) return;
    await _playSystemSound(SystemSoundType.click);
  }

  /// Play success sound (for healthy BMI)
  Future<void> playSuccess() async {
    if (_isMuted) return;
    await _playTone(frequency: 880, duration: 150);
    await Future.delayed(const Duration(milliseconds: 100));
    await _playTone(frequency: 1100, duration: 200);
  }

  /// Play warning sound (for unhealthy BMI)
  Future<void> playWarning() async {
    if (_isMuted) return;
    await _playTone(frequency: 440, duration: 300);
  }

  /// Play calculation sound
  Future<void> playCalculate() async {
    if (_isMuted) return;
    await _playTone(frequency: 600, duration: 100);
    await Future.delayed(const Duration(milliseconds: 50));
    await _playTone(frequency: 800, duration: 100);
    await Future.delayed(const Duration(milliseconds: 50));
    await _playTone(frequency: 1000, duration: 150);
  }

  /// Play slider movement sound
  Future<void> playSlide() async {
    if (_isMuted) return;
    await _playSystemSound(SystemSoundType.click);
  }

  /// Play app launch sound
  Future<void> playLaunch() async {
    if (_isMuted) return;
    await _playTone(frequency: 523, duration: 100); // C5
    await Future.delayed(const Duration(milliseconds: 80));
    await _playTone(frequency: 659, duration: 100); // E5
    await Future.delayed(const Duration(milliseconds: 80));
    await _playTone(frequency: 784, duration: 150); // G5
  }

  /// Play counter increment sound
  Future<void> playIncrement() async {
    if (_isMuted) return;
    await _playTone(frequency: 700, duration: 50);
  }

  /// Play counter decrement sound
  Future<void> playDecrement() async {
    if (_isMuted) return;
    await _playTone(frequency: 500, duration: 50);
  }

  Future<void> _playTone({required double frequency, required int duration}) async {
    // Using simple beep generation with AudioPlayer
    // In production, you would use actual audio files
    try {
      await _player.setVolume(0.3);
      // For now, we'll use a simple approach
      // In real app, load from assets/sounds/
    } catch (e) {
      // Silently fail if audio is not available
    }
  }

  Future<void> _playSystemSound(SystemSoundType type) async {
    // Platform-specific system sounds handled here
    try {
      await _player.setVolume(0.2);
    } catch (e) {
      // Silently fail
    }
  }

  void dispose() {
    _player.dispose();
  }
}

enum SystemSoundType { click, alert }

/// Provider for sound service
final soundServiceProvider = Provider<SoundService>((ref) {
  final service = SoundService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Provider for mute state
final isMutedProvider = StateProvider<bool>((ref) => false);
