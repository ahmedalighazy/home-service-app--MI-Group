import 'package:flutter/material.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class TotalRow extends StatelessWidget {
  final double total;

  const TotalRow({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${total.toStringAsFixed(0)} ${SdStrings.qar}',
          style: AppText.semiBold20Black.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(SdStrings.total, style: AppText.regular12Grey),
            const SizedBox(width: 2),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.body,
              size: 18,
            ),
          ],
        ),
      ],
    );
  }
}
