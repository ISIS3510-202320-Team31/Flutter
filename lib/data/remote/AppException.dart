class AppException implements Exception {
  final _message;

  AppException([this._message]);

  @override
  String toString() {
    return "$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message);
}

class NotFoundException extends AppException {
  NotFoundException([message]) : super(message);
}

class InternalServerException extends AppException {
  InternalServerException([message]) : super(message);
}

class OtherException extends AppException {
  OtherException([message]) : super(message);
}
