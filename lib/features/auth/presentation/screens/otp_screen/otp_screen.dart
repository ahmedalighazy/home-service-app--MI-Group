import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../logic/validators/otp_validator.dart';
import '../../../logic/services/otp_timer_service.dart';
import '../../cubits/auth_cubit_v2.dart';
import '../../states/auth_state.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

// New UI Widgets
import '../../widgets/auth_primary_button.dart';
import '../../widgets/otp/otp_circles_input.dart';
import '../../widgets/otp/resend_code_timer.dart';

/// OTP Verification Screen - Presentation Layer
class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _otpCode = '';
  late final AuthCubitV2 _authCubit;
  late final OtpTimerService _timerService;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubitV2>();
    _timerService = OtpTimerService(
      onTick: _onTimerTick,
      onExpired: _onTimerExpired,
    );
    _timerService.start();
  }

  @override
  void dispose() {
    _timerService.dispose();
    super.dispose();
  }

  void _onTimerTick(int remainingSeconds) {
    setState(() {});
  }

  void _onTimerExpired() {
    setState(() {
      _canResend = true;
    });
    _showError(AuthStrings.resetCodeExpired);
  }

  bool _isFormValid() {
    return _otpCode.length == 4 && OtpValidator.isOtpValid(_otpCode);
  }

  void _handleVerifyOtp() {
    final error = OtpValidator.validateOtp(_otpCode);

    if (error != null) {
      _showError(error);
      return;
    }

    _authCubit.verifyOtp(
      phoneNumber: widget.phoneNumber,
      otp: _otpCode,
    );
  }

  void _handleResendCode() {
    if (!_canResend) return;

    setState(() {
      _canResend = false;
    });

    _timerService.reset();
    _timerService.start();

    _authCubit.sendOtp(phoneNumber: widget.phoneNumber);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.errorRed,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.greenPrimary,
      ),
    );
  }

  String _formatPhoneNumber() {
    return widget.phoneNumber.replaceAll(RegExp(r'(\d{3})(\d)'), r'$1 $2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          AuthStrings.otpVerificationTitle,
          style: AppText.ibmHeading22(color: AppColors.dark),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.dark),
      ),
      body: BlocListener<AuthCubitV2, AuthState>(
        listenWhen: (previous, current) =>
            current is AuthAuthenticated ||
            current is OtpSentState ||
            current is OtpInvalidCodeState ||
            current is OtpExpiredState ||
            current is OtpErrorState,
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            _showSuccess(AuthStrings.otpVerifiedSuccess);
            // Navigate to complete profile
            context.push('/complete_profile', extra: widget.phoneNumber);
          } else if (state is OtpSentState) {
            _showSuccess(AuthStrings.successOtpSent);
          } else if (state is OtpInvalidCodeState) {
            _showError(state.message);
          } else if (state is OtpExpiredState) {
            _showError(state.message);
          } else if (state is OtpErrorState) {
            _showError(state.message);
          }
        },
        child: BlocBuilder<AuthCubitV2, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoadingState;

            return SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.h),
                  _buildTitle(context),
                  SizedBox(height: 12.h),
                  _buildSubtitle(context),
                  SizedBox(height: 32.h),
                  OtpCirclesInput(
                    length: 4,
                    onChanged: (val) {
                      setState(() {
                        _otpCode = val;
                      });
                    },
                    onCompleted: (val) {
                      setState(() {
                        _otpCode = val;
                      });
                      if (_isFormValid() && !isLoading) {
                        _handleVerifyOtp();
                      }
                    },
                  ),
                  SizedBox(height: 32.h),
                  AuthPrimaryButton(
                    label: AuthStrings.confirm,
                    isLoading: isLoading,
                    isEnabled: _isFormValid(),
                    onPressed: _handleVerifyOtp,
                  ),
                  SizedBox(height: 24.h),
                  _buildTimerWidget(),
                  SizedBox(height: 16.h),
                  Center(
                    child: ResendCodeTimer(
                      canResend: _canResend,
                      onResend: _handleResendCode,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      AuthStrings.otpVerificationTitle,
      style: AppText.ibmHeading22(color: AppColors.dark).copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      '${AuthStrings.otpVerificationSubtitle}\n${_formatPhoneNumber()}',
      style: AppText.ibmDescription14(color: AppColors.secondaryText),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTimerWidget() {
    final remainingSeconds = _timerService.remainingSeconds;
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return Align(
      alignment: Alignment.center,
      child: Text(
        '$minutes:${seconds.toString().padLeft(2, '0')}',
        style: AppText.ibmDescription14(
          color: remainingSeconds < 30 ? AppColors.errorRed : AppColors.dark,
        ).copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
