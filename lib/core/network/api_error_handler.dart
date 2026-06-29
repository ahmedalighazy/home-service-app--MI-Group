import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import 'api_error_model.dart';

class ErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    log(error.toString());
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(
            message: "Connection to server failed. Please check your network.",
          );
        case DioExceptionType.cancel:
          return ApiErrorModel(message: "Request to server was cancelled");
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
            message: "Connection timeout. Please try again later.",
          );
        case DioExceptionType.unknown:
          return _handleUnknownError(error);
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            message: "Receive timeout. Server is not responding.",
          );
        case DioExceptionType.badResponse:
          return _handleError(error.response);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            message: "Send timeout. Please check your network speed.",
          );
        case DioExceptionType.badCertificate:
          return ApiErrorModel(message: "SSL certificate verification failed");
      }
    } else {
      return ApiErrorModel(message: "Unexpected error: ${error.toString()}");
    }
  }

  static ApiErrorModel _handleUnknownError(DioException error) {
    final err = error.error;
    if (err is SocketException) {
      return ApiErrorModel(message: "No internet connection");
    } else if (err is HandshakeException) {
      return ApiErrorModel(message: "Connection terminated during handshake");
    } else if (err is FormatException) {
      return ApiErrorModel(message: "Data format error");
    } else if (err is HttpException) {
      return ApiErrorModel(message: "HTTP protocol error");
    } else if (err is TimeoutException) {
      return ApiErrorModel(message: "Connection timeout");
    } else if (err is TlsException) {
      return ApiErrorModel(message: "TLS/SSL communication error");
    } else if (err != null) {
      return ApiErrorModel(message: "Unexpected error: ${err.toString()}");
    } else {
      return ApiErrorModel(message: "Connection failed due to unknown reasons");
    }
  }

  static ApiErrorModel _handleError(Response? response) {
    if (response == null) {
      return ApiErrorModel(
        message: "No response received from server$response",
      );
    }

    try {
      return ApiErrorModel.fromJson(response.data);
    } catch (e) {
      return ApiErrorModel(
        status: response.statusCode.toString(),
        message: response.statusMessage ?? 'خطأ في الخادم',
      );
    }
  }
}
