import 'dart:io';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
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
import 'package:bmi_calculator/core/services/sound_service.dart';
import 'package:bmi_calculator/core/services/haptic_service.dart';

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
  final ScreenshotController _screenshotController = ScreenshotController();

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
      case BMICategory.obese:
        return AppColors.obese;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Dynamic theme state checks
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final particlesEnabled = ref.watch(settingsProvider.select((s) => s.particlesEnabled));
    final isTesting = Map.from(Platform.environment).containsKey('FLUTTER_TEST');
    
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
      case BMICategory.obese:
        resultText = l10n.obese;
        advise = l10n.adviceObese;
        break;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          l10n.yourResult,
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
          if (particlesEnabled && !isTesting)
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
          
          // Confetti alignment
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
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
                
                // Result Card Screenshot Target
                Expanded(
                  flex: 5,
                  child: Screenshot(
                    controller: _screenshotController,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        gradient: isDark ? AppGradients.background : AppGradients.lightBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GlassCard(
                        isActive: true,
                        glowColor: _getCategoryColor(),
                        padding: const EdgeInsets.all(24),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            // Category text
                            Text(
                              resultText.toUpperCase(),
                              style: AppTypography.headlineLarge(
                                l10n.localeName == 'ar',
                                _getCategoryColor(),
                              ).copyWith(
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                                .animate()
                                .fadeIn(delay: const Duration(milliseconds: 400))
                                .scale(begin: const Offset(0.8, 0.8)),
                            
                            // BMI Value
                            Text(
                              widget.bmi,
                              style: AppTypography.displayLarge(
                                l10n.localeName == 'ar',
                                AppColors.getTextPrimary(isDark),
                              ).copyWith(
                                shadows: [
                                  Shadow(
                                    color: _getCategoryColor().withValues(alpha: 0.5),
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
                                  style: AppTypography.labelLarge(
                                    l10n.localeName == 'ar',
                                    AppColors.getTextSecondary(isDark),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  l10n.normalRangeValue,
                                  style: AppTypography.bodyLarge(
                                    l10n.localeName == 'ar',
                                    AppColors.getTextPrimary(isDark),
                                  ).copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                                .animate()
                                .fadeIn(delay: const Duration(milliseconds: 800)),
                            
                            // Advice text
                            Text(
                              advise,
                              textAlign: TextAlign.center,
                              style: AppTypography.bodyLarge(
                                l10n.localeName == 'ar',
                                AppColors.getTextPrimary(isDark),
                              ),
                            )
                                .animate()
                                .fadeIn(delay: const Duration(milliseconds: 1000)),
                            
                            const SizedBox(height: 10),
                            
                            // Interactive Split Save & Share Action Buttons
                            Row(
                              children: [
                                // Save Result Button
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      ref.read(hapticServiceProvider).mediumImpact();
                                      ref.read(soundServiceProvider).playTap();
                                      
                                      final history = BMIHistory(
                                        id: DateTime.now().toString(),
                                        bmi: double.parse(widget.bmi),
                                        category: widget.category,
                                        date: DateTime.now(),
                                      );
                                      await ref.read(historyRepositoryProvider).addResult(history);
                                      ref.invalidate(historyProvider);
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              l10n.saveResult,
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: AppColors.activeCard,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.save_rounded, size: 20),
                                    label: Text(
                                      l10n.saveResult.split(' ')[0], // Compact label
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.activeCard,
                                      foregroundColor: AppColors.getTextPrimary(isDark),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(width: 12),
                                
                                // Share Result Button
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () async {
                                      ref.read(hapticServiceProvider).mediumImpact();
                                      ref.read(soundServiceProvider).playTap();
                                      
                                      try {
                                        // Capture screenshot of the card
                                        final imageBytes = await _screenshotController.capture();
                                        if (imageBytes != null) {
                                          final directory = await getTemporaryDirectory();
                                          final imageFile = await File('${directory.path}/bmi_result.png').create();
                                          await imageFile.writeAsBytes(imageBytes);
                                          
                                          final shareText = l10n.shareText(widget.bmi, resultText);
                                          await Share.shareXFiles(
                                            [XFile(imageFile.path)],
                                            text: shareText,
                                          );
                                        } else {
                                          throw Exception("Screenshot failed");
                                        }
                                      } catch (e) {
                                        // Text-only fallback sharing on failure
                                        final shareText = l10n.shareText(widget.bmi, resultText);
                                        await Share.share(shareText);
                                      }
                                    },
                                    icon: const Icon(Icons.share_rounded, size: 20),
                                    label: Text(
                                      l10n.exportData.split(' ')[0],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: _getCategoryColor(), width: 1.5),
                                      foregroundColor: AppColors.getTextPrimary(isDark),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                                .animate()
                                .fadeIn(delay: const Duration(milliseconds: 1200))
                                .slideY(begin: 0.2, end: 0),
                          ],
                        ),
                      ),
                    ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 10),
                
                // Recalculate button
                PulseButton(
                  text: l10n.recalculate,
                  isPulsing: false,
                  onTap: () {
                    ref.read(soundServiceProvider).playTap();
                    ref.read(hapticServiceProvider).lightImpact();
                    context.pop();
                  },
                )
                    .animate()
                    .fadeIn(delay: const Duration(milliseconds: 1300))
                    .slideY(begin: 0.3, end: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
