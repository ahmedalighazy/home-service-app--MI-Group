import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/icons_path.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../../../../core/utils/helpers/spacing.dart';
import '../widgets/help_center_item.dart';
import '../widgets/ticket_card.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.r),
                children: [
                  HelpCenterItem(
                    title: AppStrings.faq,
                    icon: IconsPath.faq,
                    onTap: () {},
                  ),
                  verticalSpace(24),
                  _buildTechnicalSupportHeader(),
                  verticalSpace(16),
                  const TicketCard(
                    title: AppStrings.ticketTitle1,
                    status: AppStrings.open,
                    statusColor: AppColors.greenPrimary,
                    ticketCode: '${AppStrings.ticketPrefix}1001',
                    time: AppStrings.timeOneDayAgo,
                    description: AppStrings.ticketDesc1,
                  ),
                  verticalSpace(12),
                  const TicketCard(
                    title: AppStrings.ticketTitle2,
                    status: AppStrings.resolved,
                    statusColor: AppColors.bgHint,
                    ticketCode: '${AppStrings.ticketPrefix}1002',
                    time: AppStrings.timeOneDayAgo,
                    description: AppStrings.ticketDesc2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: AppColors.softWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                IconsPath.backButton,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
          Text(
            AppStrings.helpCenter,
            style: AppText.ibmHeading20(color: AppColors.headingText),
          ),
          horizontalSpace(44),
        ],
      ),
    );
  }

  Widget _buildTechnicalSupportHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlack,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(44.r)),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            minimumSize: Size(118.w, 36.h),
          ),
          child: Text(
            AppStrings.newIssue,
            style: AppText.ibmButton16(color: AppColors.white).copyWith(fontSize: 14.sp),
          ),
        ),
        Text(
          AppStrings.technicalSupport,
          style: AppText.mediumIbm(color: AppColors.primaryText, fontSize: 16),
        ),
      ],
    );
  }
}
