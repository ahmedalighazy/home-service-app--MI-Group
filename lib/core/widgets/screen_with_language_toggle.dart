import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themes/colors/app_colors.dart';
import 'language_toggle.dart';
import '../themes/image/app_assets.dart';

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
        leading: null,
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
          if (showBackButton)
            IconButton(
              icon: Image.asset(
                AppAssets.iconBack,
                width: 24.w,
                height: 24.w,
              ),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            ),
          const LanguageToggle(),
        ],
      ),
      body: child,
    );
  }
}
