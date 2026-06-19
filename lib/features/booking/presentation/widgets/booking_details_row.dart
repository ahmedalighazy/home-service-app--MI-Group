import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/helpers/spacing.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingDetailsRow extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  final String? icon2;
  final String? value2;

  const BookingDetailsRow({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.value2,
    this.icon2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 2.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              label,
              maxLines: 1,
              style: AppText.ibmHeading16(
                color: AppColors.primaryText,
              ),
            ),
          ),
          horizontalSpace(20),
          Expanded(
            child: _ValueSection(
              value: value,
              icon: icon,
              value2: value2,
              icon2: icon2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueSection extends StatelessWidget {
  final String value;
  final String? value2;
  final String icon;
  final String? icon2;

  const _ValueSection({
    required this.value,
    required this.icon,
    this.value2,
    this.icon2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              icon,
              width: 16.w,
              colorFilter: const ColorFilter.mode(
                AppColors.secondaryText,
                BlendMode.srcIn,
              ),
            ),
            if (icon2 != null) ...[
              verticalSpace(10),
              SvgPicture.asset(
                icon2!,
                width: 16.w,
                colorFilter: const ColorFilter.mode(
                  AppColors.secondaryText,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ],
        ),
        horizontalSpace(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: AppText.ibmDescription14(
                  color: AppColors.secondaryText,
                ),
              ),
              if (value2 != null) ...[
                verticalSpace(4),
                Text(
                  value2!,
                  style: AppText.ibmDescription14(
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
