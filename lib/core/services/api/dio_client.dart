import 'package:dio/dio.dart';
import '../../utils/helpers/cache_helper.dart';

class DioClient {
  DioClient._();
  static final DioClient instance = DioClient._();

  // ── Replace with your actual backend base URL ──
  static const String _baseUrl = 'https://your-backend.example.com/api';

  /// Cache keys for tokens
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';

  late final Dio dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      contentType: 'application/json',
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([
      _authInterceptor(),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    ]);

  /// Interceptor that attaches the stored Bearer token to every request.
  static Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = CacheHelper.getData(key: tokenKey);
        if (token != null && token is String && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) {
        // You can add 401-refresh-token logic here in the future
        handler.next(error);
      },
    );
  }
}
