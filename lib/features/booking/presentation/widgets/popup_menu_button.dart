import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';

import '../../../../core/routes/app_routes.dart';

enum MenuAction { reschedule, delete }

class CustomPopupMenuBooking extends StatelessWidget {
  const CustomPopupMenuBooking({super.key, required this.onSelected});

  final ValueChanged<MenuAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      icon: Icon(Icons.more_vert, color: AppColors.black),
      color: AppColors.white,
      shadowColor: AppColors.bgDisabled,
      surfaceTintColor: AppColors.bgDisabled,
      // style: const ButtonStyle(),
      onSelected: onSelected,
      itemBuilder: (context) => [
        PopupMenuItem<MenuAction>(
          value: MenuAction.reschedule,
          onTap: () {
            context.pushNamed(AppRouter.rescheduleBooking);
          },

          child: Row(
            children: [
              SvgPicture.asset(IconsPath.enlargement, width: 18, height: 18),
              horizontalSpace(8),
              Text(context.tr(LocaleKeys.bookingReschedule)),
            ],
          ),
        ),

        PopupMenuItem<MenuAction>(
          value: MenuAction.delete,
          onTap: () {
            context.pushNamed(AppRouter.cancelBooking);
          },
          child: Row(
            children: [
              SvgPicture.asset(IconsPath.delete, width: 18, height: 18),
              horizontalSpace(8),
              Text(
                context.tr(LocaleKeys.bookingCancel),
                style: const TextStyle(color: AppColors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
