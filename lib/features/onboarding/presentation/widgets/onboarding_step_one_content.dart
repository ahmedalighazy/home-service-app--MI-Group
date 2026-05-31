// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/image/app_assets.dart';

class OnboardingStepOneContent extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingStepOneContent({
    super.key,
    required this.onNext,
    required this.onSkip,
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
          colors: [
            AppColors.greenPrimary,
            AppColors.white,
          ],
          stops: [0.0, 0.7],
        ),
      ),
      child: Stack(
        children: [
          // Topographic lines background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 0.6.sh,
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                AppAssets.topographicBg,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Cleaning guy image positioned nicely
          Positioned(
            top: 0.15.sh,
            left: 0,
            right: 0,
            bottom: 0.36.sh,
            child: Image.asset(
              AppAssets.cleaningGuy,
              fit: BoxFit.contain,
            ),
          ),
          
          // White fade at the bottom to ensure high text contrast
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 0.45.sh,
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

          // Content and Buttons
          Positioned(
            bottom: 0,
            left: 24.w,
            right: 24.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Text(
                  'معدات وخامات بمعايير احترافية',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: AppColors.dark,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                // Description/Subtitle
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'نعتمد على أحدث المعدات والخامات عالية الجودة لضمان نتائج تنظيف احترافية تدوم',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ibmPlexSansArabic(
                      color: AppColors.secondaryText,
                      fontSize: 14.sp,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                // Page Indicator (Dot 1 active)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 18.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: AppColors.greenPrimary,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      width: 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: AppColors.lightGray,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                // Bottom Buttons
                Row(
                  children: [
                    // Skip Button ("تخطي")
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onSkip,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.borderInputs),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          backgroundColor: AppColors.white,
                          elevation: 0,
                        ),
                        child: Text(
                          'تخطي',
                          style: GoogleFonts.ibmPlexSansArabic(
                            color: AppColors.secondaryText,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    // Next Button ("التالي")
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.greenPrimary,
                              AppColors.dark,
                            ],
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: onNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          child: Text(
                            'التالي',
                            style: GoogleFonts.ibmPlexSansArabic(
                              color: AppColors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
