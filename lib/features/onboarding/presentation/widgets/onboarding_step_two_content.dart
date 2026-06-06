// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/image/app_assets.dart';
import '../../../../core/utils/l10n/app_strings.dart';

class OnboardingStepTwoContent extends StatelessWidget {
  final VoidCallback onStart;

  const OnboardingStepTwoContent({
    super.key,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.greenPrimary, AppColors.white],
          stops: [0.0, 0.7],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0, left: 0, right: 0, height: 0.6.sh,
            child: Opacity(
              opacity: 0.12,
              child: Image.asset(AppAssets.qatarMap, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 0.15.sh, left: 0, right: 0, bottom: 0.36.sh,
            child: Image.asset(AppAssets.technicianGuy, fit: BoxFit.contain),
          ),
          Positioned(
            bottom: 0, left: 0, right: 0, height: 0.45.sh,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white.withAlpha(0),
                    AppColors.white.withAlpha(230),
                    AppColors.white,
                  ],
                  stops: const [0.0, 0.25, 0.5],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0, left: 24.w, right: 24.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppStrings.onboardingStep2Title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: AppColors.dark, fontSize: 22.sp, fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    AppStrings.onboardingStep2Description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ibmPlexSansArabic(
                      color: AppColors.secondaryText, fontSize: 14.sp, height: 1.5, fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 6.w, height: 6.h,
                      decoration: BoxDecoration(color: AppColors.lightGray, borderRadius: BorderRadius.circular(3.r)),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      width: 18.w, height: 6.h,
                      decoration: BoxDecoration(color: AppColors.greenPrimary, borderRadius: BorderRadius.circular(3.r)),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    gradient: const LinearGradient(colors: [AppColors.greenPrimary, AppColors.dark]),
                  ),
                  child: ElevatedButton(
                    onPressed: onStart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                    ),
                    child: Text(
                      AppStrings.onboardingGetStarted,
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: AppColors.white, fontSize: 18.sp, fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
