import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/home/presentation/sections/home_promo_banner_section.dart';

class CustomPageIndicator extends StatelessWidget {
  const CustomPageIndicator({
    super.key,
    required this.widget,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final HomePromoBannerSection widget;
  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.banners.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: AppSizes.paddinMinWidth),
          width: AppSizes.pageIndicatorWidth,
          height: AppSizes.spacingSmall,
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? AppColors.greenPrimary
                : AppColors.lightGray,
            borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
          ),
        ),
      ),
    );
  }
}
