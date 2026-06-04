class SubscriptionModel {
  final String id;
  final String title;
  final String type;
  final String? nextVisitDate;
  final String? nextVisitTime;
  final String? expiryDate;
  final double price;
  final SubscriptionStatus status;

  SubscriptionModel({
    required this.id,
    required this.title,
    required this.type,
    this.nextVisitDate,
    this.nextVisitTime,
    this.expiryDate,
    required this.price,
    required this.status,
  });
}

enum SubscriptionStatus {
  active,
  paused,
  ended,
}
