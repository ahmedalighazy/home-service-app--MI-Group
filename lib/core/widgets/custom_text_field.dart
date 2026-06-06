import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors/app_colors.dart';
import '../themes/text/app_text.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? initialValue;
  final String hintText;
  final bool isReadOnly;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Widget? icon;
  final Color? borderColor;
  final TextEditingController? controller;
  final bool centerText;
  final TextStyle? textStyle;
  final bool obscureText;
  final VoidCallback? onTogglePasswordVisibility;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    this.label,
    this.initialValue,
    required this.hintText,
    this.isReadOnly = false,
    this.suffixIcon,
    this.fillColor,
    this.textStyle,
    this.icon,
    this.borderColor,
    this.controller,
    this.centerText = false,
    this.obscureText = false,
    this.onTogglePasswordVisibility,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppText.mediumIbm(
              color: AppColors.textDarkGrey,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 6.h),
        ],
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          readOnly: isReadOnly,
          textAlign: centerText ? TextAlign.center : TextAlign.start,
          style: AppText.regularIbm(color: AppColors.primaryText, fontSize: 14),
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                textStyle ??
                AppText.regularIbm(color: AppColors.borderInputs, fontSize: 14),
            fillColor: fillColor ?? AppColors.white,
            filled: true,
            suffixIcon: onTogglePasswordVisibility != null
                ? IconButton(
                    onPressed: onTogglePasswordVisibility,
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  )
                : suffixIcon,
            prefixIcon: icon,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: borderSide(),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: borderSide(),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.tealPrimary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.errorRed, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.errorRed,
                width: 1.5,
              ),
            ),
            errorStyle: AppText.ibmError12(),
          ),
        ),
      ],
    );
  }

  BorderSide borderSide() {
    if (borderColor != null) return BorderSide(color: borderColor!);
    return BorderSide.none;
  }
}
