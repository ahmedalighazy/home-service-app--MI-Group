import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';

class CustomTextCancelBooking extends StatelessWidget {
  const CustomTextCancelBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppText.mediumIbm(color: AppColors.primaryText, fontSize: 14),
        children: [
          TextSpan(text: context.tr(LocaleKeys.bookingCancelReasonOptional)),

          TextSpan(
            text: ' ( ${context.tr(LocaleKeys.profileOptional)} )',
            style: TextStyle(
              color: const Color(0xFF6B7280) /* Secondary-text */,
              fontSize: 13.sp,
              fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
