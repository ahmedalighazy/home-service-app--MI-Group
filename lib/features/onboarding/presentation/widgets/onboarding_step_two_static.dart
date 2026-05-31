// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/image/app_assets.dart';

class OnboardingStepTwoStatic extends StatelessWidget {
  final VoidCallback onStart;

  const OnboardingStepTwoStatic({
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
          colors: [
            AppColors.greenPrimary,
            AppColors.white,
          ],
          stops: [0.0, 0.7],
        ),
      ),
      child: Stack(
        children: [
          // Qatar map background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 0.6.sh,
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                AppAssets.qatarMap,
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // White fade at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 0.3.sh,
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
                ),
              ),
            ),
          ),

          // Bottom "Start Now" Button
          Positioned(
            bottom: 40.h,
            left: 24.w,
            right: 24.w,
            child: Container(
              width: double.infinity,
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
                onPressed: onStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Text(
                  'ابدأ الآن  >>>',
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: AppColors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
