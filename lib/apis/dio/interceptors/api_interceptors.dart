// ignore_for_file: prefer_single_quotes, public_member_api_docs, avoid_redundant_argument_values

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zxplore_app/apis/dio/network_exceptions.dart';
import 'package:zxplore_app/utils/app_strings.dart';
import 'package:zxplore_app/utils/shared_preference_keys.dart';

final _log = Logger('ApiInterceptor');

class ApiInterceptor extends Interceptor {
  const ApiInterceptor(this.apiKey);
  final String apiKey;

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['ApiKey'] = apiKey;
    if (options.path != 'Account/login' &&
        options.path != 'Account/loginModes' &&
        options.path != 'Account/renewToken' &&
        options.path != 'Metadata/') {
      final sp = await SharedPreferences.getInstance();
      final token = sp.getString(SharedPreferencesKeys.accessTokenKey);

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
        _log.info('Access token added to request headers');
      }
    }

    debugPrint(
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
    debugPrint(
      'Response: ${response.statusCode} ${response.statusMessage} '
      'headers: ${response.headers} data: ${response.data}',
    );

    if (response.requestOptions.path == 'Account/login') {
      if (response.data['status'] == true) {
        final pref = await SharedPreferences.getInstance();
        final secStorage = FlutterSecureStorage();

        final tk = response.data['data'];
        if (tk != null) {
          await pref.setString(SharedPreferencesKeys.accessTokenKey, tk);
          await secStorage.write(
              key: SharedPreferencesKeys.secAccessTokenKey,
              value: response.data['data']);
        }
      }
    }
    return super.onResponse(response, handler);
  }
  //   Future<void> _refreshToken() async {
  //      final  secStorage= FlutterSecureStorage();

  //   final oldToken = await secStorage.read(key: SharedPreferencesKeys.secAccessTokenKey);
  //   final response = await Dio().post(
  //     'Account/renewToken',
  //     data: {'refresh_token': oldToken},
  //   );
  //   if (response.statusCode == 200) {
  //     await secStorage.write(key: SharedPreferencesKeys.secAccessTokenKey, value: response.data['data']);

  //   } else {
  //     throw Exception('Failed to refresh token');
  //   }
  // }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null &&
        err.response?.data != null &&
        err.response!.data.toString().isNotEmpty &&
        err.response?.statusCode.runtimeType == int &&
        err.response?.data.runtimeType != String) {
      debugPrint('❌❌❌ Error  Response TypeA:${err.response}');
      debugPrint('❌❌❌ Error  Response Msg:${err.response?.data['message']}');
      debugPrint('❌❌❌ Error    Msg:${err.message}');
      debugPrint('❌❌❌ Error  Response code:${err.response?.statusCode}');

      debugPrint('❌❌❌ Error  Response Name2:${err.type.name}');
      return handler.resolve(Response(
        statusCode: err.response?.statusCode ?? 0,
        statusMessage: err.message ?? AppStrings.errorInProccessing,
        data: {
          "success": false,
          "error_code": err.response?.data['error_code'] ?? -1,
          "error": err.response?.data['error'] ?? '',
          "message": err.response?.data['message'] ??
              NetworkExceptions.getDioException(err.type),
        },
        requestOptions: RequestOptions(path: err.requestOptions.path),
      ));
    } else {
      if (err.type == DioExceptionType.badCertificate ||
          err.type == DioExceptionType.badResponse ||
          err.type == DioExceptionType.connectionError ||
          err.type == DioExceptionType.cancel ||
          err.type == DioExceptionType.cancel ||
          err.type == DioExceptionType.sendTimeout ||
          err.type == DioExceptionType.receiveTimeout ||
          err.type == DioExceptionType.unknown) {
        debugPrint('❌❌❌ Error  Response Type1:${err.type.name}');
        debugPrint('❌❌❌ Error  Response code:${err.response?.statusCode}');

        return handler.resolve(Response(
          statusCode: 0000,
          statusMessage: err.message ?? AppStrings.errorInProccessing,
          data: {
            "succeeded": false,
            "message": NetworkExceptions.getDioException(err.type)
          },
          requestOptions:
              RequestOptions(path: err.requestOptions.path, data: null),
        ));
      }
      debugPrint('❌❌❌ Error  Response Message:${err.message}');
      debugPrint('❌❌❌ Error  Response Name3:${err.type.name}');

      return handler.resolve(Response(
        statusCode: err.response?.statusCode ?? 0,
        statusMessage: err.message ?? AppStrings.errorInProccessing,
        data: {
          "succeeded": false,
          "message": err.response?.data['message'] ??
              NetworkExceptions.getDioException(err.type)
        },
        requestOptions:
            RequestOptions(path: err.requestOptions.path, data: null),
      ));
    }
  }
}
