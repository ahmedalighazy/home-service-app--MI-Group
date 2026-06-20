import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import '../cubit/feature_cubit.dart';
import '../cubit/feature_state.dart';
import '../widgets/booking_steps/home_clean/filter_section.dart';
import '../widgets/booking_steps/step_app_bar.dart';
import '../widgets/booking_steps/step_bottom_bar.dart';
import 'extras_step_view.dart';

class WorkerFilterCard extends StatelessWidget {
  final double cartTotal;
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;

  const WorkerFilterCard({
    super.key,
    required this.cartTotal,
    this.currentStep = 1,
    this.totalSteps = 6,
    this.onBack,
  });

  static const hours = [1, 2, 3, 4, 5];
  static const workers = [1, 2, 3, 4, 5, 6, 7, 8];
  List<String> apartmentSizes(BuildContext context) {
    return [
      context.l10n.smallApartment,
      context.l10n.mediumApartment,
      context.l10n.largeApartment,
      context.l10n.villa,
    ];
  }

  List<String> genders(BuildContext context) {
    return [
      context.l10n.femaleTeam,
      context.l10n.maleTeam,
      context.l10n.noPreference,
    ];
  }

  void _goToExtrasStep(BuildContext context) {
    final featureCubit = context.read<FeatureCubit>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: featureCubit,
          child: ExtrasStepScreen(
            cartTotal: cartTotal,
            currentStep: currentStep + 1,
            totalSteps: totalSteps,
            showRepeatStep: true,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatureCubit, FeatureState>(
      buildWhen: (previous, current) =>
          previous is! FeatureLoaded ||
          current is! FeatureLoaded ||
          previous.selectedHours != current.selectedHours ||
          previous.selectedWorkers != current.selectedWorkers ||
          previous.selectedSize != current.selectedSize ||
          previous.selectedGender != current.selectedGender,
      builder: (context, state) {
        final loaded = state is FeatureLoaded ? state : const FeatureLoaded();
        final cubit = context.read<FeatureCubit>();

        return Scaffold(
          appBar: StepAppBar(
            title: context.l10n.houseCleaningTitle,
            currentStep: currentStep,
            totalSteps: totalSteps,
            onBack: onBack ?? () => Navigator.maybePop(context),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterSection<int>(
                  title: context.l10n.howManyHours,
                  items: hours,
                  selectedItem: loaded.selectedHours,
                  labelBuilder: (value) => value == 1
                      ? context.l10n.oneHour
                      : '$value ${context.l10n.hours}',
                  onSelected: cubit.selectHours,
                ),
                const SizedBox(height: 24),
                FilterSection<int>(
                  title: context.l10n.howManyWorkers,
                  items: workers,
                  selectedItem: loaded.selectedWorkers,
                  labelBuilder: (value) => '$value',
                  onSelected: cubit.selectWorkers,
                ),
                const SizedBox(height: 24),
                FilterSection<String>(
                  title: context.l10n.placeSize,
                  items: apartmentSizes(context),
                  selectedItem: loaded.selectedSize,
                  labelBuilder: (value) => value,
                  onSelected: cubit.selectHomeSize,
                ),
                const SizedBox(height: 24),
                FilterSection<String>(
                  title: context.l10n.teamPreference,
                  items: genders(context),
                  selectedItem: loaded.selectedGender,
                  labelBuilder: (value) => value,
                  onSelected: cubit.selectWorkerGender,
                ),
              ],
            ),
          ),
          bottomSheet: StepBottomBar(
            total: cartTotal,
            onNext: () => _goToExtrasStep(context),
          ),
        );
      },
    );
  }
}
