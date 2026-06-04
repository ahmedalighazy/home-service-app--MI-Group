import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class ForgetEmailField extends StatelessWidget {
  final TextEditingController controller;
  final bool hasError;
  final ValueChanged<String> onChanged;

  const ForgetEmailField({
    super.key,
    required this.controller,
    required this.hasError,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: hasError ? AppColors.errorRed : AppColors.borderInputs,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.greenPrimary.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        textDirection: TextDirection.ltr,
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
        onChanged: onChanged,
        style: GoogleFonts.ibmPlexSansArabic(
          color: AppColors.primaryText,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          hintText: AppStrings.emailPlaceholder,
          hintStyle: GoogleFonts.ibmPlexSansArabic(
            color: AppColors.placeholder,
            fontSize: 13.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          prefixIcon: Icon(
            Icons.email_outlined,
            color: AppColors.gray,
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}
