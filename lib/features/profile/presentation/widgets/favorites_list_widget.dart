import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import '../../../../core/utils/helpers/spacing.dart';
import 'favorite_item_card.dart';

class FavoritesListWidget extends StatelessWidget {
  const FavoritesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16.r),
      itemCount: 3,
      separatorBuilder: (context, index) => verticalSpace(12),
      itemBuilder: (context, index) {
        return FavoriteItemCard(
          title: context.l10n.deepCleaning,
          category: context.l10n.houseCleaning,
          price: '٥٠ ${context.l10n.currency}',
        );
      },
    );
  }
}
