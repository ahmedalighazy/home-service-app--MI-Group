import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/image/app_assets.dart';
import '../../../../../../core/themes/text/app_text.dart';
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
            context.l10n.welcomeBack,
            textAlign: TextAlign.right,
            style: AppText.ibmHeading22(color: AppColors.dark),
          ),

          SizedBox(height: 32.h),

          AuthTextField(
            label: context.l10n.emailLabel,
            hint: context.l10n.emailPlaceholder,
            controller: emailController,
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            onChanged: onFieldChanged,
          ),

          SizedBox(height: 16.h),

          AuthTextField(
            label: context.l10n.passwordLabel,
            hint: context.l10n.passwordPlaceholder,
            controller: passwordController,
            prefixIcon: Icons.lock_outline_rounded,
            isPassword: true,
            hasError: hasError,
            errorMessage: context.l10n.errorIncorrectPassword,
            onChanged: onFieldChanged,
          ),

          SizedBox(height: 24.h),

          AuthPrimaryButton(
            label: context.l10n.login,
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
            text: context.l10n.signUpWithGoogle,
            onTap: onGoogleSignIn,
          ),

          SizedBox(height: 12.h),

          AuthSocialButton(
            iconPath: AppAssets.iconApple,
            text: context.l10n.signUpWithApple,
            onTap: onAppleSignIn,
          ),

          SizedBox(height: 32.h),

          AuthFooterLink(
            questionText: context.l10n.dontHaveAccount,
            actionText: context.l10n.createAccount,
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
