import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 60,
        height: 5,
        decoration: BoxDecoration(
          color: AppColors.borderInputs,
          borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
        ),
      ),
    );
  }
}
