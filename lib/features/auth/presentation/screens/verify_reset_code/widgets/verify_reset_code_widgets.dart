import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/image/app_assets.dart';
import '../../../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class VerifyResetCodeHeader extends StatelessWidget {
  final String email;

  const VerifyResetCodeHeader({super.key, required this.email});

  String _truncateEmail(String email) {
    final atIndex = email.indexOf('@');
    if (atIndex <= 5) return email;
    return '${email.substring(0, 5)}...${email.substring(atIndex)}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 180.w,
                height: 180.w,
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
                width: 150.w,
                height: 150.w,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        SizedBox(height: 28.h),
        Text(
          context.tr('checkEmail'),
          textAlign: TextAlign.center,
          style: AppText.ibmHeading22(color: AppColors.dark),
        ),
        SizedBox(height: 12.h),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppText.ibmDescription14(color: AppColors.secondaryText),
            children: [
              TextSpan(text: '${context.tr('emailSentMessage')} '),
              TextSpan(
                text: _truncateEmail(email),
                style: AppText.ibmLink13(color: AppColors.greenPrimary),
              ),
              TextSpan(text: '\n${context.tr('enter4DigitCode')}'),
            ],
          ),
        ),
      ],
    );
  }
}

class VerifyResetCodeResendRow extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onResend;

  const VerifyResetCodeResendRow({
    super.key,
    required this.isLoading,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            '${context.tr('resendCodePromptAlt')} ',
            style: AppText.ibmDescription14(color: AppColors.secondaryText),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        GestureDetector(
          onTap: isLoading ? null : onResend,
          child: Text(
            context.tr('resendCodeLink'),
            style: AppText.ibmLink13(
              color: isLoading ? AppColors.placeholder : AppColors.greenPrimary,
            ).copyWith(
              decoration: TextDecoration.underline,
              decorationColor: AppColors.greenPrimary,
            ),
          ),
        ),
      ],
    );
  }
}