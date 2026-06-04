import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/features/profile/data/models/address_model.dart';

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
      padding: EdgeInsets.all(AppSizes.paddingM.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusM.r),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: const BoxDecoration(
              color: AppColors.inputBg,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              address.iconPath,
              width: 24.w,
              height: 24.h,
              colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      address.label,
                      style: AppText.ibmHeading16(color: AppColors.primaryText),
                    ),
                    if (address.isDefault) ...[
                      horizontalSpace(8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColors.badgeBlue,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'افتراضي',
                          style: AppText.ibmDescription10(color: AppColors.white),
                        ),
                      ),
                    ],
                  ],
                ),
                verticalSpace(4),
                Text(
                  address.details,
                  style: AppText.ibmDescription12(color: AppColors.textLightGrey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: onEdit,
                child: SvgPicture.asset(
                  IconsPath.editOutline,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
              verticalSpace(12),
              GestureDetector(
                onTap: onDelete,
                child: SvgPicture.asset(
                  IconsPath.trashOutline,
                  width: 20.w,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(AppColors.red, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
