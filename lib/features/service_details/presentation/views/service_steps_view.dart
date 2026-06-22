import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/features/service_details/presentation/views/payment_step_view.dart';
import 'package:home_service_app/features/service_details/presentation/views/repeat_type_selector_view.dart';
import 'package:home_service_app/features/service_details/presentation/views/worker_filter_view.dart';

import '../../data/models/service_step_model.dart';
import '../cubit/feature_cubit.dart';
import '../cubit/feature_state.dart';
import '../widgets/booking_steps/step_app_bar.dart';
import '../widgets/booking_steps/step_bottom_bar.dart';
import 'address_step_view.dart';
import 'date_time_step_view.dart';
import 'extras_step_view.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

enum ServiceType { homeClean, deepClean }

class ServiceStepsScreen extends StatefulWidget {
  final ServiceType serviceType;

  const ServiceStepsScreen({super.key, required this.serviceType});

  @override
  State<ServiceStepsScreen> createState() => _ServiceStepsScreenState();
}

class _ServiceStepsScreenState extends State<ServiceStepsScreen> {
  static const double _initialCartTotal = 100;

  late final List<ServiceStepModel> steps;

  @override
  void initState() {
    super.initState();
    context.read<FeatureCubit>().resetBookingStepProgress();
    steps = _buildSteps();
  }

  List<ServiceStepModel> _buildSteps() {
    return switch (widget.serviceType) {
      ServiceType.deepClean => _buildDeepCleanSteps(),
      ServiceType.homeClean => _buildHomeCleanSteps(),
    };
  }

  List<ServiceStepModel> _buildDeepCleanSteps() {
    const totalSteps = 4;

    return [
      ServiceStepModel(
        title: SdStrings.extras,
        content: ExtrasStepScreen(
          cartTotal: _initialCartTotal,
          currentStep: 1,
          totalSteps: totalSteps,
          onBack: previousStep,
        ),
      ),
      ServiceStepModel(
        title: SdStrings.dateTime,
        content: DateTimeStepScreen(
          cartTotal: _initialCartTotal,
          currentStep: 2,
          totalSteps: totalSteps,
          onBack: previousStep,
        ),
      ),
      ServiceStepModel(
        title: SdStrings.text51,
        content: AddressStepScreen(
          cartTotal: _initialCartTotal,
          currentStep: 3,
          totalSteps: totalSteps,
          onBack: previousStep,
        ),
      ),
      ServiceStepModel(
        title: SdStrings.payment,
        content: PaymentStepScreen(
          cartTotal: _initialCartTotal,
          currentStep: 4,
          totalSteps: totalSteps,
          onBack: previousStep,
        ),
      ),
    ];
  }

  List<ServiceStepModel> _buildHomeCleanSteps() {
    const totalSteps = 6;

    return [
      ServiceStepModel(
        title: SdStrings.cleaningHome,
        content: WorkerFilterCard(
          cartTotal: _initialCartTotal,
          currentStep: 1,
          totalSteps: totalSteps,
          onBack: previousStep,
        ),
      ),
      ServiceStepModel(
        title: SdStrings.extras,
        content: ExtrasStepScreen(
          cartTotal: _initialCartTotal,
          currentStep: 2,
          totalSteps: totalSteps,
          showRepeatStep: true,
          onBack: previousStep,
        ),
      ),
      ServiceStepModel(
        title: SdStrings.repeatService,
        content: RepeatTypeSelector(
          cartTotal: _initialCartTotal,
          currentStep: 3,
          totalSteps: totalSteps,
          onBack: previousStep,
        ),
      ),
      ServiceStepModel(
        title: SdStrings.dateTime,
        content: DateTimeStepScreen(
          cartTotal: _initialCartTotal,
          currentStep: 4,
          totalSteps: totalSteps,
          onBack: previousStep,
        ),
      ),
      ServiceStepModel(
        title: SdStrings.text51,
        content: AddressStepScreen(
          cartTotal: _initialCartTotal,
          currentStep: 5,
          totalSteps: totalSteps,
          onBack: previousStep,
        ),
      ),
      ServiceStepModel(
        title: SdStrings.payment,
        content: PaymentStepScreen(
          cartTotal: _initialCartTotal,
          currentStep: 6,
          totalSteps: totalSteps,
          onBack: previousStep,
        ),
      ),
    ];
  }

  void nextStep() {
    context.read<FeatureCubit>().nextBookingStep(steps.length - 1);
  }

  void previousStep() {
    final currentIndex = context
        .read<FeatureCubit>()
        .loadedState
        .bookingStepIndex;
    if (currentIndex == 0) {
      Navigator.of(context).pop();
      return;
    }

    context.read<FeatureCubit>().previousBookingStep();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FeatureCubit, FeatureState, int>(
      selector: (state) => state is FeatureLoaded ? state.bookingStepIndex : 0,
      builder: (context, currentIndex) {
        final safeIndex = currentIndex.clamp(0, steps.length - 1);
        final currentStep = steps[safeIndex];

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: StepAppBar(
            title: currentStep.title,
            currentStep: safeIndex + 1,
            totalSteps: steps.length,
            onBack: previousStep,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            child: currentStep.content,
          ),
          bottomSheet: StepBottomBar(
            total: _initialCartTotal,
            nextLabel: currentStep.nextLabel,
            onNext: nextStep,
          ),
        );
      },
    );
  }
}
