import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'BMI CALCULATOR'**
  String get appTitle;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'MALE'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'FEMALE'**
  String get female;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'HEIGHT'**
  String get height;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT'**
  String get weight;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'AGE'**
  String get age;

  /// No description provided for @calculate.
  ///
  /// In en, this message translates to:
  /// **'CALCULATE'**
  String get calculate;

  /// No description provided for @yourResult.
  ///
  /// In en, this message translates to:
  /// **'Your Result'**
  String get yourResult;

  /// No description provided for @normalRange.
  ///
  /// In en, this message translates to:
  /// **'Normal BMI range:'**
  String get normalRange;

  /// No description provided for @normalRangeValue.
  ///
  /// In en, this message translates to:
  /// **'18.5 - 25 kg/m2'**
  String get normalRangeValue;

  /// No description provided for @saveResult.
  ///
  /// In en, this message translates to:
  /// **'SAVE RESULT'**
  String get saveResult;

  /// No description provided for @recalculate.
  ///
  /// In en, this message translates to:
  /// **'RE-CALCULATE'**
  String get recalculate;

  /// No description provided for @cm.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get cm;

  /// No description provided for @resultUnderweight.
  ///
  /// In en, this message translates to:
  /// **'Underweight'**
  String get resultUnderweight;

  /// No description provided for @resultNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get resultNormal;

  /// No description provided for @resultOverweight.
  ///
  /// In en, this message translates to:
  /// **'Overweight'**
  String get resultOverweight;

  /// No description provided for @obese.
  ///
  /// In en, this message translates to:
  /// **'Obese'**
  String get obese;

  /// No description provided for @adviceUnderweight.
  ///
  /// In en, this message translates to:
  /// **'You have a lower than normal body weight. You can eat a bit more.'**
  String get adviceUnderweight;

  /// No description provided for @adviceNormal.
  ///
  /// In en, this message translates to:
  /// **'You have a normal body weight. Good job!'**
  String get adviceNormal;

  /// No description provided for @adviceOverweight.
  ///
  /// In en, this message translates to:
  /// **'You have a higher than normal body weight. Try to exercise more.'**
  String get adviceOverweight;

  /// No description provided for @adviceObese.
  ///
  /// In en, this message translates to:
  /// **'You have an obese body weight. Please consult a doctor or a nutritionist.'**
  String get adviceObese;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get clearHistory;

  /// No description provided for @clearHistoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear your entire history? This action cannot be undone.'**
  String get clearHistoryConfirm;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @calculateBmiPrompt.
  ///
  /// In en, this message translates to:
  /// **'Calculate your BMI to see trends here!'**
  String get calculateBmiPrompt;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @enableSound.
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get enableSound;

  /// No description provided for @enableHaptic.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get enableHaptic;

  /// No description provided for @enableParticles.
  ///
  /// In en, this message translates to:
  /// **'Particle Background'**
  String get enableParticles;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @averageBmi.
  ///
  /// In en, this message translates to:
  /// **'Avg BMI'**
  String get averageBmi;

  /// No description provided for @maxBmi.
  ///
  /// In en, this message translates to:
  /// **'Max BMI'**
  String get maxBmi;

  /// No description provided for @minBmi.
  ///
  /// In en, this message translates to:
  /// **'Min BMI'**
  String get minBmi;

  /// No description provided for @totalCalculations.
  ///
  /// In en, this message translates to:
  /// **'Total Calculations'**
  String get totalCalculations;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No history records found.'**
  String get noHistory;

  /// No description provided for @errorSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Please select your gender first!'**
  String get errorSelectGender;

  /// No description provided for @errorInvalidHeight.
  ///
  /// In en, this message translates to:
  /// **'Height must be between 50 and 250 cm!'**
  String get errorInvalidHeight;

  /// No description provided for @errorInvalidWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight must be between 10 and 300 kg!'**
  String get errorInvalidWeight;

  /// No description provided for @errorInvalidAge.
  ///
  /// In en, this message translates to:
  /// **'Age must be between 1 and 120 years!'**
  String get errorInvalidAge;

  /// Text shared by the user about their BMI result
  ///
  /// In en, this message translates to:
  /// **'My BMI is {bmi} ({category})! Calculated using modern BMI App.'**
  String shareText(String bmi, String category);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
