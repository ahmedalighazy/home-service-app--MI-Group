import 'package:flutter/material.dart';
import '../../../../../core/constants/auth_strings.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/text/app_text.dart';

class SignInRow extends StatelessWidget {
  final VoidCallback onTap;

  const SignInRow({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AuthStrings.alreadyHaveAccount,
          style: AppText.ibmDescription14(color: AppColors.secondaryText),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            AuthStrings.signIn,
            style: AppText.ibmLink13(color: AppColors.greenPrimary),
          ),
        ),
      ],
    );
  }
}
