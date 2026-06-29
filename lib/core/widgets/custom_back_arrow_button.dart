import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

import '../routes/navigation_extensions.dart';

class CustomBackArrowButton extends StatelessWidget {
  const CustomBackArrowButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSizes.radiusLarge,
      backgroundColor: AppColors.borderGrey,
      child: IconButton(
        onPressed: onPressed ?? () => context.pop(),
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.primaryText,
          size: AppSizes.iconSizeMedium,
        ),
      ),
    );
  }
}
