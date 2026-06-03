import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cubits/auth_cubit.dart';
import '../logic/states/auth_state.dart';
import '../../../core/di/injection.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _hasError = false; // Set to true to show the error state from the design

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الرجاء إدخال البريد الإلكتروني وكلمة المرور', style: AppText.ibmDescription14(color: AppColors.white))),
      );
      return;
    }
    context.read<AuthCubit>().loginWithEmail(_emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.dark),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              setState(() => _hasError = true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message, style: AppText.ibmDescription14(color: AppColors.white)),
                  backgroundColor: AppColors.errorRed,
                ),
              );
            } else if (state is AuthSuccess) {
              setState(() => _hasError = false);
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            
            return Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                SizedBox(height: 20.h),
                
                // Title
                Text(
                  AppStrings.welcomeBackAlt,
                  textAlign: TextAlign.right,
                  style: AppText.ibmHeading22(color: AppColors.dark),
                ),
                
                SizedBox(height: 32.h),
                
                // Email Field
                Text(
                  AppStrings.emailLabel,
                  style: AppText.ibmFieldLabel14(color: AppColors.dark),
                ),
                SizedBox(height: 8.h),
                _CustomTextField(
                  controller: _emailController,
                  hintText: AppStrings.emailPlaceholder,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.mail_outline, color: AppColors.placeholder),
                ),
                
                SizedBox(height: 16.h),
                
                // Password Field
                Text(
                  AppStrings.passwordLabel,
                  style: AppText.ibmFieldLabel14(color: _hasError ? AppColors.errorRed : AppColors.dark),
                ),
                SizedBox(height: 8.h),
                _CustomTextField(
                  controller: _passwordController,
                  hintText: AppStrings.passwordPlaceholder,
                  obscureText: _obscurePassword,
                  hasError: _hasError,
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.placeholder),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.placeholder,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                
                // Error message
                if (_hasError) ...[
                  SizedBox(height: 6.h),
                  Text(
                    AppStrings.errorIncorrectPassword,
                    style: AppText.ibmError12(),
                  ),
                ],
                
                SizedBox(height: 24.h),
                
                // Login Button
                GestureDetector(
                  onTap: isLoading ? null : () => _login(context),
                  child: Container(
                    height: 54.h,
                    decoration: BoxDecoration(
                      color: isLoading ? AppColors.bgDisabled : AppColors.dark,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Center(
                      child: isLoading 
                          ? const SizedBox(
                              height: 24, 
                              width: 24, 
                              child: CircularProgressIndicator(color: AppColors.dark, strokeWidth: 2.5)
                            )
                          : Text(
                              AppStrings.login,
                              style: AppText.ibmButton16(color: AppColors.white),
                            ),
                    ),
                  ),
                ),
                
                SizedBox(height: 16.h),
                
                // Remember me & Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: Checkbox(
                            value: _rememberMe,
                            activeColor: AppColors.greenPrimary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          AppStrings.rememberMe,
                          style: AppText.ibmDescription14(color: AppColors.dark),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                         Navigator.of(context).pushNamed(AppRoutes.forgetPassword);
                      },
                      child: Text(
                        AppStrings.forgotPassword,
                        style: AppText.ibmLink13(color: AppColors.greenPrimary),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 32.h),
                
                // Or Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.borderInputs, thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        AppStrings.orUsing,
                        style: AppText.ibmCaption11(color: AppColors.gray),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.borderInputs, thickness: 1)),
                  ],
                ),
                
                SizedBox(height: 24.h),
                
                // Google Login
                _SocialButton(
                  iconPath: AppAssets.iconGoogle,
                  label: AppStrings.signUpWithGoogle,
                  onPressed: () {},
                ),
                
                SizedBox(height: 16.h),
                
                // Apple Login
                _SocialButton(
                  iconPath: AppAssets.iconApple,
                  label: AppStrings.signUpWithApple,
                  onPressed: () {},
                ),
                
                SizedBox(height: 32.h),
                
                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccount,
                      style: AppText.ibmDescription14(color: AppColors.secondaryText),
                    ),
                     GestureDetector(
                      onTap: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                        }
                      },
                      child: Text(
                        AppStrings.createAccount,
                        style: AppText.ibmLink13(color: AppColors.greenPrimary),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 16.h),
                
                // Terms
                Text(
                  AppStrings.termsAndPrivacy,
                  textAlign: TextAlign.center,
                  style: AppText.ibmCaption11(color: AppColors.gray),
                ),
                
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      );
    },
  ),
),
    );
  }
}

// Custom Text Field for Auth
class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hasError;

  const _CustomTextField({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: hasError ? AppColors.errorRed : AppColors.borderInputs,
          width: 1,
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: AppText.ibmDescription14(color: AppColors.primaryText),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppText.ibmPlaceholder14(),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
        ),
      ),
    );
  }
}

// Social Login Button
class _SocialButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.iconPath,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 54.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: AppColors.borderInputs),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 24.w, height: 24.w),
            SizedBox(width: 12.w),
            Text(
              label,
              style: AppText.ibmFieldLabel14(color: AppColors.primaryText),
            ),
          ],
        ),
      ),
    );
  }
}
