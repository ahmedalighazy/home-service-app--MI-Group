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
  RegisterState _previousState = RegisterInitial();

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
    final state = context.watch<RegisterCubit>().state;
    if (state is OtpVerifyFailure && _previousState is! OtpVerifyFailure) {
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
    final cubit = context.read<RegisterCubit>();

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
                      widget.email,
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
                        animation: _shakeAnim,
                        builder: (context, _) =>
                            BlocSelector<
                              RegisterCubit,
                              RegisterState,
                              OtpFieldState
                            >(
                              selector: (s) => s is OtpVerifySuccess
                                  ? OtpFieldState.success
                                  : s is OtpVerifyFailure
                                  ? OtpFieldState.error
                                  : OtpFieldState.idle,
                              builder: (context, fieldState) => OtpInputRow(
                                digits: cubit.otpCodeCtrl.text,
                                length: 6,
                                fieldState: fieldState,
                                shakeAnimation: _shakeAnim,
                                onTap: () => cubit.otpFocusNode.requestFocus(),
                              ),
                            ),
                      ),
                    ),
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
              child: BlocSelector<RegisterCubit, RegisterState, _OtpBtnData>(
                selector: (s) {
                  final isError = s is OtpVerifyFailure;
                  return _OtpBtnData(
                    isLoading: s is OtpVerifyLoading,
                    isSuccess: s is OtpVerifySuccess,
                    isError: isError,
                  );
                },
                builder: (context, data) {
                  final digitsLen = cubit.otpCodeCtrl.text.length;
                  return OtpConfirmButton(
                    label: context.tr('confirm'),
                    isLoading: data.isLoading,
                    isSuccess: data.isSuccess,
                    isEnabled: digitsLen == 6 && !data.isError,
                    onPressed: digitsLen == 6
                        ? () {
                            cubit.otpFocusNode.unfocus();
                            cubit.verifyOtp(
                              phoneNumber: widget.email,
                              otp: cubit.otpCodeCtrl.text,
                            );
                          }
                        : () {},
                  );
                },
              ),
            ),
            OtpHiddenInput(email: widget.email),
          ],
        ),
      ),
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
}
