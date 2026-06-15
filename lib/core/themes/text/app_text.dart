import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors/app_colors.dart';

class AppText {

  static TextStyle regularText({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle mediumText({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle semiBoldText({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle boldText({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle regularTextRoboto({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.roboto(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle boldTextRoboto({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.roboto(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle regularIbm({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle mediumIbm({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle semiBoldIbm({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle boldIbm({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle ibmHeading22({
    Color color = AppColors.dark,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle ibmDescription14({
    Color color = AppColors.secondaryText,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

  static TextStyle ibmFieldLabel14({
    Color color = AppColors.dark,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle ibmPlaceholder14({
    Color color = AppColors.placeholder,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle ibmButton16({
    Color color = AppColors.white,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle ibmLink13({
    Color color = AppColors.greenPrimary,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 13.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle ibmCaption11({
    Color color = AppColors.gray,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle ibmError12({
    Color color = AppColors.errorRed,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle ibmHeading18({
    Color color = AppColors.dark,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle ibmHeading20({
    Color color = AppColors.dark,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle ibmHeading16({
    Color color = AppColors.dark,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle ibmHeading14({
    Color color = AppColors.dark,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle ibmDescription12({
    Color color = AppColors.secondaryText,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      height: 1.4,
    );
  }

  static TextStyle get ibmPlexSansArabic16SemiBold => GoogleFonts.ibmPlexSansArabic(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get ibmPlexSansArabic12SemiBold => GoogleFonts.ibmPlexSansArabic(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get semiBold16Black => GoogleFonts.ibmPlexSansArabic(
    color: AppColors.dark,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get semiBold14Black => GoogleFonts.ibmPlexSansArabic(
    color: AppColors.dark,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get regular12Grey => GoogleFonts.ibmPlexSansArabic(
    color: AppColors.gray,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get semiBold14White => GoogleFonts.ibmPlexSansArabic(
    color: AppColors.white,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get bold14Black => GoogleFonts.ibmPlexSansArabic(
    color: AppColors.dark,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get semiBold18Black => GoogleFonts.ibmPlexSansArabic(
    color: AppColors.dark,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get semiBold12Black => GoogleFonts.ibmPlexSansArabic(
    color: AppColors.dark,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get regular14Black => GoogleFonts.ibmPlexSansArabic(
    color: AppColors.dark,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get regular10Grey => GoogleFonts.ibmPlexSansArabic(
    color: AppColors.gray,
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get bold12Black => GoogleFonts.ibmPlexSansArabic(
    color: AppColors.dark,
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get semiBold20Black => GoogleFonts.ibmPlexSansArabic(
    color: AppColors.dark,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get bold10Black => GoogleFonts.ibmPlexSansArabic(
    color: AppColors.dark,
    fontSize: 10.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get bold16Cyan => GoogleFonts.ibmPlexSansArabic(
    color: AppColors.greenPrimary,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle ibmFieldLabel12({
    Color color = AppColors.dark,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );
  }
}
