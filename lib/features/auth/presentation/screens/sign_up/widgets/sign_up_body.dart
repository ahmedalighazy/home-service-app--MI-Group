import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/features/auth/presentation/screens/sign_up/widgets/guest_mode_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_footer_link.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_or_divider.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_social_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:home_service_app/features/auth/presentation/widgets/terms_and_privacy_text.dart';

class SignUpBody extends StatelessWidget {
  final TextEditingController emailController;
  final bool hasError;
  final String? errorMessage;
  final bool isLoading;
  final VoidCallback onSendCode;
  final VoidCallback onGoogleSignUp;
  final VoidCallback onAppleSignUp;
  final VoidCallback onGuestMode;
  final VoidCallback onSignIn;
  final ValueChanged<String> onEmailChanged;

  const SignUpBody({
    super.key,
    required this.emailController,
    required this.hasError,
    required this.errorMessage,
    required this.isLoading,
    required this.onSendCode,
    required this.onGoogleSignUp,
    required this.onAppleSignUp,
    required this.onGuestMode,
    required this.onSignIn,
    required this.onEmailChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(20.h),
          Text(
            context.tr('welcomeSignUp'),
            textAlign: TextAlign.end,
            style: AppText.ibmHeading22(color: AppColors.dark),
          ),
          verticalSpace(32.h),
          AuthTextField(
            label: context.tr('emailLabel'),
            hint: context.tr('emailPlaceholder'),
            controller: emailController,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            hasError: hasError,
            errorMessage: errorMessage,
            onChanged: onEmailChanged,
          ),
          verticalSpace(24.h),
          AuthPrimaryButton(
            label: context.tr('sendCode'),
            isLoading: isLoading,
            isEnabled: emailController.text.isNotEmpty,
            onPressed: onSendCode,
          ),
          verticalSpace(12.h),
          Text(
            context.tr('verificationMethodInfo'),
            textAlign: TextAlign.center,
            style: AppText.ibmCaption11(color: AppColors.secondaryText),
          ),
          verticalSpace(24.h),
          const AuthOrDivider(),
          verticalSpace(24.h),
          AuthSocialButton(
            iconPath: AppAssets.iconGoogle,
            text: context.tr('signUpWithGoogle'),
            onTap: onGoogleSignUp,
          ),
          verticalSpace(12.h),
          AuthSocialButton(
            iconPath: AppAssets.iconApple,
            text: context.tr('signUpWithApple'),
            onTap: onAppleSignUp,
          ),
          verticalSpace(24.h),
          Center(child: GuestModeButton(onTap: onGuestMode)),
          verticalSpace(16.h),
          AuthFooterLink(
            questionText: context.tr('alreadyHaveAccount'),
            actionText: context.tr('login'),
            onTap: onSignIn,
          ),
          verticalSpace(40.h),
          const TermsAndPrivacyText(),
          verticalSpace(32.h),
        ],
      ),
    );
  }
}
