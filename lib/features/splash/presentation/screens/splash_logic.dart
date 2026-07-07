import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/utils/helpers/cache_helper.dart';

mixin SplashLogic<T extends StatefulWidget> on State<T> {
  late final AnimationController splashAnimCtrl;
  late final Animation<double> splashFadeAnim;

  void initSplashAnimation(TickerProvider vsync) {
    splashAnimCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 2000),
    );
    splashFadeAnim = CurvedAnimation(
      parent: splashAnimCtrl,
      curve: Curves.easeIn,
    );
    splashAnimCtrl.forward();
  }

  void navigateFromSplash() async {
    // CacheHelper.clearData();

    if (!mounted) return;
    final bool? onBoarding = CacheHelper.getData('onBoarding');
    final String? email = await CacheHelper.getSecure('token');
    final bool loggedIn = email != null;
    log(onBoarding.toString());
    log(email.toString());
    log(loggedIn.toString());

    if (loggedIn) {
      if (!mounted) return;

      GoRouter.of(context).go(AppRouter.home);
    } else {
      final route = (onBoarding != null && onBoarding)
          ? AppRouter.signUp
          : AppRouter.onboarding;
      if (!mounted) return;

      GoRouter.of(context).go(route);
    }
  }

  @override
  void dispose() {
    splashAnimCtrl.dispose();
    super.dispose();
  }
}
