import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
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
            title: context.l10n.viewVisits,
            subtitle: context.l10n.viewVisitsDesc,
            icon: IconsPath.timeBlue,
            onTap: () => context.pushNamed(AppRouter.myVisits),
          ),
          const Divider(height: 1),
          SubscriptionActionTile(
            title: context.l10n.pauseTemporarily,
            subtitle: context.l10n.pauseTemporarilyDesc,
            icon: IconsPath.paused,
            onTap: onPauseTap,
          ),
          const Divider(height: 1),
          SubscriptionActionTile(
            title: context.l10n.changePackage,
            subtitle: context.l10n.changePackageDesc,
            icon: IconsPath.exit,
            onTap: () {},
          ),
          const Divider(height: 1),
          SubscriptionActionTile(
            title: context.l10n.cancelSubscription,
            subtitle: context.l10n.cancelSubscriptionDesc,
            icon: IconsPath.delete,
            onTap: onCancelTap,
            isDanger: true,
          ),
        ],
      ),
    );
  }
}
