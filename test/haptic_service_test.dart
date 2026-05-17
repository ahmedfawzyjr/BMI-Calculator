import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bmi_calculator/core/data/preferences_repository.dart';
import 'package:bmi_calculator/core/services/haptic_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('HapticService Tests', () {
    // Feature: bmi-app-enhancement, Property 3: Haptic Service
    final log = <MethodCall>[];
    
    setUp(() {
      log.clear();
      // Intercept platform channel calls for haptic feedback
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (methodCall) async {
        log.add(methodCall);
        return null;
      });
      SharedPreferences.setMockInitialValues({});
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, null);
    });

    test('Haptics play when enabled', () async {
      final prefs = await SharedPreferences.getInstance();
      final repository = PreferencesRepository(prefs);
      await repository.setHapticEnabled(true);

      final container = ProviderContainer(
        overrides: [
          preferencesRepositoryProvider.overrideWithValue(repository),
        ],
      );

      final service = container.read(hapticServiceProvider);
      await service.lightImpact();
      await service.mediumImpact();
      await service.heavyImpact();

      expect(log, isNotEmpty);
      expect(log.any((call) => call.method == 'HapticFeedback.vibrate'), isTrue);
    });

    test('Haptics do not play when disabled', () async {
      final prefs = await SharedPreferences.getInstance();
      final repository = PreferencesRepository(prefs);
      await repository.setHapticEnabled(false);

      final container = ProviderContainer(
        overrides: [
          preferencesRepositoryProvider.overrideWithValue(repository),
        ],
      );

      final service = container.read(hapticServiceProvider);
      await service.lightImpact();
      await service.mediumImpact();
      await service.heavyImpact();

      expect(log, isEmpty);
    });
  });
}
