import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/features/favorites/data/models/favorite_responses.dart';
import 'package:home_service_app/features/favorites/logic/favorites_cubit.dart';

class FavoriteItemCard extends StatelessWidget {
  final Content item;

  const FavoriteItemCard({
    super.key,
    required this.item,
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
                  item.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.mediumIbm(
                    color: AppColors.primaryText,
                    fontSize: 14.sp,
                  ),
                ),
                verticalSpace(4),
                Text(
                  item.categoryName ?? '',
                  style: AppText.regularIbm(
                    color: AppColors.secondaryText,
                    fontSize: 14.sp,
                  ),
                ),
                verticalSpace(8),
                Text(
                  '${item.price ?? 0} ${context.tr(LocaleKeys.currency)}',
                  style: AppText.mediumIbm(
                    color: AppColors.primaryText,
                    fontSize: 14,
                  ).copyWith(
                    height: 1.40,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                        color: const Color(0xFF000000).withValues(alpha: 0.25),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildFavoriteButton(context),
        ],
      ),
    );
  }

  Widget _buildItemImage() {
    final imageUrl = (item.imageUrls != null && item.imageUrls!.isNotEmpty)
        ? item.imageUrls!.first
        : null;

    return Container(
      width: 72.w,
      height: 72.h,
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium.r),
        child: imageUrl != null && imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildFallbackIcon(),
              )
            : _buildFallbackIcon(),
      ),
    );
  }

  Widget _buildFallbackIcon() {
    return Icon(
      Icons.cleaning_services_outlined,
      color: AppColors.primary,
      size: 30.r,
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.id != null) {
          context.read<FavoritesCubit>().removeFavorite(item.id!);
        }
      },
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderGrey),
        ),
        child: Icon(Icons.favorite, color: AppColors.red, size: 16.r),
      ),
    );
  }
}
