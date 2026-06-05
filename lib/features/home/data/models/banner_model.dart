import '../../domain/entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    required super.title,
    required super.subTitle,
    required super.price,
    required super.offerPrice,
    required super.promoCode,
    required super.imagePath,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      title: json['title'] ?? '',
      subTitle: json['sub_title'] ?? '',
      price: json['price']?.toString() ?? '',
      offerPrice: json['offer_price']?.toString() ?? '',
      promoCode: json['promo_code'] ?? '',
      imagePath: json['image_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'sub_title': subTitle,
      'price': price,
      'offer_price': offerPrice,
      'promo_code': promoCode,
      'image_path': imagePath,
    };
  }
}
