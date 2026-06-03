import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

/// A reusable social login button (Google, Apple, etc.) for auth screens.
///
/// Usage example:
/// ```dart
/// AuthSocialButton(
///   iconPath: AppAssets.iconGoogle,
///   label: AppStrings.signUpWithGoogle,
///   onPressed: () => _signInWithGoogle(),
/// )
/// ```
class AuthSocialButton extends StatefulWidget {
  final String iconPath;
  final String label;
  final VoidCallback onPressed;

  const AuthSocialButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onPressed,
  });

  @override
  State<AuthSocialButton> createState() => _AuthSocialButtonState();
}

class _AuthSocialButtonState extends State<AuthSocialButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        height: 54.h,
        decoration: BoxDecoration(
          color: _pressed ? const Color(0xFFF8FAFC) : AppColors.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: AppColors.borderInputs),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.iconPath, width: 24.w, height: 24.w),
            SizedBox(width: 10.w),
            Text(
              widget.label,
              style: AppText.ibmFieldLabel14(color: AppColors.primaryText),
            ),
          ],
        ),
      ),
    );
  }
}
