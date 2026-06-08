import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/service_details/presentation/views/repeat_type_selector_view.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../data/models/extra_item_model.dart';
import '../cubit/feature_cubit.dart';
import '../cubit/feature_state.dart';
import '../widgets/booking_steps/extras/extra_card.dart';
import '../widgets/booking_steps/extras/worker_promo_card.dart';
import '../widgets/booking_steps/step_app_bar.dart';
import '../widgets/booking_steps/step_bottom_bar.dart';
import 'date_time_step_view.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';



class ExtrasStepScreen extends StatelessWidget {
  final double cartTotal;
  final int currentStep;
  final int totalSteps;
  final bool showRepeatStep;
  final VoidCallback? onBack;

  const ExtrasStepScreen({
    super.key,
    required this.cartTotal,
    this.currentStep = 1,
    this.totalSteps = 4,
    this.showRepeatStep = false,
    this.onBack,
  });

  void _goToNextStep(BuildContext context, FeatureLoaded state) {
    final featureCubit = context.read<FeatureCubit>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: featureCubit,
          child: _buildNextStep(state),
        ),
      ),
    );
  }

  Widget _buildNextStep(FeatureLoaded state) {
    final grandTotal = state.bookingTotal(cartTotal);

    if (showRepeatStep) {
      return RepeatTypeSelector(
        cartTotal: grandTotal,
        currentStep: currentStep + 1,
        totalSteps: totalSteps,
        selectedExtras: state.selectedExtras,
      );
    }

    return DateTimeStepScreen(
      cartTotal: grandTotal,
      currentStep: currentStep + 1,
      totalSteps: totalSteps,
      selectedExtras: state.selectedExtras,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<FeatureCubit, FeatureState>(
      buildWhen: (previous, current) =>
          previous is! FeatureLoaded ||
          current is! FeatureLoaded ||
          previous.extraQuantities != current.extraQuantities,
      builder: (context, state) {
        final loaded = state is FeatureLoaded ? state : const FeatureLoaded();
        final extras = ExtraItem.catalogue;

        return Scaffold(
          backgroundColor: AppColors.scaffoldBg,
          appBar: StepAppBar(
            title: AppStrings.extras2,
            currentStep: currentStep,
            totalSteps: totalSteps,
            onBack: onBack ?? () => Navigator.maybePop(context),
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(
              size.width * 0.04,
              size.height * 0.02,
              size.width * 0.04,
              size.height * 0.16,
            ),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: extras
                    .map(
                      (item) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.015,
                          ),
                          child: ExtraCard(
                            item: item,
                            quantity: loaded.extraQuantity(item.title),
                            onIncrement: () => context
                                .read<FeatureCubit>()
                                .incrementExtra(item.title),
                            onDecrement: () => context
                                .read<FeatureCubit>()
                                .decrementExtra(item.title),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: size.height * 0.028),
              const WorkerPromoCard(),
            ],
          ),
          bottomSheet: StepBottomBar(
            total: loaded.bookingTotal(cartTotal),
            onNext: () => _goToNextStep(context, loaded),
          ),
        );
      },
    );
  }
}

