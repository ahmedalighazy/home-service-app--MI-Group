import 'package:flutter/material.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/text/app_text.dart';


class StepNextButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const StepNextButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.38,
        height: size.height * 0.058,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff0D7A8A), AppColors.primary],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: AppText.semiBold16Black.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

