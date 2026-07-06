import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_constants.dart';
import 'api_interceptors.dart';

class DioClient {
  DioClient._();

  static Dio? _dio;

  static Dio getDio() {
    if (_dio != null) {
      return _dio!;
    }

    const timeout = Duration(seconds: 10);

    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        sendTimeout: timeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _addInterceptors();

    return _dio!;
  }

  static void _addInterceptors() {
    _dio!.interceptors.add(ApiInterceptor());

    if (kDebugMode) {
      _dio!.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          logPrint: (object) => debugPrint(object.toString()),
        ),
      );
    }
  }
}
