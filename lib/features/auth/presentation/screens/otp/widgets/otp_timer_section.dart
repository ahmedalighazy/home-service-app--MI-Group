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

    return ValueListenableBuilder<OtpTimerValue>(
      valueListenable: cubit.otpTimerNotifier,
      builder: (context, timer, _) {
        final canResend = timer.canResend;
        return Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: !canResend
                  ? Text(
                      '${timer.secondsLeft ~/ 60}:${(timer.secondsLeft % 60).toString().padLeft(2, '0')}',
                      key: const ValueKey('timer'),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.gray, fontSize: 14.sp),
                    )
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: canResend
                      ? () {
                          cubit.initOtp(email);
                          cubit.resendOtp(email);
                          cubit.otpFocusNode.requestFocus();
                        }
                      : null,
                  child: Text(
                    context.tr('resendCodeLink'),
                    style: TextStyle(
                      color: canResend
                          ? AppColors.greenPrimary
                          : AppColors.placeholder,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      decoration: canResend
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
            const _OtpErrorText(),
          ],
        );
      },
    );
  }
}

class _OtpErrorText extends StatelessWidget {
  const _OtpErrorText();

  @override
  Widget build(BuildContext context) {
    final isError = context.select<RegisterCubit, bool>(
      (c) => c.state is OtpVerifyFailure,
    );
    if (!isError) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        context.tr('otpCodeError'),
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.errorRed, fontSize: 12.sp),
      ),
    );
  }
}
