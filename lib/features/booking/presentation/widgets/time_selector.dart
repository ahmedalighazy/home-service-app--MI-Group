import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/helpers/spacing.dart';

class TimeSelector extends StatelessWidget {
  final int selectedTimeIndex;
  final Function(int) onTimeSelected;

  const TimeSelector({
    super.key,
    required this.selectedTimeIndex,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    log(80.h.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('اختر وقت', style: AppText.ibmHeading14()),
        verticalSpace(12),
        SizedBox(
          height: 80.h,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            itemCount: 6,
            itemBuilder: (context, index) => _TimeItem(
              time: '08:00 ص\n-09:00 ص',
              isSelected: selectedTimeIndex == index,
              onTap: () => onTimeSelected(index),
            ),
          ),
        ),
      ],
    );
  }
}

class _TimeItem extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimeItem({
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: ShapeDecoration(
          color: isSelected ? AppColors.bluegreen : AppColors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: isSelected ? AppColors.primary : AppColors.borderGrey,
            ),
            borderRadius: BorderRadius.circular(9999),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),

        alignment: Alignment.center,
        child: FittedBox(
          // fit: BoxFit.scaleDown,
          child: Text(
            time,
            style: AppText.ibmDescription12(color: AppColors.primaryText),
          ),
        ),
      ),
    );
  }
}
