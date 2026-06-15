import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/features/profile/data/models/visit_model.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';

import '../widgets/visit_card.dart';

class MyVisitsScreen extends StatelessWidget {
  const MyVisitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with real data from Cubit
    final upcomingVisits = [
      VisitModel(
        id: '1',
        serviceType: 'Cleaning',
        date: DateTime(2026, 5, 15),
        status: 'scheduled',
        time: '08:00 ص - 09:00 ص',
      ),
      VisitModel(
        id: '2',
        serviceType: 'Cleaning',
        date: DateTime(2026, 5, 15),
        status: 'in_progress',
        time: '08:00 ص - 09:00 ص',
      ),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.myVisits,
          onBack: () => context.pop(),
          bottom: TabBar(
            labelStyle: AppText.ibmHeading14(),
            unselectedLabelStyle: AppText.ibmDescription14(),
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.primaryText,
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: AppStrings.upcomingVisits),

              Tab(text: AppStrings.previousSubscriptions),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Center(child: Text('لا توجد زيارات سابقة')),
            ListView.builder(
              padding: EdgeInsets.all(AppSizes.paddingM.r),
              itemCount: upcomingVisits.length,
              itemBuilder: (_, index) =>
                  VisitCard(visit: upcomingVisits[index]),
            ),
          ],
        ),
      ),
    );
  }
}
