import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_confirm_button.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_input_row.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_field_state.dart';
import 'package:home_service_app/features/auth/presentation/screens/verify_reset_code/widget/verify_reset_code_widgets.dart';
import 'verify_reset_code_hidden_input.dart';

class VerifyResetCodeScaffold extends StatelessWidget {
  final String email;
  static const int length = 4;

  const VerifyResetCodeScaffold({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();
    final isLoading = cubit.state is AuthLoadingState;

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: CustomBackArrowButton(),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 16.h),
                          VerifyResetCodeHeader(email: email),
                          SizedBox(height: 36.h),
                          GestureDetector(
                            onTap: () =>
                                cubit.controllers.resetFocusNode.requestFocus(),
                            child: AnimatedBuilder(
                              animation: cubit.uiState.resetAnimation.shakeAnim,
                              builder: (context, _) => OtpInputRow(
                                digits: cubit.resetCodeCtrl.text,
                                length: length,
                                fieldState: cubit.uiState.resetFieldState,
                                shakeAnimation:
                                    cubit.uiState.resetAnimation.shakeAnim,
                                onTap: () => cubit.controllers.resetFocusNode
                                    .requestFocus(),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          if (cubit.uiState.resetFieldState ==
                              OtpFieldState.error)
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Text(
                                LocalizationService.instance.translate(
                                  'otpCodeError',
                                ),
                                textAlign: TextAlign.center,
                                style: AppText.ibmError12(),
                              ),
                            ),
                          SizedBox(height: 12.h),
                          VerifyResetCodeResendRow(
                            isLoading: isLoading,
                            onResend: () {
                              cubit.controllers.resetCodeCtrl.clear();
                              cubit.setResetFieldState(OtpFieldState.idle);
                              cubit.sendResetCode(email);
                              cubit.controllers.resetFocusNode.requestFocus();
                            },
                          ),
                          SizedBox(height: 32.h),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
                    child: OtpConfirmButton(
                      label: context.tr('confirm'),
                      isLoading: isLoading,
                      isSuccess:
                          cubit.uiState.resetFieldState ==
                          OtpFieldState.success,
                      onPressed: cubit.resetCodeCtrl.text.length == length
                          ? () {
                              cubit.controllers.resetFocusNode.unfocus();
                              cubit.verifyResetCode(
                                email,
                                cubit.resetCodeCtrl.text,
                              );
                            }
                          : () {},
                      isEnabled: cubit.resetCodeCtrl.text.length == length,
                    ),
                  ),
                ],
              ),
            ),
            VerifyResetCodeHiddenInput(cubit: cubit, length: length),
          ],
        ),
      ),
    );
  }
}
