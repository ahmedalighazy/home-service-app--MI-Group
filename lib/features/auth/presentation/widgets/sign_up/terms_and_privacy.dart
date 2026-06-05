import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/text/app_text.dart';

class TermsAndPrivacy extends StatelessWidget {
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  const TermsAndPrivacy({
    super.key,
    this.onTermsTap,
    this.onPrivacyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppText.ibmCaption11(color: AppColors.secondaryText),
          children: [
            const TextSpan(
              text: 'تسجيل الدخول أنت توافق على ',
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: onTermsTap,
                child: Text(
                  'الشروط والأحكام',
                  style: AppText.ibmLink13(color: AppColors.greenPrimary),
                ),
              ),
            ),
            const TextSpan(text: ' و '),
            WidgetSpan(
              child: GestureDetector(
                onTap: onPrivacyTap,
                child: Text(
                  'سياسة الخصوصية',
                  style: AppText.ibmLink13(color: AppColors.greenPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
