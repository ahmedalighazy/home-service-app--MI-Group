import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/features/home/presentation/widgets/location_block.dart';
import 'package:home_service_app/features/home/presentation/widgets/notification_bell.dart';
import 'package:home_service_app/features/home/presentation/widgets/user_avatar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.locationLabel,
    required this.locationAddress,
    this.avatarImageUrl,
    this.avatarPlaceholder,
    this.notificationCount = 0,
    this.onNotificationTap,
    this.onAvatarTap,
    this.onLocationTap,
  });
  final String locationLabel;
  final String locationAddress;

  final String? avatarImageUrl;

  final String? avatarPlaceholder;

  final int notificationCount;

  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onLocationTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            UserAvatar(
              imageUrl: avatarImageUrl,
              assetPath: avatarPlaceholder,
              onTap: onAvatarTap,
            ),

            Expanded(
              child: LocationBlock(
                label: locationLabel,
                address: locationAddress,
                onTap: onLocationTap,
              ),
            ),

            NotificationBell(
              count: notificationCount,
              onTap: onNotificationTap,
            ),
          ],
        ),
      ),
    );
  }
}
