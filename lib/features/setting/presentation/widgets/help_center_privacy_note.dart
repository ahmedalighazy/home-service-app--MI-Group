import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class HelpCenterPrivacyNote extends StatelessWidget {
  const HelpCenterPrivacyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Text(
          context.l10n.privacyConfidentialityNote,
          textAlign: TextAlign.center,
          style: AppText.ibmDescription12(color: AppColors.textLightGrey),
        ),
      ),
    );
  }
}
