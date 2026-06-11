class ServicePageEntity {
  final String coverImage;
  final String mainTitle;
  final String rate;
  final String reviews;
  final String totalSteps;
  final String currentStep;
  final List<ServiceCategoryEntity> categories;
  final String promoCode;
  final String promoDiscount;
  final List<ServiceGroupEntity> serviceGroups;

  const ServicePageEntity({
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

class ServiceCategoryEntity {
  final String id;
  final String name;
  final String icon;

  const ServiceCategoryEntity({
    required this.id,
    required this.name,
    required this.icon,
  });
}

class ServiceGroupEntity {
  final String id;
  final String name;
  final List<ServiceItemEntity> items;

  const ServiceGroupEntity({
    required this.id,
    required this.name,
    required this.items,
  });
}

class ServiceItemEntity {
  final String image;
  final String title;
  final String description;
  final double price;

  const ServiceItemEntity({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });
}
