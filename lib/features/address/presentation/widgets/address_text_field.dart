import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class AddressTextField extends StatelessWidget {
  const AddressTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
  });

  final String hintText;
  final TextEditingController? controller;
  final int maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.padding,
          vertical: AppSizes.padding,
        ),

        enabledBorder: _buildBorder(AppColors.placeholder),

        focusedBorder: _buildBorder(AppColors.greenPrimary),

        border: _buildBorder(AppColors.placeholder),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.radius),
      borderSide: BorderSide(color: color),
    );
  }
}
