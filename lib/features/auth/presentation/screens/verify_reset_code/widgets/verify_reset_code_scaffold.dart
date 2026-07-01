import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_state.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_confirm_button.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_input_row.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_field_state.dart';
import 'verify_reset_code_widgets.dart';
import 'verify_reset_code_hidden_input.dart';

class VerifyResetCodeScaffold extends StatefulWidget {
  final String email;
  static const int length = 4;

  const VerifyResetCodeScaffold({super.key, required this.email});

  @override
  State<VerifyResetCodeScaffold> createState() =>
      _VerifyResetCodeScaffoldState();
}

class _VerifyResetCodeScaffoldState extends State<VerifyResetCodeScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;
  ForgotPasswordState _previousState = ForgotPasswordInitial();

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeCtrl, curve: Curves.easeInOut));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.watch<ForgotPasswordCubit>().state;
    if (state is ResetCodeVerifyFailure &&
        _previousState is! ResetCodeVerifyFailure) {
      _shakeCtrl.forward(from: 0.0);
    }
    _previousState = state;
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();

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
                          VerifyResetCodeHeader(email: widget.email),
                          SizedBox(height: 36.h),
                          GestureDetector(
                            onTap: () => cubit.resetFocusNode.requestFocus(),
                            child: AnimatedBuilder(
                              animation: _shakeAnim,
                              builder: (context, _) =>
                                  BlocSelector<
                                    ForgotPasswordCubit,
                                    ForgotPasswordState,
                                    OtpFieldState
                                  >(
                                    selector: (s) => s is ResetCodeVerifySuccess
                                        ? OtpFieldState.success
                                        : s is ResetCodeVerifyFailure
                                        ? OtpFieldState.error
                                        : OtpFieldState.idle,
                                    builder: (context, fieldState) =>
                                        OtpInputRow(
                                          digits: cubit.resetCodeCtrl.text,
                                          length:
                                              VerifyResetCodeScaffold.length,
                                          fieldState: fieldState,
                                          shakeAnimation: _shakeAnim,
                                          onTap: () => cubit.resetFocusNode
                                              .requestFocus(),
                                        ),
                                  ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          BlocSelector<
                            ForgotPasswordCubit,
                            ForgotPasswordState,
                            bool
                          >(
                            selector: (s) => s is ResetCodeVerifyFailure,
                            builder: (context, isError) {
                              if (!isError) return const SizedBox.shrink();
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Text(
                                  context.tr('otpCodeError'),
                                  textAlign: TextAlign.center,
                                  style: AppText.ibmError12(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 12.h),
                          BlocSelector<
                            ForgotPasswordCubit,
                            ForgotPasswordState,
                            bool
                          >(
                            selector: (s) => s is ResetCodeVerifyLoading,
                            builder: (context, isLoading) =>
                                VerifyResetCodeResendRow(
                                  isLoading: isLoading,
                                  onResend: () {
                                    cubit.resetCodeCtrl.clear();
                                    cubit.sendResetCode(widget.email);
                                    cubit.resetFocusNode.requestFocus();
                                  },
                                ),
                          ),
                          SizedBox(height: 32.h),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
                    child:
                        BlocSelector<
                          ForgotPasswordCubit,
                          ForgotPasswordState,
                          _ResetCodeBtnData
                        >(
                          selector: (s) {
                            final isError = s is ResetCodeVerifyFailure;
                            return _ResetCodeBtnData(
                              isLoading: s is ResetCodeVerifyLoading,
                              isSuccess: s is ResetCodeVerifySuccess,
                              isError: isError,
                            );
                          },
                          builder: (context, data) {
                            final digitsLen = cubit.resetCodeCtrl.text.length;
                            return OtpConfirmButton(
                              label: context.tr('confirm'),
                              isLoading: data.isLoading,
                              isSuccess: data.isSuccess,
                              onPressed:
                                  digitsLen == VerifyResetCodeScaffold.length
                                  ? () {
                                      cubit.resetFocusNode.unfocus();
                                      cubit.verifyResetCode(
                                        widget.email,
                                        cubit.resetCodeCtrl.text,
                                      );
                                    }
                                  : () {},
                              isEnabled:
                                  digitsLen == VerifyResetCodeScaffold.length &&
                                  !data.isError,
                            );
                          },
                        ),
                  ),
                ],
              ),
            ),
            VerifyResetCodeHiddenInput(length: VerifyResetCodeScaffold.length),
          ],
        ),
      ),
    );
  }
}

class _ResetCodeBtnData {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  const _ResetCodeBtnData({
    required this.isLoading,
    required this.isSuccess,
    required this.isError,
  });
}
