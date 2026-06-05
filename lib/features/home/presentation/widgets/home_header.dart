import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/home/presentation/widgets/location_block.dart';
import 'package:home_service_app/features/home/presentation/widgets/notification_bell.dart';
import 'package:home_service_app/features/home/presentation/widgets/user_avatar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    this.locationLabel = AppStrings.currentLocation,
    this.locationAddress = '18، شارع الوعب، الدوحة',
    this.avatarImageUrl,
    this.avatarPlaceholder,
    this.notificationCount = 0,
    this.onNotificationTap,
    this.onAvatarTap,
    this.onLocationTap,
  });
  final String locationLabel;
  final String locationAddress;

  /// Remote image URL for the user avatar.
  final String? avatarImageUrl;

  /// Local asset path fallback (e.g. 'assets/images/avatar.png').
  final String? avatarPlaceholder;

  /// Badge count shown on the bell icon. Pass 0 to hide the badge.
  final int notificationCount;

  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onLocationTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // User Avatar
          UserAvatar(
            imageUrl: avatarImageUrl,
            assetPath: avatarPlaceholder,
            onTap: onAvatarTap,
          ),

          //Location Block (center)
          Expanded(
            child: LocationBlock(
              label: locationLabel,
              address: locationAddress,
              onTap: onLocationTap,
            ),
          ),
          // Notification Bell
          NotificationBell(count: notificationCount, onTap: onNotificationTap),
        ],
      ),
    );
  }
}
