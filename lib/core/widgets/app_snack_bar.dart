import 'package:flutter/material.dart';

import '../themes/colors/app_colors.dart';
import '../themes/text/app_text.dart';

class AppSnackBar {
  AppSnackBar._();

  static void success(BuildContext context, String message) {
    _show(context, message, AppColors.greenPrimary, Icons.check_circle);
  }

  static void error(BuildContext context, String message) {
    _show(context, message, AppColors.errorRed, Icons.error);
  }

  static void warning(BuildContext context, String message) {
    _show(context, message, Colors.orange, Icons.warning);
  }

  static void info(BuildContext context, String message) {
    _show(context, message, AppColors.primary, Icons.info);
  }

  static void _show(
    BuildContext context,
    String message,
    Color color,
    IconData icon,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          content: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: AppText.ibmDescription14(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
