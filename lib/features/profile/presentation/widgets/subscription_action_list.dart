import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';

import 'subscription_action_tile.dart';

class SubscriptionActionList extends StatelessWidget {
  final VoidCallback onPauseTap;
  final VoidCallback onCancelTap;

  const SubscriptionActionList({
    super.key,
    required this.onPauseTap,
    required this.onCancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        children: [
          SubscriptionActionTile(
            title: AppStrings.viewVisits,
            subtitle: AppStrings.viewVisitsDesc,
            icon: IconsPath.timeBlue,
            onTap: () => context.pushNamed(AppRouter.myVisits),
          ),
          const Divider(height: 1),
          SubscriptionActionTile(
            title: AppStrings.pauseTemporarily,
            subtitle: AppStrings.pauseTemporarilyDesc,
            icon: IconsPath.paused,
            onTap: onPauseTap,
          ),
          const Divider(height: 1),
          SubscriptionActionTile(
            title: AppStrings.changePackage,
            subtitle: AppStrings.changePackageDesc,
            icon: IconsPath.exit,
            onTap: () {},
          ),
          const Divider(height: 1),
          SubscriptionActionTile(
            title: AppStrings.cancelSubscription,
            subtitle: AppStrings.cancelSubscriptionDesc,
            icon: IconsPath.delete,
            onTap: onCancelTap,
            isDanger: true,
          ),
        ],
      ),
    );
  }
}
