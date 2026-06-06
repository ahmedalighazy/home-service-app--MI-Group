import 'package:flutter/material.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class PasswordTextField extends StatefulWidget {
  final String label;
  final String hintText;

  const PasswordTextField({
    super.key,
    required this.label,
    required this.hintText,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: widget.label,
      hintText: widget.hintText,
      obscureText: _obscureText,
      borderColor: AppColors.placeholder,
      textStyle: AppText.regularIbm(
        color: AppColors.placeholder,
        fontSize: 15,
      ),
      onTogglePasswordVisibility: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }
}