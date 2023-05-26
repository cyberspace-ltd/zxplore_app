import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:zxplore_app/src/api/dio/dio_factory.dart';
import 'package:zxplore_app/src/api/models/account_class_model.dart';
import 'package:zxplore_app/src/api/models/account_details_response.dart';
import 'package:zxplore_app/src/api/models/accounts_response.dart';
import 'package:zxplore_app/src/api/models/login_response.dart';
import 'package:zxplore_app/src/api/models/occupation_model.dart';
import 'package:zxplore_app/src/api/models/save_account_response.dart';
import 'package:zxplore_app/src/api/models/state_model.dart';
import 'package:zxplore_app/src/api/models/verify_account_response.dart';

part 'zenithbank_api.g.dart';

@RestApi()
abstract class ZenithBankApi {
  factory ZenithBankApi(Dio dio) = _ZenithBankApi;

  // ----------------- Authentication Endpoints -----------------

  @POST('/Security/authUser')
  Future<LoginResponse> login({
    @Field("Username") required String username,
    @Field("Password") required String password,
  });

  @GET('/accounts/Occupations')
  Future<Occupation> fetchOccupations();

  @GET('/accounts/AccountClass')
  Future<AccountClass> fetchAccountClasses();

  @GET('/accounts/States')
  Future<State> fetchStates();

  @GET('/accounts/Cities')
  Future<State> fetchCities();

  @GET('/accounts/Countries')
  Future<State> fetchCountries();

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
}

final apiPod = FutureProvider<ZenithBankApi>((ref) async {
  final dio = await createDio();

  return ZenithBankApi(dio);
});
