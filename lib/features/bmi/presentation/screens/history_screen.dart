import 'package:bmi_calculator/core/widgets/glass_card.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';
import 'package:bmi_calculator/features/bmi/presentation/providers/bmi_providers.dart';
import 'package:bmi_calculator/features/bmi/presentation/widgets/bmi_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bmi_calculator/l10n/generated/app_localizations.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'History',
          style: AppTextStyles.titleLarge,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.background,
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
                        color: AppColors.textSecondary.withOpacity(0.5),
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(reverse: true),
                          )
                          .scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.1, 1.1),
                            duration: const Duration(seconds: 2),
                          ),
                      const SizedBox(height: 20),
                      Text(
                        'No history yet',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Calculate your BMI to see it here',
                        style: AppTextStyles.bodyMedium,
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
                  // BMI Chart
                  if (history.length >= 2)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BMIChart(history: history),
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 200))
                        .slideY(begin: -0.1, end: 0),
                  
                  // History list
                  Expanded(
                    child: ListView.builder(
                      itemCount: history.length,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        final item = history[history.length - 1 - index];
                        
                        Color categoryColor;
                        switch (item.category) {
                          case _:
                            categoryColor = AppColors.normal;
                        }
                        
                        // Set category color based on category name
                        final categoryName = item.category.name.toLowerCase();
                        if (categoryName.contains('under')) {
                          categoryColor = AppColors.underweight;
                        } else if (categoryName.contains('normal')) {
                          categoryColor = AppColors.normal;
                        } else {
                          categoryColor = AppColors.overweight;
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
                              color: AppColors.errorRed.withOpacity(0.3),
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
                                // BMI Circle
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
                                        color: categoryColor.withOpacity(0.3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      item.bmi.toStringAsFixed(1),
                                      style: AppTextStyles.titleLarge.copyWith(
                                        color: categoryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                
                                // Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.category.name.toUpperCase(),
                                        style: AppTextStyles.labelLarge.copyWith(
                                          color: categoryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        DateFormat.yMMMd().add_jm().format(item.date),
                                        style: AppTextStyles.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Arrow
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: AppColors.textSecondary,
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
                  AppColors.hotPink.withOpacity(0.7),
                ),
              ),
            ),
            error: (err, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 60,
                    color: AppColors.errorRed,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: $err',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.errorRed,
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
