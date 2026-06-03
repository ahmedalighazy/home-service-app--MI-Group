import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/extention_navigator.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../widgets/help_center_item.dart';
import '../widgets/new_issue_bottom_sheet.dart';
import '../widgets/ticket_card.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: AppStrings.helpCenter),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.r),
              children: [
                HelpCenterItem(
                  title: AppStrings.faq,
                  icon: IconsPath.faq,
                  onTap: () {
                    context.pushName(AppRoutes.faq);
                  },
                ),
                verticalSpace(24),
                _buildTechnicalSupportHeader(context),
                verticalSpace(16),
                TicketCard(
                  title: AppStrings.ticketTitle1,
                  status: AppStrings.open,
                  statusColor: AppColors.greenPrimary,
                  ticketCode: '${AppStrings.ticketPrefix}1001',
                  time: AppStrings.timeOneDayAgo,
                  description: AppStrings.ticketDesc1,
                  onTap: () {
                    context.pushName(AppRoutes.chatDetail);
                  },
                ),
                verticalSpace(12),
                TicketCard(
                  title: AppStrings.ticketTitle2,
                  status: AppStrings.resolved,
                  statusColor: AppColors.bgHint,
                  ticketCode: '${AppStrings.ticketPrefix}1002',
                  time: AppStrings.timeOneDayAgo,
                  description: AppStrings.ticketDesc2,
                  onTap: () {
                    context.pushName(AppRoutes.chatDetail);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalSupportHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.technicalSupport,
          style: AppText.mediumIbm(color: AppColors.primaryText, fontSize: 16),
        ),
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const NewIssueBottomSheet(),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(44.r),
            ),
            shadowColor: AppColors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            minimumSize: Size(118.w, 36.h),
          ),
          child: Text(
            AppStrings.newIssue,
            style: AppText.ibmButton16(
              color: AppColors.greenPrimary,
            ).copyWith(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
