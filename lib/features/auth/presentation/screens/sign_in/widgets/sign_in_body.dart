import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/image/app_assets.dart';
import '../../../../../../core/themes/text/app_text.dart';
import '../../../../../../core/utils/l10n/app_strings.dart';
import '../../../widgets/auth_footer_link.dart';
import '../../../widgets/auth_or_divider.dart';
import '../../../widgets/auth_primary_button.dart';
import '../../../widgets/auth_social_button.dart';
import '../../../widgets/auth_text_field.dart';
import '../../../widgets/terms_and_privacy_text.dart';
import 'remember_me_checkbox.dart';

class SignInBody extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final bool hasError;
  final bool isLoading;
  final VoidCallback onLogin;
  final ValueChanged<String> onFieldChanged;
  final ValueChanged<bool?> onRememberChanged;
  final VoidCallback onForgotPassword;
  final VoidCallback onGoogleSignIn;
  final VoidCallback onAppleSignIn;
  final VoidCallback onSignUp;

  const SignInBody({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.hasError,
    required this.isLoading,
    required this.onLogin,
    required this.onFieldChanged,
    required this.onRememberChanged,
    required this.onForgotPassword,
    required this.onGoogleSignIn,
    required this.onAppleSignIn,
    required this.onSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20.h),

          Text(
            AppStrings.welcomeBackAlt,
            textAlign: TextAlign.right,
            style: AppText.ibmHeading22(color: AppColors.dark),
          ),

          SizedBox(height: 32.h),

          AuthTextField(
            label: AppStrings.emailLabel,
            hint: AppStrings.emailPlaceholder,
            controller: emailController,
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            onChanged: onFieldChanged,
          ),

          SizedBox(height: 16.h),

          AuthTextField(
            label: AppStrings.passwordLabel,
            hint: AppStrings.passwordPlaceholder,
            controller: passwordController,
            prefixIcon: Icons.lock_outline_rounded,
            isPassword: true,
            hasError: hasError,
            errorMessage: AppStrings.errorIncorrectPassword,
            onChanged: onFieldChanged,
          ),

          SizedBox(height: 24.h),

          AuthPrimaryButton(
            label: AppStrings.login,
            isLoading: isLoading,
            onPressed: onLogin,
          ),

          SizedBox(height: 16.h),

          RememberMeCheckbox(
            rememberMe: rememberMe,
            onRememberChanged: onRememberChanged,
            onForgotTap: onForgotPassword,
          ),

          SizedBox(height: 32.h),

          const AuthOrDivider(),

          SizedBox(height: 24.h),

          AuthSocialButton(
            iconPath: AppAssets.iconGoogle,
            text: AppStrings.signUpWithGoogle,
            onTap: onGoogleSignIn,
          ),

          SizedBox(height: 12.h),

          AuthSocialButton(
            iconPath: AppAssets.iconApple,
            text: AppStrings.signUpWithApple,
            onTap: onAppleSignIn,
          ),

          SizedBox(height: 32.h),

          AuthFooterLink(
            questionText: AppStrings.dontHaveAccount,
            actionText: AppStrings.createAccount,
            onTap: onSignUp,
          ),

          SizedBox(height: 16.h),

          const TermsAndPrivacyText(),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
