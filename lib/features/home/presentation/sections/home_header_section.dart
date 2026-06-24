import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/core/widgets/gradient_header.dart';
import 'package:home_service_app/features/address/presentation/bottom_sheets/saved_addresses_bottom_sheet.dart';
import 'package:home_service_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:home_service_app/features/address/presentation/cubit/address_state.dart';
import 'package:home_service_app/features/home/presentation/widgets/home_header.dart';
import 'package:home_service_app/features/home/presentation/widgets/home_search_bar.dart';
import 'package:home_service_app/features/notification/presentation/cubit/notification_cubit.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientHeader(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: AppSizes.spacingMedium),
          BlocBuilder<AddressCubit, AddressState>(
            builder: (context, state) {
              final unreadCount = context
                  .watch<NotificationCubit>()
                  .state
                  .notifications
                  .where((notification) => !notification.isRead)
                  .length;
              final selectedAddress = state.addresses.firstWhere(
                (address) => address.isSelected,
                orElse: () => state.addresses.first,
              );

              return HomeHeader(
                onAvatarTap: () => context.push(AppRouter.editProfile),
                avatarPlaceholder: AppAssets.cleaningGuy,
                locationAddress: selectedAddress.address,

                notificationCount: unreadCount,

                //  Location
                onLocationTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) {
                      return BlocProvider.value(
                        value: context.read<AddressCubit>(),
                        child: const SavedAddressesBottomSheet(),
                      );
                    },
                  );
                },
                onNotificationTap: () {
                  context.push(AppRouter.notification);
                },
                locationLabel: context.tr(LocaleKeys.currentLocation),
              );
            },
          ),
          SizedBox(height: AppSizes.spacingLarge),
          HomeSearchBar(onTap: () => context.push(AppRouter.search)),
          SizedBox(height: AppSizes.spacingLarge),
        ],
      ),
    );
  }
}
