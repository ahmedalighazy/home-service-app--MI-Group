import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import '../../../widgets/auth_footer_link.dart';
import '../../../widgets/auth_or_divider.dart';
import '../../../widgets/auth_primary_button.dart';
import '../../../widgets/auth_social_button.dart';
import '../../../widgets/terms_and_privacy_text.dart';
import 'guest_mode_button.dart';
import 'phone_input_field.dart';

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
          verticalSpace(20.h),

          Text(
            AppStrings.welcomeSignUp,
            textAlign: TextAlign.center,
            style: AppText.ibmHeading22(color: AppColors.dark),
          ),
          verticalSpace(8.h),
          Text(
            AppStrings.signUpSubtitle,
            textAlign: TextAlign.center,
            style: AppText.ibmDescription14(color: AppColors.secondaryText),
          ),
          verticalSpace(32.h),

          PhoneInputField(
            controller: phoneController,
            hasError: hasError,
            errorMessage: errorMessage,
            onChanged: onPhoneChanged,
          ),
          verticalSpace(24.h),

          AuthPrimaryButton(
            label: AppStrings.sendCode,
            isLoading: isLoading,
            isEnabled: phoneController.text.isNotEmpty,
            onPressed: onSendCode,
          ),
          verticalSpace(32.h),
          const AuthOrDivider(),
          verticalSpace(24.h),

          AuthSocialButton(
            iconPath: AppAssets.iconGoogle,
            text: AppStrings.signUpWithGoogle,
            onTap: onGoogleSignUp,
          ),
          verticalSpace(12.h),
          AuthSocialButton(
            iconPath: AppAssets.iconApple,
            text: AppStrings.signUpWithApple,
            onTap: onAppleSignUp,
          ),
          verticalSpace(24.h),
          Center(child: GuestModeButton(onTap: onGuestMode)),
          verticalSpace(16.h),
          AuthFooterLink(
            questionText: AppStrings.alreadyHaveAccount,
            actionText: AppStrings.signInAction,
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
