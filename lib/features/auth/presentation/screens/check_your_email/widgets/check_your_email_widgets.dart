import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

/// Circle-shaped OTP input field (single digit)
class OtpCircleField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const OtpCircleField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.borderInputs,
          width: 1.5,
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
          style: AppText.ibmHeading16(color: AppColors.dark),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

/// Header section: email illustration + title + description with email
class CheckEmailHeader extends StatelessWidget {
  final String email;

  const CheckEmailHeader({super.key, required this.email});

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
                  text: _truncateEmail(email),
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

/// Resend code row: "لم تتلقي الكود بعد ؟" + "أعد ارسال الكود"
class CheckEmailResendRow extends StatelessWidget {
  final VoidCallback onResend;

  const CheckEmailResendRow({super.key, required this.onResend});

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
          onTap: onResend,
          child: Text(
            context.tr('resendCodeLink'),
            style: AppText.ibmLink13(
              color: AppColors.greenPrimary,
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