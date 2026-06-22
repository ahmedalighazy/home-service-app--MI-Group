import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'sign_in_header.dart';
import 'email_input_field.dart';
import 'password_input_field.dart';
import 'login_button.dart';
import 'remember_me_section.dart';
import 'social_sign_in_buttons.dart';
import 'footer_link.dart';
import '../../../widgets/auth_or_divider.dart';
import '../../../widgets/terms_and_privacy_text.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

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
          const SignInHeader(),
          SizedBox(height: 32.h),
          EmailInputField(controller: emailController, onChanged: onFieldChanged),
          SizedBox(height: 16.h),
          PasswordInputField(controller: passwordController, hasError: hasError, onChanged: onFieldChanged),
          SizedBox(height: 24.h),
          LoginButton(isLoading: isLoading, onPressed: onLogin),
          SizedBox(height: 16.h),
          RememberMeSection(
            rememberMe: rememberMe,
            onRememberChanged: onRememberChanged,
            onForgotTap: onForgotPassword,
          ),
          SizedBox(height: 32.h),
          const AuthOrDivider(),
          SizedBox(height: 24.h),
          SocialSignInButtons(
            onGoogleSignIn: onGoogleSignIn,
            onAppleSignIn: onAppleSignIn,
          ),
          SizedBox(height: 32.h),
          FooterLink(
            questionText: context.tr('dontHaveAccount'),
            actionText: context.tr('createAccount'),
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
