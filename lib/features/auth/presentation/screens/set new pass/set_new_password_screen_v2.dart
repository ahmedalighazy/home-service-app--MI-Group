import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';

class SetNewPasswordScreenV2 extends StatefulWidget {
  final String email;

  const SetNewPasswordScreenV2({
    super.key,
    required this.email,
  });

  @override
  State<SetNewPasswordScreenV2> createState() => _SetNewPasswordScreenV2State();
}

class _SetNewPasswordScreenV2State extends State<SetNewPasswordScreenV2>
    with SingleTickerProviderStateMixin {
  // Controllers
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  late final AuthCubit _authCubit;

  // Form states
  bool _passwordError = false;
  bool _confirmPasswordError = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  // Animation
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
    _setupAnimation();
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

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleSetPassword() {
    bool hasError = false;

    // Validate password
    if (_passwordCtrl.text.isEmpty) {
      setState(() => _passwordError = true);
      hasError = true;
    } else if (_passwordCtrl.text.length < 6) {
      setState(() => _passwordError = true);
      hasError = true;
    } else {
      setState(() => _passwordError = false);
    }

    // Validate confirm password
    if (_confirmPasswordCtrl.text.isEmpty) {
      setState(() => _confirmPasswordError = true);
      hasError = true;
    } else if (_passwordCtrl.text != _confirmPasswordCtrl.text) {
      setState(() => _confirmPasswordError = true);
      hasError = true;
    } else {
      setState(() => _confirmPasswordError = false);
    }

    if (!hasError) {
      // Call Cubit to set new password
      _authCubit.resetPassword(
            email: widget.email,
            code: '000000', // Code was already verified
            newPassword: _passwordCtrl.text,
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
                  // Show success modal
                  _showSuccessModal();
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Back Button
                            _buildBackButton(isArabic),
                            SizedBox(height: 24.h),

                            // Title
                            _buildTitle(),
                            SizedBox(height: 8.h),

                            // Description
                            _buildDescription(),
                            SizedBox(height: 32.h),

                            // Password Field
                            _buildPasswordField(isArabic),
                            SizedBox(height: 16.h),

                            // Confirm Password Field
                            _buildConfirmPasswordField(isArabic),
                            SizedBox(height: 40.h),

                            // Confirm Button
                            AuthPrimaryButton(
                              label: 'تأكيد',
                              onPressed: _handleSetPassword,
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
      'تعيين كلمة مرور جديدة',
      style: AppText.ibmHeading22(color: AppColors.dark),
    );
  }

  Widget _buildDescription() {
    return Text(
      'أنشئ كلمة مرور جديدة وتأكد من أنها مختلفة عن كلمة المرور السابقة',
      style: AppText.ibmDescription14(color: AppColors.secondaryText),
    );
  }

  Widget _buildPasswordField(bool isArabic) {
    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          'كلمة المرور',
          style: AppText.ibmFieldLabel14(color: AppColors.dark),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _passwordError ? AppColors.errorRed : AppColors.greenPrimary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
          child: Row(
            children: [
              Icon(
                Icons.lock_outline,
                size: 20.sp,
                color: AppColors.greenPrimary,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextField(
                  controller: _passwordCtrl,
                  obscureText: !_passwordVisible,
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                  onChanged: (value) {
                    if (_passwordError && value.isNotEmpty) {
                      setState(() => _passwordError = false);
                    }
                  },
                  style: AppText.ibmDescription14(color: AppColors.primaryText),
                  decoration: InputDecoration(
                    hintText: 'أدخل كلمة المرور',
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
                  color: AppColors.greenPrimary,
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

  Widget _buildConfirmPasswordField(bool isArabic) {
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
                  : AppColors.greenPrimary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
          child: Row(
            children: [
              Icon(
                Icons.lock_outline,
                size: 20.sp,
                color: AppColors.greenPrimary,
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
                  color: AppColors.greenPrimary,
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

  void _showSuccessModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PasswordResetSuccessModal(
        onLoginPressed: () {
          Navigator.of(context).pop(); // Close dialog
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home',
            (route) => false,
          );
        },
      ),
    );
  }
}

/// Success Modal Widget
class PasswordResetSuccessModal extends StatefulWidget {
  final VoidCallback onLoginPressed;

  const PasswordResetSuccessModal({
    super.key,
    required this.onLoginPressed,
  });

  @override
  State<PasswordResetSuccessModal> createState() =>
      _PasswordResetSuccessModalState();
}

class _PasswordResetSuccessModalState extends State<PasswordResetSuccessModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(32.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Success Icon
                  _buildSuccessIcon(),
                  SizedBox(height: 24.h),

                  // Success Title
                  Text(
                    'تم تغيير كلمة المرور بنجاح',
                    style: AppText.ibmHeading22(color: AppColors.dark),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),

                  // Success Description
                  Text(
                    'يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة',
                    style: AppText.ibmDescription14(
                      color: AppColors.secondaryText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),

                  // Login Button
                  _buildLoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        color: AppColors.greenPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Icon(
          Icons.check_rounded,
          size: 48.sp,
          color: AppColors.greenPrimary,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: widget.onLoginPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.greenPrimary,
              AppColors.greenPrimary.withValues(alpha: 0.8),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.greenPrimary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          'تسجيل الدخول',
          style: AppText.ibmButton16(color: AppColors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
