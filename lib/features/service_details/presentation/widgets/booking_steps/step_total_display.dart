import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import '../../../../../core/themes/colors/app_colors.dart';

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
            Text(context.l10n.currentTotal, style: AppText.regular12Grey),
          ],
        ),
        const SizedBox(height: 1),
        Text(
          '${total.toStringAsFixed(0)} ${context.l10n.currency}',
          style: AppText.semiBold20Black.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
