import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:go_router/go_router.dart';

class CustomBackArrowButton extends StatelessWidget {
  const CustomBackArrowButton({super.key, this.onPressed});
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {

    return CircleAvatar(
      radius: AppSizes.radiusLarge,
      backgroundColor: AppColors.borderInputs,
      child: IconButton(
        onPressed: onPressed ?? () => GoRouter.of(context).pop(),
        icon: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(Directionality.of(context) == TextDirection.rtl ? -1.0 : 1.0, 1.0, 1.0),
          child: Image.asset(
            AppAssets.iconBack,
            width: AppSizes.iconSize,
            height: AppSizes.iconSize,
          ),
        ),
      ),
    );
  }
}
