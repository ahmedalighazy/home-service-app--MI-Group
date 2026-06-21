import 'package:flutter/material.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';

class FooterLink extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onTap;

  const FooterLink({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          questionText,
          style: AppText.ibmDescription14(color: AppColors.dark),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: AppText.ibmLink13(color: AppColors.greenPrimary),
          ),
        ),
      ],
    );
  }
}
