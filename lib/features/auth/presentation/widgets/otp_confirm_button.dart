import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// A reusable OTP confirm button with loading and success states.
///
/// Usage:
/// ```dart
/// OtpConfirmButton(
///   label: 'تأكيد',
///   isLoading: isLoading,
///   isSuccess: _isSuccess,
///   onPressed: () => _onVerify(context),
/// )
/// ```
class OtpConfirmButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final bool isSuccess;
  final bool isEnabled;
  final VoidCallback onPressed;

  const OtpConfirmButton({
    super.key,
    required this.label,
    required this.isLoading,
    required this.isSuccess,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = isEnabled && !isLoading;

    return GestureDetector(
      onTap: active ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: active ? null : const Color(0xFFEDF2FA),
          gradient: active
              ? const LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [Color(0xFF0A434E), Color(0xFF189AB4)],
                )
              : null,
          boxShadow: active
              ? [
                  BoxShadow(
                    color: const Color(0xFF189AB4).withValues(alpha: 0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 22.w,
                  height: 22.w,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : isSuccess
                  ? Icon(Icons.check_rounded,
                      color: Colors.white, size: 24.sp)
                  : Text(
                      label,
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: active
                            ? Colors.white
                            : const Color(0xFFB0BEC5),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
        ),
      ),
    );
  }
}
