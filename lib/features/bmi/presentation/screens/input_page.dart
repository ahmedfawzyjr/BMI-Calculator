import 'dart:io';
import 'package:bmi_calculator/core/widgets/animated_3d_card.dart';
import 'package:bmi_calculator/core/widgets/glow_slider.dart';
import 'package:bmi_calculator/core/widgets/counter_button.dart';
import 'package:bmi_calculator/core/widgets/pulse_button.dart';
import 'package:bmi_calculator/features/bmi/domain/calculator_brain.dart';
import 'package:bmi_calculator/features/bmi/domain/input_validator.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';
import 'package:bmi_calculator/features/bmi/presentation/providers/bmi_providers.dart';
import 'package:bmi_calculator/features/bmi/domain/gender.dart';
import 'package:bmi_calculator/core/services/sound_service.dart';
import 'package:bmi_calculator/core/services/haptic_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:bmi_calculator/l10n/generated/app_localizations.dart';

class InputPage extends ConsumerStatefulWidget {
  const InputPage({super.key});

  @override
  ConsumerState<InputPage> createState() => _InputPageState();
}

class _InputPageState extends ConsumerState<InputPage> {
  int _shakeCounter = 0;

  @override
  Widget build(BuildContext context) {
    final selectedGender = ref.watch(genderProvider);
    final height = ref.watch(heightProvider);
    final weight = ref.watch(weightProvider);
    final age = ref.watch(ageProvider);
    final l10n = AppLocalizations.of(context)!;
    final isArabic = l10n.localeName == 'ar';
    
    // Check dark/light brightness dynamically
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Disable particle timers in widget testing environments to avoid infinite loop exceptions
    final isTesting = Map.from(Platform.environment).containsKey('FLUTTER_TEST');
    final particlesEnabled = !isTesting && ref.watch(settingsProvider.select((s) => s.particlesEnabled));

    final activeColor = selectedGender == Gender.male 
        ? AppColors.maleBlue 
        : (selectedGender == Gender.female ? AppColors.femalePink : AppColors.hotPink);
        
    final activeGradient = selectedGender == Gender.male
        ? const LinearGradient(
              colors: [AppColors.maleBlue, AppColors.maleDarkBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        : (selectedGender == Gender.female
            ? const LinearGradient(
                colors: [AppColors.femalePink, AppColors.femalepurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : AppGradients.primaryButton);

    return Scaffold(
      backgroundColor: AppColors.getBgStart(isDark),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          l10n.appTitle,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.getTextPrimary(isDark),
          ),
        ),
        actions: [
          // Theme Toggle
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: AppColors.getTextPrimary(isDark),
            ),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
              ref.read(hapticServiceProvider).lightImpact();
              ref.read(soundServiceProvider).playTap();
            },
          ),
          
          // History Button
          IconButton(
            icon: Icon(
              Icons.history_rounded,
              color: AppColors.getTextPrimary(isDark),
            ),
            onPressed: () {
              ref.read(hapticServiceProvider).lightImpact();
              ref.read(soundServiceProvider).playTap();
              context.push('/history');
            },
          ),
          
          // Settings Button
          IconButton(
            icon: Icon(
              Icons.settings_rounded,
              color: AppColors.getTextPrimary(isDark),
            ),
            onPressed: () {
              ref.read(hapticServiceProvider).lightImpact();
              ref.read(soundServiceProvider).playTap();
              context.push('/settings');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: isDark ? AppGradients.background : AppGradients.lightBackground,
            ),
          ),
          
          // Interactive Particle background
          if (particlesEnabled)
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
          
          // Foreground components
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Gender Selection Cards with dynamic Shake animations on error
                Expanded(
                  child: Row(
                    children: [
                      // Male Card
                      Expanded(
                        child: Animated3DCard(
                          isSelected: selectedGender == Gender.male,
                          selectionColor: AppColors.maleBlue,
                          onTap: () {
                            ref.read(genderProvider.notifier).state = Gender.male;
                            ref.read(hapticServiceProvider).mediumImpact();
                            ref.read(soundServiceProvider).playTap();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: selectedGender == Gender.male
                                      ? [AppColors.maleBlue, AppColors.maleDarkBlue]
                                      : [AppColors.getTextSecondary(isDark), AppColors.getTextSecondary(isDark)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds),
                                child: const Icon(
                                  FontAwesomeIcons.mars,
                                  size: 80,
                                  color: Colors.white,
                                ),
                              )
                                  .animate(target: selectedGender == Gender.male ? 1 : 0)
                                  .scale(
                                    begin: const Offset(1, 1),
                                    end: const Offset(1.2, 1.2),
                                    duration: 500.ms,
                                    curve: Curves.elasticOut,
                                  ),
                              const SizedBox(height: 15),
                              Text(
                                l10n.male,
                                style: AppTypography.labelLarge(
                                  isArabic,
                                  selectedGender == Gender.male
                                      ? AppColors.maleBlue
                                      : AppColors.getTextSecondary(isDark),
                                ).copyWith(
                                  fontWeight: selectedGender == Gender.male ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // Female Card
                      Expanded(
                        child: Animated3DCard(
                          isSelected: selectedGender == Gender.female,
                          selectionColor: AppColors.femalePink,
                          onTap: () {
                            ref.read(genderProvider.notifier).state = Gender.female;
                            ref.read(hapticServiceProvider).mediumImpact();
                            ref.read(soundServiceProvider).playTap();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                    colors: selectedGender == Gender.female
                                        ? [AppColors.femalePink, AppColors.femalepurple]
                                        : [AppColors.getTextSecondary(isDark), AppColors.getTextSecondary(isDark)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(bounds),
                                child: const Icon(
                                  FontAwesomeIcons.venus,
                                  size: 80,
                                  color: Colors.white,
                                ),
                              )
                                  .animate(target: selectedGender == Gender.female ? 1 : 0)
                                  .scale(
                                    begin: const Offset(1, 1),
                                    end: const Offset(1.2, 1.2),
                                    duration: 500.ms,
                                    curve: Curves.elasticOut,
                                  ),
                              const SizedBox(height: 15),
                              Text(
                                l10n.female,
                                style: AppTypography.labelLarge(
                                  isArabic,
                                  selectedGender == Gender.female
                                      ? AppColors.femalePink
                                      : AppColors.getTextSecondary(isDark),
                                ).copyWith(
                                  fontWeight: selectedGender == Gender.female ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                      .animate(
                        target: _shakeCounter > 0 ? 1 : 0,
                        onComplete: (_) {
                          if (_shakeCounter > 0) {
                            setState(() => _shakeCounter = 0);
                          }
                        },
                      )
                      .shake(hz: 8, duration: 400.ms, curve: Curves.easeInOut),
                ),
            
                // Height Slider Card
                Expanded(
                  child: Animated3DCard(
                    isSelected: selectedGender != null,
                    selectionColor: activeColor,
                    enableTilt: false,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GlowSlider(
                        value: height.toDouble(),
                        min: 120,
                        max: 220,
                        activeColor: activeColor,
                        glowColor: activeColor,
                        label: l10n.height,
                        unit: l10n.cm,
                        onChanged: (double newValue) {
                          final rounded = newValue.round();
                          if (rounded != height) {
                            ref.read(heightProvider.notifier).state = rounded;
                            ref.read(hapticServiceProvider).lightImpact();
                            ref.read(soundServiceProvider).playSlide();
                          }
                        },
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: const Duration(milliseconds: 150))
                    .slideY(begin: 0.1, end: 0),
                
                // Weight and Age Counters
                Expanded(
                  child: Row(
                    children: [
                      // Weight Card
                      Expanded(
                        child: Animated3DCard(
                          isSelected: selectedGender != null,
                          selectionColor: activeColor,
                          child: AnimatedCounterWidget(
                            label: l10n.weight,
                            value: weight,
                            minValue: 30,
                            maxValue: 200,
                            activeColor: activeColor,
                            onIncrement: () {
                              ref.read(weightProvider.notifier).state++;
                              ref.read(hapticServiceProvider).mediumImpact();
                              ref.read(soundServiceProvider).playIncrement();
                            },
                            onDecrement: () {
                              ref.read(weightProvider.notifier).state--;
                              ref.read(hapticServiceProvider).mediumImpact();
                              ref.read(soundServiceProvider).playDecrement();
                            },
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: const Duration(milliseconds: 200))
                          .slideX(begin: -0.1, end: 0),
                      
                      // Age Card
                      Expanded(
                        child: Animated3DCard(
                          isSelected: selectedGender != null,
                          selectionColor: activeColor,
                          child: AnimatedCounterWidget(
                            label: l10n.age,
                            value: age,
                            minValue: 1,
                            maxValue: 120,
                            activeColor: activeColor,
                            onIncrement: () {
                              ref.read(ageProvider.notifier).state++;
                              ref.read(hapticServiceProvider).mediumImpact();
                              ref.read(soundServiceProvider).playIncrement();
                            },
                            onDecrement: () {
                              ref.read(ageProvider.notifier).state--;
                              ref.read(hapticServiceProvider).mediumImpact();
                              ref.read(soundServiceProvider).playDecrement();
                            },
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: const Duration(milliseconds: 250))
                          .slideX(begin: 0.1, end: 0),
                    ],
                  ),
                ),
                
                // Calculate Button with input validation checks
                PulseButton(
                  text: l10n.calculate,
                  isPulsing: selectedGender != null,
                  gradient: activeGradient,
                  shadowColor: activeColor,
                  onTap: () {
                    // Validate inputs
                    final validation = InputValidator.validate(
                      gender: selectedGender,
                      height: height,
                      weight: weight,
                      age: age,
                    );

                    if (!validation.isValid) {
                      // Trigger audio/haptic error and shaking animation
                      ref.read(soundServiceProvider).playWarning();
                      ref.read(hapticServiceProvider).errorNotification();
                      setState(() {
                        _shakeCounter = 1;
                      });

                      // Show error snackbar
                      String errorText;
                      switch (validation.errorMessageKey) {
                        case 'errorSelectGender':
                          errorText = l10n.errorSelectGender;
                          break;
                        case 'errorInvalidHeight':
                          errorText = l10n.errorInvalidHeight;
                          break;
                        case 'errorInvalidWeight':
                          errorText = l10n.errorInvalidWeight;
                          break;
                        case 'errorInvalidAge':
                          errorText = l10n.errorInvalidAge;
                          break;
                        default:
                          errorText = 'Invalid input!';
                      }

                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            errorText,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: AppColors.errorRed,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                      return;
                    }

                    // Successful Calculation
                    ref.read(soundServiceProvider).playCalculate();
                    ref.read(hapticServiceProvider).heavyImpact();

                    final calc = Calculate(
                      height: height,
                      weight: weight,
                    );
                    
                    context.push(
                      '/result',
                      extra: {
                        'bmi': calc.result(),
                        'category': calc.getCategory(),
                        'textColor': calc.getTextColor(),
                      },
                    );
                  },
                )
                    .animate()
                    .fadeIn(delay: const Duration(milliseconds: 300))
                    .slideY(begin: 0.2, end: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
