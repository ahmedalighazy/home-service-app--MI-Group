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
import '../../../widgets/terms_and_privacy_text.dart';
import 'guest_mode_button.dart';
import 'phone_input_field.dart';

/// Sign Up Screen Body
///
/// Contains all UI components for sign up
class SignUpBody extends StatelessWidget {
  final TextEditingController phoneController;
  final bool hasError;
  final String? errorMessage;
  final bool isLoading;
  final VoidCallback onSendCode;
  final VoidCallback onGoogleSignUp;
  final VoidCallback onAppleSignUp;
  final VoidCallback onGuestMode;
  final VoidCallback onSignIn;
  final ValueChanged<String> onPhoneChanged;

  const SignUpBody({
    super.key,
    required this.phoneController,
    required this.hasError,
    required this.errorMessage,
    required this.isLoading,
    required this.onSendCode,
    required this.onGoogleSignUp,
    required this.onAppleSignUp,
    required this.onGuestMode,
    required this.onSignIn,
    required this.onPhoneChanged,
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

          // ── Title ────────────────────────────────────
          _buildTitle(context),

          SizedBox(height: 8.h),

          // ── Subtitle ─────────────────────────────────
          _buildSubtitle(context),

          SizedBox(height: 32.h),

          // ── Phone input ──────────────────────────────
          PhoneInputField(
            controller: phoneController,
            hasError: hasError,
            errorMessage: errorMessage,
            onChanged: onPhoneChanged,
          ),

          SizedBox(height: 24.h),

          // ── Send code button ─────────────────────────
          AuthPrimaryButton(
            label: context.l10n.sendCode,
            isLoading: isLoading,
            isEnabled: phoneController.text.isNotEmpty,
            onPressed: onSendCode,
          ),

          SizedBox(height: 32.h),

          // ── Or divider ───────────────────────────────
          const AuthOrDivider(),

          SizedBox(height: 24.h),

          // ── Social buttons ───────────────────────────
          _buildSocialButtons(context),

          SizedBox(height: 24.h),

          // ── Guest mode ───────────────────────────────
          Center(child: GuestModeButton(onTap: onGuestMode)),

          SizedBox(height: 16.h),

          // ── Sign in link ─────────────────────────────
          AuthFooterLink(
            questionText: context.l10n.alreadyHaveAccount,
            actionText: context.l10n.signInAction,
            onTap: onSignIn,
          ),

          SizedBox(height: 40.h),

          // ── Terms and privacy ────────────────────────
          const TermsAndPrivacyText(),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      context.l10n.welcomeSignUp,
      textAlign: TextAlign.center,
      style: AppText.ibmHeading22(color: AppColors.dark),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      context.l10n.signUpSubtitle,
      textAlign: TextAlign.center,
      style: AppText.ibmDescription14(color: AppColors.secondaryText),
    );
  }

  Widget _buildSocialButtons(BuildContext context) {
    return Column(
      children: [
        AuthSocialButton(
          iconPath: AppAssets.iconGoogle,
          text: context.l10n.signUpWithGoogle,
          onTap: onGoogleSignUp,
        ),
        SizedBox(height: 12.h),
        AuthSocialButton(
          iconPath: AppAssets.iconApple,
          text: context.l10n.signUpWithApple,
          onTap: onAppleSignUp,
        ),
      ],
    );
  }
}
