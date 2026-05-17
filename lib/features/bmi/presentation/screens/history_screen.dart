import 'dart:io';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bmi_calculator/core/widgets/glass_card.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';
import 'package:bmi_calculator/features/bmi/presentation/providers/bmi_providers.dart';
import 'package:bmi_calculator/features/bmi/presentation/widgets/bmi_chart.dart';
import 'package:bmi_calculator/features/bmi/domain/bmi_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bmi_calculator/l10n/generated/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:bmi_calculator/core/services/sound_service.dart';
import 'package:bmi_calculator/core/services/haptic_service.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          l10n.history,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.getTextPrimary(isDark),
          ),
        ),
        actions: [
          // Export History CSV Button
          IconButton(
            icon: Icon(Icons.download_rounded, color: AppColors.getTextPrimary(isDark)),
            tooltip: l10n.exportData,
            onPressed: () async {
              ref.read(hapticServiceProvider).lightImpact();
              ref.read(soundServiceProvider).playTap();
              
              final history = historyAsync.value ?? [];
              if (history.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.noHistory),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              
              try {
                final csvData = [
                  ['ID', 'BMI', 'Category', 'Date'],
                  ...history.map((e) => [
                    e.id,
                    e.bmi.toStringAsFixed(1),
                    e.category.name,
                    e.date.toIso8601String(),
                  ]),
                ];
                final csvString = const ListToCsvConverter().convert(csvData);
                
                final directory = await getTemporaryDirectory();
                final csvFile = await File('${directory.path}/bmi_history.csv').create();
                await csvFile.writeAsString(csvString);
                
                await Share.shareXFiles(
                  [XFile(csvFile.path)],
                  text: l10n.shareText('0.0', l10n.history),
                );
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to export data: $e'),
                      backgroundColor: AppColors.errorRed,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
          ),
          
          // Clear All Records Button
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded, color: AppColors.errorRed),
            tooltip: l10n.clearHistory,
            onPressed: () async {
              ref.read(hapticServiceProvider).heavyImpact();
              ref.read(soundServiceProvider).playSuccess();
              
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppColors.activeCard,
                  title: Text(l10n.clearHistory, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  content: Text(l10n.clearHistoryConfirm, style: const TextStyle(color: Colors.white70)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(l10n.cancel, style: const TextStyle(color: Colors.white60)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorRed),
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(l10n.confirm, style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
              
              if (confirm == true) {
                await ref.read(historyRepositoryProvider).clearHistory();
                ref.invalidate(historyProvider);
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppGradients.background : AppGradients.lightBackground,
        ),
        child: SafeArea(
          child: historyAsync.when(
            data: (history) {
              if (history.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history_rounded,
                        size: 80,
                        color: AppColors.getTextSecondary(isDark).withValues(alpha: 0.5),
                      )
                          .animate(
                            onPlay: (controller) {
                              if (!Platform.environment.containsKey('FLUTTER_TEST')) {
                                controller.repeat(reverse: true);
                              }
                            },
                          )
                          .scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.1, 1.1),
                            duration: const Duration(seconds: 2),
                          ),
                      const SizedBox(height: 20),
                      Text(
                        l10n.noHistory,
                        style: AppTypography.headlineMedium(
                          l10n.localeName == 'ar',
                          AppColors.getTextSecondary(isDark),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.calculateBmiPrompt,
                        style: AppTypography.bodyLarge(
                          l10n.localeName == 'ar',
                          AppColors.getTextSecondary(isDark),
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn()
                    .scale(begin: const Offset(0.9, 0.9));
              }
              
              return Column(
                children: [
                  // BMI Trends Chart
                  if (history.length >= 2)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BMIChart(history: history),
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 200))
                        .slideY(begin: -0.1, end: 0),
                  
                  // History List
                  Expanded(
                    child: ListView.builder(
                      itemCount: history.length,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        final item = history[history.length - 1 - index];
                        
                        Color categoryColor;
                        switch (item.category) {
                          case BMICategory.underweight:
                            categoryColor = AppColors.underweight;
                            break;
                          case BMICategory.normal:
                            categoryColor = AppColors.normal;
                            break;
                          case BMICategory.overweight:
                            categoryColor = AppColors.overweight;
                            break;
                          case BMICategory.obese:
                            categoryColor = AppColors.obese;
                            break;
                        }
                        
                        return Dismissible(
                          key: Key(item.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.errorRed.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.delete_rounded,
                              color: AppColors.errorRed,
                            ),
                          ),
                          onDismissed: (_) async {
                            await ref.read(historyRepositoryProvider).deleteResult(item.id);
                            ref.invalidate(historyProvider);
                          },
                          child: GlassCard(
                            margin: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 8,
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                // BMI Circle Badge
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: categoryColor,
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: categoryColor.withValues(alpha: 0.3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      item.bmi.toStringAsFixed(1),
                                      style: TextStyle(
                                        color: categoryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                
                                // History Record Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.category == BMICategory.underweight
                                            ? l10n.resultUnderweight.toUpperCase()
                                            : item.category == BMICategory.normal
                                                ? l10n.resultNormal.toUpperCase()
                                                : item.category == BMICategory.overweight
                                                    ? l10n.resultOverweight.toUpperCase()
                                                    : l10n.obese.toUpperCase(),
                                        style: AppTypography.labelLarge(
                                          l10n.localeName == 'ar',
                                          categoryColor,
                                        ).copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        DateFormat.yMMMd().add_jm().format(item.date),
                                        style: AppTypography.bodyMedium(
                                          l10n.localeName == 'ar',
                                          AppColors.getTextSecondary(isDark),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: AppColors.getTextSecondary(isDark),
                                ),
                              ],
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(
                              delay: Duration(milliseconds: 100 * index),
                            )
                            .slideX(
                              begin: 0.2,
                              end: 0,
                              delay: Duration(milliseconds: 100 * index),
                            );
                      },
                    ),
                  ),
                ],
              );
            },
            loading: () => Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.hotPink.withValues(alpha: 0.7),
                ),
              ),
            ),
            error: (err, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 60,
                    color: AppColors.errorRed,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: $err',
                    style: const TextStyle(
                      color: AppColors.errorRed,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
