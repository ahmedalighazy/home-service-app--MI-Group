import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

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

        Text(
          '${SdStrings.step} $currentStep ${SdStrings.from} $totalSteps',
          style: AppText.regular10Grey,
        ),

        SizedBox(height: size.height * 0.005),

        Text(mainTitle, style: AppText.semiBold20Black),

        SizedBox(height: size.height * 0.005),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.star_rounded, color: AppColors.yellow, size: 18),
            const SizedBox(width: 4),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: rate, style: AppText.bold10Black),
                  TextSpan(
                    text: '  ($reviews)',
                    style: AppText.regular10Grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
