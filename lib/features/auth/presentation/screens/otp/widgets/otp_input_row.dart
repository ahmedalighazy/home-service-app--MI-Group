import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/themes/colors/app_colors.dart';

enum OtpFieldState { idle, error, success }


class OtpInputRow extends StatelessWidget {
  final String digits;
  final int length;
  final OtpFieldState fieldState;
  final Animation<double> shakeAnimation;
  final VoidCallback onTap;

  const OtpInputRow({
    super.key,
    required this.digits,
    required this.length,
    required this.fieldState,
    required this.shakeAnimation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            fieldState == OtpFieldState.error ? shakeAnimation.value : 0.0,
            0.0,
          ),
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

            switch (fieldState) {
              case OtpFieldState.error:
                if (hasDigit) {
                  borderColor = AppColors.errorRed;
                  fillColor = AppColors.bgError;
                  textColor = AppColors.errorRed;
                } else {
                  borderColor = AppColors.borderInputs;
                  fillColor = AppColors.white;
                  textColor = AppColors.primaryText;
                }
                break;
              case OtpFieldState.success:
                if (hasDigit) {
                  borderColor = AppColors.greenPrimary;
                  fillColor = AppColors.light;
                  textColor = AppColors.greenPrimary;
                } else {
                  borderColor = AppColors.borderInputs;
                  fillColor = AppColors.white;
                  textColor = AppColors.primaryText;
                }
                break;
              case OtpFieldState.idle:
                if (hasDigit || isCurrent) {
                  borderColor = AppColors.greenPrimary;
                  fillColor = AppColors.white;
                  textColor = AppColors.primaryText;
                } else {
                  borderColor = AppColors.borderInputs;
                  fillColor = AppColors.white;
                  textColor = AppColors.primaryText;
                }
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
                          color:
                              (fieldState == OtpFieldState.error
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
                    ? const OtpBlinkingCursor()
                    : null,
              ),
            );
          }),
        ),
      ),
    );
  }
}

class OtpBlinkingCursor extends StatefulWidget {
  const OtpBlinkingCursor({super.key});

  @override
  State<OtpBlinkingCursor> createState() => _OtpBlinkingCursorState();
}

class _OtpBlinkingCursorState extends State<OtpBlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _ctrl,
      child: Container(
        width: 1.5.w,
        height: 18.h,
        color: AppColors.greenPrimary,
      ),
    );
  }
}
