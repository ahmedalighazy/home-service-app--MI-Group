import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../../../core/themes/colors/app_colors.dart';

class TitleSection extends StatelessWidget {
  final String currentStep;
  final String totalSteps;
  final String mainTitle;
  final String rate;
  final String reviews;

  const TitleSection({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.mainTitle,
    required this.rate,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Step counter  context.l10n.stepNumber1FromNumber5
        Text(
          '${context.l10n.step} $currentStep ${context.l10n.ofText} $totalSteps',
          style: AppText.regular10Grey,
        ),

        SizedBox(height: size.height * 0.005),

        // Service title
        Text(mainTitle, style: AppText.semiBold20Black),

        SizedBox(height: size.height * 0.005),

        // Star + rating + reviews
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.star_rounded, color: AppColors.yellow, size: 18),
            const SizedBox(width: 4),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: rate, style: AppText.bold10Black),
                  TextSpan(text: '  ($reviews)', style: AppText.regular10Grey),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
