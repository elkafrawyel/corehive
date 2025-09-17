sealed class ApiResult<T> {
  const ApiResult();

  bool get isStart => this is ApiStart<T>;

  bool get isSuccess => this is ApiSuccess<T>;

  bool get isLoading => this is ApiLoading<T>;

  bool get isEmpty => this is ApiEmpty<T>;

  bool get isFailure => this is ApiFailure<T>;

  /// Safe getters
  T? get dataResult =>
      this is ApiSuccess<T> ? (this as ApiSuccess<T>).data : null;

  String? get errorResult =>
      this is ApiFailure<T> ? (this as ApiFailure<T>).message : null;

  /// Pattern matching-like helper
  R when<R>({
    required R Function() start,
    required R Function() loading,
    required R Function(String message) empty,
    required R Function(T data) success,
    required R Function(String message, dynamic data) failure,
  }) {
    return switch (this) {
      ApiStart<T>() => start(),
      ApiLoading<T>() => loading(),
      ApiEmpty<T>(:final message) => empty(message),
      ApiSuccess<T>(:final data) => success(data),
      ApiFailure<T>(:final message, :final data) => failure(message, data),
    };
  }
}

class ApiStart<T> extends ApiResult<T> {
  const ApiStart();
}

class ApiLoading<T> extends ApiResult<T> {
  const ApiLoading();
}

class ApiEmpty<T> extends ApiResult<T> {
  final String message;

  const ApiEmpty(this.message);
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;

  const ApiSuccess(this.data);
}

class ApiFailure<T> extends ApiResult<T> {
  final String message;
  final dynamic data;

  const ApiFailure(this.message, {this.data});
}
