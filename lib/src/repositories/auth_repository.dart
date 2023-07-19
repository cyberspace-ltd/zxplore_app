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
    } catch (e) {
      throw AppException(getErrorMessage(e));
    }
  }
}
