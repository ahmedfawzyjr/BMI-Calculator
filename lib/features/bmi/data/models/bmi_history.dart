import 'package:bmi_calculator/features/bmi/domain/bmi_category.dart';
import 'package:hive/hive.dart';

class BMIHistory {
  final String id;
  final double bmi;
  final BMICategory category;
  final DateTime date;

  BMIHistory({
    required this.id,
    required this.bmi,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bmi': bmi,
      'category': category.index,
      'date': date.toIso8601String(),
    };
  }

  factory BMIHistory.fromMap(Map<String, dynamic> map) {
    return BMIHistory(
      id: map['id'],
      bmi: map['bmi'],
      category: BMICategory.values[map['category']],
      date: DateTime.parse(map['date']),
    );
  }
}

class BMIHistoryAdapter extends TypeAdapter<BMIHistory> {
  @override
  final int typeId = 0;

  @override
  BMIHistory read(BinaryReader reader) {
    final map = reader.readMap();
    return BMIHistory.fromMap(Map<String, dynamic>.from(map));
  }

  @override
  void write(BinaryWriter writer, BMIHistory obj) {
    writer.writeMap(obj.toMap());
  }
}
