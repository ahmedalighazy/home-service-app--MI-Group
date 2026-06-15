import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/widgets/empty_state_widget.dart';
import 'package:home_service_app/features/profile/data/models/payment_method_model.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import '../../../../core/utils/helpers/show_dialog.dart';
import '../widgets/add_card_button_widget.dart';
import '../widgets/payment_card_widget.dart';
import '../widgets/payment_footer_info_widget.dart';
import '../widgets/add_new_card_bottom_sheet.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  void _onAddPaymentMethod() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (_) => const AddNewCardBottomSheet(),
    );
  }

  void _onEditPaymentMethod(PaymentMethodModel method) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (_) =>
          AddNewCardBottomSheet(paymentMethod: method, isEdit: true),
    );
  }

  void _onDeletePaymentMethod(PaymentMethodModel method) {
    showCannotDeleteDialogred(
      context,
      context.tr(LocaleKeys.profileDeleteCardTitle),
      context.tr(LocaleKeys.profileDeleteCardWarning),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<PaymentMethodModel> paymentMethods = [
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

    return Scaffold(
      appBar: CustomAppBar(
        title: context.tr(LocaleKeys.profilePaymentMethods),
        onBack: () => context.pop(),
      ),
      body: Column(
        children: [
          Expanded(
            child: paymentMethods.isEmpty
                ? EmptyStateWidget(
                    iconPath: IconsPath.wallet05Svg,
                    title: context.tr(LocaleKeys.profileNoSavedPaymentMethods),
                    subtitle: context.tr(
                      LocaleKeys.profileAddPaymentMethodDesc,
                    ),
                    buttonLabel: context.tr(
                      LocaleKeys.profileAddPaymentMethodBtn,
                    ),
                    onButtonPressed: _onAddPaymentMethod,
                  )
                : ListView(
                    padding: EdgeInsets.all(AppSizes.padding.r),
                    children: [
                      ...paymentMethods.map(
                        (method) => Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: PaymentCardWidget(
                            paymentMethod: method,
                            onEdit: () => _onEditPaymentMethod(method),
                            onDelete: () => _onDeletePaymentMethod(method),
                          ),
                        ),
                      ),
                      verticalSpace(16),
                      AddCardButtonWidget(onTap: _onAddPaymentMethod),
                    ],
                  ),
          ),
          if (paymentMethods.isNotEmpty) const PaymentFooterInfoWidget(),
        ],
      ),
    );
  }
}
