import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/utils/helpers/booking_date_utils.dart';
import '../../data/models/extra_item_model.dart';
import '../../data/models/time_slot_model.dart';
import '../../domain/entities/time_slot_entity.dart';
import '../cubit/feature_cubit.dart';
import '../cubit/feature_state.dart';
import '../widgets/booking_steps/date_time/day_picker_table.dart';
import '../widgets/booking_steps/date_time/policy_banner.dart';
import '../widgets/booking_steps/date_time/section_label.dart';
import '../widgets/booking_steps/date_time/time_slot_grid.dart';
import '../widgets/booking_steps/step_app_bar.dart';
import '../widgets/booking_steps/step_bottom_bar.dart';
import 'address_step_view.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class DateTimeStepScreen extends StatelessWidget {
  final double cartTotal;
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;
  final List<ExtraItem> selectedExtras;

  const DateTimeStepScreen({
    super.key,
    required this.cartTotal,
    this.currentStep = 2,
    this.totalSteps = 4,
    this.onBack,
    this.selectedExtras = const [],
  });

  void _goToAddressStep(BuildContext context) {
    final featureCubit = context.read<FeatureCubit>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: featureCubit,
          child: AddressStepScreen(
            cartTotal: cartTotal,
            currentStep: currentStep + 1,
            totalSteps: totalSteps,
            selectedExtras: selectedExtras,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final days = buildWeekStartingSaturday();
    final slots = TimeSlotEntity.catalogue;

    return BlocBuilder<FeatureCubit, FeatureState>(
      buildWhen: (previous, current) =>
          previous is! FeatureLoaded ||
          current is! FeatureLoaded ||
          previous.selectedDayIndex != current.selectedDayIndex ||
          previous.selectedSlotIndex != current.selectedSlotIndex,
      builder: (context, state) {
        final loaded = state is FeatureLoaded ? state : const FeatureLoaded();
        final cubit = context.read<FeatureCubit>();

        return Scaffold(
          backgroundColor: AppColors.scaffoldBg,
          appBar: StepAppBar(
            title: SdStrings.dateTime,
            currentStep: currentStep,
            totalSteps: totalSteps,
            onBack: onBack ?? () => Navigator.maybePop(context),
          ),
          body: ListView(
            padding: EdgeInsets.only(
              top: size.height * 0.008,
              bottom: size.height * 0.16,
            ),
            children: [
              SectionLabel(label: SdStrings.chooseToday),
              SizedBox(height: size.height * 0.008),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: DayPickerTable(
                  days: days,
                  selectedIndex: loaded.selectedDayIndex,
                  onDaySelected: cubit.selectDay,
                ),
              ),
              SizedBox(height: size.height * 0.028),
              SectionLabel(label: SdStrings.chooseTime),
              SizedBox(height: size.height * 0.008),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: TimeSlotGrid(
                  slots: slots.map((e) => TimeSlot(startTime: e.startTime, endTime: e.endTime)).toList(),
                  selectedIndex: loaded.selectedSlotIndex,
                  onSlotSelected: cubit.selectTimeSlot,
                ),
              ),
              SizedBox(height: size.height * 0.032),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: const PolicyBanner(),
              ),
            ],
          ),
          bottomSheet: StepBottomBar(
            total: cartTotal,
            onNext: () => _goToAddressStep(context),
          ),
        );
      },
    );
  }
}
