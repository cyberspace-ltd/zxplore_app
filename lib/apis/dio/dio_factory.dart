

  // ignore_for_file: public_member_api_docs

import 'package:dio/dio.dart';
import 'package:zxplore_app/apis/dio/interceptors/api_interceptors.dart';
import 'package:zxplore_app/apis/endpoints.dart';
 
 

class DioFactory {
  DioFactory(this.baseUrl, this.interceptor);

  final String baseUrl;
  final ApiInterceptor interceptor;

  BaseOptions _createBaseOptions() => BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 120),
        sendTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
        contentType: 'application/json',
      );

  Dio create() {
    final dio = Dio(_createBaseOptions())..interceptors.add(interceptor);
    return dio;
  }
}

Dio createDio() {
 
  const apiInterceptor = ApiInterceptor('Zxplore@APIKey2007ZW0RD\$2024Xyz&&60@AEJ\$');
  final dioFactory = DioFactory(
   Endpoints.EPMA_MIDDLEWARE_BASE_URL,
    apiInterceptor,
  );

  return dioFactory.create();
}