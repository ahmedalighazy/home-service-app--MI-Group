import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/text/app_text.dart';
import '../../../../../features/language/l10n/app_strings.dart';

class SocialSignUpButtons extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;

  const SocialSignUpButtons({
    super.key,
    required this.onGoogleTap,
    required this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSocialButton(
          icon: Icons.g_mobiledata_rounded,
          label: AppStrings.signUpWithGoogle,
          onTap: onGoogleTap,
          iconColor: const Color(0xFF4285F4),
        ),
        SizedBox(height: 12.h),
        _buildSocialButton(
          icon: Icons.apple_rounded,
          label: AppStrings.signUpWithApple,
          onTap: onAppleTap,
          iconColor: AppColors.dark,
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.borderInputs,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: iconColor,
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: AppText.ibmDescription14(color: AppColors.dark),
            ),
          ],
        ),
      ),
    );
  }
}
