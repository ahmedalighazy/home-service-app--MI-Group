import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:home_service_app/core/network/error_model.dart';

class ErrorHandler {
  static ErrorModel handle(dynamic error) {
    if (kDebugMode) {
      log(error.toString());
    }

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return const ErrorModel(message: "No internet connection");

        case DioExceptionType.connectionTimeout:
          return const ErrorModel(
            message: "Connection timeout. Please try again.",
          );

        case DioExceptionType.sendTimeout:
          return const ErrorModel(
            message: "Request timeout. Please try again.",
          );

        case DioExceptionType.receiveTimeout:
          return const ErrorModel(message: "Server took too long to respond.");

        case DioExceptionType.cancel:
          return const ErrorModel(message: "Request cancelled.");

        case DioExceptionType.badCertificate:
          return const ErrorModel(message: "Certificate verification failed.");

        case DioExceptionType.badResponse:
          return _handleResponse(error.response);

        case DioExceptionType.unknown:
          return _handleUnknownError(error);
      }
    }

    return ErrorModel(message: error.toString());
  }

  static ErrorModel _handleUnknownError(DioException error) {
    final err = error.error;

    if (err is SocketException) {
      return const ErrorModel(message: "No internet connection");
    }

    if (err is TimeoutException) {
      return const ErrorModel(message: "Connection timeout");
    }

    if (err is HandshakeException) {
      return const ErrorModel(message: "Secure connection failed");
    }

    if (err is HttpException) {
      return const ErrorModel(message: "Server connection failed");
    }

    if (err is FormatException) {
      return const ErrorModel(message: "Invalid server response");
    }

    if (err is TlsException) {
      return const ErrorModel(message: "SSL/TLS error");
    }

    return ErrorModel(message: err?.toString() ?? "Unexpected error occurred");
  }

  static ErrorModel _handleResponse(Response? response) {
    if (response == null) {
      return const ErrorModel(message: "No response from server");
    }

    final statusCode = response.statusCode;
    final data = response.data;

    if (data is Map<String, dynamic>) {
      switch (statusCode) {
        case 400:
          return ErrorModel(
            status: "400",
            message: data["message"]?.toString() ?? "Bad request",
          );

        case 401:
          return ErrorModel(
            status: "401",
            message: data["message"]?.toString() ?? "Invalid email or password",
          );

        case 403:
          return ErrorModel(
            status: "403",
            message: data["message"]?.toString() ?? "Access denied",
          );

        case 404:
          return ErrorModel(
            status: "404",
            message: data["message"]?.toString() ?? "Resource not found",
          );

        case 409:
          return ErrorModel(
            status: "409",
            message: data["message"]?.toString() ?? "Conflict occurred",
          );

        case 422:
          return ErrorModel(
            status: "422",
            message: data["message"]?.toString() ?? "Validation failed",
          );

        case 500:
          return ErrorModel(
            status: "500",
            message: data["message"]?.toString() ?? "Internal server error",
          );

        default:
          return ErrorModel.fromJson(data);
      }
    }

    return ErrorModel(
      status: statusCode?.toString(),
      message: response.statusMessage ?? "Something went wrong",
    );
  }
}
