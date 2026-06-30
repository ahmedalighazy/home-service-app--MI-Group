import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class CheckEmailResendRow extends StatelessWidget {
  final VoidCallback onResend;

  const CheckEmailResendRow({super.key, required this.onResend});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            '${context.tr('resendCodePromptAlt')} ',
            style: AppText.ibmDescription14(color: AppColors.secondaryText),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        GestureDetector(
          onTap: onResend,
          child: Text(
            context.tr('resendCodeLink'),
            style: AppText.ibmLink13(
              color: AppColors.greenPrimary,
            ).copyWith(
              decoration: TextDecoration.underline,
              decorationColor: AppColors.greenPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
