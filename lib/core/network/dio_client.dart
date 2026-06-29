import 'package:dio/dio.dart';
import 'package:home_service_app/core/network/api_constants.dart';
import 'package:home_service_app/core/network/api_interceptors.dart'
    show ApiInterceptor;

class DioClient {
  /// private constructor as I don't want to allow creating an instance of this class
  DioClient._();

  static Dio? dio;
  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 10);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.baseUrl = ApiConstants.baseUrl
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(ApiInterceptor());
    dio?.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }
}
