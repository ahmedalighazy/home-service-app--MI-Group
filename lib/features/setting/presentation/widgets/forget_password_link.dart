import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';

class ForgetPasswordLink extends StatelessWidget {
  const ForgetPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              // Add navigation to forgot password screen here
            },
            child: Text(
              context.tr(LocaleKeys.settingsForgotPassword),
              style:
                  AppText.mediumIbm(
                    fontSize: 14.sp,
                    color: AppColors.primary,
                  ).copyWith(
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                    // decorationStyle: TextDecorationStyle.dotted,
                    decorationColor: AppColors.primary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
