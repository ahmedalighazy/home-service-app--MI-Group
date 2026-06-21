// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/language/language_cubit.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/image/app_assets.dart';

class OnboardingStepOneStatic extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingStepOneStatic({
    super.key,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

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
              opacity: 0.15,
              child: Image.asset(AppAssets.topographicBg, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 0, left: 0, right: 0, height: 0.4.sh,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white.withValues(alpha: 0.0),
                    AppColors.white.withValues(alpha: 0.9),
                    AppColors.white,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40.h, left: 24.w, right: 24.w,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onSkip,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.borderInputs),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                      backgroundColor: AppColors.white, elevation: 0,
                    ),
                    child: Text(
                      isArabic ? 'تخطي' : 'Skip',
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: AppColors.secondaryText, fontSize: 16.sp, fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      gradient: const LinearGradient(colors: [AppColors.greenPrimary, AppColors.dark]),
                    ),
                    child: ElevatedButton(
                      onPressed: onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                      ),
                      child: Text(
                        isArabic ? 'التالي' : 'Next',
                        style: GoogleFonts.ibmPlexSansArabic(
                          color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
