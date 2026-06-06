import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themes/colors/app_colors.dart';
import 'language_toggle.dart';

class ScreenWithLanguageToggle extends StatelessWidget {
  final Widget child;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final String? title;

  const ScreenWithLanguageToggle({
    super.key,
    required this.child,
    this.showBackButton = true,
    this.onBackPressed,
    this.backgroundColor,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.white,
      appBar: AppBar(
        backgroundColor: backgroundColor ?? AppColors.white,
        elevation: 0,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.dark,
                ),
                onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
              )
            : null,
        title: title != null
            ? Text(
                title!,
                style: TextStyle(
                  color: AppColors.dark,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              )
            : null,
        centerTitle: true,
        actions: [
          // Language Toggle in top right
          Padding(
            padding: EdgeInsets.only(right: 16.w, top: 8.h),
            child: const LanguageToggle(),
          ),
        ],
      ),
      body: child,
    );
  }
}
