import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/service_item_add_button.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/service_item_info.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/service_item_quantity_counter.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/service_item_thumbnail.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../../../data/models/service_item_model.dart';
import '../../cubit/feature_cubit.dart';
import '../../cubit/feature_state.dart';


class ServiceItemCard extends StatelessWidget {
  final String itemKey;
  final ServiceItemModel item;

  const ServiceItemCard({super.key, required this.itemKey, required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocSelector<
      FeatureCubit,
      FeatureState,
      ({int quantity, bool favorite})
    >(
      selector: (state) {
        final loaded = state is FeatureLoaded ? state : const FeatureLoaded();
        return (
          quantity: loaded.serviceItemQuantity(itemKey),
          favorite: loaded.isServiceItemFavorite(itemKey),
        );
      },
      builder: (context, itemState) {
        final cubit = context.read<FeatureCubit>();

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * 0.014,
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              itemState.quantity == 0
                  ? ServiceItemAddButton(
                      onTap: () =>
                          cubit.incrementServiceItem(itemKey, item.price),
                    )
                  : ServiceItemQuantityCounter(
                      quantity: itemState.quantity,
                      onIncrement: () =>
                          cubit.incrementServiceItem(itemKey, item.price),
                      onDecrement: () =>
                          cubit.decrementServiceItem(itemKey, item.price),
                    ),
              SizedBox(width: size.width * 0.03),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ServiceItemInfo(
                        isFavorite: itemState.favorite,
                        item: item,
                        onFavoritePressed: () =>
                            cubit.toggleServiceItemFavorite(itemKey),
                      ),
                    ),
                    SizedBox(width: size.width * 0.025),
                    ServiceItemThumbnail(image: item.image),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

