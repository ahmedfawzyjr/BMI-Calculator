// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'BMI CALCULATOR';

  @override
  String get male => 'MALE';

  @override
  String get female => 'FEMALE';

  @override
  String get height => 'HEIGHT';

  @override
  String get weight => 'WEIGHT';

  @override
  String get age => 'AGE';

  @override
  String get calculate => 'CALCULATE';

  @override
  String get yourResult => 'Your Result';

  @override
  String get normalRange => 'Normal BMI range:';

  @override
  String get normalRangeValue => '18.5 - 25 kg/m2';

  @override
  String get saveResult => 'SAVE RESULT';

  @override
  String get recalculate => 'RE-CALCULATE';

  @override
  String get cm => 'cm';

  @override
  String get resultUnderweight => 'Underweight';

  @override
  String get resultNormal => 'Normal';

  @override
  String get resultOverweight => 'Overweight';

  @override
  String get adviceUnderweight =>
      'You have a lower than normal body weight. You can eat a bit more.';

  @override
  String get adviceNormal => 'You have a normal body weight. Good job!';

  @override
  String get adviceOverweight =>
      'You have a higher than normal body weight. Try to exercise more.';
}
