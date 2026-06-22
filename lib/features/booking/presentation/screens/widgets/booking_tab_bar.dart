import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class BookingTabBar extends StatelessWidget implements PreferredSizeWidget {
  const BookingTabBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelStyle: AppText.ibmHeading14(),
      unselectedLabelStyle: AppText.ibmDescription14(),
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.primaryText,
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: [
        Tab(text: AppStrings.currentSubscriptions),
        Tab(text: AppStrings.previousSubscriptions),
      ],
    );
  }
}
