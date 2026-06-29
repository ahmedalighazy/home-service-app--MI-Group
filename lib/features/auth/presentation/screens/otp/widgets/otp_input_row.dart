import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import 'otp_field_state.dart' show OtpFieldState;

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
        behavior: HitTestBehavior.opaque,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(length, (i) {
            final hasDigit = i < digits.length;
            final isCurrent =
                i == digits.length && fieldState == OtpFieldState.idle;

            // ── Colors per state ──────────────────────────────────────
            Color borderColor;
            Color fillColor;
            Color textColor;

            if (fieldState == OtpFieldState.error && hasDigit) {
              borderColor = AppColors.errorRed;
              fillColor = AppColors.errorRed.withValues(alpha: 0.08);
              textColor = AppColors.errorRed;
            } else if (fieldState == OtpFieldState.success && hasDigit) {
              borderColor = AppColors.greenPrimary;
              fillColor = AppColors.greenPrimary.withValues(alpha: 0.08);
              textColor = AppColors.greenPrimary;
            } else if (isCurrent) {
              borderColor = const Color(0xFF1B85A6);
              fillColor = Colors.white;
              textColor = AppColors.dark;
            } else if (hasDigit) {
              borderColor = const Color(0xFF1B85A6);
              fillColor = Colors.white;
              textColor = AppColors.dark;
            } else {
              borderColor = const Color(0xFFDDE3EC);
              fillColor = Colors.white;
              textColor = AppColors.dark;
            }

            return AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              width: 46.w,
              height: 46.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: fillColor,
                border: Border.all(
                  color: borderColor,
                  width: isCurrent || hasDigit ? 1.8 : 1.2,
                ),
                boxShadow: (isCurrent || hasDigit)
                    ? [
                        BoxShadow(
                          color: borderColor.withValues(alpha: 0.15),
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
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : isCurrent
                        ? const _BlinkingCursor()
                        : null,
              ),
            );
          }),
        ),
      ),
    ),
  );
  }
}

// ── Blinking cursor shown on the active (empty) cell ──────────────────────────
class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
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
        width: 2.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: const Color(0xFF1B85A6),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
