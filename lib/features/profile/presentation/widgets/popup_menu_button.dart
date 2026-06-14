import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

enum MenuAction { favorite, edit, delete }

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({super.key, required this.onSelected});

  final ValueChanged<MenuAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      icon: Icon(Icons.more_vert, size: 24.r),
      color: AppColors.white,
      shadowColor: AppColors.bgDisabled,
      surfaceTintColor: AppColors.white,
      onSelected: onSelected,
      itemBuilder: (context) => [
        PopupMenuItem<MenuAction>(
          value: MenuAction.favorite,
          child: Row(
            children: [
              SvgPicture.asset(IconsPath.star, width: 18.r, height: 18.r),
              const SizedBox(width: 8),
              const Text(AppStrings.defaultText),
            ],
          ),
        ),
        PopupMenuItem<MenuAction>(
          value: MenuAction.edit,
          child: Row(
            children: [
              SvgPicture.asset(
                IconsPath.editLocation,
                width: 18.r,
                height: 18.r,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryText,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              const Text(AppStrings.edit),
            ],
          ),
        ),
        PopupMenuItem<MenuAction>(
          value: MenuAction.delete,
          child: Row(
            children: [
              SvgPicture.asset(
                IconsPath.delete,
                width: 18.r,
                height: 18.r,
                colorFilter: const ColorFilter.mode(
                  AppColors.red,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              const Text(AppStrings.delete, style: TextStyle(color: AppColors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
