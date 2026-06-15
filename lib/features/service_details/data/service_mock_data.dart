import '../../../core/themes/image/app_assets.dart';
import 'models/service_page_model.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class ServiceMockData {
  static final List<ServicePageModel> pages = [
    ServicePageModel(
      coverImage: AppAssets.furnitureCleaningCover,
      mainTitle: SdStrings.furnitureCleaning,
      rate: '4.7',
      reviews: SdStrings.twelveThousandBookings,
      totalSteps: '5',
      currentStep: '1',
      promoCode: 'CLEAN15',
      promoDiscount: SdStrings.seventyPercentDiscount,
      categories: [
        ServicePageCategoryModel(title: SdStrings.sofas, image: AppAssets.serviceItem),
        ServicePageCategoryModel(title: SdStrings.carpets, image: AppAssets.serviceItem),
      ],
      serviceGroups: [
        ServicePageGroupModel(
          categoryTitle: SdStrings.sofas,
          items: [
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.cleaningSofa,
              description: SdStrings.cleaningInsideHome2,
              price: 50,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.cleaningSofaOnL,
              description: SdStrings.cleaningOnL,
              price: 150,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.cleaningSofa,
              description: SdStrings.cleaningInsideHome2,
              price: 50,
            ),
          ],
        ),
        ServicePageGroupModel(
          categoryTitle: SdStrings.carpetsCategory,
          items: [
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.smallNumber100Number200,
              description: SdStrings.cleaningInsideHome,
              price: 150,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.mediumSize150By275,
              description: SdStrings.cleaningInsideHome,
              price: 200,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.largeSize250By345,
              description: SdStrings.cleaningInsideHome,
              price: 300,
            ),
          ],
        ),
      ],
    ),
    ServicePageModel(
      coverImage: AppAssets.pestControlCover,
      mainTitle: SdStrings.pestControl,
      rate: '4.7',
      reviews: SdStrings.twelveThousandBookings,
      totalSteps: '5',
      currentStep: '1',
      promoCode: 'CLEAN15',
      promoDiscount: SdStrings.seventyPercentDiscount,
      categories: [
        ServicePageCategoryModel(title: SdStrings.cockroaches, image: AppAssets.serviceItem),
        ServicePageCategoryModel(title: SdStrings.ants, image: AppAssets.serviceItem),
        ServicePageCategoryModel(title: SdStrings.bedbugs, image: AppAssets.serviceItem),
        ServicePageCategoryModel(title: SdStrings.mice, image: AppAssets.serviceItem),
      ],
      serviceGroups: [
        ServicePageGroupModel(
          categoryTitle: SdStrings.cockroaches,
          items: [
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.pestControlApartment,
              description: SdStrings.sprayFullInApartment,
              price: 120,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.pestControlVilla,
              description: SdStrings.sprayFullInVilla,
              price: 250,
            ),
          ],
        ),
        ServicePageGroupModel(
          categoryTitle: SdStrings.ants,
          items: [
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.pestControlAntsApartment,
              description: SdStrings.sprayFullAntsInApartment,
              price: 120,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.pestControlAntsVilla,
              description: SdStrings.sprayFullAntsInVilla,
              price: 250,
            ),
          ],
        ),
        ServicePageGroupModel(
          categoryTitle: SdStrings.bedbugs,
          items: [
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.pestControlBedbugsApartment,
              description: SdStrings.sprayFullBedbugsInApartment,
              price: 120,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.pestControlBedbugsVilla,
              description: SdStrings.sprayFullBedbugsInVilla,
              price: 250,
            ),
          ],
        ),
        ServicePageGroupModel(
          categoryTitle: SdStrings.mice,
          items: [
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.pestControlMiceApartment,
              description: SdStrings.sprayFullMiceInApartment,
              price: 120,
            ),
            ServicePageItemModel(
              image: AppAssets.serviceItem,
              title: SdStrings.pestControlMiceVilla,
              description: SdStrings.sprayFullMiceInVilla,
              price: 250,
            ),
          ],
        ),
      ],
    ),
  ];
}
