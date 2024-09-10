// ignore_for_file: prefer_single_quotes, public_member_api_docs, avoid_redundant_argument_values

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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

    if (!options.path.startsWith('Account/login') ||
        !options.path.startsWith('Account/loginModes') ||
        !options.path.startsWith('Account/renewToken')) {
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

    if (response.requestOptions.path.startsWith('/auth/login')) {
      final loginResponse = {'a': 'b'}
          as Response; // LoginResponseWrapper.fromJson(response.data);
      if (loginResponse.statusCode == 200) {
        if (loginResponse.data.responseCode == 0) {
          final sp = await SharedPreferences.getInstance();
          final token = loginResponse.data.data?.token;
          if (token != null) {
            await sp.setString('accessTokenKey', token);
            _log.info('Access token saved to shared preferences');
          }
        }
      }
    }

    if (response.requestOptions.path.startsWith('/getteasy/personalDetails')) {
      final personalDetailsresponse = {'a': 'b'} as Response;
      // PersonalDetailsResponseWrapper.fromJson(response.data);
      if (personalDetailsresponse.statusCode == 200) {
        if (personalDetailsresponse.data.responseCode == 0) {
          final sp = await SharedPreferences.getInstance();
          final firstName = personalDetailsresponse.data.data.details.firstName;
          final surname = personalDetailsresponse.data.data.details.surname;
          final email = personalDetailsresponse.data.data.details.email;
          final phoneNumber =
              personalDetailsresponse.data.data.details.phoneNumber;
          final title = personalDetailsresponse.data.data.details.title;
          if (firstName != null) {
            // await sp.setString(SharedPreferencesKeys.firstNameKey, firstName);
            _log.info('First name saved to shared preferences');
          }
          if (surname != null) {
            // await sp.setString(SharedPreferencesKeys.surnameKey, surname);
            _log.info('Surname saved to shared preferences');
          }
          if (email != null) {
            await sp.setString(SharedPreferencesKeys.emailKey, email);
            _log.info('Email saved to shared preferences');
          }
          if (phoneNumber != null) {
            await sp.setString(
                SharedPreferencesKeys.phoneNumberKey, phoneNumber);
            _log.info('Phone number saved to shared preferences');
          }
          if (title != null) {
            await sp.setString(SharedPreferencesKeys.titleKey, title);
            _log.info('Title saved to shared preferences');
          }
        }
      }
    }

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('❌❌❌ Error  Response TypeA:${err.response}');
    debugPrint('❌❌❌ Error  Response Msg:${err.response?.data['message']}');
    // debugPrint('❌❌❌ Error    Msg:${err.message}');
    // log('❌❌❌ Error  Response code:${err.response?.statusCode}');

    if (err.response != null &&
        err.response?.data != null &&
        err.response!.data.toString().isNotEmpty &&
        err.response?.statusCode.runtimeType == int &&
        err.response?.data.runtimeType != String) {
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
