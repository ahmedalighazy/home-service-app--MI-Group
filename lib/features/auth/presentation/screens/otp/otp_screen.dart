import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import '../../cubits/auth_cubit.dart';
import 'widgets/otp_confirm_button.dart';
import 'widgets/otp_input_row.dart';
import 'widgets/otp_field_state.dart';
import 'widgets/otp_timer_section.dart';
import 'widgets/otp_hidden_input.dart';
import 'widgets/otp_bloc_listener.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();
    if (!cubit.uiState.otpInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        cubit.initOtp(email);
        cubit.controllers.otpFocusNode.requestFocus();
      });
    }

    final isLoading = cubit.state is AuthLoadingState;

    return OtpBlocListener(
      email: email,
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 120.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(alignment: AlignmentDirectional.centerStart, child: CustomBackArrowButton()),
                      SizedBox(height: 40.h),
                      Text(context.tr('confirmCode'), textAlign: TextAlign.center, style: TextStyle(color: AppColors.dark, fontSize: 22.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10.h),
                      Text(context.tr('enterVerificationCode'), textAlign: TextAlign.center, style: TextStyle(color: AppColors.secondaryText, fontSize: 13.sp, height: 1.5)),
                      SizedBox(height: 6.h),
                      Directionality(textDirection: TextDirection.ltr, child: Text(email, textAlign: TextAlign.center, style: TextStyle(color: AppColors.greenPrimary, fontSize: 14.sp, fontWeight: FontWeight.bold))),
                      SizedBox(height: 48.h),
                      GestureDetector(
                        onTap: () => cubit.controllers.otpFocusNode.requestFocus(),
                        child: AnimatedBuilder(
                          animation: cubit.uiState.otpAnimation.shakeAnim,
                          builder: (context, _) => OtpInputRow(
                            digits: cubit.otpCodeCtrl.text,
                            length: 6,
                            fieldState: cubit.uiState.otpFieldState,
                            shakeAnimation: cubit.uiState.otpAnimation.shakeAnim,
                            onTap: () => cubit.controllers.otpFocusNode.requestFocus(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      OtpTimerSection(email: email, cubit: cubit),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 24.w, right: 24.w, bottom: 24.h,
                child: OtpConfirmButton(
                  label: context.tr('confirm'),
                  isLoading: isLoading,
                  isSuccess: cubit.uiState.otpFieldState == OtpFieldState.success,
                  isEnabled: cubit.otpCodeCtrl.text.length == 6 && cubit.uiState.otpFieldState != OtpFieldState.error,
                  onPressed: cubit.otpCodeCtrl.text.length == 6 ? () {
                    cubit.controllers.otpFocusNode.unfocus();
                    cubit.verifyOtp(phoneNumber: email, otp: cubit.otpCodeCtrl.text);
                  } : () {},
                ),
              ),
              OtpHiddenInput(cubit: cubit),
            ],
          ),
        ),
      ),
    );
  }
}
