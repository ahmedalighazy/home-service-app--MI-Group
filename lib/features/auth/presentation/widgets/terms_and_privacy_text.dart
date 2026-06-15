import 'package:flutter/material.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/constants/auth_strings.dart';

/// Terms and privacy policy text at the bottom of auth screens
class TermsAndPrivacyText extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const TermsAndPrivacyText({
    super.key,
    this.text = AuthStrings.termsAndPrivacy,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: AppText.ibmCaption11(color: AppColors.gray),
        textAlign: TextAlign.center,
      ),
    );
  }
}
