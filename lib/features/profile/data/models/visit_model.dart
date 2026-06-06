class VisitModel {
  final String id;
  final String date;
  final String time;
  final VisitStatus status;

  VisitModel({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
  });
}

enum VisitStatus { scheduled, inProgress, completed }
