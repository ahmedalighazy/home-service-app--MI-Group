import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

import '../../../../core/themes/image/app_assets.dart';

class ProfileImageEditWidget extends StatelessWidget {
  const ProfileImageEditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: const ShapeDecoration(
              shape: OvalBorder(
                side: BorderSide(width: 1, color: AppColors.greenPrimary),
              ),
            ),
            child: CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 48.r,
              child: Image.asset(AppAssets.cleaningGuy),
            ),
          ),
          Positioned(
            bottom: -9,
            right: 0,
            child: CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 20.r,
              child: SvgPicture.asset(IconsPath.edit),
            ),
          ),
        ],
      ),
    );
  }
}
