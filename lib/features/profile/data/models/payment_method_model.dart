class PaymentMethodModel {
  final String id;
  final String type;
  final String lastFourDigits;
  final bool isDefault;
  final String? expiryDate;
  final String? cardHolderName;
  final String? iconPath;

  PaymentMethodModel({
    required this.id,
    required this.type,
    required this.lastFourDigits,
    this.isDefault = false,
    this.expiryDate,
    this.cardHolderName,
    this.iconPath,
  });
}
