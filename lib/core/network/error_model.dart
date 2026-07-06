class ErrorModel {
  final String? status;
  final String message;

  const ErrorModel({this.status, this.message = 'Something went wrong'});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      status: json['status']?.toString(),
      message:
          (json['message'] ??
                  json['error'] ??
                  json['details'] ??
                  'Something went wrong')
              .toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message};
  }
}
