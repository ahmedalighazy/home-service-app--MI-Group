import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/widgets/empty_state_widget.dart';
import 'package:home_service_app/features/profile/data/models/payment_method_model.dart';

import '../../../../core/constants/icons_path.dart';
import '../widgets/add_card_button_widget.dart';
import '../widgets/payment_card_widget.dart';
import '../widgets/payment_footer_info_widget.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<PaymentMethodModel> _paymentMethods = [
    PaymentMethodModel(
      id: '1',
      cardHolderName: 'Ahmed Ibrahim',
      lastFourDigits: '1234',
      expiryDate: '12/26',
      brand: 'Visa',
      isDefault: true,
      iconPath: IconsPath.visaCard,
    ),
    PaymentMethodModel(
      id: '2',
      cardHolderName: 'Ahmed Ibrahim',
      lastFourDigits: '5678',
      expiryDate: '09/25',
      brand: 'Mastercard',
      isDefault: false,
      iconPath: IconsPath.logosMastercardSvg,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.paymentMethods,
        onBack: () => context.pop(),
      ),
      body: Column(
        children: [
          Expanded(
            child: _paymentMethods.isEmpty
                ? const EmptyStateWidget(
                    iconPath: IconsPath.wallet05Svg,
                    title: AppStrings.noSavedPaymentMethods,
                    subtitle: AppStrings.addPaymentMethodDesc,
                    buttonLabel: AppStrings.addPaymentMethodBtn,
                    // onButtonPressed: _showAddCardBottomSheet,
                  )
                : ListView(
                    padding: EdgeInsets.all(16.r),
                    children: [
                      ..._paymentMethods.map(
                        (method) => Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: PaymentCardWidget(
                            paymentMethod: method,
                            onMoreTap: () {},
                          ),
                        ),
                      ),
                      verticalSpace(16),
                      const AddCardButtonWidget(),
                    ],
                  ),
          ),
          if (_paymentMethods.isNotEmpty) const PaymentFooterInfoWidget(),
        ],
      ),
    );
  }
}
