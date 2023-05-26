// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
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

    if (options.path.startsWith('/Security')) {
      final data = options.data;
      final encryptedUserName = CryptoHelper.encrypt(data["Username"]);
      final encryptedPassword = CryptoHelper.encrypt(data["Password"]);

      options.data = {
        "Username": encryptedUserName,
        "Password": encryptedPassword,
      };
    }

    if (!options.path.startsWith('/Security')) {
      final token = await SecureStorage.getEmployeeToken();
      options.headers['Authorization'] = 'Bearer $token';
    }

    log.info(
      'Request: ${options.method} ${options.baseUrl}${options.path} '
      'headers: ${options.headers} data: ${options.data}',
    );

    return super.onRequest(options, handler);
  }
}
