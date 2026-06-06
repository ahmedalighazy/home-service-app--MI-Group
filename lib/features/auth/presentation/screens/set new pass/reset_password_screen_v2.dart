import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_router.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';

class ResetPasswordScreenV2 extends StatefulWidget {
  final String email;

  const ResetPasswordScreenV2({
    super.key,
    required this.email,
  });

  @override
  State<ResetPasswordScreenV2> createState() => _ResetPasswordScreenV2State();
}

class _ResetPasswordScreenV2State extends State<ResetPasswordScreenV2>
    with SingleTickerProviderStateMixin {
  // Controllers for OTP digits
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _otpFocusNodes;
  late final AuthCubit _authCubit;

  // Password fields
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  // Form states
  bool _passwordError = false;
  bool _confirmPasswordError = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _otpError = false;

  // Countdown
  int _remainingSeconds = 300; // 5 minutes

  // Animation
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
    _setupAnimation();
    _initializeOtpControllers();
    _startCountdown();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  void _initializeOtpControllers() {
    _otpControllers = List.generate(4, (_) => TextEditingController());
    _otpFocusNodes = List.generate(4, (_) => FocusNode());
  }

  void _startCountdown() {
    _countdown();
  }

  Future<void> _countdown() async {
    while (_remainingSeconds > 0 && mounted) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() => _remainingSeconds--);
      }
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _handleOtpInput(int index, String value) {
    if (value.isNotEmpty) {
      if (value.length > 1) {
        // Handle paste
        final paste = value.replaceAll(RegExp(r'\D'), '');
        for (int i = 0; i < paste.length && index + i < 4; i++) {
          _otpControllers[index + i].text = paste[i];
        }
        if (paste.length >= 4 - index) {
          _otpFocusNodes[3].unfocus();
        } else {
          _otpFocusNodes[index + paste.length].requestFocus();
        }
      } else {
        if (index < 3) {
          _otpFocusNodes[index + 1].requestFocus();
        } else {
          _otpFocusNodes[index].unfocus();
        }
      }
    }
    setState(() => _otpError = false);
  }

  void _handleOtpBackspace(int index, String value) {
    if (value.isEmpty && index > 0) {
      _otpControllers[index - 1].clear();
      _otpFocusNodes[index - 1].requestFocus();
    }
  }

  String _getOtpCode() {
    return _otpControllers.map((c) => c.text).join();
  }

  bool _isOtpComplete() {
    return _otpControllers.every((c) => c.text.isNotEmpty);
  }

  void _handleResendCode() {
    _authCubit.forgotPassword(email: widget.email);
    setState(() => _remainingSeconds = 300);
    _startCountdown();
  }

  void _handleVerifyAndReset() {
    bool hasError = false;

    // Validate OTP
    if (!_isOtpComplete()) {
      setState(() => _otpError = true);
      hasError = true;
    } else {
      setState(() => _otpError = false);
    }

    // Validate password
    if (_newPasswordCtrl.text.isEmpty) {
      setState(() => _passwordError = true);
      hasError = true;
    } else if (_newPasswordCtrl.text.length < 6) {
      setState(() => _passwordError = true);
      hasError = true;
    } else {
      setState(() => _passwordError = false);
    }

    // Validate confirm password
    if (_confirmPasswordCtrl.text.isEmpty) {
      setState(() => _confirmPasswordError = true);
      hasError = true;
    } else if (_newPasswordCtrl.text != _confirmPasswordCtrl.text) {
      setState(() => _confirmPasswordError = true);
      hasError = true;
    } else {
      setState(() => _confirmPasswordError = false);
    }

    if (!hasError) {
      // Reset password
      _authCubit.resetPassword(
            email: widget.email,
            code: _getOtpCode(),
            newPassword: _newPasswordCtrl.text,
          );
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.errorRed,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.greenPrimary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: BlocProvider.value(
            value: _authCubit,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is ResetPasswordSuccess) {
                  _showSuccessSnackBar('تم تعيين كلمة المرور الجديدة بنجاح');
                  final router = GoRouter.of(context);
                  Future.delayed(const Duration(seconds: 1), () {
                    if (!mounted) return;
                    router.go(AppRouter.signIn);
                  });
                } else if (state is ResetPasswordError) {
                  _showErrorSnackBar(state.message);
                } else if (state is AuthError) {
                  _showErrorSnackBar(state.message);
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 20.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Back Button
                            _buildBackButton(isArabic),
                            SizedBox(height: 24.h),

                            // Title
                            _buildTitle(),
                            SizedBox(height: 32.h),

                            // Email Icon with decoration
                            _buildEmailIcon(),
                            SizedBox(height: 32.h),

                            // Description
                            _buildDescription(),
                            SizedBox(height: 24.h),

                            // OTP Input Fields
                            _buildOtpFields(),
                            SizedBox(height: 16.h),

                            // Resend Code Link
                            _buildResendLink(),
                            SizedBox(height: 32.h),

                            // New Password Field
                            _buildPasswordField(),
                            SizedBox(height: 16.h),

                            // Confirm Password Field
                            _buildConfirmPasswordField(),
                            SizedBox(height: 32.h),

                            // Verify and Reset Button
                            AuthPrimaryButton(
                              label: 'تأكيد',
                              onPressed: _handleVerifyAndReset,
                              isLoading: state is AuthLoading,
                            ),

                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(bool isArabic) {
    return Align(
      alignment:
          isArabic ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            isArabic
                ? Icons.arrow_forward_ios_rounded
                : Icons.arrow_back_ios_rounded,
            size: 18.sp,
            color: AppColors.primaryText,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'إعادة تعيين كلمة المرور',
      style: AppText.ibmHeading22(color: AppColors.dark),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildEmailIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Envelope
        Icon(
          Icons.mail_outline,
          size: 80.sp,
          color: AppColors.greenPrimary,
        ),

        // Play button overlay
        Positioned(
          bottom: 5.h,
          right: isArabic() ? null : 5.w,
          left: isArabic() ? 5.w : null,
          child: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.greenPrimary,
              boxShadow: [
                BoxShadow(
                  color: AppColors.greenPrimary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.play_arrow,
              size: 16.sp,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      children: [
        Text(
          'تحقق من بريدك الإلكتروني',
          style: AppText.ibmHeading18(color: AppColors.dark),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'لم يصل رابط إعادة تعيين في بريدك الإلكتروني!\nأدخل الرمز الذي أرسلناه إلى ',
                style: AppText.ibmDescription14(color: AppColors.secondaryText),
              ),
              TextSpan(
                text: widget.email,
                style: AppText.ibmDescription14(
                  color: AppColors.greenPrimary,
                ),
              ),
              TextSpan(
                text: '\nأدخل الرمز المكون من 4 أرقام',
                style: AppText.ibmDescription14(color: AppColors.secondaryText),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_otpError)
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Text(
              'يرجى إدخال الرمز كاملاً',
              style: AppText.ibmError12(),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            4,
            (index) => Container(
              width: 60.w,
              height: 60.w,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _otpError
                      ? AppColors.errorRed
                      : (index == 2
                          ? AppColors.greenPrimary
                          : AppColors.borderInputs),
                  width: index == 2 ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
                color: index == 2
                    ? AppColors.greenPrimary.withValues(alpha: 0.05)
                    : AppColors.white,
              ),
              child: TextField(
                controller: _otpControllers[index],
                focusNode: _otpFocusNodes[index],
                keyboardType: TextInputType.number,
                maxLength: 1,
                textAlign: TextAlign.center,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _handleOtpInput(index, value);
                  }
                },
                onSubmitted: (value) {
                  if (value.isEmpty && index > 0) {
                    _handleOtpBackspace(index, value);
                  }
                },
                style: AppText.ibmHeading22(color: AppColors.dark),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  counterText: '',
                  hintStyle: AppText.ibmDescription14(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResendLink() {
    return Center(
      child: GestureDetector(
        onTap: _remainingSeconds > 0 ? null : _handleResendCode,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'لم تستقبل الرمز؟ ',
                style: AppText.ibmDescription12(
                  color: AppColors.secondaryText,
                ),
              ),
              TextSpan(
                text: _remainingSeconds > 0
                    ? 'أعد الإرسال في ${_formatTime(_remainingSeconds)}'
                    : 'أعد إرسال الكود',
                style: AppText.ibmDescription12(
                  color: _remainingSeconds > 0
                      ? AppColors.secondaryText
                      : AppColors.greenPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          'كلمة المرور الجديدة',
          style: AppText.ibmFieldLabel14(color: AppColors.dark),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _passwordError ? AppColors.errorRed : AppColors.borderInputs,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
          child: Row(
            children: [
              Icon(
                Icons.lock_outline,
                size: 20.sp,
                color: AppColors.secondaryText,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextField(
                  controller: _newPasswordCtrl,
                  obscureText: !_passwordVisible,
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                  onChanged: (value) {
                    if (_passwordError && value.isNotEmpty) {
                      setState(() => _passwordError = false);
                    }
                  },
                  style: AppText.ibmDescription14(color: AppColors.primaryText),
                  decoration: InputDecoration(
                    hintText: 'أدخل كلمة المرور الجديدة',
                    hintStyle: AppText.ibmPlaceholder14(),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => _passwordVisible = !_passwordVisible);
                },
                child: Icon(
                  _passwordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20.sp,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
        if (_passwordError)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
              style: AppText.ibmError12(),
            ),
          ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          'تأكيد كلمة المرور',
          style: AppText.ibmFieldLabel14(color: AppColors.dark),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _confirmPasswordError
                  ? AppColors.errorRed
                  : AppColors.borderInputs,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
          child: Row(
            children: [
              Icon(
                Icons.lock_outline,
                size: 20.sp,
                color: AppColors.secondaryText,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextField(
                  controller: _confirmPasswordCtrl,
                  obscureText: !_confirmPasswordVisible,
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                  onChanged: (value) {
                    if (_confirmPasswordError && value.isNotEmpty) {
                      setState(() => _confirmPasswordError = false);
                    }
                  },
                  style: AppText.ibmDescription14(color: AppColors.primaryText),
                  decoration: InputDecoration(
                    hintText: 'أدخل كلمة المرور مرة أخرى',
                    hintStyle: AppText.ibmPlaceholder14(),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => _confirmPasswordVisible = !_confirmPasswordVisible);
                },
                child: Icon(
                  _confirmPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20.sp,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
        if (_confirmPasswordError)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              'كلمات المرور غير متطابقة',
              style: AppText.ibmError12(),
            ),
          ),
      ],
    );
  }

  bool isArabic() {
    return Localizations.localeOf(context).languageCode == 'ar';
  }
}
