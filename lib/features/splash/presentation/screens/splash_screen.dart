import 'dart:async';
import 'package:flutter/material.dart';
import 'splash_logic.dart';
import 'widgets/splash_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin, SplashLogic {
  @override
  void initState() {
    super.initState();
    initSplashAnimation(this);
    Timer(const Duration(seconds: 3), navigateFromSplash);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashBackground(
        child: SplashLogo(fadeAnimation: splashFadeAnim),
      ),
    );
  }
}