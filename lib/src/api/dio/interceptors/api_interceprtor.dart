// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:zxplore_app/src/api/models/login_response.dart';
import 'package:zxplore_app/src/utils/secure_storage.dart';
import 'package:zxplore_app/src/utils/zxplore_crypto_helper.dart';

final log = Logger('ApiInterceptor');

/// Interceptor for the Zenith Bank API.
class ApiInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Content-Type'] = 'application/json';

    if (!options.path.startsWith('/Security')) {
      final token = await SecureStorage.getEmployeeToken();
      options.headers['Authorization'] = 'Bearer $token';
    }

    // encrypt username and password
    if (options.path.startsWith('/Security')) {
      final data = options.data;
      final encryptedUserName = CryptoHelper.encrypt(data["Username"]);
      final encryptedPassword = CryptoHelper.encrypt(data["Password"]);

      options.data = {
        "Username": encryptedUserName,
        "Password": encryptedPassword,
      };
    }

    // encrypt bvn
    if (options.path.startsWith('/accounts/VerifySingleBVN')) {
      final data = options.data;
      final encryptedBvn = CryptoHelper.encrypt(data["BvnNew"]);

      options.data = {
        "BvnNew": encryptedBvn,
      };
    }

    log.info(
      'Request: ${options.method} ${options.baseUrl}${options.path} '
      'headers: ${options.headers} data: ${options.data}',
    );

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    log.info(
      'Response: ${response.statusCode} ${response.statusMessage} '
      'headers: ${response.headers} data: ${response.data}',
    );

    if (response.requestOptions.path.startsWith('/Security')) {
      final loginResponse = LoginResponse.fromJson(response.data);
      if (loginResponse.data?.responseCode == '200') {
        final token = loginResponse.data?.user?.token;
        final employeeId = loginResponse.data?.user?.employeeId;
        final branchNumber = loginResponse.data?.user?.branchNumber;
        await SecureStorage.saveAgentInformation(
          token: token,
          employeeId: employeeId?.toString(),
          branchNumber: branchNumber?.toString(),
        );
      }
    }

    return super.onResponse(response, handler);
  }
}
