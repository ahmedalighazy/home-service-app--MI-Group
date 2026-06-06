import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/widgets/empty_state_widget.dart';
import 'package:home_service_app/features/profile/data/models/payment_method_model.dart';
import 'package:home_service_app/features/profile/presentation/widgets/add_new_card_bottom_sheet.dart';
import 'package:home_service_app/features/profile/presentation/widgets/payment_card_widget.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  // Mock data
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

  void _showAddCardBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddNewCardBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.white, // Screen usually has white background in MI apps
      appBar: CustomAppBar(
        title: AppStrings.paymentMethods,
        onBack: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          Expanded(
            child: _paymentMethods.isEmpty
                ? EmptyStateWidget(
                    iconPath: IconsPath.wallet05Svg,
                    title: AppStrings.noSavedPaymentMethods,
                    subtitle: AppStrings.addPaymentMethodDesc,
                    buttonLabel: AppStrings.addPaymentMethodBtn,
                    onButtonPressed: _showAddCardBottomSheet,
                  )
                : ListView(
                    padding: EdgeInsets.all(16.r),
                    children: [
                      ..._paymentMethods.map(
                        (method) => Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: PaymentCardWidget(
                            paymentMethod: method,
                            onMoreTap: () {
                              // Show options (Edit, Delete, Set as default)
                            },
                          ),
                        ),
                      ),
                      verticalSpace(16),
                      _buildAddCardButton(),
                    ],
                  ),
          ),
          if (_paymentMethods.isNotEmpty) _buildFooterInfo(),
        ],
      ),
    );
  }

  Widget _buildAddCardButton() {
    return InkWell(
      onTap: _showAddCardBottomSheet,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            style: BorderStyle
                .solid, // Should be dashed, but using solid with low opacity for now
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.addNewCard,
              style: AppText.ibmHeading16(color: AppColors.primary),
            ),
            horizontalSpace(8),
            Icon(Icons.add, color: AppColors.primary, size: 24.r),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterInfo() {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6), // Light grey from image
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: AppColors.textLightGrey,
              size: 24.r,
            ),
            horizontalSpace(12),

            Expanded(
              child: Text(
                AppStrings.defaultPaymentNotice,
                style: AppText.ibmDescription14(
                  color: AppColors.textLightGrey,
                ).copyWith(height: 1.5),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
