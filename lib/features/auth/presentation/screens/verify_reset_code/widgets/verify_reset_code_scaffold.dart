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
  static const int length = 6;

  const VerifyResetCodeScaffold({super.key, required this.email});

  @override
  State<VerifyResetCodeScaffold> createState() =>
      _VerifyResetCodeScaffoldState();
}

class _VerifyResetCodeScaffoldState extends State<VerifyResetCodeScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

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
  void dispose() {
    _shakeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) =>
          current is ResetCodeVerifyFailure &&
          previous is! ResetCodeVerifyFailure,
      listener: (context, state) {
        _shakeCtrl.forward(from: 0.0);
      },
      child: Scaffold(
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
                            _ResetCodeInputSection(shakeAnim: _shakeAnim),
                            SizedBox(height: 20.h),
                            const _ResetCodeErrorText(),
                            SizedBox(height: 12.h),
                            _ResetCodeTimerSection(email: widget.email),
                            SizedBox(height: 32.h),
                          ],
                        ),
                      ),
                    ),
                    _ResetCodeConfirmButton(email: widget.email),
                  ],
                ),
              ),
              const VerifyResetCodeHiddenInput(
                length: VerifyResetCodeScaffold.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResetCodeInputSection extends StatelessWidget {
  final Animation<double> shakeAnim;

  const _ResetCodeInputSection({required this.shakeAnim});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    final fieldState = context.select<ForgotPasswordCubit, OtpFieldState>(
      (c) => c.state is ResetCodeVerifySuccess
          ? OtpFieldState.success
          : c.state is ResetCodeVerifyFailure
          ? OtpFieldState.error
          : OtpFieldState.idle,
    );
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: cubit.resetCodeCtrl,
      builder: (context, value, _) {
        final digits = value.text;
        return GestureDetector(
          onTap: () => cubit.resetFocusNode.requestFocus(),
          child: AnimatedBuilder(
            animation: shakeAnim,
            builder: (context, _) => OtpInputRow(
              digits: digits,
              length: VerifyResetCodeScaffold.length,
              fieldState: fieldState,
              shakeAnimation: shakeAnim,
              onTap: () => cubit.resetFocusNode.requestFocus(),
            ),
          ),
        );
      },
    );
  }
}

class _ResetCodeErrorText extends StatelessWidget {
  const _ResetCodeErrorText();

  @override
  Widget build(BuildContext context) {
    final isError = context.select<ForgotPasswordCubit, bool>(
      (c) => c.state is ResetCodeVerifyFailure,
    );
    if (!isError) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        context.tr('otpCodeError'),
        textAlign: TextAlign.center,
        style: AppText.ibmError12(),
      ),
    );
  }
}

class _ResetCodeTimerSection extends StatelessWidget {
  final String email;

  const _ResetCodeTimerSection({required this.email});

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

class _ResetCodeConfirmButton extends StatelessWidget {
  final String email;

  const _ResetCodeConfirmButton({required this.email});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    final btnData = context.select<ForgotPasswordCubit, _ResetCodeBtnData>((c) {
      final s = c.state;
      final isError = s is ResetCodeVerifyFailure;
      return _ResetCodeBtnData(
        isLoading: s is ResetCodeVerifyLoading,
        isSuccess: s is ResetCodeVerifySuccess,
        isError: isError,
      );
    });
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: cubit.resetCodeCtrl,
        builder: (context, value, _) {
          final digitsLen = value.text.length;
          return OtpConfirmButton(
            label: context.tr('confirm'),
            isLoading: btnData.isLoading,
            isSuccess: btnData.isSuccess,
            isEnabled:
                digitsLen == VerifyResetCodeScaffold.length && !btnData.isError,
            onPressed: digitsLen == VerifyResetCodeScaffold.length
                ? () {
                    cubit.resetFocusNode.unfocus();
                    cubit.passwordVerifyOtp(email, value.text);
                  }
                : () {},
          );
        },
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ResetCodeBtnData &&
          isLoading == other.isLoading &&
          isSuccess == other.isSuccess &&
          isError == other.isError;

  @override
  int get hashCode => Object.hashAll([isLoading, isSuccess, isError]);
}
