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
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: const Color(0xFFF8FBFF) /* bg-secondary */,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFF1F5F9) /* border-cards */,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Default Badge (Positioned Top Left)
          Row(
            // mainAxisAlignment: MainAxisAlignment.end,
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

              Text(
                address.label,
                style: AppText.ibmHeading16(color: AppColors.black),
              ),

              const Spacer(),
              if (address.isDefault) _DefaultBadge(),
            ],
          ),

          // Main Content (Right Aligned)

          // Title and Icon
          verticalSpace(8),
          // Address Details
          Align(
            alignment: AlignmentGeometry.bottomRight,
            child: Text(
              address.details,
              style: AppText.ibmDescription14(color: AppColors.textLightGrey),
              // textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          verticalSpace(12),
          // Action Buttons (Edit/Delete)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _ActionButton(
                label: 'تعديل',
                icon: IconsPath.editLocation,
                color: AppColors.primary,
                onTap: onEdit,
              ),
              horizontalSpace(16),

              _ActionButton(
                label: 'حذف',
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
    );
  }
}
