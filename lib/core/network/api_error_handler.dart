import 'dart:async';
import 'dart:convert';
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
            message: "connection to server failed. please check your network.",
          );
        case DioExceptionType.cancel:
          return ApiErrorModel(message: "request to server was cancelled.");
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
            message: "connection timeout. please try again later.",
          );
        case DioExceptionType.unknown:
          return _handleUnknownError(error);
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            message: "receive timeout. server is not responding.",
          );
        case DioExceptionType.badResponse:
          return _handleError(error.response);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            message: "send timeout. please check your network speed.",
          );
        case DioExceptionType.badCertificate:
          return ApiErrorModel(message: "ssl certificate verification failed.");
      }
    } else {
      return ApiErrorModel(message: "unexpected error: ${error.toString()}");
    }
  }

  static ApiErrorModel _handleUnknownError(DioException error) {
    final err = error.error;
    if (err is SocketException) {
      return ApiErrorModel(message: "no internet connection.");
    } else if (err is HandshakeException) {
      return ApiErrorModel(message: "connection terminated during handshake.");
    } else if (err is FormatException) {
      return ApiErrorModel(message: "data format error.");
    } else if (err is HttpException) {
      return ApiErrorModel(message: "http protocol error.");
    } else if (err is TimeoutException) {
      return ApiErrorModel(message: "connection timeout.");
    } else if (err is TlsException) {
      return ApiErrorModel(message: "tls/ssl communication error.");
    } else if (err != null) {
      return ApiErrorModel(message: "unexpected error: ${err.toString()}");
    } else {
      return ApiErrorModel(message: "connection failed due to unknown reasons.");
    }
  }

  static ApiErrorModel _handleError(Response? response) {
    if (response == null) {
      return ApiErrorModel(
        message: "no response received from server.",
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

      // استخدام الدالة لتحويل الرسالة
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
        message: response.statusMessage?.toLowerCase() ?? "server error.",
      );
    }
  }
}