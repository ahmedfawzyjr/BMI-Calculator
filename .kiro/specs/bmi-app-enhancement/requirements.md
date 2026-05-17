# وثيقة المتطلبات - تحسين تطبيق حاسبة BMI

## مقدمة

هذه الوثيقة تحدد متطلبات تطوير وتحسين تطبيق حاسبة مؤشر كتلة الجسم (BMI Calculator) المبني بـ Flutter. المشروع الحالي يمتلك بنية جيدة مع طبقات domain/data/presentation، ويستخدم Riverpod للحالة، وHive للتخزين، وgo_router للتنقل. الهدف هو رفع مستوى التطبيق إلى تجربة مستخدم استثنائية مع تأثيرات بصرية متقدمة، أنيميشن سلس، ودعم كامل للغتين العربية والإنجليزية.

## قاموس المصطلحات

- **التطبيق**: تطبيق حاسبة BMI المبني بـ Flutter
- **نظام الثيم**: منظومة الألوان والخطوط والأنماط البصرية (Dark/Light)
- **الأنيميشن**: التأثيرات الحركية والانتقالات بين الشاشات
- **Glassmorphism**: تأثير الزجاج الضبابي مع خلفية شفافة
- **Neumorphism**: تأثير النتوء الناعم بظلال داخلية وخارجية
- **Micro-animations**: تأثيرات حركية صغيرة على العناصر التفاعلية
- **Haptic Feedback**: الاهتزاز اللمسي عند التفاعل
- **Particle Effects**: تأثيرات الجسيمات المتحركة في الخلفية
- **Typography**: منظومة الخطوط والأحجام والأوزان
- **BMI_Calculator**: محرك حساب مؤشر كتلة الجسم
- **Theme_Manager**: مدير نظام الثيم الديناميكي
- **Animation_Controller**: متحكم الأنيميشن المركزي
- **Sound_Service**: خدمة المؤثرات الصوتية
- **Haptic_Service**: خدمة الاهتزاز اللمسي
- **History_Repository**: مستودع سجل القياسات

## المتطلبات

### المتطلب 1: نظام الثيم المتكامل (Dark/Light)

**قصة المستخدم:** بوصفي مستخدماً، أريد التبديل بين الوضع الداكن والفاتح، حتى أتمكن من استخدام التطبيق بشكل مريح في أي إضاءة.

#### معايير القبول

1. THE Theme_Manager SHALL توفير وضعين كاملين: داكن (Dark) وفاتح (Light) مع لوحة ألوان مختلفة لكل وضع
2. WHEN يضغط المستخدم على زر تبديل الثيم، THE Theme_Manager SHALL تطبيق الثيم الجديد فورياً مع أنيميشن انتقال سلس مدته 400 ميلي ثانية
3. THE Theme_Manager SHALL حفظ تفضيل الثيم في التخزين المحلي واستعادته عند إعادة فتح التطبيق
4. WHILE الوضع الداكن مفعّل، THE Theme_Manager SHALL استخدام لوحة الألوان الداكنة: خلفية `#0A0E21`، بطاقات `#1D1E33`، نص أساسي أبيض
5. WHILE الوضع الفاتح مفعّل، THE Theme_Manager SHALL استخدام لوحة الألوان الفاتحة: خلفية `#F0F4FF`، بطاقات `#FFFFFF`، نص أساسي `#1A1A2E`
6. THE Theme_Manager SHALL دعم ألوان التمييز (Accent Colors) المتوافقة مع كلا الوضعين: وردي `#EB1555`، سماوي `#00D9FF`، أخضر `#24D876`
7. IF فشل تحميل الثيم المحفوظ، THEN THE Theme_Manager SHALL الرجوع إلى الوضع الداكن كقيمة افتراضية


### المتطلب 2: منظومة الخطوط (Typography System)

**قصة المستخدم:** بوصفي مستخدماً عربياً أو إنجليزياً، أريد قراءة النصوص بخطوط واضحة وجميلة تتناسب مع اللغة، حتى تكون تجربتي مريحة وأنيقة.

#### معايير القبول

1. THE Typography_System SHALL استخدام خط "Cairo" للنصوص العربية وخط "Outfit" للعناوين الإنجليزية وخط "Inter" للنصوص الإنجليزية العادية
2. WHEN تكون لغة التطبيق عربية، THE Typography_System SHALL تطبيق خط Cairo تلقائياً على جميع النصوص مع ضبط الاتجاه من اليمين لليسار (RTL)
3. WHEN تكون لغة التطبيق إنجليزية، THE Typography_System SHALL تطبيق خطي Outfit وInter حسب نوع النص
4. THE Typography_System SHALL تعريف 8 مستويات نصية: displayLarge (100px)، displayMedium (50px)، headlineLarge (32px)، headlineMedium (27px)، titleLarge (22px)، bodyLarge (18px)، bodyMedium (16px)، labelLarge (18px)
5. THE Typography_System SHALL دعم Variable Font Weights من 300 إلى 900 لكل خط
6. WHEN يتغير حجم النص في إعدادات النظام، THE Typography_System SHALL تكييف الأحجام تلقائياً مع الحفاظ على النسب
7. THE Typography_System SHALL تطبيق Letter Spacing مناسب: 2px للعناوين الكبيرة، 0.5px للنصوص العادية

### المتطلب 3: شاشة البداية (Splash Screen) المحسّنة

**قصة المستخدم:** بوصفي مستخدماً، أريد رؤية شاشة بداية جذابة ومبهجة عند فتح التطبيق، حتى تكون أول انطباعاتي ممتازة.

#### معايير القبول

1. THE Splash_Screen SHALL عرض أنيميشن دوران ثلاثي الأبعاد (3D rotation) للشعار مع تأثير Elastic Out خلال 1500 ميلي ثانية
2. THE Splash_Screen SHALL تشغيل تأثير الجسيمات (Particle Effects) في الخلفية بـ 80 جسيماً متحركاً بألوان التطبيق
3. THE Splash_Screen SHALL عرض نص "BMI Calculator" مع تأثير Shimmer متدرج من الأبيض إلى السماوي
4. THE Splash_Screen SHALL تشغيل مؤثر صوتي ترحيبي (نغمة صاعدة ثلاثية) عند الإطلاق
5. WHEN تنتهي مدة الـ Splash (3 ثوانٍ)، THE Splash_Screen SHALL الانتقال إلى الشاشة الرئيسية بأنيميشن Fade + Scale
6. THE Splash_Screen SHALL عرض مؤشر تحميل دائري بلون وردي شفاف يظهر بعد 1200 ميلي ثانية
7. THE Splash_Screen SHALL تفعيل Haptic Feedback خفيف عند اكتمال تحميل الشعار

### المتطلب 4: شاشة الإدخال (Input Page) المحسّنة

**قصة المستخدم:** بوصفي مستخدماً، أريد إدخال بياناتي (الجنس، الطول، الوزن، العمر) بطريقة ممتعة وتفاعلية، حتى تكون عملية الإدخال سهلة ومبهجة.

#### معايير القبول

1. THE Input_Page SHALL عرض بطاقات اختيار الجنس بتأثير 3D Tilt عند تحريك الإصبع عليها
2. WHEN يختار المستخدم جنساً، THE Input_Page SHALL تطبيق تأثير Scale (1.2x) مع Elastic Out وتغيير لون الحدود والأيقونة فورياً
3. WHEN يختار المستخدم جنساً، THE Input_Page SHALL تشغيل Haptic Feedback متوسط الشدة
4. THE Input_Page SHALL عرض Slider الطول مع تأثير Neon Glow متحرك على المقبض أثناء السحب
5. WHEN يسحب المستخدم Slider الطول، THE Input_Page SHALL تحديث الرقم بأنيميشن Flip رقمي سلس
6. THE Input_Page SHALL عرض أزرار +/- للوزن والعمر مع تأثير Ripple وGlow عند الضغط
7. WHEN يضغط المستخدم على زر +/-، THE Input_Page SHALL تشغيل Haptic Feedback خفيف ومؤثر صوتي نقر
8. THE Input_Page SHALL عرض زر "احسب" بتأثير Pulse متواصل مع Gradient يتغير حسب الجنس المختار
9. THE Input_Page SHALL عرض خلفية متحركة بجسيمات شفافة تتحرك ببطء
10. WHEN لا يختار المستخدم جنساً ويضغط احسب، THE Input_Page SHALL عرض رسالة تنبيه مع Shake Animation على البطاقات
11. THE Input_Page SHALL دعم Gesture Swipe للتنقل بين حقول الإدخال


### المتطلب 5: شاشة النتيجة (Result Page) المحسّنة

**قصة المستخدم:** بوصفي مستخدماً، أريد رؤية نتيجة BMI بطريقة بصرية مثيرة ومفيدة، حتى أفهم وضعي الصحي بوضوح وأشعر بالتحفيز.

#### معايير القبول

1. THE Result_Page SHALL عرض مقياس BMI (Gauge) بأنيميشن إبرة تتحرك من الصفر إلى القيمة الصحيحة خلال 1500 ميلي ثانية بمنحنى Elastic Out
2. WHEN تكون نتيجة BMI في النطاق الطبيعي، THE Result_Page SHALL تشغيل تأثير Confetti بـ 50 جسيماً ملوناً مع مؤثر صوتي احتفالي
3. THE Result_Page SHALL عرض قيمة BMI الرقمية بأنيميشن Scale من 0.5x إلى 1x مع Elastic Out
4. THE Result_Page SHALL عرض بطاقة النتيجة بتأثير Glassmorphism مع Glow بلون الفئة (أزرق/أخضر/برتقالي)
5. THE Result_Page SHALL عرض نصيحة صحية مخصصة لكل فئة BMI مع أيقونة توضيحية
6. THE Result_Page SHALL عرض مقياس بصري شريطي يوضح موضع BMI على النطاق الكامل (10-40)
7. WHEN يضغط المستخدم "حفظ النتيجة"، THE Result_Page SHALL تشغيل أنيميشن حفظ مع Haptic Feedback وتأكيد بصري
8. THE Result_Page SHALL عرض مقارنة مع آخر قياس محفوظ (إن وجد) مع سهم يشير للتحسن أو التراجع
9. THE Result_Page SHALL دعم مشاركة النتيجة كصورة مع تصميم جميل
10. WHEN تكون النتيجة غير طبيعية، THE Result_Page SHALL عرض توصيات صحية مفصّلة قابلة للتوسيع

### المتطلب 6: شاشة السجل (History Screen) المحسّنة

**قصة المستخدم:** بوصفي مستخدماً، أريد متابعة تطور مؤشر BMI عبر الزمن بطريقة بصرية جذابة، حتى أتابع تقدمي الصحي.

#### معايير القبول

1. THE History_Screen SHALL عرض رسم بياني خطي تفاعلي (Line Chart) لتطور BMI عبر الزمن مع أنيميشن رسم تدريجي
2. WHEN يضغط المستخدم على نقطة في الرسم البياني، THE History_Screen SHALL عرض تفاصيل القياس في Tooltip متحرك
3. THE History_Screen SHALL عرض كل قياس في بطاقة Glass مع دائرة ملونة تعكس الفئة وأنيميشن ظهور متتالي
4. WHEN يسحب المستخدم بطاقة قياس لليسار، THE History_Screen SHALL عرض خيار الحذف مع تأكيد وأنيميشن اختفاء
5. THE History_Screen SHALL عرض إحصائيات ملخصة: أعلى قيمة، أدنى قيمة، المتوسط، عدد القياسات
6. THE History_Screen SHALL دعم تصفية السجل حسب الفترة الزمنية (أسبوع، شهر، 3 أشهر، كل الوقت)
7. WHEN لا يوجد سجل، THE History_Screen SHALL عرض رسم توضيحي (Illustration) مع نص تحفيزي وأنيميشن متكرر
8. THE History_Screen SHALL دعم تصدير السجل كملف CSV أو PDF

### المتطلب 7: تأثيرات Glassmorphism وNeumorphism

**قصة المستخدم:** بوصفي مستخدماً، أريد رؤية تأثيرات بصرية عصرية وأنيقة على عناصر الواجهة، حتى يبدو التطبيق احترافياً ومميزاً.

#### معايير القبول

1. THE Glass_Card SHALL تطبيق BackdropFilter بـ sigmaX=20 وsigmaY=20 مع خلفية شفافة 10-20%
2. THE Glass_Card SHALL عرض حدود متدرجة شفافة (Gradient Border) بسماكة 1-2px
3. WHEN يكون Glass_Card نشطاً، THE Glass_Card SHALL إضافة Glow خارجي بلون العنصر المحدد
4. THE Neumorphic_Button SHALL تطبيق ظلين: ظل داكن في الأسفل-اليمين وظل فاتح في الأعلى-اليسار
5. WHEN يُضغط على Neumorphic_Button، THE Neumorphic_Button SHALL عكس الظلال لإعطاء تأثير الضغط الداخلي
6. THE Glassmorphism_System SHALL التكيف مع كلا الوضعين الداكن والفاتح بألوان مناسبة لكل وضع


### المتطلب 8: تأثيرات الجسيمات والخلفيات المتحركة

**قصة المستخدم:** بوصفي مستخدماً، أريد رؤية خلفيات حية ومتحركة تضيف عمقاً وحيوية للتطبيق، حتى تكون التجربة البصرية غنية.

#### معايير القبول

1. THE Particle_System SHALL عرض 60-100 جسيم متحرك في خلفية شاشة البداية بألوان التطبيق وشفافية 20-40%
2. THE Particle_System SHALL تحريك الجسيمات بسرعات عشوائية (0.5-2.0 وحدة/ثانية) واتجاهات متنوعة
3. WHEN يلمس المستخدم الشاشة، THE Particle_System SHALL إنشاء موجة تنافر للجسيمات القريبة من نقطة اللمس
4. THE Background_Animation SHALL عرض تدرج لوني متحرك ببطء في خلفية شاشة الإدخال
5. THE Background_Animation SHALL عرض دوائر ضوئية (Orbs) شفافة تتحرك ببطء في الخلفية
6. WHILE يتم حساب BMI، THE Background_Animation SHALL تشغيل تأثير موجة انتشار من مركز الشاشة
7. THE Particle_System SHALL تحسين الأداء باستخدام Canvas مباشرة وتجنب إعادة البناء غير الضرورية

### المتطلب 9: الأنيميشن والانتقالات

**قصة المستخدم:** بوصفي مستخدماً، أريد انتقالات سلسة وأنيميشن جميل بين جميع شاشات وعناصر التطبيق، حتى تكون التجربة متدفقة وممتعة.

#### معايير القبول

1. THE Navigation_System SHALL تطبيق انتقال Fade + Scale (0.95 → 1.0) بين جميع الشاشات بمدة 350 ميلي ثانية
2. THE Navigation_System SHALL تطبيق انتقال Slide من اليمين لليسار عند الذهاب للأمام، والعكس عند الرجوع
3. THE Animation_System SHALL تطبيق Staggered Animation على عناصر الشاشة بتأخير 100ms بين كل عنصر
4. WHEN تظهر البطاقات للمرة الأولى، THE Animation_System SHALL تطبيق FadeIn + SlideY من الأسفل
5. THE Micro_Animation SHALL تطبيق Scale Bounce (0.9 → 1.05 → 1.0) على جميع الأزرار عند الضغط
6. THE Micro_Animation SHALL تطبيق تأثير Ripple دائري عند الضغط على العناصر التفاعلية
7. WHEN تتغير قيمة العداد (وزن/عمر)، THE Animation_System SHALL تطبيق Flip Animation رقمي
8. THE Animation_System SHALL استخدام مكتبة flutter_animate لجميع التأثيرات مع Curves مناسبة
9. WHEN يتم تحميل البيانات، THE Animation_System SHALL عرض Shimmer Loading Effect بدلاً من مؤشر التحميل العادي

### المتطلب 10: الأيقونات والرسوم التوضيحية

**قصة المستخدم:** بوصفي مستخدماً، أريد رؤية أيقونات ورسوم توضيحية جميلة ومعبّرة في جميع أنحاء التطبيق، حتى تكون الواجهة بصرية وسهلة الفهم.

#### معايير القبول

1. THE Icon_System SHALL استخدام مكتبة font_awesome_flutter للأيقونات الأساسية مع دعم الأيقونات المخصصة
2. THE Icon_System SHALL تطبيق Gradient على الأيقونات الرئيسية باستخدام ShaderMask
3. THE Icon_System SHALL استخدام أيقونات مخصصة لفئات BMI: نحيف (شخص نحيل)، طبيعي (شخص رياضي)، وزن زائد (شخص ممتلئ)
4. THE Illustration_System SHALL عرض رسوم Lottie متحركة في شاشة السجل الفارغ وشاشات الخطأ
5. THE Icon_System SHALL تطبيق أنيميشن Bounce على الأيقونات عند الضغط عليها
6. THE Icon_System SHALL دعم حجمين: صغير (24px) ومتوسط (48px) وكبير (80px) مع Glow مناسب لكل حجم


### المتطلب 11: Haptic Feedback والمؤثرات الصوتية

**قصة المستخدم:** بوصفي مستخدماً، أريد شعوراً لمسياً وصوتياً عند التفاعل مع التطبيق، حتى تكون التجربة متعددة الحواس وأكثر إشباعاً.

#### معايير القبول

1. THE Haptic_Service SHALL توفير 4 مستويات اهتزاز: خفيف (Light)، متوسط (Medium)، قوي (Heavy)، نجاح (Success)
2. WHEN يختار المستخدم جنساً، THE Haptic_Service SHALL تشغيل اهتزاز متوسط
3. WHEN يضغط المستخدم على زر +/-، THE Haptic_Service SHALL تشغيل اهتزاز خفيف
4. WHEN يضغط المستخدم "احسب"، THE Haptic_Service SHALL تشغيل اهتزاز قوي
5. WHEN تكون النتيجة طبيعية، THE Haptic_Service SHALL تشغيل نمط اهتزاز النجاح (ثلاث نبضات متصاعدة)
6. THE Sound_Service SHALL توفير مؤثرات صوتية لـ: النقر، الحساب، النجاح، التحذير، الإطلاق، الزيادة، النقصان
7. THE Sound_Service SHALL دعم كتم الصوت مع حفظ التفضيل
8. WHEN يكون الجهاز في وضع الصامت، THE Sound_Service SHALL إيقاف المؤثرات الصوتية تلقائياً
9. WHERE يدعم الجهاز Haptic Feedback، THE Haptic_Service SHALL تفعيله تلقائياً

### المتطلب 12: إمكانية الوصول (Accessibility)

**قصة المستخدم:** بوصفي مستخدماً من ذوي الاحتياجات الخاصة، أريد استخدام التطبيق بسهولة مع قارئات الشاشة وإعدادات إمكانية الوصول، حتى لا أُحرم من الاستفادة منه.

#### معايير القبول

1. THE Accessibility_System SHALL إضافة Semantics labels لجميع العناصر التفاعلية باللغتين العربية والإنجليزية
2. THE Accessibility_System SHALL دعم Dynamic Text Size مع الحفاظ على تخطيط الواجهة
3. THE Accessibility_System SHALL توفير نسبة تباين لوني لا تقل عن 4.5:1 بين النص والخلفية (WCAG AA)
4. THE Accessibility_System SHALL دعم التنقل بلوحة المفاتيح الخارجية
5. WHEN يكون وضع High Contrast مفعّلاً في النظام، THE Accessibility_System SHALL تطبيق ألوان عالية التباين
6. THE Accessibility_System SHALL توفير Tooltip وصفي لكل أيقونة وزر

### المتطلب 13: تحسين الأداء

**قصة المستخدم:** بوصفي مستخدماً، أريد تطبيقاً سريعاً وسلساً لا يتأخر أو يتجمد، حتى تكون تجربتي مريحة على جميع الأجهزة.

#### معايير القبول

1. THE Performance_System SHALL تحقيق معدل إطارات 60fps على الأجهزة المتوسطة وما فوق
2. THE Performance_System SHALL استخدام const constructors لجميع الـ Widgets الثابتة
3. THE Performance_System SHALL استبدال جميع استخدامات withOpacity() المهجورة بـ withValues()
4. THE Performance_System SHALL تطبيق RepaintBoundary على العناصر المتحركة المعزولة
5. THE Performance_System SHALL استخدام Lazy Loading لقائمة السجل مع ListView.builder
6. THE Performance_System SHALL تحسين الصور والأصول باستخدام الأحجام المناسبة
7. WHEN يكون عدد عناصر السجل أكثر من 50، THE Performance_System SHALL تطبيق Pagination
8. THE Performance_System SHALL تقليل حجم التطبيق النهائي بإزالة الأصول غير المستخدمة

### المتطلب 14: دعم اللغة العربية الكامل

**قصة المستخدم:** بوصفي مستخدماً عربياً، أريد تجربة عربية كاملة وصحيحة في التطبيق، حتى أستخدمه بلغتي الأم بشكل طبيعي.

#### معايير القبول

1. THE Localization_System SHALL دعم التبديل الديناميكي بين العربية والإنجليزية دون إعادة تشغيل التطبيق
2. WHEN تكون اللغة عربية، THE Localization_System SHALL عكس اتجاه الواجهة بالكامل (RTL) تلقائياً
3. THE Localization_System SHALL ترجمة جميع النصوص بما فيها: رسائل الخطأ، التلميحات، التواريخ، الأرقام
4. THE Localization_System SHALL عرض الأرقام بالصيغة العربية (٠١٢٣٤٥٦٧٨٩) عند اختيار اللغة العربية
5. THE Localization_System SHALL تنسيق التواريخ بالتقويم الميلادي مع أسماء الأشهر بالعربية
6. THE Localization_System SHALL حفظ تفضيل اللغة واستعادته عند إعادة فتح التطبيق
7. WHEN تكون اللغة عربية، THE Localization_System SHALL ضبط محاذاة النصوص والأيقونات للاتجاه الصحيح


### المتطلب 15: التفاعلات بالإيماءات (Gesture Interactions)

**قصة المستخدم:** بوصفي مستخدماً، أريد التفاعل مع التطبيق بإيماءات طبيعية وبديهية، حتى تكون التجربة أكثر سلاسة وإمتاعاً.

#### معايير القبول

1. THE Gesture_System SHALL دعم Swipe Down لإغلاق شاشة النتيجة والعودة للإدخال
2. THE Gesture_System SHALL دعم Long Press على بطاقات السجل لعرض خيارات إضافية
3. THE Gesture_System SHALL دعم Pinch to Zoom على الرسم البياني في شاشة السجل
4. THE Gesture_System SHALL دعم Double Tap على قيمة BMI لنسخها للحافظة
5. WHEN يسحب المستخدم Slider الطول، THE Gesture_System SHALL عرض Tooltip متحرك يتبع الإصبع
6. THE Gesture_System SHALL دعم Shake Gesture لإعادة تعيين جميع القيم للافتراضية مع تأكيد

### المتطلب 16: شاشة الإعدادات

**قصة المستخدم:** بوصفي مستخدماً، أريد تخصيص التطبيق حسب تفضيلاتي، حتى أحصل على تجربة مخصصة لي.

#### معايير القبول

1. THE Settings_Screen SHALL توفير خيار تبديل الثيم (داكن/فاتح) مع معاينة فورية
2. THE Settings_Screen SHALL توفير خيار تبديل اللغة (عربي/إنجليزي) مع تطبيق فوري
3. THE Settings_Screen SHALL توفير خيار تفعيل/إيقاف المؤثرات الصوتية
4. THE Settings_Screen SHALL توفير خيار تفعيل/إيقاف Haptic Feedback
5. THE Settings_Screen SHALL توفير خيار تفعيل/إيقاف تأثيرات الجسيمات (لتوفير البطارية)
6. THE Settings_Screen SHALL توفير خيار مسح جميع بيانات السجل مع تأكيد
7. THE Settings_Screen SHALL عرض معلومات التطبيق: الإصدار، المطور، سياسة الخصوصية
8. WHEN يغير المستخدم أي إعداد، THE Settings_Screen SHALL حفظه فورياً وتطبيقه دون إعادة تشغيل

