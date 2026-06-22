import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class SuccessIcon extends StatelessWidget {
  const SuccessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 90.w,
      decoration: const BoxDecoration(
        color: Color(0xFFEAFAF1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_circle_outline_rounded,
        color: const Color(0xFF1A924E),
        size: 50.sp,
      ),
    );
  }
}

class SuccessTextSection extends StatelessWidget {
  const SuccessTextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            context.tr('successPasswordReset'),
            textAlign: TextAlign.center,
            style: AppText.ibmHeading22(color: AppColors.dark),
          ),
        ),
        verticalSpace(8),
        Text(
          context.tr('loginWithNewPassword'),
          textAlign: TextAlign.center,
          style: AppText.ibmDescription14(color: AppColors.secondaryText),
        ),
      ],
    );
  }
}

class SuccessGradientButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SuccessGradientButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF189CB7),
            Color(0xFF033C48),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF033C48).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparentColor,
          shadowColor: AppColors.transparentColor,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        child: Text(
          context.tr('signIn'),
          style: AppText.ibmButton16(color: AppColors.white),
        ),
      ),
    );
  }
}