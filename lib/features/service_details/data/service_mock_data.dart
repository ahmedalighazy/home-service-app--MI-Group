import 'package:home_service_app/core/utils/l10n/app_strings.dart';

import '../../../core/themes/image/app_assets.dart';
import 'models/service_category_model.dart';
import 'models/service_group_model.dart';
import 'models/service_item_model.dart';
import 'models/service_page_model.dart';

class ServiceMockData {
  static const List<ServicePageModel> pages = [
    ServicePageModel(
      coverImage: AppAssets.furnitureCleaningCover,
      mainTitle: AppStrings.deepFurnitureCleaning,
      rate: '4.7',
      reviews: AppStrings.twelveThousandBookings,
      totalSteps: '5',
      currentStep: '1',
      promoCode: 'CLEAN15',
      promoDiscount: AppStrings.discountUpTo70,
      categories: [
        ServiceCategoryModel(
          image: AppAssets.serviceItem,
          title: AppStrings.sofas,
        ),
        ServiceCategoryModel(
          image: AppAssets.serviceItem,
          title: AppStrings.carpets,
        ),
      ],
      serviceGroups: [
        ServiceGroupModel(
          categoryTitle: AppStrings.sofas,
          items: [
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.cleaningSofa,
              description: AppStrings.cleaningInsideHomeForSofas,
              price: 50,
            ),
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.cleaningSofaOnL,
              description: AppStrings.cleaningSofaOnL,
              price: 150,
            ),
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.cleaningSofa,
              description: AppStrings.cleaningInsideHomeForSofas,
              price: 50,
            ),
          ],
        ),
        ServiceGroupModel(
          categoryTitle: AppStrings.carpets,
          items: [
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.smallNumber100Number200,
              description: AppStrings.cleaningInsideHomeForCarpets,
              price: 150,
            ),
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.mediumSize150By275,
              description: AppStrings.cleaningInsideHomeForCarpets,
              price: 200,
            ),
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.largeSize250By345,
              description: AppStrings.cleaningInsideHomeForCarpets,
              price: 300,
            ),
          ],
        ),
      ],
    ),
    ServicePageModel(
      coverImage: AppAssets.pestControlCover,
      mainTitle: AppStrings.pestControl,
      rate: '4.7',
      reviews: AppStrings.twelveThousandBookings,
      totalSteps: '5',
      currentStep: '1',
      promoCode: 'CLEAN15',
      promoDiscount: AppStrings.discountUpTo70,
      categories: [
        ServiceCategoryModel(
          image: AppAssets.serviceItem,
          title: AppStrings.cockroaches,
        ),
        ServiceCategoryModel(
          image: AppAssets.serviceItem,
          title: AppStrings.ants,
        ),
        ServiceCategoryModel(
          image: AppAssets.serviceItem,
          title: AppStrings.bedbugs,
        ),
        ServiceCategoryModel(
          image: AppAssets.serviceItem,
          title: AppStrings.mice,
        ),
      ],
      serviceGroups: [
        ServiceGroupModel(
          categoryTitle: AppStrings.cockroaches,
          items: [
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlApartment,
              description: AppStrings.sprayFullInApartment,
              price: 120,
            ),
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlVilla,
              description: AppStrings.sprayFullInVilla,
              price: 250,
            ),
          ],
        ),
        ServiceGroupModel(
          categoryTitle: AppStrings.ants,
          items: [
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlAntsApartment,
              description: AppStrings.sprayFullAntsInApartment,
              price: 120,
            ),
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlAntsVilla,
              description: AppStrings.sprayFullAntsInVilla,
              price: 250,
            ),
          ],
        ),
        ServiceGroupModel(
          categoryTitle: AppStrings.bedbugs,
          items: [
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlBedbugsApartment,
              description: AppStrings.sprayFullBedbugsInApartment,
              price: 120,
            ),
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlBedbugsVilla,
              description: AppStrings.sprayFullBedbugsInVilla,
              price: 250,
            ),
          ],
        ),
        ServiceGroupModel(
          categoryTitle: AppStrings.mice,
          items: [
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlMiceApartment,
              description: AppStrings.sprayFullMiceInApartment,
              price: 120,
            ),
            ServiceItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlMiceVilla,
              description: AppStrings.sprayFullMiceInVilla,
              price: 250,
            ),
          ],
        ),
      ],
    ),
  ];
}
