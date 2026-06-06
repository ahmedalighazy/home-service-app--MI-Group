import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

class TicketCard extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;
  final String ticketCode;
  final String time;
  final String description;
  final VoidCallback? onTap;

  const TicketCard({
    super.key,
    required this.title,
    required this.status,
    required this.statusColor,
    required this.ticketCode,
    required this.time,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: ShapeDecoration(
          color: const Color(0xFFF8FBFF) /* bg-secondary */,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0xFFF1F5F9) /* border-cards */,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: AppText.semiBoldIbm(
                    color: AppColors.primaryText,
                    fontSize: 12,
                  ),
                ),
                horizontalSpace(12),

                _buildStatusBadge(),

                const Spacer(),

                Icon(
                  Icons.chevron_right,
                  color: AppColors.primaryText,
                  size: 24.r,
                ),
              ],
            ),
            verticalSpace(6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  ticketCode,
                  style: AppText.regularIbm(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                ),
                horizontalSpace(8),

                Text(
                  time,
                  style: AppText.regularIbm(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
              ],
            ),
            verticalSpace(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.messenger_outline_sharp,
                  color: AppColors.primaryText,
                  size: 15.r,
                ),
                horizontalSpace(10),

                Expanded(
                  child: Text(
                    description,
                    textAlign: TextAlign.right,
                    style: AppText.regularIbm(
                      color: AppColors.secondaryText,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      //  padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: statusColor,
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
        status,
        style: AppText.semiBoldIbm(color: AppColors.white, fontSize: 12),
      ),
    );
  }
}
