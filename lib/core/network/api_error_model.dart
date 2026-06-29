class ApiErrorModel {
  final String? status;
  final String? message;

  ApiErrorModel({this.status, this.message});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      status: json['status']?.toString(),
      message: json['message']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message};
  }
}
