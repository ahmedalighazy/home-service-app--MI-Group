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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: width(context) / 5,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                style: AppText.ibmHeading16(
                  color: AppColors.primaryText,
                ).copyWith(),
              ),
            ),
          ),
          horizontalSpace(40),
          _ValueSection(value: value, icon: icon, value2: value2, icon2: icon2),
          Spacer(),
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

  // ignore: unused_element_parameter
  const _ValueSection({
    required this.value,
    required this.icon,
    this.value2,
    this.icon2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              spacing: 10,
              children: [
                SvgPicture.asset(
                  icon,
                  width: 16.w,
                  color: AppColors.secondaryText,
                ),
                if (icon2 != null)
                  SvgPicture.asset(
                    icon2!,
                    width: 16.w,
                    color: AppColors.secondaryText,
                  ),
              ],
            ),
            horizontalSpace(8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  value,
                  style: AppText.ibmDescription14(
                    color: AppColors.secondaryText,
                  ),
                ),
                if (value2 != null)
                  Text(
                    value2!,
                    style: AppText.ibmDescription14(
                      color: AppColors.secondaryText,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
