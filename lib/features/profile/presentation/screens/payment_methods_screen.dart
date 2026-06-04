import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
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
      iconPath: IconsPath.visa,
    ),
    PaymentMethodModel(
      id: '2',
      cardHolderName: 'Ahmed Ibrahim',
      lastFourDigits: '5678',
      expiryDate: '09/25',
      brand: 'Mastercard',
      isDefault: false,
      iconPath: IconsPath.mastercard,
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
      backgroundColor: AppColors.backgroundGrey,
      appBar: CustomAppBar(
        title: AppStrings.paymentMethods,
        onBack: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          Expanded(
            child: _paymentMethods.isEmpty
                ? EmptyStateWidget(
                    iconPath: IconsPath.emptyPayment,
                    title: AppStrings.noSavedPaymentMethods,
                    subtitle: AppStrings.addPaymentMethodDesc,
                    buttonLabel: AppStrings.addPaymentMethodBtn,
                    onButtonPressed: _showAddCardBottomSheet,
                  )
                : ListView(
                    padding: EdgeInsets.all(AppSizes.paddingM.r),
                    children: [
                      Text(
                        AppStrings.savedCards,
                        style: AppText.ibmHeading16(color: AppColors.primaryText),
                      ),
                      verticalSpace(12),
                      ..._paymentMethods.map((method) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: PaymentCardWidget(
                          paymentMethod: method,
                          onMoreTap: () {
                            // Show options (Edit, Delete, Set as default)
                          },
                        ),
                      )),
                      verticalSpace(8),
                      TextButton.icon(
                        onPressed: _showAddCardBottomSheet,
                        icon: Icon(Icons.add, color: AppColors.primary, size: 20.r),
                        label: Text(
                          AppStrings.addNewCard,
                          style: AppText.ibmHeading14(color: AppColors.primary),
                        ),
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
          ),
          if (_paymentMethods.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(AppSizes.paddingM.r),
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderGrey),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      IconsPath.infoCircle,
                      width: 20.w,
                      height: 20.h,
                      colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    ),
                    horizontalSpace(8),
                    Expanded(
                      child: Text(
                        AppStrings.defaultPaymentNotice,
                        style: AppText.ibmDescription12(color: AppColors.textLightGrey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
