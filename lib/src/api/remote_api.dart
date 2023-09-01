import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/src/api/dio/dio_factory.dart';
import 'package:zxplore_app/src/api/models/account_class_response.dart';
import 'package:zxplore_app/src/api/models/account_details_response.dart';
import 'package:zxplore_app/src/api/models/accounts_response.dart';
import 'package:zxplore_app/src/api/models/bvn_response.dart';
import 'package:zxplore_app/src/api/models/cities_model.dart';
import 'package:zxplore_app/src/api/models/country_model.dart';
import 'package:zxplore_app/src/api/models/login_response.dart';
import 'package:zxplore_app/src/api/models/occupation_model.dart';
import 'package:zxplore_app/src/api/models/save_account_response.dart';
import 'package:zxplore_app/src/api/models/state_model.dart';
import 'package:zxplore_app/src/api/models/title_model.dart';
import 'package:zxplore_app/src/api/models/verify_account_response.dart';
import 'package:zxplore_app/src/shared/providers.dart';

part 'remote_api.g.dart';

@RestApi()
abstract class RemoteApi {
  factory RemoteApi(Dio dio) = _RemoteApi;

  // ----------------- Authentication Endpoints -----------------

  @POST('/Security/authUser')
  Future<LoginResponse> login({
    @Field("Username") required String username,
    @Field("Password") required String password,
  });

  @GET('/accounts/Occupations')
  Future<OccupationModel> fetchOccupations();

  @GET('/accounts/AccountClass')
  Future<AccountClassResponse> fetchAccountClasses();

  @GET('/accounts/Countries')
  Future<CountryModel> fetchCountries();

  @GET('/accounts/States')
  Future<StateModel> fetchStates();

  @GET('/accounts/Cities')
  Future<CitiesModel> fetchCities();

  @GET('/accounts/Titles')
  Future<TitleModel> fetchTitles();

  @GET('/accounts/GetAccountsByRsmID/{rsmId}/All')
  Future<AccountsResponse> getAllAccountsByRsmId({
    @Path('rsmId') String? rsmId,
  });

  @GET('/accounts/GetAccountByRefID/{referenceId}')
  Future<AccountDetailsResponse> getAccountsDetailsByReference({
    @Path('referenceId') String? referenceId,
  });

  @GET('/accounts/VerifyReferenceID/{referenceId}')
  Future<VerifyAccountResponse> verifyAccountsByRefId({
    @Path('referenceId') String? referenceId,
  });

  @POST('/accounts/SaveAccount')
  Future<SaveAccountResponse> attemptSaveAccounts({
    @Body() required String encodedJson,
  });

  @POST('/accounts/VerifySingleBVN')
  Future<BvnResponse> verifyBvn({
    @Field("BvnNew") required String encodedBvn,
  });
}

@riverpod
RemoteApi remoteApi(RemoteApiRef ref) => RemoteApi(
      createDio(
        crtContent: ref.watch(crtContentProvider),
        keyContent: ref.watch(keyContentProvider),
        pemContent: ref.watch(pemContentProvider),
      ),
    );
