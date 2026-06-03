/// Base class for all failures in the application.
abstract class Failure {
  final String message;
  const Failure({required this.message});
}

/// Failure returned when a server/API call fails.
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({
    required super.message,
    this.statusCode,
  });

  factory ServerFailure.fromStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return const ServerFailure(
          message: 'طلب غير صالح',
          statusCode: 400,
        );
      case 401:
        return const ServerFailure(
          message: 'غير مصرح - يرجى تسجيل الدخول مرة أخرى',
          statusCode: 401,
        );
      case 403:
        return const ServerFailure(
          message: 'ليس لديك صلاحية الوصول',
          statusCode: 403,
        );
      case 404:
        return const ServerFailure(
          message: 'الصفحة غير موجودة',
          statusCode: 404,
        );
      case 422:
        return const ServerFailure(
          message: 'البيانات المدخلة غير صحيحة',
          statusCode: 422,
        );
      case 500:
        return const ServerFailure(
          message: 'خطأ في الخادم - حاول مرة أخرى لاحقاً',
          statusCode: 500,
        );
      default:
        return ServerFailure(
          message: 'حدث خطأ غير متوقع ($statusCode)',
          statusCode: statusCode,
        );
    }
  }
}

/// Failure returned when no internet connection is available.
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'لا يوجد اتصال بالإنترنت',
  });
}

/// Failure returned when a local cache operation fails.
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'خطأ في الذاكرة المؤقتة',
  });
}
