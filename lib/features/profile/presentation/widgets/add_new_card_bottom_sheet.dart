import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';
import 'package:home_service_app/core/widgets/custom_text_field.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import 'package:home_service_app/features/profile/data/models/payment_method_model.dart';

class AddNewCardBottomSheet extends StatefulWidget {
  final PaymentMethodModel? paymentMethod;
  final bool isEdit;

  const AddNewCardBottomSheet({
    super.key,
    this.paymentMethod,
    this.isEdit = false,
  });

  @override
  State<AddNewCardBottomSheet> createState() => _AddNewCardBottomSheetState();
}

class _AddNewCardBottomSheetState extends State<AddNewCardBottomSheet> {
  bool _saveForLater = false;
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _cvvController = TextEditingController();
  final _expiryDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.paymentMethod != null) {
      _cardNumberController.text = '**** **** **** ${widget.paymentMethod!.lastFourDigits}';
      _cardHolderController.text = widget.paymentMethod!.cardHolderName;
      _expiryDateController.text = widget.paymentMethod!.expiryDate;
    }
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _cvvController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingM.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLarge)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.borderGrey,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            verticalSpace(24),
            Text(
              widget.isEdit
                  ? context.tr(LocaleKeys.profileEditCard)
                  : context.tr(LocaleKeys.profileAddCard),
              style: AppText.ibmHeading20(color: AppColors.black),
            ),
            verticalSpace(24),
            CustomTextField(
              controller: _cardNumberController,
              hintText: '0000 0000 0000 0000',
              label: context.tr(LocaleKeys.profileCardNumberLabel),
              fillColor: AppColors.white,
              textStyle: AppText.regularIbm(
                color: AppColors.primaryText,
                fontSize: 14,
              ),
              borderColor: AppColors.textLightGrey,
              keyboardType: TextInputType.number,
            ),
            verticalSpace(16),
            CustomTextField(
              controller: _cardHolderController,
              hintText: context.tr(LocaleKeys.profileCardHolderPlaceholder),
              label: context.tr(LocaleKeys.profileCardHolderLabel),
              fillColor: AppColors.white,
              borderColor: AppColors.textLightGrey,
              textStyle: AppText.regularIbm(
                color: AppColors.primaryText,
                fontSize: 14,
              ),
            ),
            verticalSpace(16),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _cvvController,
                    hintText: '000',
                    label: context.tr(LocaleKeys.profileCvvLabel),
                    fillColor: AppColors.white,
                    borderColor: AppColors.textLightGrey,
                    textStyle: AppText.regularIbm(
                      color: AppColors.primaryText,
                      fontSize: 14,
                    ),
                    keyboardType: TextInputType.number,
                    suffixIcon: Icon(
                      Icons.help_outline,
                      size: 20.r,
                      color: AppColors.textLightGrey,
                    ),
                  ),
                ),
                horizontalSpace(16),
                Expanded(
                  child: CustomTextField(
                    controller: _expiryDateController,
                    hintText: 'MM/YY',
                    textStyle: AppText.regularIbm(
                      color: AppColors.primaryText,
                      fontSize: 14,
                    ),
                    label: context.tr(LocaleKeys.profileCardExpiryDateLabel),
                    fillColor: AppColors.white,
                    borderColor: AppColors.textLightGrey,
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ],
            ),
            verticalSpace(16),
            Row(
              children: [
                Checkbox(
                  value: _saveForLater,
                  onChanged: (val) =>
                      setState(() => _saveForLater = val ?? false),
                  activeColor: AppColors.primary,
                ),
                Text(
                  context.tr(LocaleKeys.profileSaveCardForLater),
                  style: AppText.ibmDescription14(color: AppColors.primaryText),
                ),
              ],
            ),
            verticalSpace(24),
            CustomButtom(
              onTap: () => context.pop(),
              text: context.tr(LocaleKeys.profileSave),
              textStyle: AppText.ibmButton16(),
              startColor: AppColors.primary,
              endColor: AppColors.primaryActive,
            ),
            verticalSpace(16),
          ],
        ),
      ),
    );
  }
}
