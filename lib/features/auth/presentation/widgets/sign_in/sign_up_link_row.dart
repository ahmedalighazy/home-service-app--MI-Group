import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/language/l10n/app_strings.dart';

class SignUpLinkRow extends StatelessWidget {
  final VoidCallback onTap;

  const SignUpLinkRow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontHaveAccount,
          style: AppText.ibmDescription14(color: AppColors.secondaryText),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            AppStrings.createAccount,
            style: AppText.ibmLink13(color: AppColors.greenPrimary),
          ),
        ),
      ],
    );
  }
}
