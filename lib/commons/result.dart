class Result<T> {
  Status status;
  T? data;
  String? message;

  Result.loading() : status = Status.loading;

  Result.success(this.data) : status = Status.success;

  Result.error(this.message) : status = Status.error;

  get entityId => null;

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }
}

enum Status { loading, success, error }
