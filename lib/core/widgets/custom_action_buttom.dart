import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/text/app_text.dart';
import '../utils/helpers/spacing.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor = const Color(0xFFD2503C),
    this.textColor = const Color(0xFFF8FAFC),
    this.widths,
    this.height = 40,
  });

  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final double? widths;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: widths ?? width(context) / 3.4,
        height: height.h,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(44.r),
            side: const BorderSide(
              width: 1,
              color: Color(0xFFE5E7EB) /* border-inputs */,
            ),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppText.semiBoldText(
              fontSize: 16,
              color: textColor,
            ).copyWith(),
          ),
        ),
      ),
    );
  }
}
