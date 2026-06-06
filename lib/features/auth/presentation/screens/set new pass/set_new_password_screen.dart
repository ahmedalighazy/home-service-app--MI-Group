import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final String email;
  final String code;

  const SetNewPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late final AuthCubit _authCubit;

  bool _passwordError = false;
  bool _confirmPasswordError = false;
  bool _passwordsMatch = false;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    bool hasError = false;

    if (_passwordController.text.isEmpty) {
      setState(() => _passwordError = true);
      hasError = true;
    } else {
      setState(() => _passwordError = false);
    }

    if (_confirmPasswordController.text.isEmpty) {
      setState(() => _confirmPasswordError = true);
      hasError = true;
    } else {
      setState(() => _confirmPasswordError = false);
    }

    if (!hasError && _passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.passwordsDoNotMatch),
          backgroundColor: AppColors.errorRed,
        ),
      );
      return;
    }

    if (!hasError) {
      _authCubit.resetPassword(
            email: widget.email,
            code: widget.code,
            newPassword: _passwordController.text,
          );
    }
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
                  _showSuccessDialog(context);
                } else if (state is ResetPasswordError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: AppColors.errorRed,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return SlideTransition(
                  position: _slideAnim,
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),

                            // Back Button
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Image.asset(
                                'assets/images/Frame 2147225973.png',
                                width: 40,
                                height: 40,
                              ),
                            ),
                            SizedBox(height: 40.h),

                            // Title
                            Text(
                              AppStrings.setNewPassword,
                              style: AppText.ibmHeading22(color: AppColors.dark),
                            ),
                            SizedBox(height: 8.h),

                            // Description
                            Text(
                              AppStrings.setNewPasswordDescription,
                              style: AppText.ibmDescription14(color: AppColors.secondaryText),
                            ),
                            SizedBox(height: 24.h),

                            // New Password Field
                            AuthTextField(
                              label: AppStrings.passwordLabel,
                              hint: AppStrings.passwordPlaceholder,
                              controller: _passwordController,
                              prefixIcon: Icons.lock_outline,
                              isPassword: true,
                              hasError: _passwordError,
                              errorMessage: _passwordError ? AppStrings.passwordLabel : null,
                              onChanged: (value) {
                                if (_passwordError && value.isNotEmpty) {
                                  setState(() => _passwordError = false);
                                }
                                setState(() {
                                  _passwordsMatch = value == _confirmPasswordController.text;
                                });
                              },
                            ),
                            SizedBox(height: 16.h),

                            // Confirm Password Field
                            AuthTextField(
                              label: AppStrings.confirmPasswordLabel,
                              hint: AppStrings.confirmPasswordPlaceholder,
                              controller: _confirmPasswordController,
                              prefixIcon: Icons.lock_outline,
                              isPassword: true,
                              hasError: _confirmPasswordError,
                              errorMessage: _confirmPasswordError ? AppStrings.confirmPasswordLabel : null,
                              onChanged: (value) {
                                if (_confirmPasswordError && value.isNotEmpty) {
                                  setState(() => _confirmPasswordError = false);
                                }
                                setState(() {
                                  _passwordsMatch = value == _passwordController.text;
                                });
                              },
                            ),
                            SizedBox(height: 8.h),

                            // Password Match Indicator
                            if (_passwordsMatch && _confirmPasswordController.text.isNotEmpty)
                              Row(
                                children: [
                                  Icon(Icons.check_circle, color: AppColors.greenPrimary, size: 16.sp),
                                  SizedBox(width: 8.w),
                                  Text(
                                    AppStrings.passwordsMatch,
                                    style: AppText.ibmCaption11(color: AppColors.greenPrimary),
                                  ),
                                ],
                              ),
                            SizedBox(height: 32.h),

                            // Reset Password Button
                            AuthPrimaryButton(
                              label: AppStrings.setNewPassword,
                              isLoading: state is AuthLoading,
                              onPressed: _handleResetPassword,
                            ),
                            SizedBox(height: 40.h),
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

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: AppColors.light,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 40.w,
                  color: AppColors.greenPrimary,
                ),
              ),
              SizedBox(height: 16.h),

              // Success Message
              Text(
                AppStrings.passwordChangedSuccessfully,
                style: AppText.ibmFieldLabel14(color: AppColors.dark),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              // Description
              Text(
                AppStrings.loginWithNewPassword,
                style: AppText.ibmDescription14(color: AppColors.secondaryText),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.home,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greenPrimary,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppStrings.login,
                    style: AppText.ibmButton16(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
