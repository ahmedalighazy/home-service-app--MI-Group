import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/gradient_header.dart';
import 'package:home_service_app/features/address/domain/entities/address_entity.dart';
import 'package:home_service_app/features/address/presentation/bottom_sheets/saved_addresses_bottom_sheet.dart';
import 'package:home_service_app/features/home/presentation/widgets/home_header.dart';
import 'package:home_service_app/features/home/presentation/widgets/home_search_bar.dart';
import 'package:home_service_app/features/notification/data/dummy/notification_dummy_data.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<AddressEntity> addressCard = [
      AddressEntity(
        title: AppStrings.addressHome,
        address: '18 شارع الوعب، الدوحة',
        iconPath: IconsPath.home,
      ),

      AddressEntity(
        title: AppStrings.addressWork,
        address: 'برج الشراف، الطابق الثامن',
        iconPath: IconsPath.institutionsIcon,
        isSelected: true,
      ),
    ];
    return GradientHeader(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: AppSizes.spacingMedium),
          HomeHeader(
            notificationCount: NotificationDummyData.notifications.length,
            onLocationTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) {
                  return SavedAddressesBottomSheet(addresses: addressCard);
                },
              );
            },
            onNotificationTap: () {
              context.push(AppRouter.notification);
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
