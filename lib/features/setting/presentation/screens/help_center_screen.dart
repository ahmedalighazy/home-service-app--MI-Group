import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/extention_navigator.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../widgets/help_center_item.dart';
import '../widgets/technical_support_header.dart';
import '../widgets/ticket_card.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: AppStrings.helpCenter),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          HelpCenterItem(
            title: AppStrings.faq,
            icon: IconsPath.faq,
            onTap: () => context.pushName(AppRouter.faq),
          ),
          SizedBox(height: 24.h),
          const TechnicalSupportHeader(),
          SizedBox(height: 16.h),
          TicketCard(
            title: AppStrings.ticketTitle1,
            status: AppStrings.open,
            statusColor: AppColors.greenPrimary,
            ticketCode: '${AppStrings.ticketPrefix}1001',
            time: AppStrings.timeOneDayAgo,
            description: AppStrings.ticketDesc1,
            onTap: () => context.pushName(AppRouter.chatDetail),
          ),
          SizedBox(height: 12.h),
          TicketCard(
            title: AppStrings.ticketTitle2,
            status: AppStrings.resolved,
            statusColor: AppColors.bgHint,
            ticketCode: '${AppStrings.ticketPrefix}1002',
            time: AppStrings.timeOneDayAgo,
            description: AppStrings.ticketDesc2,
            onTap: () => context.pushName(AppRouter.chatDetail),
          ),
        ],
      ),
    );
  }
}
