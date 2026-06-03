import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/utils/helpers/spacing.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../widgets/empty_favorites_view.dart';
import '../widgets/favorite_item_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool hasFavorites = MediaQuery.of(context).size.width > 0;

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: const CustomAppBar(title: AppStrings.favorites),
      body: SafeArea(
        child: hasFavorites
            ? _buildFavoritesList()
            : const EmptyFavoritesView(),
      ),
    );
  }

  Widget _buildFavoritesList() {
    return ListView.separated(
      padding: EdgeInsets.all(16.r),
      itemCount: 3,
      separatorBuilder: (context, index) => verticalSpace(12),
      itemBuilder: (context, index) {
        return const FavoriteItemCard(
          title: AppStrings.deepCleaning,
          category: AppStrings.houseCleaning,
          price: '٥٠ ${AppStrings.currency}',
        );
      },
    );
  }
}
