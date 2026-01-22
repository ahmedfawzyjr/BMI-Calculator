import 'package:bmi_calculator/features/bmi/data/models/bmi_history.dart';
import 'package:bmi_calculator/features/bmi/data/repositories/history_repository.dart';
import 'package:bmi_calculator/features/bmi/domain/bmi_category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';

void main() {
  group('HistoryRepository', () {
    late HistoryRepository repository;

    setUp(() async {
      await setUpTestHive();
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(BMIHistoryAdapter());
      }
      repository = HistoryRepository();
    });

    tearDown(() async {
      await tearDownTestHive();
    });

    test('adds and retrieves history', () async {
      final history = BMIHistory(
        id: '1',
        bmi: 22.0,
        category: BMICategory.normal,
        date: DateTime.now(),
      );

      await repository.addResult(history);
      final results = await repository.getHistory();

      expect(results.length, 1);
      expect(results.first.bmi, 22.0);
      expect(results.first.category, BMICategory.normal);
    });

    test('clears history', () async {
      final history = BMIHistory(
        id: '1',
        bmi: 22.0,
        category: BMICategory.normal,
        date: DateTime.now(),
      );

      await repository.addResult(history);
      await repository.clearHistory();
      final results = await repository.getHistory();

      expect(results.isEmpty, true);
    });
  });
}
