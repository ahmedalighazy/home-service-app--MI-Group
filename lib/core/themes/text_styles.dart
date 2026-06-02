import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class AppTextStyles {
  // Headings
  static TextStyle heading1 = GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  static TextStyle heading2 = GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  static TextStyle heading3 = GoogleFonts.cairo(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  // Body Text
  static TextStyle bodyLarge = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static TextStyle bodyMedium = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
  );

  static TextStyle bodySmall = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
  );

  // Special Styles
  static TextStyle priceText = GoogleFonts.cairo(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static TextStyle categoryLabel = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryText,
  );

  static TextStyle searchHint = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.placeholder,
  );

  static TextStyle locationText = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static TextStyle locationSubText = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
  );

  static TextStyle buttonText = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle badgeText = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle promoCodeText = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}
