import 'package:flutter/material.dart';

import '../../../../core/themes/colors/app_colors.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            Navigator.pop(context);
          },
      child: Padding(
        padding: const EdgeInsets.only(right: 3),
        child: Container(
          width: 44,
          height: 44,

          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: AppColors.borderInputs),
              borderRadius: BorderRadius.circular(44),
            ),
          ),
          child: const Icon(Icons.arrow_back, size: 30, color: AppColors.black),
        ),
      ),
    );
  }
}
