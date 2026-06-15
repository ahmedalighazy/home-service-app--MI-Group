import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';


class RememberMeCheckbox extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberChanged;
  final VoidCallback onForgotTap;

  const RememberMeCheckbox({
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
        Row(
          children: [
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
            SizedBox(width: 8.w),
            Text(
              context.tr('rememberMe'),
              style: AppText.ibmDescription14(color: AppColors.dark),
            ),
          ],
        ),

        GestureDetector(
          onTap: onForgotTap,
          child: Text(
            context.tr('forgotPassword'),
            style: AppText.ibmLink13(color: AppColors.greenPrimary),
          ),
        ),
      ],
    );
  }
}
