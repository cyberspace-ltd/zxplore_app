import 'package:dio/dio.dart';

String getErrorMessage<T>(T error) {
  String errorDescription = "";

  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        errorDescription = "The connection timeout with API server, "
            "verify your internet connection and try again";
        break;
      case DioExceptionType.receiveTimeout:
        errorDescription = "The connection timeout with API server, "
            "verify your internet connection and try again";
        break;
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 401) {
          errorDescription = "Session expired. Kindly login again.";
        } else {
          errorDescription = "The server couldn't process your request.";
        }
        break;
      case DioExceptionType.unknown:
        errorDescription = "An unidentifed error occurred";
        break;
      case DioExceptionType.sendTimeout:
        errorDescription = "The connection timeout with API server, "
            "verify your internet connection and try again";
        break;
      default:
        errorDescription = "Unexpected error occured";
        break;
    }
  }

  if (error is FormatException) {
    errorDescription =
        "The data recieved from server was not formatted as expected";
  }

  return errorDescription;
}

class CleanerException implements Exception {
  String? cause;

  CleanerException(this.cause);

  @override
  String toString() {
    return cause!;
  }
}
