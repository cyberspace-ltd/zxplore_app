import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/models/epma_models/epma_login_response.dart';
import 'package:zxplore_app/models/epma_models/login_modes_response.dart';
import 'package:zxplore_app/models/epma_models/rennew_token_response.dart';
import 'package:zxplore_app/models/epma_models/user_pending_statistics_ressponse.dart';
import 'package:zxplore_app/utils/app_exception.dart';
import 'remote_api_base.dart';

part 'remote_endpoints.g.dart';

@riverpod
RemoteApi remoteApi(RemoteApiRef ref) => RemoteApi(createDio());

/// UnauthorisedException
class UnauthorisedException extends AppException {
  /// UnauthorisedException
  UnauthorisedException(super.message);
}

/// RemoteApi
@RestApi()
abstract class RemoteApi {
  /// RemoteApi
  factory RemoteApi(Dio dio) = _RemoteApi;

  // ----------------- Authentication Endpoints -----------------

  @GET('Account/loginModes')
  Future<LoginModesResponse> getLoginModes({
    @CancelRequest() CancelToken? cancelToken,
  });
  @POST('Account/login')
  Future<EpmaLoginResponse> login({
    @Field('loginMode') required String loginMode,
    @Field('username') required String username,
    @Field('password') required String password,
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST('Account/renewToken')
  Future<dynamic> renewToken({
    @Field('token') required String oldToken,
  });
  // ----------------- IN APP -----------------
  @GET('Operation/userPendingStatistics')
  Future<UserPendingStatisticsResponse> getUserPendingStatistics({
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET('Operation/pendingRequestsDraft')
  Future<dynamic> getUserPendingDraft({
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET('Operation/pendingRequestsAll')
  Future<dynamic> getUserPendingAll({
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET('Operation/viewAccountRequest')
  Future<dynamic> viewAccountRequest({
    @Query('RequestId') required String? typeValue,
  });
}
