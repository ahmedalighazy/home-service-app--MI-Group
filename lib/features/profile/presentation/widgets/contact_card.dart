import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class ContactCard extends StatelessWidget {
  final String title;
  final String value;
  final String icon;
  final VoidCallback onCopy;

  const ContactCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusM.r),
        border: Border.all(color: AppColors.borderGrey.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              icon,
              width: 17.w,
              height: 17.h,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 5.w),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppText.ibmHeading14(color: AppColors.black)),
              SizedBox(height: 4.h),
              Text(
                value,
                style: AppText.ibmDescription14(
                  color: AppColors.textLightGrey,
                ).copyWith(overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const Spacer(),

          _CopyButton(onCopy: onCopy),
        ],
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  final VoidCallback onCopy;

  const _CopyButton({required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCopy,
      borderRadius: BorderRadius.circular(AppSizes.radiusSmall.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall.r),
        ),
        child: Row(
          children: [
            Text(
              context.l10n.copy,
              style: AppText.ibmDescription12(color: AppColors.primary),
            ),
            SizedBox(width: 4.w),
            SvgPicture.asset(
              IconsPath.copy,
              width: 14.w,
              height: 14.w,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
