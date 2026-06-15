import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/widgets/custom_text_field.dart';
import 'package:home_service_app/features/booking/logic/cubit/booking_cubit.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../data/repositories/booking_repository.dart';
import '../widgets/day_selector.dart';
import '../widgets/time_selector.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../../../../core/utils/helpers/spacing.dart';

class RescheduleBookingScreen extends StatelessWidget {
  const RescheduleBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCubit(BookingRepository()),
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.confirmReschedule),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('اختر اليوم', style: AppText.ibmHeading14()),
              verticalSpace(12),
              DaySelector(selectedDayIndex: 0, onDaySelected: (idx) {}),
              verticalSpace(24),
              TimeSelector(onTimeSelected: (idx) {}),
              verticalSpace(24),
              Text(
                AppStrings.specialNotesOptional,
                style: AppText.ibmHeading14(),
              ),
              verticalSpace(12),
              CustomTextField(
                hintText: AppStrings.exampleHomeLocation,
                maxLines: 4,
                fillColor: AppColors.gry,
                borderColor: AppColors.borderGrey,
              ),
              verticalSpace(5),

              Row(
                children: [
                  Spacer(),
                  Text(
                    '300/0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF1D265C) ,
                      fontSize: 14.sp,
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Spacer(),
              CustomButtom(
                onTap: () {},
                text: AppStrings.confirmReschedule2,
                textStyle: AppText.ibmButton16(color: AppColors.white),
                startColor: AppColors.primary,
                endColor: AppColors.dark,
              ),
              verticalSpace(12),
            ],
          ),
        ),
      ),
    );
  }
}
