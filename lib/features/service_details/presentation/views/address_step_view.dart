import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/service_details/presentation/views/payment_step_view.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../data/models/address_model.dart';
import '../../data/models/extra_item_model.dart';
import '../cubit/feature_cubit.dart';
import '../cubit/feature_state.dart';
import '../widgets/booking_steps/address/address_card.dart';
import '../widgets/booking_steps/address/step_text_field.dart';
import '../widgets/booking_steps/step_app_bar.dart';
import '../widgets/booking_steps/step_bottom_bar.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class AddressStepScreen extends StatelessWidget {
  final double cartTotal;
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;
  final List<ExtraItem> selectedExtras;

  const AddressStepScreen({
    super.key,
    required this.cartTotal,
    this.currentStep = 3,
    this.totalSteps = 4,
    this.onBack,
    this.selectedExtras = const [],
  });

  void _goToPaymentStep(BuildContext context) {
    final featureCubit = context.read<FeatureCubit>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: featureCubit,
          child: PaymentStepScreen(
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
    final addresses = AddressModel.savedAddresses;

    return BlocSelector<FeatureCubit, FeatureState, int>(
      selector: (state) =>
          state is FeatureLoaded ? state.selectedAddressIndex : 0,
      builder: (context, selectedIndex) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBg,
          appBar: StepAppBar(
            title: SdStrings.text51,
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
              Text(
                SdStrings.savedAddressesTitle,
                style: AppText.semiBold16Black,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: size.height * 0.016),
              ...addresses.asMap().entries.map(
                (entry) => Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.012),
                  child: AddressCard(
                    address: entry.value,
                    isSelected: entry.key == selectedIndex,
                    onTap: () =>
                        context.read<FeatureCubit>().selectAddress(entry.key),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    SdStrings.addNewAddress,
                    style: AppText.semiBold14Black.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.028),
              StepTextField(
                label: SdStrings.notesOptional,
                hint: SdStrings.exampleHomeFrontMosque,
                maxLines: 4,
                maxLength: 300,
              ),
            ],
          ),
          bottomSheet: StepBottomBar(
            total: cartTotal,
            onNext: () => _goToPaymentStep(context),
          ),
        );
      },
    );
  }
}
