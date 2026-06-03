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

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.isOutlined = false,
    this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: Container(
      decoration:isOutlined?   ShapeDecoration(
    shape: RoundedRectangleBorder(
      side: const BorderSide(
        width: 1,
        color: AppColors.redBorder,
      ),
      borderRadius: BorderRadius.circular(44),
    ),
  ):null,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: isOutlined ? AppColors.transparentColor : backgroundColor,
            // side: isOutlined ? BorderSide(color: backgroundColor, width: 5,) : BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular( flex != null ? flex??0 : 18.r),
            ),
          ),
          child: Text(
            text,
            style: AppText.semiBoldIbm(color: textColor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}