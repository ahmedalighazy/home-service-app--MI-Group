import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/image/app_assets.dart';
import '../../../../core/utils/helpers/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation that fades the logo in over 2 seconds
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // Keep splash visible for 8 seconds before navigating
    Timer(const Duration(seconds: 8), _navigateFromSplash);

    // Debug: print animation values
    _controller.addListener(() {
      debugPrint('Splash animation value: ${_controller.value}');
    });
  }

  void _navigateFromSplash() async {
    if (!mounted) return;

    final bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
    final route = (onBoarding != null && onBoarding)
        ? AppRouter.signIn
        : AppRouter.onboarding;

    // Use GoRouter navigation
    context.go(route);
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
            colors: [AppColors.greenPrimary, AppColors.white],
            stops: [0.0, 0.9],
          ),
        ),
        child: Stack(
          children: [
            // Optional decorative background image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 0.5.sh,
              child: Opacity(
                opacity: 0.25,
                child: Image.asset(AppAssets.topographicBg, fit: BoxFit.cover),
              ),
            ),
            // Centered logo that fades in
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Image.asset(
                  AppAssets.logo,
                  width: 150.w,
                  height: 150.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
