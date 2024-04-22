enum ResultStatus { success, loading, error, idle }

class ResultWrapper<T> {
  final ResultStatus status;
  final T? data;
  final dynamic error;

  ResultWrapper._(this.status, this.data, this.error);

  factory ResultWrapper.success(T data) =>
      ResultWrapper._(ResultStatus.success, data, null);

  factory ResultWrapper.loading() =>
      ResultWrapper._(ResultStatus.loading, null, null);

  factory ResultWrapper.error(dynamic error) =>
      ResultWrapper._(ResultStatus.error, null, error);

  factory ResultWrapper.idle() =>
      ResultWrapper._(ResultStatus.idle, null, null);

  RETURN_TYPE? when<RETURN_TYPE>(
      {RETURN_TYPE Function(T? data)? success,
      RETURN_TYPE Function()? loading,
      RETURN_TYPE Function(dynamic error)? error,
      RETURN_TYPE Function()? idle}) {
    if (success != null && status == ResultStatus.success) {
      return success(data);
    } else if (loading != null && status == ResultStatus.loading) {
      return loading();
    } else if (error != null && status == ResultStatus.error) {
      return error(error);
    } else if (idle != null) {
      return idle();
    }
    return null;
  }
}
