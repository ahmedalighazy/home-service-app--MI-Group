import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

/// Support message bubble (aligned right, grey background)
class SupportMessageBubble extends StatelessWidget {
  final String text;
  final String time;

  const SupportMessageBubble({
    super.key,
    required this.text,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
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
              style: AppText.regularIbm(color: AppColors.primaryText, fontSize: 14),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            time,
            style: AppText.regularIbm(color: AppColors.textLightGrey, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

/// User message bubble (aligned left, primary green background)
class UserMessageBubble extends StatelessWidget {
  final String text;
  final String time;

  const UserMessageBubble({
    super.key,
    required this.text,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 4.h),
          Text(
            time,
            style: AppText.regularIbm(color: AppColors.textLightGrey, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
