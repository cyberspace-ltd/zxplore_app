import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:zxplore_app/env/app_env.dart';
import 'package:zxplore_app/src/api/dio/interceptors/api_interceprtor.dart';

/// Factory for the Dio client used by the Asset Management API.
class AssetMgmtDioFactory {
  /// Constructor.
  AssetMgmtDioFactory(this._baseUrl, this._interceptor);

  final String _baseUrl;
  final ApiInterceptor _interceptor;

  /// Creates a Dio client.
  Future<Dio> create() async {
    final dio = Dio(_createBaseOptions())..interceptors.add(_interceptor);

    ByteData pemContent =
        await rootBundle.load('assets/server_certificate.pem');
    ByteData keyContent =
        await rootBundle.load('assets/server_certificate_key.pem');
    ByteData crtContent =
        await rootBundle.load('assets/server_certificate.crt');
    // String pem = String.fromCharCodes(pemContent.buffer.asUint8List());
    dio.httpClientAdapter = IOHttpClientAdapter(
      onHttpClientCreate: (_) {
        SecurityContext securityContext = SecurityContext();
        securityContext.setTrustedCertificatesBytes(
            crtContent.buffer.asUint8List(),
            password: 'P@ssw0rd1234');
        securityContext.useCertificateChainBytes(
            pemContent.buffer.asUint8List(),
            password: 'P@ssw0rd1234');
        securityContext.usePrivateKeyBytes(keyContent.buffer.asUint8List(),
            password: 'P@ssw0rd1234');
        HttpClient client = HttpClient(context: securityContext);
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
    return dio;
  }

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
Future<Dio> createDio() async {
  final apiInterceptor = ApiInterceptor();
  final dioFactory = AssetMgmtDioFactory(AppEnv.baseUrl, apiInterceptor);

  return dioFactory.create();
}
