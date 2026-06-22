import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import '../../logic/cubit/booking_cubit.dart';
import '../../logic/cubit/booking_state.dart';

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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 90.h,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            itemCount: 7,
            itemBuilder: (context, index) => _DayItem(
              dayName: _getDayName(context, index),
              dayNumber: (index + 1).toString(),
              index: index,
            ),
          ),
        ),
      ],
    );
  }

  String _getDayName(BuildContext context, int index) {
    final days = [
      context.tr(LocaleKeys.bookingSaturday),
      context.tr(LocaleKeys.bookingSunday),
      context.tr(LocaleKeys.bookingMonday),
      context.tr(LocaleKeys.bookingTuesday),
      context.tr(LocaleKeys.bookingWednesday),
      context.tr(LocaleKeys.bookingThursday),
      context.tr(LocaleKeys.bookingFriday),
    ];
    return days[index];
  }
}

class _DayItem extends StatelessWidget {
  final String dayName;
  final String dayNumber;
  final int index;

  const _DayItem({
    required this.dayName,
    required this.dayNumber,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      buildWhen: (previous, current) => current is BookingDaySelected,
      listener: (context, state) {},
      builder: (context, state) {
        var isSelected = context.read<BookingCubit>().selectedDayIndex == index;
        return Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                dayName,
                style: AppText.mediumText(color: Colors.black, fontSize: 14),
              ),
            ),
            GestureDetector(
              onTap: () => context.read<BookingCubit>().selectDay(index),

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
            ),
          ],
        );
      },
    );
  }
}
