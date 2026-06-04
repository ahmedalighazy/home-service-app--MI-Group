import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/features/profile/data/models/visit_model.dart';

import '../widgets/visit_card.dart';

class MyVisitsScreen extends StatelessWidget {
  const MyVisitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real data from Cubit
    final upcomingVisits = [
      VisitModel(id: '1', date: 'الأحد، 15 مايو 2026', time: '08:00 ص - 09:00 ص', status: VisitStatus.scheduled),
      VisitModel(id: '2', date: 'الأحد، 15 مايو 2026', time: '08:00 ص - 09:00 ص', status: VisitStatus.inProgress),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: CustomAppBar(
          title: AppStrings.myVisits,
          onBack: () => Navigator.pop(context),
          bottom: TabBar(
            labelStyle: AppText.ibmHeading14(),
            unselectedLabelStyle: AppText.ibmDescription14(),
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.primaryText,
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: AppStrings.previousSubscriptions),
              Tab(text: AppStrings.upcomingVisits),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Center(child: Text('لا توجد زيارات سابقة')),
            ListView.builder(
              padding: EdgeInsets.all(AppSizes.paddingM.r),
              itemCount: upcomingVisits.length,
              itemBuilder: (_, index) => VisitCard(visit: upcomingVisits[index]),
            ),
          ],
        ),
      ),
    );
  }
}
