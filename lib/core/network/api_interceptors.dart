import 'package:dio/dio.dart';
import 'package:home_service_app/core/utils/helpers/cache_helper.dart';

import '../token/refresh_token_handler.dart';
import '../token/token_manager.dart';

class ApiInterceptor extends Interceptor {
  // Auth endpoints that should NOT have Authorization header
  static const _publicPaths = ['/auth/login', '/auth/register'];

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

    // Check if bypass via extra flag
    if (options.extra[_bypassAuth] == true) {
      handler.next(options);
      return;
    }

    // Only add token for protected routes
    final isPublicPath = _publicPaths.any((p) => options.path.contains(p));
    if (!isPublicPath) {
      final token = await tokenManager.getToken();
      if (token != null) {
        options.headers['Authorization'] = tokenManager.getAuthHeader(token);
      } else {
        // Fallback to cache if tokenManager is empty
        final cacheToken = CacheHelper.getData(key: 'token');
        if (cacheToken != null && cacheToken.toString().isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $cacheToken';
        }
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final isUnauthorized = err.response?.statusCode == 401;
    final hasAuthorization = err.requestOptions.headers.containsKey(
      'Authorization',
    );

    if (isUnauthorized && hasAuthorization) {
      refreshHandler.handleRefresh(err, handler);
    } else {
      handler.next(err);
    }
  }
}
