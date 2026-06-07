import 'package:flutter/material.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';

class DialogFilledButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool hasShadow;

  const DialogFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.hasShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: hasShadow ? 8 : 0,
          shadowColor: AppColors.primary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(label, style: AppText.semiBold14White),
        ),
      ),
    );
  }
}

