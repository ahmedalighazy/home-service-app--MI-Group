import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/network/api_constants.dart';
import 'package:home_service_app/core/network/api_interceptors.dart'
    show ApiInterceptor;

import '../di/injection.dart';
import '../token/refresh_token_handler.dart';
import '../token/token_manager.dart';

class DioClient {
  DioClient._();

  static Dio? _dio;

  static Dio getDio({required TokenManager tokenManager}) {
    const Duration timeOut = Duration(seconds: 10);

    if (_dio == null) {
      _dio = Dio();
      _dio!
        ..options.baseUrl = ApiConstants.baseUrl
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;

      _addDioInterceptor(tokenManager, _dio!);
      return _dio!;
    } else {
      return _dio!;
    }
  }

  static void _addDioInterceptor(TokenManager tokenManager, Dio dio) {
    _dio?.interceptors.add(
      ApiInterceptor(
        tokenManager: tokenManager,
        refreshHandler: RefreshTokenHandler(
          dio: dio,
          tokenManager: getIt<TokenManager>(),
        ),
      ),
    );

    _dio?.interceptors.add(
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
