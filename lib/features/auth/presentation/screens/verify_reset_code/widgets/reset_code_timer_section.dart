import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_state.dart';

class ResetCodeTimerSection extends StatelessWidget {
  final String email;

  const ResetCodeTimerSection({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    final canResend = context.select<ForgotPasswordCubit, bool>(
      (c) => c.resetCodeCanResend,
    );
    final secondsLeft = context.select<ForgotPasswordCubit, int>(
      (c) => c.resetCodeSecondsLeft,
    );
    final isLoading = context.select<ForgotPasswordCubit, bool>(
      (c) => c.state is ResetCodeSendLoading,
    );

    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: !canResend
              ? Text(
                  '${secondsLeft ~/ 60}:${(secondsLeft % 60).toString().padLeft(2, '0')}',
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
            if (isLoading)
              SizedBox(
                width: 16.sp,
                height: 16.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.greenPrimary,
                ),
              )
            else ...[
              GestureDetector(
                onTap: canResend
                    ? () {
                        cubit.resetCodeCtrl.clear();
                        cubit.resendResetCode(email);
                        cubit.resetFocusNode.requestFocus();
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
          ],
        ),
      ],
    );
  }
}
