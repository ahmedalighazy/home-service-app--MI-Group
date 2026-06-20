import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

class CustomWidgetDelete extends StatelessWidget {
  const CustomWidgetDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppText.mediumIbm(color: AppColors.primaryText, fontSize: 14),
        children: [
          TextSpan(text: context.l10n.confirmDeleteHint),
          TextSpan(
            text: 'حذف',
            style: AppText.mediumIbm(color: AppColors.redDanger, fontSize: 14),
          ),

          TextSpan(
            text: ')',
            style: AppText.mediumIbm(
              color: AppColors.primaryText,
              fontSize: 14,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
