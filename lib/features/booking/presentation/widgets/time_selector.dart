import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import '../../logic/cubit/booking_cubit.dart';
import '../../logic/cubit/booking_state.dart';

class TimeSelector extends StatelessWidget {
  final Function(int) onTimeSelected;

  const TimeSelector({super.key, required this.onTimeSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr(LocaleKeys.bookingChooseTime),
          style: AppText.ibmHeading14(),
        ),
        verticalSpace(12),
        SizedBox(
          height: 85.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            itemCount: 6,
            itemBuilder: (context, index) => _TimeItem(
              time:
                  '08:00 ${context.tr(LocaleKeys.bookingAm)}\n-09:00 ${context.tr(LocaleKeys.bookingAm)}',
              index: index,
              onTap: () => context.read<BookingCubit>().selectTime(index),
            ),
          ),
        ),
      ],
    );
  }
}

class _TimeItem extends StatelessWidget {
  final String time;
  final int index;
  final VoidCallback onTap;

  const _TimeItem({
    required this.time,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      buildWhen: (previous, current) => current is BookingTimeSelected,
      listener: (context, state) {},
      builder: (context, state) {
        var isSelected =
            context.read<BookingCubit>().selectedTimeIndex == index;
        return GestureDetector(
          onTap: () => context.read<BookingCubit>().selectTime(index),
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

              child: Text(
                time,
                style: AppText.ibmDescription12(color: AppColors.primaryText),
              ),
            ),
          ),
        );
      },
    );
  }
}
