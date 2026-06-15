import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class GradientHeader extends StatelessWidget {
  const GradientHeader({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.greenPrimary, AppColors.white],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSizes.radiusXLarge),
          bottomRight: Radius.circular(AppSizes.radiusXLarge),
        ),
      ),
      child: child,
    );
  }
}
