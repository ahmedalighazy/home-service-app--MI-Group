import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'api_error_model.dart';

class ErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    log(error.toString());
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(
            message: 'error_connection_failed'.tr(),
          );
        case DioExceptionType.cancel:
          return ApiErrorModel(message: 'error_request_cancelled'.tr());
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
            message: 'error_connection_timeout'.tr(),
          );
        case DioExceptionType.unknown:
          return _handleUnknownError(error);
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            message: 'error_receive_timeout'.tr(),
          );
        case DioExceptionType.badResponse:
          return _handleError(error.response);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            message: 'error_send_timeout'.tr(),
          );
        case DioExceptionType.badCertificate:
          return ApiErrorModel(message: 'error_bad_certificate'.tr());
      }
    } else {
      return ApiErrorModel(
        message: "${'error_something_went_wrong'.tr()} (${error.toString()})",
      );
    }
  }

  static ApiErrorModel _handleUnknownError(DioException error) {
    final err = error.error;
    if (err is SocketException) {
      return ApiErrorModel(message: 'errorNetworkNoInternet'.tr());
    } else if (err is HandshakeException) {
      return ApiErrorModel(message: 'error_handshake_failed'.tr());
    } else if (err is FormatException) {
      return ApiErrorModel(message: 'error_data_format'.tr());
    } else if (err is HttpException) {
      return ApiErrorModel(message: 'error_http_protocol'.tr());
    } else if (err is TimeoutException) {
      return ApiErrorModel(message: 'errorNetworkTimeout'.tr());
    } else if (err is TlsException) {
      return ApiErrorModel(message: 'error_tls_ssl'.tr());
    } else if (err != null) {
      return ApiErrorModel(
        message:
            "${'error_something_went_wrong'.tr()} (${err.toString()})",
      );
    } else {
      return ApiErrorModel(
        message: 'error_connection_failed_unknown'.tr(),
      );
    }
  }

  static ApiErrorModel _handleError(Response? response) {
    if (response == null) {
      return ApiErrorModel(
        message: 'error_no_response'.tr(),
      );
    }

    try {
      final data = response.data;
      ApiErrorModel errorModel;
      if (data is String) {
        errorModel = ApiErrorModel.fromJson(jsonDecode(data));
      } else {
        errorModel = ApiErrorModel.fromJson(data as Map<String, dynamic>);
      }

      final expressiveMessage = errorModel.getLocalizedErrorMessage();
      return ApiErrorModel(
        timestamp: errorModel.timestamp,
        status: errorModel.status,
        error: errorModel.error,
        message: expressiveMessage,
      );
    } catch (e) {
      return ApiErrorModel(
        status: response.statusCode,
        message: response.statusMessage?.toLowerCase() ??
            'error_server_fallback'.tr(),
      );
    }
  }
}