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
  String get obese => 'Obese';

  @override
  String get adviceUnderweight =>
      'You have a lower than normal body weight. You can eat a bit more.';

  @override
  String get adviceNormal => 'You have a normal body weight. Good job!';

  @override
  String get adviceOverweight =>
      'You have a higher than normal body weight. Try to exercise more.';

  @override
  String get adviceObese =>
      'You have an obese body weight. Please consult a doctor or a nutritionist.';

  @override
  String get history => 'History';

  @override
  String get clearHistory => 'Clear History';

  @override
  String get clearHistoryConfirm =>
      'Are you sure you want to clear your entire history? This action cannot be undone.';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get calculateBmiPrompt => 'Calculate your BMI to see trends here!';

  @override
  String get settings => 'Settings';

  @override
  String get enableSound => 'Sound Effects';

  @override
  String get enableHaptic => 'Haptic Feedback';

  @override
  String get enableParticles => 'Particle Background';

  @override
  String get exportData => 'Export Data';

  @override
  String get theme => 'Theme Mode';

  @override
  String get language => 'Language';

  @override
  String get statistics => 'Statistics';

  @override
  String get averageBmi => 'Avg BMI';

  @override
  String get maxBmi => 'Max BMI';

  @override
  String get minBmi => 'Min BMI';

  @override
  String get totalCalculations => 'Total Calculations';

  @override
  String get noHistory => 'No history records found.';

  @override
  String get errorSelectGender => 'Please select your gender first!';

  @override
  String get errorInvalidHeight => 'Height must be between 50 and 250 cm!';

  @override
  String get errorInvalidWeight => 'Weight must be between 10 and 300 kg!';

  @override
  String get errorInvalidAge => 'Age must be between 1 and 120 years!';

  @override
  String shareText(String bmi, String category) {
    return 'My BMI is $bmi ($category)! Calculated using modern BMI App.';
  }
}
