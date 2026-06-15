class SubscriptionModel {
  final String id;
  final String planName;
  final String status;
  final DateTime startDate;
  final DateTime? endDate;
  final String? title;
  final String? type;
  final DateTime? nextVisitDate;
  final String? nextVisitTime;
  final double? price;
  final DateTime? expiryDate;

  SubscriptionModel({
    required this.id,
    required this.planName,
    required this.status,
    required this.startDate,
    this.endDate,
    this.title,
    this.type,
    this.nextVisitDate,
    this.nextVisitTime,
    this.price,
    this.expiryDate,
  });
}

enum SubscriptionStatus { active, paused, cancelled, ended }
