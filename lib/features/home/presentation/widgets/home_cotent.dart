import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/home/presentation/widgets/home_header.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(AppSizes.padding),
          height: AppSizes.homeContainerHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.white],
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
            ),

            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppSizes.radiusXL),
              bottomRight: Radius.circular(AppSizes.radiusXL),
            ),
          ),
          child: HomeHeader(),
        ),
      ],
    );
  }
}
