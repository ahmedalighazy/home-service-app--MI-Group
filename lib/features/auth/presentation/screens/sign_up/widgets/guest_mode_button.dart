import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class GuestModeButton extends StatelessWidget {
  final VoidCallback onTap;

  const GuestModeButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        context.tr('continueAsGuest'),
        style: AppText.ibmLink13(color: AppColors.greenPrimary),
      ),
    );
  }
}
