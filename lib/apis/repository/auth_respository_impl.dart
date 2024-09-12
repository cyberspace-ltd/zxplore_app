import 'package:dio/dio.dart';
import 'package:zxplore_app/apis/dio/remote_endpoints.dart';
import 'package:zxplore_app/apis/repository/auth_repository.dart';
import 'package:zxplore_app/models/epma_models/epma_login_response.dart';
import 'package:zxplore_app/models/epma_models/login_modes_response.dart';
import 'package:zxplore_app/models/epma_models/rennew_token_response.dart';
import 'package:zxplore_app/utils/app_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

    /// AuthRespositoryImpl
class AuthRespositoryImpl extends AuthRepository {

    /// AuthRespositoryImpl
  AuthRespositoryImpl({required this.api});

  final RemoteApi api;
  @override
  Future<LoginModesResponse> getLoginModesRepo() async{
  try {
      final response = await api.getLoginModes();

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future<EpmaLoginResponse> loginRepo({required String loginMode, required String username, required String password}) async{
  try {
      final response = await api.login(loginMode: loginMode,password: password,username: username);

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future<dynamic> renewToken({required String oldToken}) async {
try {
      final response = await api.renewToken(oldToken: oldToken);

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
}

 
