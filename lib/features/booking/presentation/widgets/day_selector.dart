import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

class DaySelector extends StatelessWidget {
  final int selectedDayIndex;
  final Function(int) onDaySelected;

  const DaySelector({
    super.key,
    required this.selectedDayIndex,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 70.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // reverse: true, // For RTL
            itemCount: 7,
            itemBuilder: (context, index) => _DayItem(
              dayName: _getDayName(index),
              dayNumber: (index + 1).toString(),
              isSelected: selectedDayIndex == index,
              onTap: () => onDaySelected(index),
            ),
          ),
        ),
      ],
    );
  }

  String _getDayName(int index) {
    const days = [
      'السبت',
      'الاحد',
      'الاثنين',
      'الثلاثاء',
      'الاربعاء',
      'الخميس',
      'الجمعة',
    ];
    return days[index];
  }
}

class _DayItem extends StatelessWidget {
  final String dayName;
  final String dayNumber;
  final bool isSelected;
  final VoidCallback onTap;

  const _DayItem({
    required this.dayName,
    required this.dayNumber,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dayName,
          style: AppText.mediumText(color: Colors.black, fontSize: 14),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.all(5.r),
            width: 40.w,
            height: 40.h,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: isSelected ? AppColors.primary : AppColors.inputBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(44),
              ),
            ),
            child: Center(
              child: Text(
                dayNumber,
                style: AppText.ibmHeading14(
                  color: isSelected ? AppColors.white : AppColors.black,
                ),
              ),
            ),
          ),

          // color: isSelected ? AppColors.primary : AppColors.inputBg,
        ),
      ],
    );
  }
}
