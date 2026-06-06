import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class ResendCodeTimer extends StatelessWidget {
  final bool canResend;
  final VoidCallback onResend;

  const ResendCodeTimer({
    super.key,
    required this.canResend,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          AppStrings.resendCodePromptAlt,
          style: AppText.ibmCaption11(color: AppColors.secondaryText),
        ),
        GestureDetector(
          onTap: canResend ? onResend : null,
          child: Text(
            AppStrings.resendCodeLink,
            style: AppText.ibmCaption11(
              color: canResend
                  ? AppColors.greenPrimary
                  : AppColors.secondaryText,
            ).copyWith(
              decoration: canResend ? TextDecoration.underline : null,
              decorationColor: AppColors.greenPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
