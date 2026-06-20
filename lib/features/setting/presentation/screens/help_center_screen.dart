import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';

import '../widgets/help_center_item.dart';
import '../widgets/technical_support_header.dart';
import '../widgets/ticket_card.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: context.l10n.helpCenter),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          HelpCenterItem(
            title: context.l10n.faq,
            icon: IconsPath.faq,
            onTap: () => context.pushNamed(AppRouter.faq),
          ),
          SizedBox(height: 24.h),
          const TechnicalSupportHeader(),
          SizedBox(height: 16.h),
          TicketCard(
            title: context.l10n.ticketTitle1,
            status: context.l10n.open,
            statusColor: AppColors.greenPrimary,
            ticketCode: '${context.l10n.ticketPrefix}1001',
            time: context.l10n.timeOneDayAgo,
            description: context.l10n.ticketDesc1,
            onTap: () => context.pushNamed(AppRouter.chatDetail),
          ),
          SizedBox(height: 12.h),
          TicketCard(
            title: context.l10n.ticketTitle2,
            status: context.l10n.resolved,
            statusColor: AppColors.bgHint,
            ticketCode: '${context.l10n.ticketPrefix}1002',
            time: context.l10n.timeOneDayAgo,
            description: context.l10n.ticketDesc2,
            onTap: () => context.pushNamed(AppRouter.chatDetail),
          ),
        ],
      ),
    );
  }
}
