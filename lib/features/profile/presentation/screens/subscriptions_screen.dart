import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
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
  final List<SubscriptionModel> _currentSubscriptions = [
    SubscriptionModel(
      id: '1',
      title: LocaleKeys.profileWeeklyCleaning,
      type: LocaleKeys.profileWeekly,
      nextVisitDate: 'الأحد، 15 مايو 2026',
      nextVisitTime: '9:00 ص',
      price: 350.0,
      status: SubscriptionStatus.active,
    ),
  ];

  final List<SubscriptionModel> _previousSubscriptions = [
    SubscriptionModel(
      id: '2',
      title: LocaleKeys.profileWeeklyCleaning,
      type: LocaleKeys.profileWeekly,
      expiryDate: 'الأحد، 15 مايو 2026',
      price: 350.0,
      status: SubscriptionStatus.ended,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.tr(LocaleKeys.profileMySubscriptions),
          onBack: () => context.pop(),
          bottom: TabBar(
            labelStyle: AppText.ibmHeading14(),
            unselectedLabelStyle: AppText.ibmDescription14(),
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.primaryText,
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: context.tr(LocaleKeys.profileCurrentSubscriptions)),
              Tab(text: context.tr(LocaleKeys.profilePreviousSubscriptions)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SubscriptionListWidget(
              subscriptions: _currentSubscriptions,
              isCurrent: true,
            ),
            SubscriptionListWidget(
              subscriptions: _previousSubscriptions,
              isCurrent: false,
            ),
          ],
        ),
      ),
    );
  }
}
