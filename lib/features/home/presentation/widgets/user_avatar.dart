import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.imageUrl, this.assetPath, this.onTap});

  final String? imageUrl;
  final String? assetPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    ImageProvider? provider;

    if (imageUrl != null) {
      provider = NetworkImage(imageUrl!);
    } else if (assetPath != null) {
      provider = AssetImage(assetPath!);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSizes.avatarSize,
        height: AppSizes.avatarSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white.withValues(alpha: 0.6),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.10),
              blurRadius: AppSizes.spacingSmall,
              offset: const Offset(0, 2),
            ),
          ],
          image: provider != null
              ? DecorationImage(image: provider, fit: BoxFit.cover)
              : null,
        ),
        child: provider == null
            ? const Icon(
                Icons.person_outline_rounded,
                color: AppColors.greyDarker,
                size: 26,
              )
            : null,
      ),
    );
  }
}
