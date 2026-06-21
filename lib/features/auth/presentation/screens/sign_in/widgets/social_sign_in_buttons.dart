import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/themes/image/app_assets.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_social_button.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class SocialSignInButtons extends StatelessWidget {
  final VoidCallback onGoogleSignIn;
  final VoidCallback onAppleSignIn;

  const SocialSignInButtons({
    Key? key,
    required this.onGoogleSignIn,
    required this.onAppleSignIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthSocialButton(
          iconPath: AppAssets.iconGoogle,
          text: context.tr('signInWithGoogle'),
          onTap: onGoogleSignIn,
        ),
        SizedBox(height: 12.h),
        AuthSocialButton(
          iconPath: AppAssets.iconApple,
          text: context.tr('signInWithApple'),
          onTap: onAppleSignIn,
        ),
      ],
    );
  }
}