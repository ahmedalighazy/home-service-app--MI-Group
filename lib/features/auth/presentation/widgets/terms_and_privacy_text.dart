import 'package:flutter/material.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

/// Terms and privacy policy text at the bottom of auth screens
class TermsAndPrivacyText extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;

  const TermsAndPrivacyText({
    super.key,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text ?? context.tr('termsAndPrivacy'),
        style: AppText.ibmCaption11(color: AppColors.gray),
        textAlign: TextAlign.center,
      ),
    );
  }
}
