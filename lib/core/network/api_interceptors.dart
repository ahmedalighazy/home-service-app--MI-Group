import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });
    options.headers["Authorization"] =
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoic3RyaW5nIiwiaWQiOiI3ZTA1OTc0ZC02MTViLTRiNTktODJhNC1lNzA4ZTU5MzM0NjIiLCJzdWIiOiJtamFkMzc3N0BnbWFpbC5jb20iLCJpYXQiOjE3ODI4MjI4NTgsImV4cCI6MTgxNDM1ODg1OH0.of7Qd0Y7zePpkBiIrxPvWoq85-E4OdfSLYYWyUO5JQk";
    super.onRequest(options, handler);
  }
}
