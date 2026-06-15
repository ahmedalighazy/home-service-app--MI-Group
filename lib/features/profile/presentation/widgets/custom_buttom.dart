import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isOutlined;
  final double? flex;
  final bool? porderRed;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.isOutlined = false,
    this.porderRed,
    this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: GestureDetector(
        onTap: onPressed,

        child: Container(
          decoration: ShapeDecoration(
            color: isOutlined ? AppColors.white : backgroundColor,

            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: !isOutlined ? AppColors.borderGrey : AppColors.redBorder,
              ),
              borderRadius: BorderRadius.circular(33),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: AppText.semiBoldIbm(color: textColor, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
