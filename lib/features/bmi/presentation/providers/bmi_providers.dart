import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bmi_calculator/features/bmi/domain/gender.dart';

import 'package:bmi_calculator/features/bmi/data/models/bmi_history.dart';
import 'package:bmi_calculator/features/bmi/data/repositories/history_repository.dart';

final genderProvider = StateProvider<Gender>((ref) => Gender.male);
final heightProvider = StateProvider<int>((ref) => 180);
final weightProvider = StateProvider<int>((ref) => 60);
final ageProvider = StateProvider<int>((ref) => 20);

final historyRepositoryProvider = Provider((ref) => HistoryRepository());

final historyProvider = FutureProvider<List<BMIHistory>>((ref) async {
  final repository = ref.watch(historyRepositoryProvider);
  return repository.getHistory();
});
