import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';

class HelpCenterPrivacyNote extends StatelessWidget {
  const HelpCenterPrivacyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Text(
          context.tr(LocaleKeys.settingsPrivacyNote),
          textAlign: TextAlign.center,
          style: AppText.ibmDescription12(color: AppColors.textLightGrey),
        ),
      ),
    );
  }
}
