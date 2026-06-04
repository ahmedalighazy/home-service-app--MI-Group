class PaymentMethodModel {
  final String id;
  final String cardHolderName;
  final String lastFourDigits;
  final String expiryDate;
  final String brand; // e.g., 'Visa', 'Mastercard'
  final bool isDefault;
  final String iconPath;

  PaymentMethodModel({
    required this.id,
    required this.cardHolderName,
    required this.lastFourDigits,
    required this.expiryDate,
    required this.brand,
    this.isDefault = false,
    required this.iconPath,
  });
}
