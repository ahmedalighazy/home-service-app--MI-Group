import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';
import 'package:home_service_app/core/widgets/custom_text_field.dart';

class AddNewCardBottomSheet extends StatefulWidget {
  const AddNewCardBottomSheet({super.key});

  @override
  State<AddNewCardBottomSheet> createState() => _AddNewCardBottomSheetState();
}

class _AddNewCardBottomSheetState extends State<AddNewCardBottomSheet> {
  bool _saveForLater = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingM.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
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
              AppStrings.addNewCard,
              style: AppText.ibmHeading20(color: AppColors.primaryText),
            ),
            verticalSpace(24),
            const CustomTextField(
              hintText: '0000 0000 0000 0000',
              label: AppStrings.cardNumberLabel,
              fillColor: AppColors.inputBg,
            ),
            verticalSpace(16),
            const CustomTextField(
              hintText: AppStrings.cardHolderPlaceholder,
              label: AppStrings.cardHolderLabel,
              fillColor: AppColors.inputBg,
            ),
            verticalSpace(16),
            Row(
              children: [
                const Expanded(
                  child: CustomTextField(
                    hintText: 'MM/YY',
                    label: AppStrings.expiryDateLabel,
                    fillColor: AppColors.inputBg,
                  ),
                ),
                horizontalSpace(16),
                Expanded(
                  child: CustomTextField(
                    hintText: '000',
                    label: AppStrings.cvvLabel,
                    fillColor: AppColors.inputBg,
                    suffixIcon: Icon(Icons.help_outline, size: 20.r, color: AppColors.textLightGrey),
                  ),
                ),
              ],
            ),
            verticalSpace(16),
            Row(
              children: [
                Checkbox(
                  value: _saveForLater,
                  onChanged: (val) => setState(() => _saveForLater = val ?? false),
                  activeColor: AppColors.primary,
                ),
                Text(
                  AppStrings.saveCardForLater,
                  style: AppText.ibmDescription14(color: AppColors.primaryText),
                ),
              ],
            ),
            verticalSpace(24),
            CustomButtom(
              onTap: () => Navigator.pop(context),
              text: AppStrings.add,
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
