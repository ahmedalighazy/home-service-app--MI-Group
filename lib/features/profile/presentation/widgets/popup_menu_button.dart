import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

import '../../../../core/utils/helpers/show_dialog.dart';

enum MenuAction { favorite, edit, delete }

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({super.key, required this.onSelected});

  final ValueChanged<MenuAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      icon: const Icon(Icons.more_vert),
      color: AppColors.white,
      shadowColor: AppColors.bgDisabled,
      surfaceTintColor: AppColors.bgDisabled,
      style: const ButtonStyle(),
      onSelected: onSelected,
      itemBuilder: (context) => [
        PopupMenuItem<MenuAction>(
          value: MenuAction.favorite,
          child: Row(
            children: [
              SvgPicture.asset(IconsPath.star, width: 18, height: 18),
              const SizedBox(width: 8),
              const Text('تعيين كافتراضي'),
            ],
          ),
        ),
        PopupMenuItem<MenuAction>(
          value: MenuAction.edit,
          child: Row(
            children: [
              SvgPicture.asset(
                IconsPath.editLocation,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryText,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              const Text('Edit'),
            ],
          ),
        ),
        PopupMenuItem<MenuAction>(
          value: MenuAction.delete,
          onTap: () {
            showCannotDeleteDialogred(
              context,
              " حذف البطاقة",
              "هل انت متاكد انك تريد خذف هذة البطاقة",
            );
          },
          child: Row(
            children: [
              SvgPicture.asset(IconsPath.delete, width: 18, height: 18),
              const SizedBox(width: 8),
              const Text('Delete', style: TextStyle(color: AppColors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
