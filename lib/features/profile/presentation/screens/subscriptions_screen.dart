import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/widgets/empty_state_widget.dart';
import 'package:home_service_app/features/profile/data/models/subscription_model.dart';
import 'package:home_service_app/features/profile/presentation/widgets/subscription_card_widget.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  // Mock data
  final List<SubscriptionModel> _currentSubscriptions = [
    SubscriptionModel(
      id: '1',
      title: AppStrings.weeklyCleaning,
      type: AppStrings.weekly,
      nextVisitDate: 'الأحد، 15 مايو 2026',
      nextVisitTime: '9:00 ص',
      price: 350.0,
      status: SubscriptionStatus.active,
    ),
  ];

  final List<SubscriptionModel> _previousSubscriptions = [
    SubscriptionModel(
      id: '2',
      title: AppStrings.weeklyCleaning,
      type: AppStrings.weekly,
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
          title: AppStrings.mySubscriptions,
          onBack: () => Navigator.pop(context),
          bottom: TabBar(
            labelStyle: AppText.ibmHeading14(),
            unselectedLabelStyle: AppText.ibmDescription14(),
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.primaryText,
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: AppStrings.currentSubscriptions),
              Tab(text: AppStrings.previousSubscriptions),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildSubscriptionList(_currentSubscriptions, true),
            _buildSubscriptionList(_previousSubscriptions, false),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionList(
    List<SubscriptionModel> subscriptions,
    bool isCurrent,
  ) {
    if (subscriptions.isEmpty) {
      return EmptyStateWidget(
        iconPath:
            IconsPath.group590Svg, // Assuming this exists or using a fallback
        title: AppStrings.noActiveSubscriptions,
        subtitle: AppStrings.subscribePackagesDesc,
        buttonLabel: AppStrings.browsePackagesBtn,
        onButtonPressed: () {
          // Navigate to browse packages
        },
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(AppSizes.paddingM.r),
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: SubscriptionCardWidget(
            subscription: subscriptions[index],
            onTap: () {
              if (subscriptions[index].status == SubscriptionStatus.active) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.subscriptionDetail,
                  arguments: subscriptions[index],
                );
              } else if (subscriptions[index].status ==
                  SubscriptionStatus.paused) {
                // Implement reactivate logic
              } else {
                // Implement subscribe again logic
              }
            },
          ),
        );
      },
    );
  }
}
