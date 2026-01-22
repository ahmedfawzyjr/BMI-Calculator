import 'package:bmi_calculator/core/widgets/animated_3d_card.dart';
import 'package:bmi_calculator/core/widgets/glow_slider.dart';
import 'package:bmi_calculator/core/widgets/counter_button.dart';
import 'package:bmi_calculator/core/widgets/pulse_button.dart';
import 'package:bmi_calculator/features/bmi/domain/calculator_brain.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';
import 'package:bmi_calculator/features/bmi/presentation/providers/bmi_providers.dart';
import 'package:bmi_calculator/features/bmi/domain/gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:bmi_calculator/l10n/generated/app_localizations.dart';

class InputPage extends ConsumerWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGender = ref.watch(genderProvider);
    final height = ref.watch(heightProvider);
    final weight = ref.watch(weightProvider);
    final age = ref.watch(ageProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.deepSpaceStart,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          l10n.appTitle,
          style: AppTextStyles.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              context.push('/history');
            },
          )
              .animate()
              .fadeIn(delay: const Duration(milliseconds: 300))
              .slideX(begin: 0.3, end: 0),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.background,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Gender Selection Row
              Expanded(
                child: Row(
                  children: [
                    // Male Card
                    Expanded(
                      child: Animated3DCard(
                        isSelected: selectedGender == Gender.male,
                        onTap: () {
                          ref.read(genderProvider.notifier).state = Gender.male;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.mars,
                              size: 70,
                              color: selectedGender == Gender.male
                                  ? AppColors.hotPink
                                  : AppColors.textSecondary,
                            )
                                .animate(
                                  target: selectedGender == Gender.male ? 1 : 0,
                                )
                                .scale(
                                  begin: const Offset(1, 1),
                                  end: const Offset(1.1, 1.1),
                                ),
                            const SizedBox(height: 15),
                            Text(
                              l10n.male,
                              style: AppTextStyles.labelLarge.copyWith(
                                color: selectedGender == Gender.male
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 100))
                        .slideX(begin: -0.2, end: 0),
                    
                    // Female Card
                    Expanded(
                      child: Animated3DCard(
                        isSelected: selectedGender == Gender.female,
                        onTap: () {
                          ref.read(genderProvider.notifier).state = Gender.female;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.venus,
                              size: 70,
                              color: selectedGender == Gender.female
                                  ? AppColors.hotPink
                                  : AppColors.textSecondary,
                            )
                                .animate(
                                  target: selectedGender == Gender.female ? 1 : 0,
                                )
                                .scale(
                                  begin: const Offset(1, 1),
                                  end: const Offset(1.1, 1.1),
                                ),
                            const SizedBox(height: 15),
                            Text(
                              l10n.female,
                              style: AppTextStyles.labelLarge.copyWith(
                                color: selectedGender == Gender.female
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 200))
                        .slideX(begin: 0.2, end: 0),
                  ],
                ),
              ),
              
              // Height Slider Card
              Expanded(
                child: Animated3DCard(
                  isSelected: true,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GlowSlider(
                      value: height.toDouble(),
                      min: 120,
                      max: 220,
                      label: l10n.height,
                      unit: l10n.cm,
                      onChanged: (double newValue) {
                        ref.read(heightProvider.notifier).state = newValue.round();
                      },
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 300))
                  .slideY(begin: 0.2, end: 0),
              
              // Weight and Age Row
              Expanded(
                child: Row(
                  children: [
                    // Weight Card
                    Expanded(
                      child: Animated3DCard(
                        isSelected: true,
                        child: AnimatedCounterWidget(
                          label: l10n.weight,
                          value: weight,
                          minValue: 30,
                          maxValue: 200,
                          onIncrement: () {
                            ref.read(weightProvider.notifier).state++;
                          },
                          onDecrement: () {
                            ref.read(weightProvider.notifier).state--;
                          },
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 400))
                        .slideX(begin: -0.2, end: 0),
                    
                    // Age Card
                    Expanded(
                      child: Animated3DCard(
                        isSelected: true,
                        child: AnimatedCounterWidget(
                          label: l10n.age,
                          value: age,
                          minValue: 1,
                          maxValue: 120,
                          onIncrement: () {
                            ref.read(ageProvider.notifier).state++;
                          },
                          onDecrement: () {
                            ref.read(ageProvider.notifier).state--;
                          },
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 500))
                        .slideX(begin: 0.2, end: 0),
                  ],
                ),
              ),
              
              // Calculate Button
              PulseButton(
                text: l10n.calculate,
                isPulsing: true,
                onTap: () {
                  Calculate calc = Calculate(
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
                  .fadeIn(delay: const Duration(milliseconds: 600))
                  .slideY(begin: 0.3, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}
