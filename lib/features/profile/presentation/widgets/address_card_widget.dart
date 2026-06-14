import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/profile/data/models/address_model.dart';

import '../../../../core/constants/icons_path.dart';

class AddressCardWidget extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AddressCardWidget({
    super.key,
    required this.address,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.paddingSmall.r),
      decoration: ShapeDecoration(
        color: AppColors.bgSecondary,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.borderCards),
          borderRadius: BorderRadius.circular(AppSizes.radiusM.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                address.iconPath,
                width: 24.r,
                height: 24.r,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              horizontalSpace(8),
              Expanded(
                child: Text(
                  address.label,
                  style: AppText.ibmHeading16(color: AppColors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (address.isDefault) const _DefaultBadge(),
            ],
          ),
          verticalSpace(8),
          Text(
            address.details,
            style: AppText.ibmDescription14(color: AppColors.textLightGrey),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace(12),
          Row(
            children: [
              _ActionButton(
                label: AppStrings.edit,
                icon: IconsPath.editLocation,
                color: AppColors.primary,
                onTap: onEdit,
              ),
              horizontalSpace(16),
              _ActionButton(
                label: AppStrings.delete,
                icon: IconsPath.delete,
                color: AppColors.red,
                onTap: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DefaultBadge extends StatelessWidget {
  const _DefaultBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.badgeCyan,
        borderRadius: BorderRadius.circular(AppSizes.radiusXL.r),
      ),
      child: Text(
        AppStrings.defaultText,
        style: AppText.semiBoldIbm(color: AppColors.white, fontSize: 13.sp),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final String icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusSmall.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              width: 17.r,
              height: 17.r,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            horizontalSpace(4),

            Text(label, style: AppText.regularIbm(color: color, fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
