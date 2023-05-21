import 'package:dio/dio.dart';
import 'package:zxplore_app/env/app_env.dart';
import 'package:zxplore_app/src/api/dio/interceptors/api_interceprtor.dart';

/// Factory for the Dio client used by the Asset Management API.
class AssetMgmtDioFactory {
  /// Constructor.
  AssetMgmtDioFactory(this._baseUrl, this._interceptor);

  final String _baseUrl;
  final ApiInterceptor _interceptor;

  /// Creates a Dio client.
  Dio create() => Dio(_createBaseOptions())..interceptors.add(_interceptor);

  BaseOptions _createBaseOptions() => BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: 'application/json',
      );
}

/// Creates a Dio client.
///
/// To used by the repositories.
Dio createDio() {
  final apiInterceptor = ApiInterceptor();
  final dioFactory = AssetMgmtDioFactory(AppEnv.baseUrl, apiInterceptor);

  return dioFactory.create();
}
