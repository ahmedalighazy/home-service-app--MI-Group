import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/home/data/models/home_data_model.dart';

import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/service_model.dart';

class HomeDummyData {
  const HomeDummyData._();

  static List<CategoryModel> categories = [
    CategoryModel(
      title: AppStrings.deepCleaning,
      iconPath: IconsPath.cleanerIcon,
    ),
    CategoryModel(
      title: AppStrings.houseCleaning,
      iconPath: IconsPath.manualCleanerIcon,
    ),
    CategoryModel(title: AppStrings.pestControl, iconPath: IconsPath.bugIcon),
    CategoryModel(
      title: AppStrings.corporateServices,
      iconPath: IconsPath.institutionsIcon,
    ),
  ];

  static List<ServiceModel> popularServices = [
    ServiceModel(
      title: AppStrings.deepFurnitureCleaning,
      imagePath: AppAssets.deepFurnitureCleaning,
      badge: AppStrings.discountUpTo70,
    ),

    ServiceModel(
      title: AppStrings.pestControlService,
      imagePath: AppAssets.pestControlService,
      badge: AppStrings.discountUpTo20,
    ),
    ServiceModel(
      title: AppStrings.glassCleaning,
      imagePath: AppAssets.glassCleaning,
      badge: AppStrings.newNotifications,
    ),
  ];

  static List<BannerModel> banners = [
    BannerModel(
      title: AppStrings.bestCleaningWork,
      subTitle: AppStrings.hourlyClean,
      price: AppStrings.price120,
      offerPrice: AppStrings.startingPrice,
      promoCode: AppStrings.promoCode,
      imagePath: AppAssets.banner,
    ),
    BannerModel(
      title: AppStrings.bestCleaningWork,
      subTitle: AppStrings.hourlyClean,
      price: AppStrings.price120,
      offerPrice: AppStrings.startingPrice,
      promoCode: AppStrings.promoCode,
      imagePath: AppAssets.banner,
    ),
    BannerModel(
      title: AppStrings.bestCleaningWork,
      subTitle: AppStrings.hourlyClean,
      price: AppStrings.price120,
      offerPrice: AppStrings.startingPrice,
      promoCode: AppStrings.promoCode,
      imagePath: AppAssets.banner,
    ),
  ];
  static HomeDataModel getHomeData() {
    return HomeDataModel(
      banners: banners,
      categories: categories,
      services: popularServices,
    );
  }
}
