# خطة التنفيذ: تحسين تطبيق حاسبة BMI

## نظرة عامة

تحويل تطبيق BMI الحالي إلى تجربة مستخدم استثنائية مع تأثيرات بصرية متقدمة، أنيميشن سلس، ودعم كامل للغتين. المهام مرتبة بشكل تصاعدي حيث كل مهمة تبني على السابقة.

## المهام

- [ ] 1. إصلاح المشاكل الحالية وتحديث الأساس
  - استبدال جميع استخدامات `withOpacity()` المهجورة بـ `withValues(alpha:)` في الملفات: glass_card.dart، animated_3d_card.dart، counter_button.dart، glow_slider.dart، pulse_button.dart، bmi_gauge.dart، splash_screen.dart، input_page.dart، result_page.dart، history_screen.dart
  - إضافة `const` للـ constructors الثابتة في جميع الملفات
  - إزالة الـ unused imports (particles_flutter في splash_screen.dart)
  - إصلاح الـ unused variables (size في splash_screen.dart، l10n في history_screen.dart)
  - _المتطلبات: 13.3_

  - [ ] 1.1 كتابة اختبار للتحقق من عدم وجود withOpacity في الكود
    - **الخاصية 0: لا يوجد withOpacity**
    - **يتحقق من: المتطلب 13.3**


- [ ] 2. إضافة التبعيات الجديدة وتحديث pubspec.yaml
  - إضافة `shared_preferences: ^2.3.2` لحفظ الإعدادات
  - إضافة `share_plus: ^10.0.0` لمشاركة النتيجة
  - إضافة `screenshot: ^3.0.0` لالتقاط صورة للمشاركة
  - إضافة `path_provider: ^2.1.4` لمسارات الملفات
  - إضافة `csv: ^6.0.0` لتصدير السجل
  - تشغيل `flutter pub get` للتحقق من التوافق
  - _المتطلبات: 6.8، 9.7_

- [ ] 3. إنشاء نظام الألوان والخطوط المحسّن
  - [ ] 3.1 إنشاء `lib/core/theme/app_colors.dart` مع ألوان الوضعين الداكن والفاتح
    - تعريف `DarkColors` و`LightColors` كـ abstract classes
    - نقل جميع الألوان من app_theme.dart إلى هذا الملف
    - إضافة ألوان الوضع الفاتح: background `#F0F4FF`، surface `#FFFFFF`، text `#1A1A2E`
    - _المتطلبات: 1.4، 1.5، 1.6_

  - [ ] 3.2 إنشاء `lib/core/theme/app_typography.dart` مع دعم خط Cairo العربي
    - إضافة `GoogleFonts.cairo()` لجميع النصوص العربية
    - إنشاء دالة `adaptive()` تختار الخط حسب اللغة الحالية
    - تعريف 8 مستويات نصية مع الأحجام المحددة في التصميم
    - _المتطلبات: 2.1، 2.2، 2.3، 2.4_

  - [ ] 3.3 كتابة اختبار للتحقق من مستويات الخطوط
    - التحقق من أن كل مستوى له الحجم الصحيح (displayLarge=100، displayMedium=50، إلخ)
    - **يتحقق من: المتطلب 2.4**

  - [ ] 3.4 تحديث `lib/core/theme/app_theme.dart` لدعم الوضع الفاتح
    - إضافة `static ThemeData get lightTheme` مع لوحة الألوان الفاتحة
    - تحديث `darkTheme` ليستخدم الملفات الجديدة
    - _المتطلبات: 1.1، 1.4، 1.5_

- [ ] 4. إنشاء خدمات الأساس الجديدة
  - [ ] 4.1 إنشاء `lib/core/services/haptic_service.dart`
    - تنفيذ `HapticFeedback.lightImpact()` و`mediumImpact()` و`heavyImpact()`
    - تنفيذ نمط النجاح: ثلاث نبضات متصاعدة بتأخير 100ms
    - تنفيذ نمط الخطأ: نبضتان متتاليتان
    - إنشاء `hapticServiceProvider` في Riverpod
    - _المتطلبات: 11.1، 11.2، 11.3، 11.4، 11.5_

  - [ ] 4.2 كتابة اختبار للتحقق من واجهة HapticService
    - التحقق من وجود الدوال الأربع الأساسية
    - **يتحقق من: المتطلب 11.1**

  - [ ] 4.3 إنشاء `lib/core/data/preferences_repository.dart`
    - تنفيذ حفظ واسترجاع: ThemeMode، Locale، soundEnabled، hapticEnabled، particlesEnabled
    - استخدام SharedPreferences كـ backend
    - إنشاء `preferencesRepositoryProvider`
    - _المتطلبات: 1.3، 14.6، 16.8_

  - [ ] 4.4 كتابة اختبار Round Trip للإعدادات
    - **الخاصية 1: Round Trip لحفظ الإعدادات**
    - توليد قيم عشوائية لكل إعداد، حفظها، استرجاعها، التحقق من التطابق
    - **يتحقق من: المتطلبات 1.3، 16.8**

  - [ ] 4.5 تحديث `lib/core/services/sound_service.dart`
    - تنفيذ فعلي للمؤثرات الصوتية باستخدام audioplayers
    - إضافة ملفات صوتية في `assets/sounds/` (tap.mp3، success.mp3، warning.mp3، calculate.mp3)
    - ربط حالة الكتم بـ `preferencesRepository`
    - _المتطلبات: 11.6، 11.7، 11.8_


- [ ] 5. إنشاء Providers الجديدة وتحديث الموجودة
  - [ ] 5.1 تحديث `lib/features/bmi/presentation/providers/bmi_providers.dart`
    - إضافة `themeProvider` من نوع `StateNotifierProvider<ThemeNotifier, ThemeMode>`
    - إضافة `localeProvider` من نوع `StateNotifierProvider<LocaleNotifier, Locale>`
    - إضافة `settingsProvider` يجمع جميع إعدادات التطبيق
    - إضافة `bmiStatisticsProvider` يحسب الإحصائيات من السجل
    - _المتطلبات: 1.2، 14.1، 16.1_

  - [ ] 5.2 تحديث `lib/main.dart`
    - ربط `themeProvider` بـ `MaterialApp.router`
    - ربط `localeProvider` بـ `MaterialApp.router`
    - تحميل الإعدادات المحفوظة عند بدء التطبيق
    - _المتطلبات: 1.3، 14.6_

- [ ] 6. تحديث Domain Layer
  - [ ] 6.1 تحديث `lib/features/bmi/domain/bmi_category.dart`
    - إضافة فئة `obese` للـ BMI ≥ 30
    - _المتطلبات: 5.1_

  - [ ] 6.2 تحديث `lib/features/bmi/domain/calculator_brain.dart`
    - تحديث `getCategory()` لدعم الفئة الجديدة `obese`
    - إضافة `getAdvice()` تُعيد نصيحة مخصصة لكل فئة
    - _المتطلبات: 5.5_

  - [ ] 6.3 كتابة اختبار خاصية تصنيف BMI
    - **الخاصية 6: صحة تصنيف BMI**
    - توليد قيم BMI عشوائية والتحقق من صحة التصنيف لكل نطاق
    - **يتحقق من: المتطلب 5.1**

  - [ ] 6.4 إنشاء `lib/features/bmi/domain/input_validator.dart`
    - تنفيذ `isValidHeight()`، `isValidWeight()`، `isValidAge()`، `isGenderSelected()`
    - _المتطلبات: 4.10_

  - [ ] 6.5 كتابة اختبار خاصية التحقق من المدخلات
    - **الخاصية 7: التحقق من صحة المدخلات**
    - توليد قيم خارج النطاق والتحقق من الرفض
    - **يتحقق من: المتطلب 4.10**

- [ ] 7. تحديث Data Layer
  - [ ] 7.1 تحديث `lib/features/bmi/data/models/bmi_history.dart`
    - إضافة حقل `gender` اختياري
    - إضافة حقل `height` و`weight` اختياريين
    - _المتطلبات: 5.8_

  - [ ] 7.2 تحديث `lib/features/bmi/data/repositories/history_repository.dart`
    - إضافة `getStatistics()` تُعيد `BMIStatistics`
    - إضافة `getFilteredHistory(DateRange range)` للتصفية الزمنية
    - إضافة `exportToCSV()` لتصدير البيانات
    - _المتطلبات: 6.5، 6.6، 6.8_

  - [ ] 7.3 كتابة اختبار خاصية صحة الإحصائيات
    - **الخاصية 2: صحة حساب الإحصائيات**
    - توليد قوائم عشوائية من القياسات والتحقق من: أعلى ≥ جميع القيم، أدنى ≤ جميع القيم، المتوسط بين الحدين
    - **يتحقق من: المتطلب 6.5**

- [ ] 8. نقطة تفتيش - التأكد من اجتياز جميع الاختبارات
  - تشغيل `flutter test` والتأكد من نجاح جميع الاختبارات
  - التأكد من عدم وجود أخطاء في `flutter analyze`
  - اسأل المستخدم إذا كان هناك أي أسئلة قبل المتابعة


- [ ] 9. إنشاء Widgets الأساسية الجديدة
  - [ ] 9.1 إنشاء `lib/core/widgets/particle_background.dart`
    - تنفيذ `ParticleSystem` باستخدام `CustomPainter` و`AnimationController`
    - دعم 60-100 جسيم بألوان وسرعات عشوائية
    - تنفيذ تأثير التنافر عند اللمس (`GestureDetector` + `repel()`)
    - استخدام `RepaintBoundary` لعزل الأداء
    - _المتطلبات: 8.1، 8.2، 8.3، 8.7_

  - [ ] 9.2 كتابة اختبار خاصية عدد الجسيمات
    - **الخاصية 4: عدد الجسيمات ضمن النطاق**
    - التحقق من أن عدد الجسيمات المُنشأ ضمن النطاق [60, 100]
    - **يتحقق من: المتطلب 8.1**

  - [ ] 9.3 إنشاء `lib/core/widgets/neumorphic_container.dart`
    - تنفيذ ظلين: داكن أسفل-يمين، فاتح أعلى-يسار
    - تنفيذ تأثير الضغط الداخلي عند `isPressed = true`
    - دعم كلا الوضعين الداكن والفاتح
    - _المتطلبات: 7.4، 7.5، 7.6_

  - [ ] 9.4 تحديث `lib/core/widgets/glass_card.dart`
    - إضافة دعم الوضع الفاتح مع ألوان مناسبة
    - تحسين تأثير الـ Glow الخارجي
    - _المتطلبات: 7.1، 7.2، 7.3، 7.6_

  - [ ] 9.5 إنشاء `lib/shared/widgets/settings_tile.dart`
    - Widget قابل لإعادة الاستخدام لعناصر قائمة الإعدادات
    - دعم: Toggle Switch، Dropdown، زر عادي
    - تطبيق أنيميشن عند التغيير
    - _المتطلبات: 16.1، 16.2، 16.3، 16.4_

- [ ] 10. تحديث شاشة البداية (Splash Screen)
  - [ ] 10.1 تفعيل `ParticleBackground` في splash_screen.dart
    - استبدال الـ placeholder بـ `ParticleBackground` الفعلي
    - ضبط: 80 جسيم، ألوان التطبيق، شفافية 30%
    - _المتطلبات: 3.2_

  - [ ] 10.2 إضافة Haptic Feedback عند اكتمال تحميل الشعار
    - استدعاء `hapticService.light()` بعد اكتمال Scale animation
    - _المتطلبات: 3.7_

  - [ ] 10.3 تفعيل المؤثر الصوتي عند الإطلاق
    - استدعاء `soundService.playLaunch()` في `initState`
    - _المتطلبات: 3.4_

  - [ ] 10.4 إصلاح الـ warnings المتبقية في splash_screen.dart
    - إزالة متغير `size` غير المستخدم
    - إزالة import particles_flutter غير المستخدم
    - _المتطلبات: 13.2_

- [ ] 11. تحديث شاشة الإدخال (Input Page)
  - [ ] 11.1 إضافة Haptic Feedback لاختيار الجنس وأزرار العداد
    - استدعاء `hapticService.medium()` عند اختيار الجنس
    - استدعاء `hapticService.light()` عند ضغط +/-
    - استدعاء `hapticService.heavy()` عند ضغط "احسب"
    - _المتطلبات: 4.3، 4.7، 4.8_

  - [ ] 11.2 إضافة المؤثرات الصوتية لشاشة الإدخال
    - استدعاء `soundService.playTap()` عند اختيار الجنس
    - استدعاء `soundService.playIncrement/Decrement()` عند +/-
    - استدعاء `soundService.playCalculate()` عند الحساب
    - _المتطلبات: 4.7، 11.6_

  - [ ] 11.3 إضافة `ParticleBackground` لشاشة الإدخال
    - إضافة طبقة جسيمات شفافة في الخلفية
    - ضبط: 40 جسيم، شفافية 15%، غير تفاعلي
    - _المتطلبات: 4.9_

  - [ ] 11.4 إضافة Shake Animation عند محاولة الحساب بدون اختيار جنس
    - تنفيذ `InputValidator.isGenderSelected()` قبل الانتقال
    - تطبيق `.animate().shake()` على بطاقتي الجنس
    - عرض SnackBar تحذيري
    - _المتطلبات: 4.10_

  - [ ] 11.5 كتابة اختبار Widget لشاشة الإدخال
    - اختبار أن الضغط على "احسب" بدون جنس يُظهر رسالة خطأ
    - **يتحقق من: المتطلب 4.10**

  - [ ] 11.6 إضافة زر الإعدادات في AppBar
    - إضافة `IconButton` للإعدادات بجانب أيقونة السجل
    - _المتطلبات: 16.1_


- [ ] 12. تحديث شاشة النتيجة (Result Page)
  - [ ] 12.1 إضافة فئة `obese` لشاشة النتيجة
    - تحديث `_getCategoryColor()` لدعم `BMICategory.obese`
    - تحديث `switch` الخاص بـ resultText وadvise
    - _المتطلبات: 5.1_

  - [ ] 12.2 إضافة شريط BMI المرئي (Visual BMI Bar)
    - إنشاء Widget مخصص يعرض موضع BMI على شريط ملون
    - تطبيق أنيميشن تحريك المؤشر من اليسار لموضعه الصحيح
    - _المتطلبات: 5.6_

  - [ ] 12.3 إضافة مقارنة مع آخر قياس محفوظ
    - قراءة آخر قياس من `historyProvider`
    - عرض سهم ↑ أخضر أو ↓ أحمر مع الفرق
    - _المتطلبات: 5.8_

  - [ ] 12.4 إضافة زر المشاركة
    - استخدام `screenshot` package لالتقاط بطاقة النتيجة
    - استخدام `share_plus` لمشاركة الصورة
    - _المتطلبات: 5.9_

  - [ ] 12.5 إضافة Haptic Feedback للنتيجة
    - `hapticService.success()` عند BMI طبيعي
    - `hapticService.medium()` عند BMI غير طبيعي
    - _المتطلبات: 11.5_

  - [ ] 12.6 كتابة اختبار خاصية Confetti
    - **الخاصية 3: Confetti يُشغَّل فقط للـ BMI الطبيعي**
    - التحقق من أن `_confettiController.play()` يُستدعى فقط عند `BMICategory.normal`
    - **يتحقق من: المتطلب 5.2**

- [ ] 13. تحديث شاشة السجل (History Screen)
  - [ ] 13.1 إضافة بطاقة الإحصائيات الملخصة
    - إنشاء `lib/features/bmi/presentation/widgets/bmi_statistics_card.dart`
    - عرض: أعلى قيمة، أدنى قيمة، المتوسط، العدد الكلي
    - تطبيق أنيميشن ظهور مع CountUp للأرقام
    - _المتطلبات: 6.5_

  - [ ] 13.2 إضافة فلتر الفترة الزمنية
    - إضافة Row من أزرار: أسبوع، شهر، 3 أشهر، الكل
    - ربطها بـ `getFilteredHistory()` في Repository
    - تطبيق أنيميشن تغيير الاختيار
    - _المتطلبات: 6.6_

  - [ ] 13.3 تحديث الرسم البياني ليكون تفاعلياً
    - تفعيل `touchData` في fl_chart لعرض Tooltip عند الضغط
    - إضافة دعم Pinch to Zoom
    - _المتطلبات: 6.1، 6.2_

  - [ ] 13.4 إضافة زر تصدير CSV
    - إضافة `IconButton` في AppBar
    - استدعاء `historyRepository.exportToCSV()`
    - مشاركة الملف باستخدام `share_plus`
    - _المتطلبات: 6.8_

  - [ ] 13.5 تحديث شاشة السجل الفارغ
    - استبدال الأيقونة الثابتة بـ Lottie animation
    - إضافة نص تحفيزي بالعربية والإنجليزية
    - _المتطلبات: 6.7_

  - [ ] 13.6 إضافة ترجمة "History" في AppBar
    - استخدام `l10n.history` بدلاً من النص الثابت
    - إضافة مفتاح `history` لملفات الـ ARB
    - _المتطلبات: 14.3_

- [ ] 14. إنشاء شاشة الإعدادات (Settings Screen) - جديدة
  - [ ] 14.1 إنشاء `lib/features/bmi/presentation/screens/settings_screen.dart`
    - هيكل الشاشة مع AppBar وقسمين: Appearance وAudio & Haptics
    - استخدام `GlassCard` لكل قسم
    - _المتطلبات: 16.1_

  - [ ] 14.2 إضافة خيار تبديل الثيم
    - `DropdownButton` أو `SegmentedButton` للاختيار بين داكن/فاتح
    - ربطه بـ `themeProvider` مع تطبيق فوري
    - _المتطلبات: 16.1_

  - [ ] 14.3 إضافة خيار تبديل اللغة
    - `DropdownButton` للاختيار بين عربي/إنجليزي
    - ربطه بـ `localeProvider` مع تطبيق فوري
    - _المتطلبات: 16.2_

  - [ ] 14.4 إضافة خيارات الصوت والاهتزاز والجسيمات
    - ثلاثة `Switch` مع `SettingsTile`
    - ربطها بـ `preferencesRepository` للحفظ الفوري
    - _المتطلبات: 16.3، 16.4، 16.5_

  - [ ] 14.5 إضافة زر مسح السجل مع تأكيد
    - `AlertDialog` مع تأكيد قبل الحذف
    - تطبيق أنيميشن اختفاء للبيانات
    - _المتطلبات: 16.6_

  - [ ] 14.6 إضافة مسار الإعدادات في app_router.dart
    - إضافة `GoRoute` لمسار `/settings`
    - _المتطلبات: 16.1_

  - [ ] 14.7 كتابة اختبار Widget لشاشة الإعدادات
    - التحقق من وجود جميع خيارات الإعدادات
    - **يتحقق من: المتطلبات 16.1-16.5**

- [ ] 15. نقطة تفتيش - التأكد من اجتياز جميع الاختبارات
  - تشغيل `flutter test` والتأكد من نجاح جميع الاختبارات
  - التأكد من عدم وجود أخطاء في `flutter analyze`
  - اسأل المستخدم إذا كان هناك أي أسئلة قبل المتابعة


- [ ] 16. تحديث ملفات الترجمة وإضافة مفاتيح جديدة
  - [ ] 16.1 تحديث `lib/l10n/arb/app_ar.arb`
    - إضافة: `history`، `settings`، `theme`، `language`، `soundEffects`، `hapticFeedback`، `particleEffects`، `clearHistory`، `clearHistoryConfirm`، `darkMode`، `lightMode`، `arabic`، `english`
    - إضافة: `obese`، `resultObese`، `adviceObese`
    - إضافة: `highest`، `lowest`، `average`، `totalMeasurements`
    - إضافة: `shareResult`، `exportCSV`، `noHistory`، `noHistorySubtitle`
    - _المتطلبات: 14.3_

  - [ ] 16.2 تحديث `lib/l10n/arb/app_en.arb`
    - إضافة نفس المفاتيح بالإنجليزية
    - _المتطلبات: 14.3_

  - [ ] 16.3 كتابة اختبار خاصية تناسق الترجمة
    - **الخاصية 5: تناسق الترجمة بين اللغتين**
    - التحقق من أن كل مفتاح في app_en.arb موجود في app_ar.arb وليس فارغاً
    - **يتحقق من: المتطلبات 14.1، 14.3**

- [ ] 17. إضافة دعم إمكانية الوصول (Accessibility)
  - [ ] 17.1 إضافة Semantics labels لجميع العناصر التفاعلية
    - إضافة `Semantics(label: l10n.maleLabel)` لبطاقة الذكر
    - إضافة `Semantics(label: l10n.femaleLabel)` لبطاقة الأنثى
    - إضافة `Semantics` لجميع الأزرار والـ Sliders
    - _المتطلبات: 12.1_

  - [ ] 17.2 إضافة Tooltip لجميع الأيقونات
    - إضافة `Tooltip(message: ...)` لأيقونة السجل والإعدادات والحذف
    - _المتطلبات: 12.6_

  - [ ] 17.3 كتابة اختبار للتحقق من وجود Semantics
    - التحقق من أن العناصر الرئيسية لها Semantics labels
    - **يتحقق من: المتطلب 12.1**

- [ ] 18. تحسينات الأداء النهائية
  - [ ] 18.1 إضافة RepaintBoundary للعناصر المتحركة
    - تغليف `ParticleBackground` بـ `RepaintBoundary`
    - تغليف `BMIGauge` بـ `RepaintBoundary`
    - تغليف `PulseButton` بـ `RepaintBoundary`
    - _المتطلبات: 13.4_

  - [ ] 18.2 تطبيق Lazy Loading على قائمة السجل
    - التأكد من استخدام `ListView.builder` (موجود بالفعل)
    - إضافة Pagination عند تجاوز 50 عنصر
    - _المتطلبات: 13.5، 13.7_

  - [ ] 18.3 تحسين استخدام const constructors
    - مراجعة جميع الملفات وإضافة `const` حيثما أمكن
    - _المتطلبات: 13.2_

- [ ] 19. اختبارات التكامل النهائية
  - [ ] 19.1 كتابة اختبار Round Trip لتنسيق الأرقام
    - **الخاصية 8: Round Trip لتنسيق الأرقام**
    - توليد أرقام عشوائية، تحويلها للعربية، تحويلها مرة أخرى، التحقق من التطابق
    - **يتحقق من: المتطلب 14.4**

  - [ ] 19.2 كتابة اختبار تكامل لتدفق التطبيق الكامل
    - تدفق: إدخال بيانات → حساب → عرض نتيجة → حفظ → عرض في السجل
    - **يتحقق من: المتطلبات 4.1، 5.7، 6.3**

- [ ] 20. نقطة تفتيش نهائية - التأكد من اكتمال التطوير
  - تشغيل `flutter test` والتأكد من نجاح جميع الاختبارات
  - تشغيل `flutter analyze` والتأكد من عدم وجود أخطاء أو تحذيرات
  - مراجعة جميع الشاشات للتأكد من تطبيق التحسينات
  - اسأل المستخدم إذا كان هناك أي أسئلة أو تعديلات مطلوبة

## ملاحظات

- جميع المهام إلزامية بما فيها اختبارات الخصائص
- كل مهمة تبني على السابقة - لا تتخطَّ المهام
- نقاط التفتيش (8، 15، 20) ضرورية للتحقق من سلامة الكود
- اختبارات الخصائص تستخدم مكتبة `test` الافتراضية مع 100 تكرار كحد أدنى
- كل اختبار خاصية يجب أن يُشير لرقم الخاصية في التصميم بالتعليق: `// Feature: bmi-app-enhancement, Property N: ...`
