import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
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
      appBar: CustomAppBar(title: context.tr(LocaleKeys.profileHelpCenter)),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        children: [
          HelpCenterItem(
            title: context.tr(LocaleKeys.helpCenterFaq),
            icon: IconsPath.faq,
            onTap: () => context.pushNamed(AppRouter.faq),
          ),
          verticalSpace(24),
          const TechnicalSupportHeader(),
          verticalSpace(16),
          TicketCard(
            title: context.tr(LocaleKeys.helpCenterTicketTitle1),
            status: context.tr(LocaleKeys.helpCenterOpenStatus),
            statusColor: AppColors.greenPrimary,
            ticketCode: '${context.tr(LocaleKeys.helpCenterTicketPrefix)}1001',
            time: context.tr(LocaleKeys.helpCenterTimeOneDayAgo),
            description: context.tr(LocaleKeys.helpCenterTicketDesc1),
            onTap: () => context.pushNamed(AppRouter.chatDetail),
          ),
          verticalSpace(12),
          TicketCard(
            title: context.tr(LocaleKeys.helpCenterTicketTitle2),
            status: context.tr(LocaleKeys.helpCenterResolvedStatus),
            statusColor: AppColors.bgHint,
            ticketCode: '${context.tr(LocaleKeys.helpCenterTicketPrefix)}1002',
            time: context.tr(LocaleKeys.helpCenterTimeOneDayAgo),
            description: context.tr(LocaleKeys.helpCenterTicketDesc2),
            onTap: () => context.pushNamed(AppRouter.chatDetail),
          ),
        ],
      ),
    );
  }
}
