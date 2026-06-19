import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/helpers/spacing.dart';
import '../../../../core/utils/l10n/locale_keys.dart';
import '../../../../core/utils/l10n/localization_extension.dart';
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
          title: context.tr(LocaleKeys.homeDeepCleaning),
          category: context.tr(LocaleKeys.homeHouseCleaning),
          price: '٥٠ ${context.tr(LocaleKeys.homeCurrency)}',
        );
      },
    );
  }
}
