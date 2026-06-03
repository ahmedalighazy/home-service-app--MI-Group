import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable social login button (Google, Apple, etc.) for auth screens.
///
/// Usage:
/// ```dart
/// AuthSocialButton(
///   icon: Icons.g_mobiledata,
///   text: 'تسجيل عبر Google',
///   onTap: () => _handleGoogleLogin(),
/// )
/// ```
class AuthSocialButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const AuthSocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade200),
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28.sp, color: Colors.black87),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
