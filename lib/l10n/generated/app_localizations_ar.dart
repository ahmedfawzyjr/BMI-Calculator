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
  String get obese => 'سمين';

  @override
  String get adviceUnderweight =>
      'لديك وزن جسم أقل من الطبيعي. يمكنك أن تأكل أكثر قليلاً.';

  @override
  String get adviceNormal => 'لديك وزن جسم طبيعي. عمل جيد!';

  @override
  String get adviceOverweight =>
      'لديك وزن جسم أعلى من الطبيعي. حاول ممارسة الرياضة أكثر.';

  @override
  String get adviceObese =>
      'لديك سمنة مفرطة. يرجى استشارة الطبيب أو أخصائي التغذية.';

  @override
  String get history => 'السجل';

  @override
  String get clearHistory => 'مسح السجل';

  @override
  String get clearHistoryConfirm =>
      'هل أنت متأكد من رغبتك في مسح السجل بالكامل؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get confirm => 'تأكيد';

  @override
  String get cancel => 'إلغاء';

  @override
  String get calculateBmiPrompt => 'احسب مؤشر كتلة جسمك لتشاهد إحصائياتك هنا!';

  @override
  String get settings => 'الإعدادات';

  @override
  String get enableSound => 'المؤثرات الصوتية';

  @override
  String get enableHaptic => 'الاهتزاز التفاعلي';

  @override
  String get enableParticles => 'خلفية الجسيمات';

  @override
  String get exportData => 'تصدير البيانات';

  @override
  String get theme => 'المظهر';

  @override
  String get language => 'اللغة';

  @override
  String get statistics => 'الإحصائيات';

  @override
  String get averageBmi => 'متوسط المؤشر';

  @override
  String get maxBmi => 'أعلى مؤشر';

  @override
  String get minBmi => 'أدنى مؤشر';

  @override
  String get totalCalculations => 'إجمالي الحسابات';

  @override
  String get noHistory => 'لا توجد سجلات محفوظة.';

  @override
  String get errorSelectGender => 'يرجى اختيار جنسك أولاً!';

  @override
  String get errorInvalidHeight => 'يجب أن يكون الطول بين 50 و 250 سم!';

  @override
  String get errorInvalidWeight => 'يجب أن يكون الوزن بين 10 و 300 كجم!';

  @override
  String get errorInvalidAge => 'يجب أن يكون العمر بين 1 و 120 سنة!';

  @override
  String shareText(String bmi, String category) {
    return 'مؤشر كتلة جسمي هو $bmi ($category)! تم حسابه باستخدام تطبيق BMI الحديث.';
  }
}
