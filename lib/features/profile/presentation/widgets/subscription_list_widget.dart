import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/widgets/empty_state_widget.dart';
import 'package:home_service_app/features/profile/data/models/subscription_model.dart';
import 'subscription_card_widget.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';

class SubscriptionListWidget extends StatelessWidget {
  final List<SubscriptionModel> subscriptions;
  final bool isCurrent;

  const SubscriptionListWidget({
    super.key,
    required this.subscriptions,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    if (subscriptions.isEmpty) {
      return EmptyStateWidget(
        iconPath: 'assets/icons/Group 590.svg',
        title: context.l10n.noActiveSubscriptions,
        subtitle: context.l10n.subscribePackagesDesc,
        buttonLabel: context.l10n.browsePackagesBtn,
        onButtonPressed: () {},
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(AppSizes.paddingM.r),
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        final subscription = subscriptions[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: SubscriptionCardWidget(
            subscription: subscription,
            onTap: () {
              if (subscription.status == SubscriptionStatus.active) {
                context.pushNamed(
                  AppRouter.subscriptionDetail,
                  arguments: subscription,
                );
              }
            },
          ),
        );
      },
    );
  }
}
