import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/models/epma_models/epma_login_response.dart';
import 'package:zxplore_app/models/epma_models/login_modes_response.dart';
// import 'package:zxplore_app/models/epma_models/user_pending_statistics_ressponse.dart';
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
  // -----------------OPERATIONS IN APP -----------------
  @GET('Operation/userPendingStatistics')
  Future<dynamic> getUserPendingStatistics({
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
    @Query('RequestId') required String? requestId,
  });
  
  @POST('Operation/createNewRequest')
  Future<dynamic> createAccount({
    @Field('surname') required String? surname,
    @Field('firstName') required String? firstName,
    @Field('otherNames')   String? otherNames,
    @Field('genderCode') required String? genderCode,
    @Field('birthDate') required String? birthDate,
    @Field('citizenshipCode') required String? citizenshipCode,
    @Field('identificationTypeId') required int? identificationTypeId,
    @Field('identificationNo') required String? identificationNo,
    @Field('idCountryCode') required String? idCountryCode,
    @Field('idIssueAuthority') required String? idIssueAuthority,
    @Field('idExpiryDate') required String? idExpiryDate,
    @Field('idIssueDate') required String? idIssueDate,
    @Field('niaVerificationNo') required String? niaVerificationNo,
    @Field('iddCode') required String? iddCode,
    @Field('telNo') required String? telNo,
    @Field('mobileNo') required String? mobileNo,
    @Field('residentialAddress') required String? residentialAddress,
    @Field('city') required String? city,
    @Field('residentialAddress2')   String? residentialAddress2,
    @CancelRequest() CancelToken? cancelToken,
  });

  // ----------------- META Endpoints -----------------
@GET('Metadata/accountClass')
  Future<dynamic> getAccountClass(
    {
     @Query('RequestId') required String? requestId,
     @Query('AccountType') required String? accountType,
     @Query('SeriesCode') required String? seriesCode}
  );
  @GET('Metadata/accountSeries')
  Future<dynamic> getAccountSeries({
     @Query('RequestId') required String? requestId,
     @Query('AccountType') required String? accountType});
  @GET('Metadata/accoutTypes')
  Future<dynamic> getAccoutTypes();
  @GET('Metadata/anticipatedAmounts')
  Future<dynamic> getAnticipatedAmounts();
  @GET('Metadata/anticipatedTransactions')
  Future<dynamic> getAnticipatedTransactions();
  @GET('Metadata/businessNatures')
  Future<dynamic> getBusinessNatures();
  @GET('Metadata/Countries')
  Future<dynamic> getCountries();
  @GET('Metadata/customerClassification')
  Future<dynamic> getCustomerClassification();
  @GET('Metadata/documentTypes')
  Future<dynamic> getDocumentTypes();
  @GET('Metadata/employTypes')
  Future<dynamic> getEmployTypes();
  @GET('Metadata/fatcaStatus')
  Future<dynamic> getFatcaStatus();
  @GET('Metadata/genders')
  Future<dynamic> getGenders();
  @GET('Metadata/identificationTypes')
  Future<dynamic> getIdentificationTypes();
  @GET('Metadata/maritalStatus')
  Future<dynamic> getMaritalStatus();
  @GET('Metadata/regions')
  Future<dynamic> getRegions();
  @GET('Metadata/searchOptions')
  Future<dynamic> getSearchOptions();
  @GET('Metadata/viewAccountRequest')
  Future<dynamic> getReconStatus();
  @GET('Metadata/subBusinessNatures')
  Future<dynamic> getSubBusinessNatures({
    @Query('BusinessNatureId') required int? businessNatureId}
  );
}
