class SubscriptionModel {
  final String id;
  final String planName;
  final String status;
  final DateTime startDate;
  final DateTime? endDate;

  SubscriptionModel({
    required this.id,
    required this.planName,
    required this.status,
    required this.startDate,
    this.endDate,
  });
}
