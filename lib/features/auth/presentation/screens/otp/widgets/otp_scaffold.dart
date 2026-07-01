import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/cubit/register/register_cubit.dart';
import 'package:home_service_app/features/auth/cubit/register/register_state.dart';
import 'otp_confirm_button.dart';
import 'otp_input_row.dart';
import 'otp_field_state.dart';
import 'otp_timer_section.dart';
import 'otp_hidden_input.dart';

class OtpScaffold extends StatefulWidget {
  final String email;

  const OtpScaffold({super.key, required this.email});

  @override
  State<OtpScaffold> createState() => _OtpScaffoldState();
}

class _OtpScaffoldState extends State<OtpScaffold>
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
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          current is OtpVerifyFailure && previous is! OtpVerifyFailure,
      listener: (context, state) {
        _shakeCtrl.forward(from: 0.0);
      },
      child: Scaffold(
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
                        widget.email,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.greenPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 48.h),
                      _OtpInputSection(shakeAnim: _shakeAnim),
                      SizedBox(height: 20.h),
                      OtpTimerSection(email: widget.email),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 24.w,
                right: 24.w,
                bottom: 24.h,
                child: _OtpConfirmSection(email: widget.email),
              ),
              OtpHiddenInput(email: widget.email),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpInputSection extends StatelessWidget {
  final Animation<double> shakeAnim;

  const _OtpInputSection({required this.shakeAnim});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    final fieldState = context.select<RegisterCubit, OtpFieldState>(
      (c) => c.state is OtpVerifySuccess
          ? OtpFieldState.success
          : c.state is OtpVerifyFailure
          ? OtpFieldState.error
          : OtpFieldState.idle,
    );
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: cubit.otpCodeCtrl,
      builder: (context, value, _) => GestureDetector(
        onTap: () => cubit.otpFocusNode.requestFocus(),
        child: AnimatedBuilder(
          animation: shakeAnim,
          builder: (context, _) => OtpInputRow(
            digits: value.text,
            length: 6,
            fieldState: fieldState,
            shakeAnimation: shakeAnim,
            onTap: () => cubit.otpFocusNode.requestFocus(),
          ),
        ),
      ),
    );
  }
}

class _OtpConfirmSection extends StatelessWidget {
  final String email;

  const _OtpConfirmSection({required this.email});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    final btnData = context.select<RegisterCubit, _OtpBtnData>((c) {
      final s = c.state;
      final isError = s is OtpVerifyFailure;
      return _OtpBtnData(
        isLoading: s is OtpVerifyLoading,
        isSuccess: s is OtpVerifySuccess,
        isError: isError,
      );
    });
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: cubit.otpCodeCtrl,
      builder: (context, value, _) {
        final digitsLen = value.text.length;
        return OtpConfirmButton(
          label: context.tr('confirm'),
          isLoading: btnData.isLoading,
          isSuccess: btnData.isSuccess,
          isEnabled: digitsLen == 6 && !btnData.isError,
          onPressed: digitsLen == 6
              ? () {
                  cubit.otpFocusNode.unfocus();
                  cubit.verifyOtp(phoneNumber: email, otp: value.text);
                }
              : () {},
        );
      },
    );
  }
}

class _OtpBtnData {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  const _OtpBtnData({
    required this.isLoading,
    required this.isSuccess,
    required this.isError,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _OtpBtnData &&
          isLoading == other.isLoading &&
          isSuccess == other.isSuccess &&
          isError == other.isError;

  @override
  int get hashCode => Object.hashAll([isLoading, isSuccess, isError]);
}
