import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_steps/payment/saved_card_tile.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import '../../../../data/models/saved_card_model.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class SavedCardsAccordion extends StatelessWidget {
  final List<SavedCard> cards;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const SavedCardsAccordion({
    super.key,
    required this.cards,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.012,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: AppColors.body,
                  size: 20,
                ),
                Text(SdStrings.cardsSaved, style: AppText.semiBold14Black),
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.border),

          ...cards.asMap().entries.map(
            (entry) => SavedCardTile(
              card: entry.value,
              isSelected: entry.key == selectedIndex,
              onTap: () => onSelected(entry.key),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.012,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  SdStrings.addCard,
                  style: AppText.semiBold14Black.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
