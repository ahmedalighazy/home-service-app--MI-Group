import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/presentation/widgets/common/blinking_cursor.dart';

class OtpCirclesRow extends StatelessWidget {
  final String digits;
  final int length;
  final bool hasError;
  final bool isSuccess;
  final Animation<double> shakeAnimation;
  final VoidCallback onTap;

  const OtpCirclesRow({
    super.key,
    required this.digits,
    required this.length,
    required this.hasError,
    required this.isSuccess,
    required this.shakeAnimation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(hasError ? shakeAnimation.value : 0.0, 0.0),
          child: child,
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(length, (i) {
            final hasDigit = i < digits.length;
            final isCurrent = i == digits.length;

            Color borderColor;
            Color fillColor;
            Color textColor;

            if (hasError && hasDigit) {
              borderColor = AppColors.errorRed;
              fillColor = AppColors.bgError;
              textColor = AppColors.errorRed;
            } else if (isSuccess && hasDigit) {
              borderColor = AppColors.greenPrimary;
              fillColor = AppColors.light;
              textColor = AppColors.greenPrimary;
            } else if (hasDigit || isCurrent) {
              borderColor = AppColors.greenPrimary;
              fillColor = AppColors.white;
              textColor = AppColors.primaryText;
            } else {
              borderColor = AppColors.borderInputs;
              fillColor = AppColors.white;
              textColor = AppColors.primaryText;
            }

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: fillColor,
                border: Border.all(color: borderColor, width: 1.5),
                boxShadow: (hasDigit || isCurrent)
                    ? [
                        BoxShadow(
                          color: (hasError
                                  ? AppColors.errorRed
                                  : AppColors.greenPrimary)
                              .withValues(alpha: 0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: hasDigit
                    ? Text(
                        digits[i],
                        style: GoogleFonts.ibmPlexSansArabic(
                          color: textColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : isCurrent
                        ? const BlinkingCursor()
                        : null,
              ),
            );
          }),
        ),
      ),
    );
  }
}
