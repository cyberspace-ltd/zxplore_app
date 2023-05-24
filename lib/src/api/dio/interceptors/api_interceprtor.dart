// import 'dart:convert';

import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

/// Interceptor for the Zenith Bank API.
class ApiInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Content-Type'] = 'application/json';

    if (!options.path.startsWith('/Authentication')) {
      // TODO: add token to header
      // final sp = await SharedPreferences.getInstance();
      // final json = sp.getString(SharedPrefKeys.assetMgmtUserKey);
      // if (json != null) {
      //   final user = AssetMgmtLocalUser.fromJson(jsonDecode(json));
      //   final token = user.authToken;
      //   options.headers['Authorization'] = 'Bearer $token';
      // }
    }

    return super.onRequest(options, handler);
  }
}
