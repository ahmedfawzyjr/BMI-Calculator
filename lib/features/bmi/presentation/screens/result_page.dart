import 'package:bmi_calculator/core/widgets/glass_card.dart';
import 'package:bmi_calculator/core/widgets/pulse_button.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';
import 'package:bmi_calculator/features/bmi/domain/bmi_category.dart';
import 'package:bmi_calculator/features/bmi/presentation/widgets/bmi_gauge.dart';
import 'package:bmi_calculator/features/bmi/presentation/providers/bmi_providers.dart';
import 'package:bmi_calculator/features/bmi/data/models/bmi_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'package:go_router/go_router.dart';
import 'package:bmi_calculator/l10n/generated/app_localizations.dart';

class ResultPage extends ConsumerStatefulWidget {
  final String bmi;
  final BMICategory category;
  final Color textColor;

  const ResultPage({
    super.key,
    required this.bmi,
    required this.category,
    required this.textColor,
  });

  @override
  ConsumerState<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends ConsumerState<ResultPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    
    // Play confetti for normal BMI
    if (widget.category == BMICategory.normal) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          _confettiController.play();
        }
      });
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Color _getCategoryColor() {
    switch (widget.category) {
      case BMICategory.underweight:
        return AppColors.underweight;
      case BMICategory.normal:
        return AppColors.normal;
      case BMICategory.overweight:
        return AppColors.overweight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    String resultText;
    String advise;

    switch (widget.category) {
      case BMICategory.underweight:
        resultText = l10n.resultUnderweight;
        advise = l10n.adviceUnderweight;
        break;
      case BMICategory.normal:
        resultText = l10n.resultNormal;
        advise = l10n.adviceNormal;
        break;
      case BMICategory.overweight:
        resultText = l10n.resultOverweight;
        advise = l10n.adviceOverweight;
        break;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          l10n.yourResult,
          style: AppTextStyles.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: AppGradients.background,
            ),
          ),
          
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: [
                AppColors.hotPink,
                AppColors.electricCyan,
                AppColors.neonGreen,
                Colors.white,
                Colors.yellow,
              ],
              numberOfParticles: 50,
              maxBlastForce: 20,
              minBlastForce: 5,
            ),
          ),
          
          // Main content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                
                // BMI Gauge
                Center(
                  child: BMIGauge(
                    bmiValue: double.parse(widget.bmi),
                    category: widget.category,
                  ),
                )
                    .animate()
                    .fadeIn(delay: const Duration(milliseconds: 200)),
                
                const SizedBox(height: 20),
                
                // Result Card
                Expanded(
                  flex: 4,
                  child: GlassCard(
                    isActive: true,
                    glowColor: _getCategoryColor(),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Category text
                        Text(
                          resultText.toUpperCase(),
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: _getCategoryColor(),
                            letterSpacing: 2,
                          ),
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 400))
                            .scale(begin: const Offset(0.8, 0.8)),
                        
                        // BMI Value
                        Text(
                          widget.bmi,
                          style: AppTextStyles.displayLarge.copyWith(
                            color: AppColors.textPrimary,
                            shadows: [
                              Shadow(
                                color: _getCategoryColor().withOpacity(0.5),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 600))
                            .scale(
                              begin: const Offset(0.5, 0.5),
                              curve: Curves.elasticOut,
                              duration: const Duration(milliseconds: 800),
                            ),
                        
                        // Normal range
                        Column(
                          children: [
                            Text(
                              l10n.normalRange,
                              style: AppTextStyles.labelLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.normalRangeValue,
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 800)),
                        
                        // Advice
                        Text(
                          advise,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyLarge,
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 1000)),
                        
                        // Save button
                        ElevatedButton.icon(
                          onPressed: () async {
                            final history = BMIHistory(
                              id: DateTime.now().toString(),
                              bmi: double.parse(widget.bmi),
                              category: widget.category,
                              date: DateTime.now(),
                            );
                            await ref.read(historyRepositoryProvider).addResult(history);
                            ref.invalidate(historyProvider);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.saveResult),
                                  backgroundColor: AppColors.activeCard,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.save_rounded),
                          label: Text(l10n.saveResult),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.activeCard,
                            foregroundColor: AppColors.textPrimary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 1200))
                            .slideY(begin: 0.3, end: 0),
                      ],
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: const Duration(milliseconds: 300))
                    .slideY(begin: 0.1, end: 0),
                
                // Recalculate button
                PulseButton(
                  text: l10n.recalculate,
                  isPulsing: false,
                  onTap: () {
                    context.pop();
                  },
                )
                    .animate()
                    .fadeIn(delay: const Duration(milliseconds: 1400))
                    .slideY(begin: 0.3, end: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
