import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

class FavoriteItemCard extends StatelessWidget {
  final String title;
  final String category;
  final String price;

  const FavoriteItemCard({
    super.key,
    required this.title,
    required this.category,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingSmall.r),
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.borderCards),
          borderRadius: BorderRadius.circular(AppSizes.radiusM.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItemImage(),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppText.mediumIbm(
                    color: AppColors.primaryText,
                    fontSize: 14.sp,
                  ),
                ),
                verticalSpace(4),
                Text(
                  category,
                  style: AppText.regularIbm(
                    color: AppColors.secondaryText,
                    fontSize: 14.sp,
                  ),
                ),
                verticalSpace(8),
                Text(
                  price,
                  style:
                      AppText.mediumIbm(
                        color: AppColors.primaryText,
                        fontSize: 14,
                      ).copyWith(
                        height: 1.40,

                        shadows: [
                          Shadow(
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                            color: const Color(
                              0xFF000000,
                            ).withValues(alpha: 0.25),
                          ),
                        ],
                      ),
                ),
              ],
            ),
          ),
          _buildFavoriteButton(),
        ],
      ),
    );
  }

  Widget _buildItemImage() {
    return Container(
      width: 72.w,
      height: 72.h,
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium.r),
      ),
      child: Icon(
        Icons.cleaning_services_outlined,
        color: AppColors.primary,
        size: 30.r,
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Icon(Icons.favorite, color: AppColors.red, size: 16.r),
    );
  }
}
