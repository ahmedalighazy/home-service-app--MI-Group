class ServicePageModel {
  final String coverImage;
  final String mainTitle;
  final String rate;
  final String reviews;
  final String totalSteps;
  final String currentStep;
  final List<ServicePageCategoryModel> categories;
  final String promoCode;
  final String promoDiscount;
  final List<ServicePageGroupModel> serviceGroups;

  ServicePageModel({
    required this.coverImage,
    required this.mainTitle,
    required this.rate,
    required this.reviews,
    required this.totalSteps,
    required this.currentStep,
    required this.categories,
    required this.promoCode,
    required this.promoDiscount,
    required this.serviceGroups,
  });
}

class ServicePageCategoryModel {
  final String title;
  final String image;

  ServicePageCategoryModel({
    required this.title,
    required this.image,
  });
}

class ServicePageGroupModel {
  final String categoryTitle;
  final List<ServicePageItemModel> items;

  ServicePageGroupModel({
    required this.categoryTitle,
    required this.items,
  });
}

class ServicePageItemModel {
  final String image;
  final String title;
  final String description;
  final double price;

  ServicePageItemModel({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });
}
