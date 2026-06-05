import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/themes/colors/app_colors.dart';

class OtpVerifyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isLoading;

  const OtpVerifyButton({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isEnabled
              ? [
                  AppColors.greenPrimary,
                  AppColors.greenPrimary.withValues(alpha: 0.8),
                ]
              : [
                  AppColors.gray.withValues(alpha: 0.3),
                  AppColors.gray.withValues(alpha: 0.3),
                ],
        ),
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: AppColors.greenPrimary.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.w,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'تأكيد',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
