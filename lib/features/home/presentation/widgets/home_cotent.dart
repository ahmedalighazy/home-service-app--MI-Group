import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: AppSizes.iconSizeSmall,
                backgroundColor: AppColors.white,
                child: SvgPicture.asset('assets/icons/profile.svg'),
              ),
              Column(
                children: [
                  Row(children: [Text('الموقع الحالي')]),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/notification_bell.svg'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
