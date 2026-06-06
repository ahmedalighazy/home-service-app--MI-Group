import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/text/app_text.dart';

class CompleteRegistrationLink extends StatelessWidget {
  final VoidCallback onTap;

  const CompleteRegistrationLink({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          'المتابعة كضيف',
          textAlign: TextAlign.center,
          style: AppText.ibmLink13(color: AppColors.greenPrimary).copyWith(
            decoration: TextDecoration.underline,
            decorationColor: AppColors.greenPrimary,
          ),
        ),
      ),
    );
  }
}
