import 'error_model.dart';

// api_result.dart
// api_result.dart
// الـ Abstract Class
abstract class ApiResult<T> {
  const ApiResult();

  /// Factories like Freezed
  factory ApiResult.success(T data) = Success<T>;
  factory ApiResult.failure(ErrorModel error) = Failure<T>;

  // ---- Pattern matching methods ----
  R when<R>({
    required R Function(T data) success,
    required R Function(ErrorModel error) failure,
  });

  R? whenOrNull<R>({
    R Function(T data)? success,
    R Function(ErrorModel error)? failure,
  });

  R maybeWhen<R>({
    R Function(T data)? success,
    R Function(ErrorModel error)? failure,
    required R Function() orElse,
  });

  R map<R>({
    required R Function(Success<T> value) success,
    required R Function(Failure<T> value) failure,
  });

  R? mapOrNull<R>({
    R Function(Success<T> value)? success,
    R Function(Failure<T> value)? failure,
  });

  R maybeMap<R>({
    R Function(Success<T> value)? success,
    R Function(Failure<T> value)? failure,
    required R Function() orElse,
  });
}

/// ---------------- Success ----------------
class Success<T> implements ApiResult<T> {
  final T data;
  const Success(this.data);

  Success<T> copyWith({T? data}) {
    return Success<T>(data ?? this.data);
  }

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(ErrorModel error) failure,
  }) => success(data);

  @override
  R? whenOrNull<R>({
    R Function(T data)? success,
    R Function(ErrorModel error)? failure,
  }) => success?.call(data);

  @override
  R maybeWhen<R>({
    R Function(T data)? success,
    R Function(ErrorModel error)? failure,
    required R Function() orElse,
  }) => success != null ? success(data) : orElse();

  @override
  R map<R>({
    required R Function(Success<T> value) success,
    required R Function(Failure<T> value) failure,
  }) => success(this);

  @override
  R? mapOrNull<R>({
    R Function(Success<T> value)? success,
    R Function(Failure<T> value)? failure,
  }) => success?.call(this);

  @override
  R maybeMap<R>({
    R Function(Success<T> value)? success,
    R Function(Failure<T> value)? failure,
    required R Function() orElse,
  }) => success != null ? success(this) : orElse();

  @override
  String toString() => 'ApiResult.success(data: $data)';
}

/// ---------------- Failure ----------------
class Failure<T> implements ApiResult<T> {
  final ErrorModel error;
  const Failure(this.error);

  Failure<T> copyWith({ErrorModel? error}) {
    return Failure<T>(error ?? this.error);
  }

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(ErrorModel error) failure,
  }) => failure(error);

  @override
  R? whenOrNull<R>({
    R Function(T data)? success,
    R Function(ErrorModel error)? failure,
  }) => failure?.call(error);

  @override
  R maybeWhen<R>({
    R Function(T data)? success,
    R Function(ErrorModel error)? failure,
    required R Function() orElse,
  }) => failure != null ? failure(error) : orElse();

  @override
  R map<R>({
    required R Function(Success<T> value) success,
    required R Function(Failure<T> value) failure,
  }) => failure(this);

  @override
  R? mapOrNull<R>({
    R Function(Success<T> value)? success,
    R Function(Failure<T> value)? failure,
  }) => failure?.call(this);

  @override
  R maybeMap<R>({
    R Function(Success<T> value)? success,
    R Function(Failure<T> value)? failure,
    required R Function() orElse,
  }) => failure != null ? failure(this) : orElse();

  @override
  String toString() => 'ApiResult.failure(error: $error)';
}
