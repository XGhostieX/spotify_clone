import 'dart:async';
import 'dart:io';

abstract class Failure {
  final String errMsg;

  Failure(this.errMsg);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMsg);

  factory ServerFailure.handleHttpException(int statusCode, String body) {
    switch (statusCode) {
      case 400:
        return ServerFailure(body);
      case 401:
        return ServerFailure('Unauthorized');
      case 403:
        return ServerFailure('Forbidden');
      case 404:
        return ServerFailure('Not Found');
      case 500:
        return ServerFailure('Internal Server Error');
      default:
        return ServerFailure('Request failed with status: $statusCode');
    }
  }

  factory ServerFailure.handleNetworkException(dynamic exception) {
    if (exception is SocketException) {
      return ServerFailure('No Internet Connection');
    } else if (exception is TimeoutException) {
      return ServerFailure('Connection Timeout');
    } else if (exception is FormatException) {
      return ServerFailure('Invalid Response Format');
    } else {
      return ServerFailure('Network Error: $exception');
    }
  }
}
