import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class OtpHeaderSection extends StatelessWidget {
  final String email;

  const OtpHeaderSection({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.tr('confirmCode'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          context.tr('enterVerificationCode'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 13.sp,
            height: 1.5,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          email,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.greenPrimary,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
