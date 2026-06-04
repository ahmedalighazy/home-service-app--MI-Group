import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class DeleteAddressDialog extends StatelessWidget {
  final bool isDefault;
  final VoidCallback onDelete;

  const DeleteAddressDialog({
    super.key,
    required this.isDefault,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingL.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: const BoxDecoration(
                color: Color(0xFFFEE2E2),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                IconsPath.trashOutline,
                width: 32.w,
                height: 32.h,
                colorFilter: const ColorFilter.mode(AppColors.red, BlendMode.srcIn),
              ),
            ),
            verticalSpace(20),
            Text(
              AppStrings.deleteAddressTitle,
              style: AppText.ibmHeading20(color: AppColors.primaryText),
            ),
            if (isDefault) ...[
              verticalSpace(8),
              Text(
                AppStrings.deleteDefaultAddressDesc,
                textAlign: TextAlign.center,
                style: AppText.ibmDescription14(color: AppColors.textLightGrey),
              ),
            ],
            verticalSpace(32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.borderGrey),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      AppStrings.cancelBtn,
                      style: AppText.ibmButton16(color: AppColors.primaryText),
                    ),
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      onDelete();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      AppStrings.deleteConfirmWord,
                      style: AppText.ibmButton16(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
