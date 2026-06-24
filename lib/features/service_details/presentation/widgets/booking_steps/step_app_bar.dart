import 'package:flutter/material.dart';
import 'package:home_service_app/core/utils/l10n/app_localizations.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_steps/step_progress_strip.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/text/app_text.dart';

class StepAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;

  const StepAppBar({
    super.key,
    required this.title,
    required this.currentStep,
    required this.totalSteps,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.step} $currentStep ${AppLocalizations.of(context)!.from} $totalSteps',
                      style: AppText.regular12Grey.copyWith(fontSize: 10),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      title,
                      style: AppText.semiBold18Black.copyWith(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(width: 38),
                GestureDetector(
                  onTap: onBack,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.lightGrey),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 22,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            StepProgressStrip(current: currentStep, total: totalSteps),
          ],
        ),
      ),
    );
  }
}
