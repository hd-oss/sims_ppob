// ignore_for_file: constant_identifier_names

class ResultState<T> {
  Status status;
  T? data;
  String? message;

  ResultState({this.status = Status.INITIAL, this.data, this.message});

  ResultState.init([this.data]) : status = Status.INITIAL;

  ResultState.loading([this.data, this.message]) : status = Status.LOADING;

  ResultState.success(this.data, [this.message]) : status = Status.SUCCESS;

  ResultState.error(this.message, [this.data]) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { INITIAL, LOADING, SUCCESS, ERROR }
