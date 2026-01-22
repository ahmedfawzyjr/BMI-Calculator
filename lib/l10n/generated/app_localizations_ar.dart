// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'حاسبة مؤشر كتلة الجسم';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get height => 'الطول';

  @override
  String get weight => 'الوزن';

  @override
  String get age => 'العمر';

  @override
  String get calculate => 'احسب';

  @override
  String get yourResult => 'نتيجتك';

  @override
  String get normalRange => 'معدل الجسم الطبيعي:';

  @override
  String get normalRangeValue => '18.5 - 25 كجم/م2';

  @override
  String get saveResult => 'حفظ النتيجة';

  @override
  String get recalculate => 'إعادة الحساب';

  @override
  String get cm => 'سم';

  @override
  String get resultUnderweight => 'نحيف';

  @override
  String get resultNormal => 'طبيعي';

  @override
  String get resultOverweight => 'وزن زائد';

  @override
  String get adviceUnderweight =>
      'لديك وزن جسم أقل من الطبيعي. يمكنك أن تأكل أكثر قليلاً.';

  @override
  String get adviceNormal => 'لديك وزن جسم طبيعي. عمل جيد!';

  @override
  String get adviceOverweight =>
      'لديك وزن جسم أعلى من الطبيعي. حاول ممارسة الرياضة أكثر.';
}
