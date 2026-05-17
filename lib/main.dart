import 'package:bmi_calculator/core/router/app_router.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';
import 'package:bmi_calculator/core/data/preferences_repository.dart';
import 'package:bmi_calculator/features/bmi/presentation/providers/bmi_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bmi_calculator/l10n/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bmi_calculator/features/bmi/data/models/bmi_history.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(BMIHistoryAdapter());
  
  // Initialize SharedPreferences for persistence
  final sharedPreferences = await SharedPreferences.getInstance();
  final preferencesRepository = PreferencesRepository(sharedPreferences);
  
  runApp(
    ProviderScope(
      overrides: [
        preferencesRepositoryProvider.overrideWithValue(preferencesRepository),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: locale,
      themeMode: themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
