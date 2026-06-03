import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/helpers/spacing.dart';

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
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
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
                    fontSize: 14,
                  ),
                ),
                verticalSpace(4),
                Text(
                  category,
                  style: AppText.regularIbm(
                    color: AppColors.secondaryText,
                    fontSize: 14,
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
                            color: const Color(0xFF000000).withOpacity(0.25),
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
    return Stack(
      children: [
        Container(
          width: 72.w,
          height: 69.h,
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(12.r),
          ),
          // In a real app, use Image.network or Image.asset
          child: Icon(
            Icons.cleaning_services,
            color: AppColors.primary,
            size: 30.r,
          ),
        ),
        Positioned(
          top: 0,
          left:
              0, // Assuming LTR for stack, but in Arabic it might be different depending on layout
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            child: Text(
              '%',
              style: AppText.regularIbm(
                color: AppColors.softWhite,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteButton() {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Icon(Icons.favorite, color: AppColors.redDanger, size: 16.r),
    );
  }
}
