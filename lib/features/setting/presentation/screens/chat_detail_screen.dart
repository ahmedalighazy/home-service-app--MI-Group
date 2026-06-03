import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isResolved = false; // This would typically come from state

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: AppStrings.ticketTitle1,
        widget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // horizontalSpace(8),
              _buildStatusBadge(),
              horizontalSpace(8),
              Text(
                "TKT.1001",
                style: AppText.regularIbm(
                  color: AppColors.secondaryText,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.r),
              children: [
                _buildSupportMessage(AppStrings.supportMsg1, '10:00 AM'),
                _buildUserMessage(AppStrings.userMsg1, '10:05 AM'),
                // Add more messages here
              ],
            ),
          ),
          if (!isResolved) _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildSupportMessage(String text, String time) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.inputBg,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: AppText.regularIbm(
                color: AppColors.primaryText,
                fontSize: 14,
              ),
            ),
          ),
          verticalSpace(4),
          Text(
            time,
            style: AppText.regularIbm(
              color: AppColors.textLightGrey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserMessage(String text, String time) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.greenPrimary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: AppText.regularIbm(color: AppColors.white, fontSize: 14),
            ),
          ),
          verticalSpace(4),
          Text(
            time,
            style: AppText.regularIbm(
              color: AppColors.textLightGrey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      //  padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        // color: statusColor,
        color: AppColors.greenPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(44)),
        shadows: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),

      child: Text(
        //   status,
        AppStrings.open,
        style: AppText.semiBoldIbm(color: AppColors.white, fontSize: 12),
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: const BoxDecoration(
              color: AppColors.primaryBlack,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(IconsPath.send, width: 20.w, height: 20.h),
          ),
          horizontalSpace(12),
          Expanded(
            child: TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: AppStrings.typeMessageHint,
                hintStyle: AppText.regularIbm(
                  color: AppColors.textLightGrey,
                  fontSize: 14,
                ),
                fillColor: AppColors.inputBg,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
