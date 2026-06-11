class PaymentMethodModel {
  final String id;
  final String type;
  final String lastFourDigits;
  final bool isDefault;

  PaymentMethodModel({
    required this.id,
    required this.type,
    required this.lastFourDigits,
    this.isDefault = false,
  });
}
