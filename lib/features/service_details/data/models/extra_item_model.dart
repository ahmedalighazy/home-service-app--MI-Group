import 'package:home_service_app/features/service_details/service_details_strings.dart';

class ExtraItem {
  final String title;
  final double price;
  final String image;
  int quantity;

  ExtraItem({
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 0,
  });

  double get subtotal => price * quantity;

  static List<ExtraItem> get catalogue => [
    ExtraItem(
      title: SdStrings.pillowsSleeping,
      price: 50,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: SdStrings.chairsDining,
      price: 50,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: SdStrings.pillowsDecorative,
      price: 50,
      image: 'assets/images/Rectangle 46.png',
    ),
  ];
}
