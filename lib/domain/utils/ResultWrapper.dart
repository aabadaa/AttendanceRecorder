enum ResultStatus { success, loading, error, idle }

class ResultWrapper<T> {
  final ResultStatus status;
  final T? data;
  final String? error;

  ResultWrapper._(this.status, this.data, this.error);

  factory ResultWrapper.success(T data) =>
      ResultWrapper._(ResultStatus.success, data, null);

  factory ResultWrapper.loading() =>
      ResultWrapper._(ResultStatus.loading, null, null);

  factory ResultWrapper.error(String error) =>
      ResultWrapper._(ResultStatus.error, null, error);

  factory ResultWrapper.idle() =>
      ResultWrapper._(ResultStatus.idle, null, null);

  void when(
      {String Function(dynamic data)? success,
      String Function()? loading,
      String Function(dynamic error)? error,
      String Function()? idle}) {
    if (success != null && status == ResultStatus.success) {
      success(data);
    } else if (loading != null && status == ResultStatus.loading) {
      loading();
    } else if (error != null && status == ResultStatus.error) {
      error(error);
    } else if (idle != null) {
      idle();
    }
  }
}
