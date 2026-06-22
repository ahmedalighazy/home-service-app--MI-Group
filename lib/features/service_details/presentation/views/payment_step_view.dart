import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../data/models/extra_item_model.dart';
import '../../data/models/payment_method.dart';
import '../../data/models/saved_card_model.dart';
import '../cubit/feature_cubit.dart';
import '../cubit/feature_state.dart';
import '../widgets/booking_steps/order_summary/summary_bottom_sheet.dart';
import '../widgets/booking_steps/payment/card_brand_badge.dart';
import '../widgets/booking_steps/payment/promo_code_field.dart';
import '../widgets/booking_steps/payment/saved_card_accordion.dart';
import '../widgets/booking_steps/payment/security_banner.dart';
import '../widgets/booking_steps/payment/step_radio_tile.dart';
import '../widgets/booking_steps/step_app_bar.dart';
import '../widgets/booking_steps/step_bottom_bar.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class PaymentStepScreen extends StatefulWidget {
  final double cartTotal;
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;
  final List<ExtraItem> selectedExtras;

  const PaymentStepScreen({
    super.key,
    required this.cartTotal,
    this.currentStep = 4,
    this.totalSteps = 4,
    this.onBack,
    this.selectedExtras = const [],
  });

  @override
  State<PaymentStepScreen> createState() => _PaymentStepScreenState();
}

class _PaymentStepScreenState extends State<PaymentStepScreen> {
  final TextEditingController _promoCtrl = TextEditingController();
  final List<SavedCard> _cards = SavedCard.savedCards;

  @override
  void dispose() {
    _promoCtrl.dispose();
    super.dispose();
  }

  void _showSummarySheet() {
    final featureCubit = context.read<FeatureCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: featureCubit,
        child: SummaryBottomSheet(
          total: widget.cartTotal,
          selectedExtras: widget.selectedExtras,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<FeatureCubit, FeatureState>(
      buildWhen: (previous, current) =>
          previous is! FeatureLoaded ||
          current is! FeatureLoaded ||
          previous.paymentMethod != current.paymentMethod ||
          previous.selectedCardIndex != current.selectedCardIndex,
      builder: (context, state) {
        final loaded = state is FeatureLoaded ? state : const FeatureLoaded();
        final cubit = context.read<FeatureCubit>();

        return Scaffold(
          backgroundColor: AppColors.scaffoldBg,
          appBar: StepAppBar(
            title: SdStrings.payment,
            currentStep: widget.currentStep,
            totalSteps: widget.totalSteps,
            onBack: widget.onBack ?? () => Navigator.maybePop(context),
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(
              size.width * 0.04,
              size.height * 0.02,
              size.width * 0.04,
              size.height * 0.18,
            ),
            children: [
              Text(
                SdStrings.methodPayment,
                style: AppText.semiBold16Black,
                textAlign: TextAlign.end,
              ),
              SizedBox(height: size.height * 0.014),
              StepRadioTile(
                label: SdStrings.paymentOnService,
                subtitle: SdStrings.afterCompletionService,
                isSelected: loaded.paymentMethod == PaymentMethod.cash,
                onTap: () => cubit.selectPaymentMethod(PaymentMethod.cash),
                leading: const Icon(
                  Icons.payments_outlined,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              StepRadioTile(
                label: 'Apple Pay',
                isSelected: loaded.paymentMethod == PaymentMethod.applePay,
                onTap: () => cubit.selectPaymentMethod(PaymentMethod.applePay),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.apple, size: 22, color: AppColors.black),
                    const SizedBox(width: 4),
                    Text(
                      'Pay',
                      style: AppText.bold14Black.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
              StepRadioTile(
                label: SdStrings.cardCreditMada,
                isSelected: loaded.paymentMethod == PaymentMethod.card,
                onTap: () => cubit.selectPaymentMethod(PaymentMethod.card),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CardBrandBadge(brand: 'VISA'),
                    SizedBox(width: 4),
                    CardBrandBadge(brand: 'MC'),
                    SizedBox(width: 4),
                    CardBrandBadge(brand: SdStrings.mada),
                  ],
                ),
              ),
              if (loaded.paymentMethod == PaymentMethod.card) ...[
                SizedBox(height: size.height * 0.018),
                SavedCardsAccordion(
                  cards: _cards,
                  selectedIndex: loaded.selectedCardIndex,
                  onSelected: cubit.selectSavedCard,
                ),
              ],
              SizedBox(height: size.height * 0.025),
              Text(
                SdStrings.text161,
                style: AppText.semiBold14Black,
                textAlign: TextAlign.end,
              ),
              SizedBox(height: size.height * 0.01),
              PromoCodeField(
                controller: _promoCtrl,
                onChanged: cubit.updatePromoCode,
              ),
              SizedBox(height: size.height * 0.025),
              const SecurityBanner(),
            ],
          ),
          bottomSheet: StepBottomBar(
            total: widget.cartTotal,
            onNext: _showSummarySheet,
          ),
        );
      },
    );
  }
}
