import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';

class SplashLogo extends StatelessWidget {
  final Animation<double> fadeAnimation;

  const SplashLogo({super.key, required this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Image.asset(
          AppAssets.logo,
          width: 150.w,
          height: 150.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
