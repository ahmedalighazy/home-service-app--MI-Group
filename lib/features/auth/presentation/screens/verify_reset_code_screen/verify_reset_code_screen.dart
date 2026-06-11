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

/// Verify Reset Code Screen - Presentation Layer
class VerifyResetCodeScreen extends StatefulWidget {
  final String email;

  const VerifyResetCodeScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerifyResetCodeScreen> createState() => _VerifyResetCodeScreenState();
}

class _VerifyResetCodeScreenState extends State<VerifyResetCodeScreen> {
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
    return _otpCode.length == 6 && OtpValidator.isOtpValid(_otpCode);
  }

  void _handleVerifyCode() {
    final error = OtpValidator.validateOtp(_otpCode);

    if (error != null) {
      _showError(error);
      return;
    }

    _authCubit.verifyResetCode(
      email: widget.email,
      code: _otpCode,
    );
  }

  void _handleResendCode() {
    if (!_canResend) return;

    setState(() {
      _canResend = false;
    });

    _timerService.reset();
    _timerService.start();

    _authCubit.requestPasswordReset(email: widget.email);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          AuthStrings.verifyResetCodeTitle,
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
            current is ResetCodeSentState ||
            current is ResetCodeInvalidState ||
            current is ResetCodeExpiredState ||
            current is PasswordResetErrorState,
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigate to set new password
            context.push('/set_new_password', extra: widget.email);
          } else if (state is ResetCodeSentState) {
            _showSuccess(AuthStrings.successResetCodeSent);
          } else if (state is ResetCodeInvalidState) {
            _showError(state.message);
          } else if (state is ResetCodeExpiredState) {
            _showError(state.message);
          } else if (state is PasswordResetErrorState) {
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
                  Text(
                    AuthStrings.verifyResetCodeTitle,
                    style: AppText.ibmHeading22(color: AppColors.dark).copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AuthStrings.verifyResetCodeDescription,
                    style: AppText.ibmDescription14(color: AppColors.secondaryText),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  OtpCirclesInput(
                    length: 6,
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
                        _handleVerifyCode();
                      }
                    },
                  ),
                  SizedBox(height: 32.h),
                  AuthPrimaryButton(
                    label: AuthStrings.confirm,
                    isLoading: isLoading,
                    isEnabled: _isFormValid(),
                    onPressed: _handleVerifyCode,
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
