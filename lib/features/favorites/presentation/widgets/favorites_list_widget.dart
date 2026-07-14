import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/features/favorites/data/models/favorite_responses.dart';
import 'favorite_item_card.dart';

class FavoritesListWidget extends StatelessWidget {
  final List<Content> items;

  const FavoritesListWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16.r),
      itemCount: items.length,
      separatorBuilder: (context, index) => verticalSpace(12),
      itemBuilder: (context, index) {
        return FavoriteItemCard(
          item: items[index],
        );
      },
    );
  }
}
