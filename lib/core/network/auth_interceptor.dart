import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utils/helpers/cache_helper.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = CacheHelper.getData(key: 'token');

    if (token != null &&
        token.toString().isNotEmpty &&
        !options.path.contains('/auth/login')) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    if (kDebugMode) {
      debugPrint('''
================ REQUEST ================
${options.method}
${options.uri}

Headers:
${options.headers}

Body:
${options.data}
========================================
''');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('''
================ RESPONSE ===============
${response.statusCode}
${response.requestOptions.uri}

${response.data}
========================================
''');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      debugPrint('''
================ ERROR ==================
${err.requestOptions.uri}

${err.response?.statusCode}

${err.response?.data}
========================================
''');
    }

    /// ToDO:
    /// لو رجع 401 هنا بعدين
    /// هنعمل Refresh Token
    /// ونعيد الـ Request تلقائياً.

    handler.next(err);
  }
}
