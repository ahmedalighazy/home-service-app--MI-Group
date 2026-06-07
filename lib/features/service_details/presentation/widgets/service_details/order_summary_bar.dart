
import 'package:flutter/material.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import 'order_summary_next_button.dart';
import 'order_summary_total.dart';

class OrderSummaryBar extends StatelessWidget {
  final double total;
  final VoidCallback onNext;

  const OrderSummaryBar({super.key, required this.total, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.018,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Next Button
          OrderSummaryNextButton(onTap: onNext),

          // Total summary
          OrderSummaryTotal(total: total),
        ],
      ),
    );
  }
}

