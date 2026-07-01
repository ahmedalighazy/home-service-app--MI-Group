import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/cubit/register/register_cubit.dart';
import 'package:home_service_app/features/auth/cubit/register/register_state.dart';

class OtpTimerSection extends StatelessWidget {
  final String email;

  const OtpTimerSection({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: !cubit.otpCanResend
              ? Text('0:${cubit.otpSecondsLeft.toString().padLeft(2, '0')}',
                  key: const ValueKey('timer'),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.gray, fontSize: 14.sp))
              : const SizedBox.shrink(key: ValueKey('empty')),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: cubit.otpCanResend
                  ? () {
                      cubit.initOtp(email);
                      cubit.resendOtp(email);
                      cubit.otpFocusNode.requestFocus();
                    }
                  : null,
              child: Text(
                context.tr('resendCodeLink'),
                style: TextStyle(
                  color: cubit.otpCanResend
                      ? AppColors.greenPrimary
                      : AppColors.placeholder,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  decoration: cubit.otpCanResend
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: AppColors.greenPrimary,
                ),
              ),
            ),
            Flexible(
              child: Text(
                ' ${context.tr('resendCodePrompt')}',
                style: TextStyle(color: AppColors.gray, fontSize: 13.sp),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        BlocSelector<RegisterCubit, RegisterState, bool>(
          selector: (state) => state is OtpVerifyFailure,
          builder: (context, isError) {
            if (!isError) return const SizedBox.shrink();
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                context.tr('otpCodeError'),
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.errorRed, fontSize: 12.sp),
              ),
            );
          },
        ),
      ],
    );
  }
}
