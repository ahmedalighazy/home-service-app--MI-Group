class VisitModel {
  final String id;
  final String serviceType;
  final DateTime date;
  final String status;
  final String? workerName;

  VisitModel({
    required this.id,
    required this.serviceType,
    required this.date,
    required this.status,
    this.workerName,
  });
}
