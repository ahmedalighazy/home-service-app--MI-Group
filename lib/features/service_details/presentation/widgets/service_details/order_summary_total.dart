import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';



class OrderSummaryTotal extends StatelessWidget {
  final double total;

  const OrderSummaryTotal({super.key, required this.total});

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
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(AppStrings.totalCurrent, style: AppText.regular12Grey),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          '${total.toStringAsFixed(0)} ${AppStrings.qar}',
          style: AppText.semiBold20Black.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}


