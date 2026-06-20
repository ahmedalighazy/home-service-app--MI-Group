import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    this.currentIndex = 0,
    required this.onTap,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.radius),
          topRight: Radius.circular(AppSizes.radius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.padding,
        horizontal: AppSizes.paddingMedium,
      ),

      // icon bottom
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            iconPath: IconsPath.home,
            label: context.l10n.navHome,
            index: 0,
          ),
          _buildNavItem(
            iconPath: IconsPath.calendar,
            label: context.l10n.navBookings,
            index: 1,
          ),
          _buildNavItem(
            iconPath: IconsPath.profile,
            label: context.l10n.navAccount,
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String iconPath,
    required String label,
    required int index,
  }) {
    final isSelected = widget.currentIndex == index;

    final backgroundColor = isSelected
        ? AppColors.lightActive
        : Colors.transparent;

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 0),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
            vertical: AppSizes.paddingMedium,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
          ),
          child: isSelected
              ? ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.centerLeft,
                      colors: [AppColors.dark, AppColors.greenPrimary],
                    ).createShader(bounds);
                  },
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          iconPath,
                          width: AppSizes.iconSize,
                          height: AppSizes.iconSize,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: AppSizes.spacingSmall),
                        Text(
                          label,
                          style: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        iconPath,
                        width: AppSizes.iconSize,
                        height: AppSizes.iconSize,
                        colorFilter: const ColorFilter.mode(
                          AppColors.secondaryGrey,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: AppSizes.spacingSmall),
                      Text(
                        label,
                        style: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                          color: AppColors.bgDisabled,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
