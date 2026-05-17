import 'package:bmi_calculator/features/bmi/data/models/bmi_history.dart';
import 'package:hive/hive.dart';

class HistoryRepository {
  static const String boxName = 'bmi_history';

  Future<void> addResult(BMIHistory result) async {
    final box = await Hive.openBox<BMIHistory>(boxName);
    await box.add(result);
  }

  Future<List<BMIHistory>> getHistory() async {
    final box = await Hive.openBox<BMIHistory>(boxName);
    return box.values.toList().reversed.toList();
  }

  Future<void> clearHistory() async {
    final box = await Hive.openBox<BMIHistory>(boxName);
    await box.clear();
  }

  Future<void> deleteResult(String id) async {
    final box = await Hive.openBox<BMIHistory>(boxName);
    final keyToDelete = box.keys.firstWhere(
      (k) => box.get(k)?.id == id,
      orElse: () => null,
    );
    if (keyToDelete != null) {
      await box.delete(keyToDelete);
    }
  }
}
