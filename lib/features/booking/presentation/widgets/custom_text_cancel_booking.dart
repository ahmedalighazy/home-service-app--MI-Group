import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/l10n/app_strings.dart';

class CustomTextCancelBooking extends StatelessWidget {
  const CustomTextCancelBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppText.mediumIbm(color: AppColors.primaryText, fontSize: 14),
        children: [
          TextSpan(text: AppStrings.cancelReasonOptional),

          TextSpan(
            text: '( اختياري )',
            style: TextStyle(
              color: Color(0xFF6B7280) /* Secondary-text */,
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
