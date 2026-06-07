import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key, this.onPressed});
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSizes.radiusLarge,
      backgroundColor: AppColors.borderInputs,
      child: IconButton(
        onPressed: () => context.pop(),
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.primaryText,
          size: AppSizes.iconSize,
        ),
      ),
    );
  }
}
