import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/language/l10n/app_strings.dart';

class SocialSignInButtons extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;

  const SocialSignInButtons({
    super.key,
    required this.onGoogleTap,
    required this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButton(
          label: AppStrings.signUpWithGoogle,
          iconPath: AppAssets.iconGoogle,
          onTap: onGoogleTap,
        ),
        SizedBox(height: 12.h),
        _buildButton(
          label: AppStrings.signUpWithApple,
          iconPath: AppAssets.iconApple,
          onTap: onAppleTap,
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.borderInputs),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26.r),
          ),
          backgroundColor: AppColors.white,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppText.ibmDescription14(color: AppColors.primaryText)
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 10.w),
            Image.asset(iconPath, width: 20.w, height: 20.w),
          ],
        ),
      ),
    );
  }
}
