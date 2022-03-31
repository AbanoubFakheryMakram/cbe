
abstract class Failure {
  final String? msg;

  Failure({this.msg});
}

// code => 500
class InternalServerErrorFailure extends Failure {
  InternalServerErrorFailure({String? msg}) : super(msg: msg);
}

// code => 400
class BadRequestFailure extends Failure {
  BadRequestFailure({String? msg}) : super(msg: msg);
}

// code => 401
class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({String? msg}) : super(msg: msg);
}

// code => 404
class NotFoundFailure extends Failure {
  NotFoundFailure({String? msg}) : super(msg: msg);
}

// code 405
class MethodNotAllowedFailure extends Failure {
  MethodNotAllowedFailure({String? msg}) : super(msg: msg);
}

// code 408
class ConnectionTimeoutFailure extends Failure {
  ConnectionTimeoutFailure({String? msg}) : super(msg: msg);
}

// socketFailure
class NoInternetConnectionFailure extends Failure {
  NoInternetConnectionFailure({String? msg}) : super(msg: msg);
}

// HttpFailure
class HttpFailure extends Failure {
  HttpFailure({String? msg}) : super(msg: msg);
}

// HttpFailure
class RequestCanceledFailure extends Failure {
  RequestCanceledFailure({String? msg}) : super(msg: msg);
}

// FormatFailure
class FormatFailure extends Failure {
  FormatFailure({String? msg}) : super(msg: msg);
}

// UnknownFailure
class UnknownFailure extends Failure {
  UnknownFailure({String? msg}) : super(msg: msg);
}

// Need to logout user
class LogoutFailure extends Failure {
  LogoutFailure({String? msg}) : super(msg: msg);
}

class CustomFailure extends Failure {
  final dynamic data;

  CustomFailure({this.data}) : super(msg: data.toString());
}

class EncryptionFailure extends Failure {
  final dynamic data;

  EncryptionFailure({this.data}) : super(msg: data.toString());
}