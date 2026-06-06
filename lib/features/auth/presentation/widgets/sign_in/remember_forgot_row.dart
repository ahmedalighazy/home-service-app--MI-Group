import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/language/l10n/app_strings.dart';

class RememberForgotRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberChanged;
  final VoidCallback onForgotTap;

  const RememberForgotRow({
    super.key,
    required this.rememberMe,
    required this.onRememberChanged,
    required this.onForgotTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onForgotTap,
          child: Text(
            AppStrings.forgotPassword,
            style: AppText.ibmLink13(color: AppColors.greenPrimary).copyWith(
              decoration: TextDecoration.underline,
              decorationColor: AppColors.greenPrimary,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              AppStrings.rememberMe,
              style: AppText.ibmDescription14(color: AppColors.dark),
            ),
            SizedBox(width: 8.w),
            SizedBox(
              width: 20.w,
              height: 20.w,
              child: Checkbox(
                value: rememberMe,
                activeColor: AppColors.greenPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                onChanged: onRememberChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
