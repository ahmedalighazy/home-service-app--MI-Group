import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String title;
  final String subTitle;
  final String price;
  final String offerPrice;
  final String promoCode;
  final String imagePath;

  const BannerEntity({
    required this.title,
    required this.subTitle,
    required this.price,
    required this.offerPrice,
    required this.promoCode,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [
    title,
    subTitle,
    price,
    offerPrice,
    promoCode,
    imagePath,
  ];
}
