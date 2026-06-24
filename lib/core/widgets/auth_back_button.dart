import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';

class AuthBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const AuthBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderInputs),
          color: AppColors.white,
        ),
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..scaleByDouble(isRtl ? -1.0 : 1.0, 1.0, 1.0, 1.0),
          child: Image.asset(
            AppAssets.iconBack,
            width: 15.sp,
            height: 15.sp,
            color: AppColors.primaryText,
            errorBuilder: (_, _, _) => Icon(
              Icons.arrow_back_rounded,
              color: AppColors.primaryText,
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
