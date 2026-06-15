import '../../../core/themes/image/app_assets.dart';
import 'models/service_page_model.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';


class ServiceMockData {
  static final List<ServicePageModel> pages = [
    ServicePageModel(
      coverImage: AppAssets.furnitureCleaningCover,
      mainTitle: AppStrings.furnitureCleaning,
      rate: '4.7',
      reviews: AppStrings.twelveThousandBookings,
      totalSteps: '5',
      currentStep: '1',
      promoCode: 'CLEAN15',
      promoDiscount: AppStrings.seventyPercentDiscount,
      categories: [
        ServicePageCategoryModel(title: AppStrings.sofas, image: AppAssets.serviceItem),
        ServicePageCategoryModel(title: AppStrings.carpets, image: AppAssets.serviceItem),
      ],
      serviceGroups: [
        ServicePageGroupModel(
          categoryTitle: AppStrings.sofas,
          items: [
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.cleaningSofa,
              description: AppStrings.cleaningInsideHome2,
              price: 50,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.cleaningSofaOnL,
              description: AppStrings.cleaningOnL,
              price: 150,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.cleaningSofa,
              description: AppStrings.cleaningInsideHome2,
              price: 50,
            ),
          ],
        ),
        ServicePageGroupModel(
          categoryTitle: AppStrings.carpetsCategory,
          items: [
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.smallNumber100Number200,
              description: AppStrings.cleaningInsideHome,
              price: 150,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.mediumSize150By275,
              description: AppStrings.cleaningInsideHome,
              price: 200,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.largeSize250By345,
              description: AppStrings.cleaningInsideHome,
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
      promoDiscount: AppStrings.seventyPercentDiscount,
      categories: [
        ServicePageCategoryModel(title: AppStrings.cockroaches, image: AppAssets.serviceItem),
        ServicePageCategoryModel(title: AppStrings.ants, image: AppAssets.serviceItem),
        ServicePageCategoryModel(title: AppStrings.bedbugs, image: AppAssets.serviceItem),
        ServicePageCategoryModel(title: AppStrings.mice, image: AppAssets.serviceItem),
      ],
      serviceGroups: [
        ServicePageGroupModel(
          categoryTitle: AppStrings.cockroaches,
          items: [
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlApartment,
              description: AppStrings.sprayFullInApartment,
              price: 120,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlVilla,
              description: AppStrings.sprayFullInVilla,
              price: 250,
            ),
          ],
        ),
        ServicePageGroupModel(
          categoryTitle: AppStrings.ants,
          items: [
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlAntsApartment,
              description: AppStrings.sprayFullAntsInApartment,
              price: 120,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlAntsVilla,
              description: AppStrings.sprayFullAntsInVilla,
              price: 250,
            ),
          ],
        ),
        ServicePageGroupModel(
          categoryTitle: AppStrings.bedbugs,
          items: [
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlBedbugsApartment,
              description: AppStrings.sprayFullBedbugsInApartment,
              price: 120,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlBedbugsVilla,
              description: AppStrings.sprayFullBedbugsInVilla,
              price: 250,
            ),
          ],
        ),
        ServicePageGroupModel(
          categoryTitle: AppStrings.mice,
          items: [
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: AppStrings.pestControlMiceApartment,
              description: AppStrings.sprayFullMiceInApartment,
              price: 120,
            ),
            ServicePageItemModel(
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

