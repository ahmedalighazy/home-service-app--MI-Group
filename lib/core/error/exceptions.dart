/// Thrown when the API returns an unsuccessful response.
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException($statusCode): $message';
}

/// Thrown when there is no internet connection.
class NetworkException implements Exception {
  final String message;
  const NetworkException({this.message = 'لا يوجد اتصال بالإنترنت'});

  @override
  String toString() => 'NetworkException: $message';
}

/// Thrown when a local cache operation fails.
class CacheException implements Exception {
  final String message;
  const CacheException({this.message = 'خطأ في الذاكرة المؤقتة'});

  @override
  String toString() => 'CacheException: $message';
}
