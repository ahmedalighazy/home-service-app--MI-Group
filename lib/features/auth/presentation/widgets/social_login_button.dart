import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 56.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderInputs),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: AppColors.primaryText,
            ),
            SizedBox(width: 12.w),
            Text(
              text,
              style: AppText.ibmButton16(color: AppColors.primaryText),
            ),
          ],
        ),
      ),
    );
  }
}
