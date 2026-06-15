import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';


class GuestModeButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const GuestModeButton({
    super.key,
    required this.onTap,
    this.text = 'المتابعة كضيف',
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: AppText.ibmLink13(color: AppColors.greenPrimary).copyWith(
          decoration: TextDecoration.underline,
          decorationColor: AppColors.greenPrimary,
        ),
      ),
    );
  }
}
