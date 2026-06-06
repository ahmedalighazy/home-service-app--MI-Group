import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class OtpConfirmButton extends StatelessWidget {
  final bool isLoading;
  final bool isEnabled;
  final bool isSuccess;
  final VoidCallback? onPressed;

  const OtpConfirmButton({
    super.key,
    required this.isLoading,
    required this.isEnabled,
    this.isSuccess = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final active = isEnabled && !isLoading;

    return GestureDetector(
      onTap: active ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.r),
          color: active ? null : const Color(0xFFDCE4EA),
          gradient: active
              ? const LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [Color(0xFF0A434E), Color(0xFF189AB4)],
                )
              : null,
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                width: 22.w,
                height: 22.w,
                child: const CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.5,
                ),
              )
            : isSuccess
                ? Icon(Icons.check_rounded, color: AppColors.white, size: 24.sp)
                : Text(
                    AppStrings.confirm,
                    style: AppText.ibmButton16(
                      color: active
                          ? AppColors.white
                          : AppColors.white.withValues(alpha: 0.7),
                    ),
                  ),
      ),
    );
  }
}
