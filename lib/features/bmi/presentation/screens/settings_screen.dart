import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:bmi_calculator/core/widgets/glass_card.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';
import 'package:bmi_calculator/features/bmi/presentation/providers/bmi_providers.dart';
import 'package:bmi_calculator/l10n/generated/app_localizations.dart';
import 'package:bmi_calculator/core/services/sound_service.dart';
import 'package:bmi_calculator/core/services/haptic_service.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final stats = ref.watch(bmiStatisticsProvider);
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isArabic = l10n.localeName == 'ar';
    final isTesting = Map.from(Platform.environment).containsKey('FLUTTER_TEST');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          l10n.settings,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.getTextPrimary(isDark),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.getTextPrimary(isDark),
          ),
          onPressed: () {
            ref.read(soundServiceProvider).playTap();
            ref.read(hapticServiceProvider).lightImpact();
            context.pop();
          },
        ),
      ),
      body: Stack(
        children: [
          // Dynamic theme background
          Container(
            decoration: BoxDecoration(
              gradient: isDark ? AppGradients.background : AppGradients.lightBackground,
            ),
          ),
          
          // Interactive Particle background
          if (settings.particlesEnabled && !isTesting)
            CircularParticle(
              key: UniqueKey(),
              awayRadius: 80,
              numberOfParticles: 40,
              speedOfParticles: 1.2,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              onTapAnimation: true,
              particleColor: isDark 
                  ? AppColors.electricCyan.withValues(alpha: 0.15) 
                  : AppColors.hotPink.withValues(alpha: 0.08),
              awayAnimationDuration: const Duration(milliseconds: 600),
              maxParticleSize: 4.0,
              isRandSize: true,
              isRandomColor: false,
              enableHover: true,
            ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Preferences Section
                  Text(
                    l10n.settings.toUpperCase(),
                    style: AppTypography.labelLarge(isArabic, AppColors.getTextSecondary(isDark)).copyWith(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(duration: 300.ms),
                  
                  const SizedBox(height: 12),
                  
                  GlassCard(
                    isActive: true,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Sound Effects Switch
                        _buildSwitchRow(
                          context: context,
                          ref: ref,
                          icon: Icons.volume_up_rounded,
                          title: l10n.enableSound,
                          value: settings.soundEnabled,
                          onChanged: (val) {
                            ref.read(settingsProvider.notifier).setSoundEnabled(val);
                            ref.read(hapticServiceProvider).mediumImpact();
                            ref.read(soundServiceProvider).playTap();
                          },
                          isDark: isDark,
                          isArabic: isArabic,
                        ),
                        const Divider(height: 24, color: Colors.white10),
                        
                        // Haptic Feedback Switch
                        _buildSwitchRow(
                          context: context,
                          ref: ref,
                          icon: Icons.vibration_rounded,
                          title: l10n.enableHaptic,
                          value: settings.hapticEnabled,
                          onChanged: (val) {
                            ref.read(settingsProvider.notifier).setHapticEnabled(val);
                            ref.read(hapticServiceProvider).heavyImpact();
                            ref.read(soundServiceProvider).playTap();
                          },
                          isDark: isDark,
                          isArabic: isArabic,
                        ),
                        const Divider(height: 24, color: Colors.white10),
                        
                        // Particle Background Switch
                        _buildSwitchRow(
                          context: context,
                          ref: ref,
                          icon: Icons.bubble_chart_rounded,
                          title: l10n.enableParticles,
                          value: settings.particlesEnabled,
                          onChanged: (val) {
                            ref.read(settingsProvider.notifier).setParticlesEnabled(val);
                            ref.read(hapticServiceProvider).mediumImpact();
                            ref.read(soundServiceProvider).playTap();
                          },
                          isDark: isDark,
                          isArabic: isArabic,
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 100.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),
                  
                  const SizedBox(height: 24),
                  
                  // App Styling Section (Theme & Language)
                  Text(
                    l10n.theme.toUpperCase(),
                    style: AppTypography.labelLarge(isArabic, AppColors.getTextSecondary(isDark)).copyWith(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                  
                  const SizedBox(height: 12),
                  
                  GlassCard(
                    isActive: true,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Theme Toggle Segment
                        _buildDropdownRow<ThemeMode>(
                          icon: Icons.palette_rounded,
                          title: l10n.theme,
                          value: themeMode,
                          items: const [
                            DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                            DropdownMenuItem(value: ThemeMode.light, child: Text('Light Mode')),
                            DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark Mode')),
                          ],
                          onChanged: (mode) {
                            if (mode != null) {
                              ref.read(themeProvider.notifier).setTheme(mode);
                              ref.read(hapticServiceProvider).lightImpact();
                              ref.read(soundServiceProvider).playTap();
                            }
                          },
                          isDark: isDark,
                          isArabic: isArabic,
                        ),
                        const Divider(height: 24, color: Colors.white10),
                        
                        // Language Segment
                        _buildDropdownRow<Locale>(
                          icon: Icons.language_rounded,
                          title: l10n.language,
                          value: locale,
                          items: const [
                            DropdownMenuItem(value: Locale('en'), child: Text('English')),
                            DropdownMenuItem(value: Locale('ar'), child: Text('العربية')),
                          ],
                          onChanged: (loc) {
                            if (loc != null) {
                              ref.read(localeProvider.notifier).setLocale(loc);
                              ref.read(hapticServiceProvider).lightImpact();
                              ref.read(soundServiceProvider).playTap();
                            }
                          },
                          isDark: isDark,
                          isArabic: isArabic,
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),
                  
                  const SizedBox(height: 24),
                  
                  // BMI Statistics Section
                  Text(
                    l10n.statistics.toUpperCase(),
                    style: AppTypography.labelLarge(isArabic, AppColors.getTextSecondary(isDark)).copyWith(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(delay: 400.ms),
                  
                  const SizedBox(height: 12),
                  
                  GlassCard(
                    isActive: true,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Grid of Stats Numbers
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.5,
                          children: [
                            _buildStatTile(
                              icon: Icons.speed_rounded,
                              label: l10n.averageBmi,
                              value: stats.averageBmi.toStringAsFixed(1),
                              color: AppColors.electricCyan,
                              isDark: isDark,
                              isArabic: isArabic,
                            ),
                            _buildStatTile(
                              icon: Icons.trending_up_rounded,
                              label: l10n.maxBmi,
                              value: stats.maxBmi.toStringAsFixed(1),
                              color: AppColors.errorRed,
                              isDark: isDark,
                              isArabic: isArabic,
                            ),
                            _buildStatTile(
                              icon: Icons.trending_down_rounded,
                              label: l10n.minBmi,
                              value: stats.minBmi.toStringAsFixed(1),
                              color: AppColors.neonGreen,
                              isDark: isDark,
                              isArabic: isArabic,
                            ),
                            _buildStatTile(
                              icon: Icons.calculate_rounded,
                              label: l10n.totalCalculations.split(' ')[0],
                              value: stats.totalCount.toString(),
                              color: AppColors.hotPink,
                              isDark: isDark,
                              isArabic: isArabic,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 500.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow({
    required BuildContext context,
    required WidgetRef ref,
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDark,
    required bool isArabic,
  }) {
    return Row(
      children: [
        Icon(icon, color: isDark ? AppColors.electricCyan : AppColors.hotPink, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: AppTypography.bodyLarge(isArabic, AppColors.getTextPrimary(isDark)),
          ),
        ),
        Switch.adaptive(
          activeTrackColor: AppColors.hotPink.withValues(alpha: 0.3),
          thumbColor: const WidgetStatePropertyAll<Color>(AppColors.hotPink),
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDropdownRow<T>({
    required IconData icon,
    required String title,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    required bool isDark,
    required bool isArabic,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: isDark ? AppColors.electricCyan : AppColors.hotPink, size: 24),
            const SizedBox(width: 16),
            Text(
              title,
              style: AppTypography.bodyLarge(isArabic, AppColors.getTextPrimary(isDark)),
            ),
          ],
        ),
        DropdownButton<T>(
          dropdownColor: AppColors.activeCard,
          value: value,
          underline: const SizedBox(),
          items: items,
          onChanged: onChanged,
          style: AppTypography.bodyLarge(isArabic, AppColors.getTextPrimary(isDark)),
        ),
      ],
    );
  }

  Widget _buildStatTile({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required bool isDark,
    required bool isArabic,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: color.withValues(alpha: 0.15),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.labelLarge(isArabic, AppColors.getTextSecondary(isDark)).copyWith(
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTypography.headlineLarge(isArabic, AppColors.getTextPrimary(isDark)).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
