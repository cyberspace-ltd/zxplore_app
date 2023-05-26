import 'package:dio/dio.dart';

String handleError(DioError error) {
  String errorDescription = "";

  switch (error.type) {
    case DioErrorType.cancel:
      errorDescription = "Request to API server was cancelled";
      break;
    case DioErrorType.connectionTimeout:
      errorDescription = "Connection timeout with API server";
      break;
    case DioErrorType.receiveTimeout:
      errorDescription = "Receive timeout in connection with API server";
      break;
    case DioErrorType.badResponse:
      if (error.response?.statusCode == 401) {
        errorDescription = "Session expired. Kindly login again.";
      } else {
        errorDescription =
            "Received invalid status code: ${error.response!.statusCode}";
      }
      break;
    case DioErrorType.unknown:
      errorDescription = "An unidentifed error occurred";
      break;
    case DioErrorType.sendTimeout:
      errorDescription = "Send timeout in connection with API server";
      break;
    default:
      errorDescription = "Unexpected error occured";
      break;
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
