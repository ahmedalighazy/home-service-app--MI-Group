import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../data/models/service_page_model.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';


class ServiceItemInfo extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final ServicePageItemModel item;

  const ServiceItemInfo({
    super.key,
    required this.item,
    required this.onFavoritePressed,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                item.title,
                style: AppText.semiBold14Black,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            SizedBox(width: size.width * 0.015),
            IconButton(
              onPressed: onFavoritePressed,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : AppColors.body,
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.005),
        Text(
          item.description,
          style: AppText.regular12Grey,
          textAlign: TextAlign.end,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: size.height * 0.005),
        Text(
          '${item.price.toStringAsFixed(0)} ${AppStrings.riyalQar}',
          style: AppText.bold12Black,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}


