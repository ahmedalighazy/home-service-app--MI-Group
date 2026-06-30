import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class CheckEmailHeader extends StatelessWidget {
  final String email;

  const CheckEmailHeader({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final atIndex = email.indexOf('@');
    final truncatedEmail = (atIndex <= 5) 
        ? email 
        : '${email.substring(0, 5)}...${email.substring(atIndex)}';

    return Column(
      children: [
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 220.w,
                height: 220.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.greenPrimary.withValues(alpha: 0.12),
                      AppColors.white.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
              Image.asset(
                AppAssets.message,
                width: 176.w,
                height: 174.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        verticalSpace(28),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            context.tr('checkEmailTitle'),
            textAlign: TextAlign.center,
            style: AppText.ibmHeading22(color: AppColors.dark),
          ),
        ),
        verticalSpace(12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppText.ibmDescription14(color: AppColors.secondaryText),
              children: [
                TextSpan(text: '${context.tr('resetLinkSent')} '),
                TextSpan(
                  text: truncatedEmail,
                  style: AppText.ibmLink13(color: AppColors.greenPrimary),
                ),
                TextSpan(text: '\n${context.tr('enter4DigitCode')}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
