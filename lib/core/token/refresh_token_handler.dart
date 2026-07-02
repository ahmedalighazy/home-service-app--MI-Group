import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../network/api_constants.dart';
import '../routes/app_routes.dart';
import 'token_manager.dart';

class RefreshTokenHandler {
  static const String _bypassAuth = 'bypassAuth';

  final Dio dio;
  final TokenManager tokenManager;
  Completer<void>? _refreshCompleter;

  RefreshTokenHandler({required this.dio, required this.tokenManager});
  bool _isRedirecting = false;

  Future<void> handleRefresh(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      if (_refreshCompleter != null) {
        await _refreshCompleter!.future;
        await _retry(err, handler);
        return;
      }

      _refreshCompleter = Completer<void>();
      await _performRefresh(err);

      _refreshCompleter!.complete();
      _refreshCompleter = null;

      await _retry(err, handler);
    } catch (e) {
      _handleRefreshError(e, err, handler);
    }
  }

  Future<void> _performRefresh(DioException err) async {
    final refreshToken = await tokenManager.getRefreshToken();
    if (refreshToken == null) {
      throw DioException(
        requestOptions: err.requestOptions,
        type: DioExceptionType.badResponse,
        message: 'No refresh token available',
      );
    }

    final response = await dio.post(
      ApiConstants.refresh,
      data: {'refreshToken': refreshToken},
      options: Options(extra: {_bypassAuth: true}),
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw DioException(
        requestOptions: err.requestOptions,
        type: DioExceptionType.badResponse,
        message: 'Invalid refresh response format',
      );
    }

    final newToken = data['token'] as String?;
    if (newToken == null || newToken.isEmpty) {
      throw DioException(
        requestOptions: err.requestOptions,
        type: DioExceptionType.badResponse,
        message: 'Refresh response missing token',
      );
    }

    await tokenManager.saveTokens(
      newToken,
      refreshToken: data['refreshToken'] as String?,
    );
  }

  Future<void> _retry(DioException err, ErrorInterceptorHandler handler) async {
    final token = await tokenManager.getToken();
    err.requestOptions.headers['Authorization'] = token != null
        ? tokenManager.getAuthHeader(token)
        : null;
    err.requestOptions.extra[_bypassAuth] = true;

    try {
      final response = await dio.fetch(err.requestOptions);
      handler.resolve(response);
    } on DioException catch (newError) {
      handler.next(newError);
    } catch (otherError) {
      handler.next(_toDioException(otherError, err.requestOptions));
    }
  }

  void _handleRefreshError(
    dynamic error,
    DioException originalError,
    ErrorInterceptorHandler handler,
  ) {
    if (_refreshCompleter != null && !_refreshCompleter!.isCompleted) {
      _refreshCompleter!.completeError(error);
    }
    _refreshCompleter = null;

    if (error is DioException) {
      _handleDioError(error, originalError, handler);
    } else {
      handler.next(_toDioException(error, originalError.requestOptions));
    }
  }

  void _handleDioError(
    DioException error,
    DioException originalError,
    ErrorInterceptorHandler handler,
  ) {
    final code = error.response?.statusCode;
    if (code == 401 || code == 403) {
      tokenManager.clearTokens();
      _navigateToLogin();
    }
    handler.next(error);
  }

  DioException _toDioException(dynamic error, RequestOptions options) {
    return DioException(
      requestOptions: options,
      error: error,
      type: DioExceptionType.unknown,
      message: error.toString(),
    );
  }

  void _navigateToLogin() {
    if (_isRedirecting) return;

    _isRedirecting = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppRouter.router.go(AppRouter.signIn);
      _isRedirecting = false;
    });
  }
}
