import 'dart:async';
import 'dart:io';

abstract class Failure {
  final String errMsg;

  Failure(this.errMsg);
}

class AuthFailure extends Failure {
  AuthFailure(super.errMsg);

  factory AuthFailure.handleHttpException(int statusCode, String body) {
    switch (statusCode) {
      case 400:
        return AuthFailure(body);
      case 401:
        return AuthFailure('Unauthorized');
      case 403:
        return AuthFailure('Forbidden');
      case 404:
        return AuthFailure('Not Found');
      case 500:
        return AuthFailure('Internal Server Error');
      default:
        return AuthFailure('Request failed with status: $statusCode');
    }
  }

  factory AuthFailure.handleNetworkException(dynamic exception) {
    if (exception is SocketException) {
      return AuthFailure('No Internet Connection');
    } else if (exception is TimeoutException) {
      return AuthFailure('Connection Timeout');
    } else if (exception is FormatException) {
      return AuthFailure('Invalid Response Format');
    } else {
      return AuthFailure('Network Error: $exception');
    }
  }
}
