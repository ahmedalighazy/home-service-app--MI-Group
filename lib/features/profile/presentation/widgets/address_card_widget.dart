import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Default Badge (Positioned Top Left)
          if (address.isDefault)
            Positioned(
              left: 12.w,
              top: 12.h,
              child: _DefaultBadge(),
            ),

          // Main Content (Right Aligned)
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Title and Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      address.label,
                      style: AppText.ibmHeading16(color: AppColors.black),
                    ),
                    horizontalSpace(8),
                    SvgPicture.asset(
                      address.iconPath,
                      width: 24.r,
                      height: 24.r,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                verticalSpace(8),
                // Address Details
                Text(
                  address.details,
                  style: AppText.ibmDescription14(color: AppColors.textLightGrey),
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(12),
                // Action Buttons (Edit/Delete)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _ActionButton(
                      label: 'حذف',
                      icon: IconsPath.trashOutline,
                      color: AppColors.red,
                      onTap: onDelete,
                    ),
                    horizontalSpace(16),
                    _ActionButton(
                      label: 'تعديل',
                      icon: IconsPath.editOutline,
                      color: AppColors.primary,
                      onTap: onEdit,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF53AABF),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        'افتراضي',
        style: AppText.semiBoldIbm(color: AppColors.white, fontSize: 13),
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppText.regularIbm(color: color, fontSize: 13),
          ),
          horizontalSpace(4),
          SvgPicture.asset(
            icon,
            width: 16.r,
            height: 16.r,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}
