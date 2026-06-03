import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key, required this.count, this.onTap});

  final int count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSizes.notificationBellSize,
        height: AppSizes.notificationBellSize,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.85),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              IconsPath.notificationBell,
              width: AppSizes.iconSize,
              height: AppSizes.iconSize,
            ),
            if (count > 0)
              Positioned(
                top: 10,
                right: 10,
                child: SvgPicture.asset(
                  IconsPath.notificationDot,
                  colorFilter: const ColorFilter.mode(
                    AppColors.errorRed,
                    BlendMode.srcIn,
                  ),
                  width: AppSizes.spacingSmall,
                  height: AppSizes.spacingSmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
