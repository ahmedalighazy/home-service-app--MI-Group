import 'package:home_service_app/core/utils/l10n/app_strings.dart';

/// Represents an optional add-on service the user can add to their booking.
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

  /// Mock catalogue shown on the Extras step.
  static List<ExtraItem> get catalogue => [
    ExtraItem(
      title: AppStrings.pillowsSleeping,
      price: 50,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: AppStrings.chairsDining,
      price: 50,
      image: 'assets/images/Rectangle 46.png',
    ),
    ExtraItem(
      title: AppStrings.pillowsDecorative,
      price: 50,
      image: 'assets/images/Rectangle 46.png',
    ),
  ];
}
