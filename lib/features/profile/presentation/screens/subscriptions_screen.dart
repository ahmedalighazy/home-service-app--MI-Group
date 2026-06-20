import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/features/profile/data/models/subscription_model.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';

import '../../../../core/themes/text/app_text.dart';
import '../widgets/subscription_list_widget.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  List<SubscriptionModel> _currentSubscriptions(BuildContext context) {
    return [
      SubscriptionModel(
        id: '1',
        title: context.l10n.weeklyCleaning,
        type: context.l10n.weekly,
        nextVisitDate: 'الأحد، 15 مايو 2026',
        nextVisitTime: '9:00 ص',
        price: 350.0,
        status: SubscriptionStatus.active,
      ),
    ];
  }

  List<SubscriptionModel> _previousSubscriptions(BuildContext context) {
    return [
      SubscriptionModel(
        id: '2',
        title: context.l10n.weeklyCleaning,
        type: context.l10n.weekly,
        expiryDate: 'الأحد، 15 مايو 2026',
        price: 350.0,
        status: SubscriptionStatus.ended,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.l10n.mySubscriptions,
          onBack: () => context.pop(),
          bottom: TabBar(
            labelStyle: AppText.ibmHeading14(),
            unselectedLabelStyle: AppText.ibmDescription14(),
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.primaryText,
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: context.l10n.currentSubscriptions),
              Tab(text: context.l10n.previousSubscriptions),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SubscriptionListWidget(
              subscriptions: _currentSubscriptions(context),
              isCurrent: true,
            ),
            SubscriptionListWidget(
              subscriptions: _previousSubscriptions(context),
              isCurrent: false,
            ),
          ],
        ),
      ),
    );
  }
}
