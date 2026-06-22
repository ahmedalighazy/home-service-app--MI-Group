import 'package:flutter/material.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';

class StepTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final int maxLines;
  final int? maxLength;
  final TextEditingController? controller;

  const StepTextField({
    super.key,
    this.label,
    required this.hint,
    this.maxLines = 1,
    this.maxLength,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: AppText.semiBold14Black),
          SizedBox(height: size.height * 0.008),
        ],
        TextField(
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLength,
          textAlign: TextAlign.start,
          style: AppText.regular14Black,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppText.regular12Grey,
            filled: true,
            fillColor: AppColors.white,
            counterStyle: AppText.regular10Grey,
            contentPadding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.014,
            ),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(focused: true),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border({bool focused = false}) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: focused ? AppColors.primary : AppColors.border,
      width: focused ? 1.5 : 1,
    ),
  );
}
