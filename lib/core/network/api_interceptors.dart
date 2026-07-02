import 'package:dio/dio.dart';
import 'package:home_service_app/core/utils/helpers/cache_helper.dart';

class ApiInterceptor extends Interceptor {
  // Auth endpoints that should NOT have Authorization header
  static const _publicPaths = ['/auth/login', '/auth/register'];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    // Only add token for protected routes
    final isPublicPath = _publicPaths.any((p) => options.path.contains(p));
    if (!isPublicPath) {
      final token = CacheHelper.getData(key: 'token');
      if (token != null && token.toString().isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    super.onRequest(options, handler);
  }
}
