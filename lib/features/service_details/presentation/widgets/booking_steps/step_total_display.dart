import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class StepTotalDisplay extends StatelessWidget {
  final double total;

  const StepTotalDisplay({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.body,
              size: 18,
            ),
            const SizedBox(width: 2),
            Text(SdStrings.totalCurrent, style: AppText.regular12Grey),
          ],
        ),
        const SizedBox(height: 1),
        Text(
          '${total.toStringAsFixed(0)} ${SdStrings.qar}',
          style: AppText.semiBold20Black.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
