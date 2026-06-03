import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/icons_path.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/helpers/spacing.dart';

class TicketCard extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;
  final String ticketCode;
  final String time;
  final String description;

  const TicketCard({
    super.key,
    required this.title,
    required this.status,
    required this.statusColor,
    required this.ticketCode,
    required this.time,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                IconsPath.container,
                width: 7.4.w,
                height: 12.h,
              ),
              const Spacer(),
              _buildStatusBadge(),
              horizontalSpace(12),
              Text(
                title,
                style: AppText.semiBoldIbm(color: AppColors.primaryText, fontSize: 12),
              ),
            ],
          ),
          verticalSpace(6),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                time,
                style: AppText.regularIbm(color: AppColors.secondaryText, fontSize: 12),
              ),
              horizontalSpace(8),
              Text(
                ticketCode,
                style: AppText.regularIbm(color: AppColors.secondaryText, fontSize: 12),
              ),
            ],
          ),
          verticalSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  description,
                  textAlign: TextAlign.right,
                  style: AppText.regularIbm(color: AppColors.secondaryText, fontSize: 12),
                ),
              ),
              horizontalSpace(10),
              SvgPicture.asset(
                IconsPath.ticket,
                width: 18.w,
                height: 18.h,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.description_outlined, size: 18.r, color: AppColors.secondaryText),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(44.r),
      ),
      child: Text(
        status,
        style: AppText.mediumIbm(color: AppColors.white, fontSize: 10),
      ),
    );
  }
}
