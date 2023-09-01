import 'package:dio/dio.dart';
import 'package:zxplore_app/src/api/dio_error_handler.dart';
import 'package:zxplore_app/src/api/models/login_response.dart';
import 'package:zxplore_app/src/api/remote_api.dart';
import 'package:zxplore_app/src/shared/app_exception.dart';

class AuthRepository {
  AuthRepository({required this.remoteApi});

  final RemoteApi remoteApi;

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      return await remoteApi.login(username: username, password: password);
    } on DioException catch (error) {
      if (error.response != null &&
          error.response!.data != null &&
          error.response!.data['message'] != null) {
        throw AppException(error.response!.data['message']);
      } else if (error.response != null &&
          error.response!.data != null &&
          error.response!.data['Message'] != null) {
        throw AppException(error.response!.data['Message']);
      } else if (error.response?.statusCode == 502) {
        var value = LoginResponse.fromJson(error.response?.data);
        throw AppException(value.message);
      } else {
        throw AppException(getErrorMessage(error));
      }
    }
  }
}
