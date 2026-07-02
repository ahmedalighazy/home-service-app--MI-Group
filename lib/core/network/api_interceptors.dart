import 'package:dio/dio.dart';

import '../token/refresh_token_handler.dart';
import '../token/token_manager.dart';

class ApiInterceptor extends Interceptor {
  static const String _bypassAuth = 'bypassAuth';

  final TokenManager tokenManager;
  final RefreshTokenHandler refreshHandler;

  ApiInterceptor({required this.tokenManager, required this.refreshHandler});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    if (options.extra[_bypassAuth] == true) {
      handler.next(options);
      return;
    }

    final token = await tokenManager.getToken();
    if (token != null) {
      options.headers['Authorization'] = tokenManager.getAuthHeader(token);
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final isUnauthorized = err.response?.statusCode == 401;
    final isBypass = err.requestOptions.extra[_bypassAuth] == true;

    if (isUnauthorized && !isBypass) {
      refreshHandler.handleRefresh(err, handler);
    } else {
      handler.next(err);
    }
  }
}
