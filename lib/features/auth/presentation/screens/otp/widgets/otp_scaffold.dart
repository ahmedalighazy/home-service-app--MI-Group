import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'otp_confirm_button.dart';
import 'otp_input_row.dart';
import 'otp_field_state.dart';
import 'otp_timer_section.dart';
import 'otp_hidden_input.dart';

class OtpScaffold extends StatelessWidget {
  final String email;

  const OtpScaffold({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();
    final isLoading = cubit.isLoading;

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 120.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: CustomBackArrowButton(),
                    ),
                    SizedBox(height: 40.h),
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
                    SizedBox(height: 48.h),
                    GestureDetector(
                      onTap: () => cubit.otpFocusNode.requestFocus(),
                      child: AnimatedBuilder(
                        animation: cubit.otpAnimation.shakeAnim,
                        builder: (context, _) => OtpInputRow(
                          digits: cubit.otpCodeCtrl.text,
                          length: 6,
                          fieldState: cubit.otpFieldState,
                          shakeAnimation: cubit.otpAnimation.shakeAnim,
                          onTap: () => cubit.otpFocusNode.requestFocus(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    OtpTimerSection(email: email),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 24.w,
              right: 24.w,
              bottom: 24.h,
              child: OtpConfirmButton(
                label: context.tr('confirm'),
                isLoading: isLoading,
                isSuccess: cubit.otpFieldState == OtpFieldState.success,
                isEnabled:
                    cubit.otpCodeCtrl.text.length == 6 &&
                    cubit.otpFieldState != OtpFieldState.error,
                onPressed: cubit.otpCodeCtrl.text.length == 6
                    ? () {
                        cubit.otpFocusNode.unfocus();
                        cubit.verifyOtp(
                          phoneNumber: email,
                          otp: cubit.otpCodeCtrl.text,
                        );
                      }
                    : () {},
              ),
            ),
            const OtpHiddenInput(),
          ],
        ),
      ),
    );
  }
}
