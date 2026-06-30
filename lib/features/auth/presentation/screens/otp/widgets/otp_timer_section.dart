import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'otp_field_state.dart';

class OtpTimerSection extends StatelessWidget {
  final String email;
  final AuthCubit cubit;

  const OtpTimerSection({super.key, required this.email, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: !cubit.uiState.otpCanResend
              ? Text('0:${cubit.uiState.otpSecondsLeft.toString().padLeft(2, '0')}', key: const ValueKey('timer'), textAlign: TextAlign.center, style: TextStyle(color: AppColors.gray, fontSize: 14.sp))
              : const SizedBox.shrink(key: ValueKey('empty')),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: cubit.uiState.otpCanResend ? () {
                cubit.initOtp(email);
                cubit.loginWithPhone(email);
                cubit.controllers.otpFocusNode.requestFocus();
              } : null,
              child: Text(
                context.tr('resendCodeLink'),
                style: TextStyle(
                  color: cubit.uiState.otpCanResend ? AppColors.greenPrimary : AppColors.placeholder,
                  fontSize: 13.sp, fontWeight: FontWeight.bold,
                  decoration: cubit.uiState.otpCanResend ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: AppColors.greenPrimary,
                ),
              ),
            ),
            Flexible(child: Text(' ${context.tr('resendCodePrompt')}', style: TextStyle(color: AppColors.gray, fontSize: 13.sp), overflow: TextOverflow.ellipsis)),
          ],
        ),
        SizedBox(height: 16.h),
        if (cubit.uiState.otpFieldState == OtpFieldState.error)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(context.tr('otpCodeError'), textAlign: TextAlign.center, style: TextStyle(color: AppColors.errorRed, fontSize: 12.sp)),
          ),
      ],
    );
  }
}
