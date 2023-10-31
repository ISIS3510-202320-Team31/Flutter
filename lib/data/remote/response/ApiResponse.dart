import 'package:hive_app/data/remote/response/Status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.none() : status = Status.NONE;

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  ApiResponse.offline() : status = Status.OFFLINE;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
