import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

/// A reusable primary action button for auth screens.
/// Supports loading state and enabled/disabled states.
///
/// Usage example:
/// ```dart
/// AuthPrimaryButton(
///   label: AppStrings.login,
///   isLoading: isLoading,
///   onPressed: () => _login(context),
/// )
/// ```
class AuthPrimaryButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final bool isEnabled;
  final VoidCallback? onPressed;

  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
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
          gradient: active
              ? const LinearGradient(
                  colors: [Color(0xFF189AB4), Color(0xFF0A434E)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: active ? null : AppColors.bgDisabled,
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
                    color: AppColors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  label,
                  style: AppText.ibmButton16(
                    color: isEnabled ? AppColors.white : AppColors.disabledText,
                  ),
                ),
        ),
      ),
    );
  }
}
