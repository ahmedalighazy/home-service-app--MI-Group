import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

void showPasswordSuccessDialog(BuildContext context, VoidCallback onLogin) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      final isArabic =
          Localizations.localeOf(context).languageCode == 'ar';
      return Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.greenPrimary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle_outline,
                    color: AppColors.greenPrimary,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  AuthStrings.successPasswordReset,
                  style: AppText.ibmHeading18(color: AppColors.dark),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  AuthStrings.loginWithNewPassword,
                  textAlign: TextAlign.center,
                  style: AppText.ibmDescription12(color: AppColors.secondaryText),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      onLogin();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dark,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      AuthStrings.login,
                      style: AppText.ibmButton16(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
