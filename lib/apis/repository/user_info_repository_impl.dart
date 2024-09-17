import 'package:zxplore_app/apis/repository/user_info_repository.dart';
import 'package:dio/dio.dart';
import 'package:zxplore_app/apis/dio/remote_endpoints.dart';
import 'package:zxplore_app/models/epma_models/pending_requests_all_response.dart';
import 'package:zxplore_app/models/epma_models/pending_requests_drafts.dart';
import 'package:zxplore_app/models/epma_models/user_pending_statistics_ressponse.dart';
import 'package:zxplore_app/utils/app_exception.dart';

/// UserInfoRepositoryImpl
class UserInfoRepositoryImpl extends UserInfoRepository {
  final RemoteApi api;

  /// UserInfoRepositoryImpl
  UserInfoRepositoryImpl({required this.api});
  @override
  Future<dynamic> getUserPendingAllRepo() async {
    try {
      final response = await api.getUserPendingAll();

      return  response;

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
  Future<dynamic> getUserPendingDraftRepo() async {
    try {
      final response = await api.getUserPendingDraft();
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
  Future<dynamic> getUserPendingStatisticsRepo() async {
    try {
      final response = await api.getUserPendingStatistics();
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
  Future viewAccountRequest({required String? requestId}) async{
      try {
      final response = await api.viewAccountRequest(requestId:requestId );

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
