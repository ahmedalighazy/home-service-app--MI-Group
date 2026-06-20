import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';

import '../../data/models/extra_item_model.dart';
import '../../data/models/repeat_type.dart';
import '../cubit/feature_cubit.dart';
import '../cubit/feature_state.dart';
import '../widgets/booking_steps/frequency/repeat_option.dart';
import '../widgets/booking_steps/frequency/repeat_option_card.dart';
import '../widgets/booking_steps/step_app_bar.dart';
import '../widgets/booking_steps/step_bottom_bar.dart';
import 'date_time_step_view.dart';

class RepeatTypeSelector extends StatelessWidget {
  final double cartTotal;
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;
  final List<ExtraItem> selectedExtras;

  const RepeatTypeSelector({
    super.key,
    required this.cartTotal,
    this.currentStep = 3,
    this.totalSteps = 6,
    this.onBack,
    this.selectedExtras = const [],
  });

  List<RepeatOption> _options(BuildContext context) {
    return [
      RepeatOption(type: RepeatType.once, title: context.l10n.once),
      RepeatOption(
        type: RepeatType.twoWeeks,
        title: context.l10n.twoWeeks,
        discount: context.l10n.sevenPercentDiscount,
        recommended: true,
      ),
      RepeatOption(
        type: RepeatType.weekly,
        title: context.l10n.weekly,
        discount: context.l10n.discountUpToTwelvePercent,
      ),
      RepeatOption(
        type: RepeatType.multipleTimes,
        title: context.l10n.countTimesInWeek,
        discount: context.l10n.discountUpToTwentyFivePercent,
      ),
    ];
  }

  void _goToDateTimeStep(BuildContext context) {
    final featureCubit = context.read<FeatureCubit>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: featureCubit,
          child: DateTimeStepScreen(
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
    return BlocSelector<FeatureCubit, FeatureState, RepeatType>(
      selector: (state) =>
          state is FeatureLoaded ? state.repeatType : RepeatType.once,
      builder: (context, repeatType) {
        final cubit = context.read<FeatureCubit>();

        return Scaffold(
          appBar: StepAppBar(
            title: context.l10n.serviceFrequency,
            currentStep: currentStep,
            totalSteps: totalSteps,
            onBack: onBack ?? () => Navigator.maybePop(context),
          ),
          body: Column(
            children: _options(context).map((option) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: RepeatOptionCard(
                  option: option,
                  isSelected: repeatType == option.type,
                  onTap: () => cubit.selectRepeatType(option.type),
                ),
              );
            }).toList(),
          ),
          bottomSheet: StepBottomBar(
            total: cartTotal,
            onNext: () => _goToDateTimeStep(context),
          ),
        );
      },
    );
  }
}
