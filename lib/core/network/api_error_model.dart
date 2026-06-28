class ApiErrorModel {
  final String? status;
  final String? messege;

  ApiErrorModel({this.messege, this.status});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
    status: json['status'] as String?,
    messege: json['message'] as String?,
  );

  Map<String, dynamic> toJson() => {'status': status, 'message': messege};
}
