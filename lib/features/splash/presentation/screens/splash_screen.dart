import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/image/app_assets.dart';
import '../../../../core/themes/image/app_logo.dart';
import '../../../../core/utils/helpers/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
        
        if (onBoarding != null && onBoarding == true) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.greenPrimary,
              AppColors.white,
            ],
            stops: [0.0, 0.9],
          ),
        ),
        child: Stack(
          children: [
            // Topographic contour background
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 0.5.sh,
              child: Opacity(
                opacity: 0.25,
                child: Image.asset(
                  AppAssets.topographicBg,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Centered Logo with fade-in animation
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: const AppLogo(
                  size: 150,
                  showText: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
