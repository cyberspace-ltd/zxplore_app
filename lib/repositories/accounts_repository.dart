import 'package:zxplore_app/apis/zenithbank_api.dart';
import 'package:zxplore_app/models/accounts_response.dart';
import 'package:zxplore_app/models/bvn_response.dart';
import 'package:zxplore_app/models/save_account_response.dart';
import 'package:zxplore_app/models/verify_account_response.dart';
import 'package:zxplore_app/utils/secure_storage.dart';

class AccountsRepository {
  ZenithBankApi _api = ZenithBankApi();

  getAccountsByRsmId(String rsmId) async {
    try {
      var token = await SecureStorage.getEmployeeToken();

      return _api.getAllAccountsByRsmId(rsmId, token);
    } catch (error) {
      rethrow;
    }
  }

  Future<VerifyAccountResponse> verifyAccountsByRefId(
      String referenceId) async {
    try {
      var token = await SecureStorage.getEmployeeToken();

      return _api.verifyAccountsByRefId(referenceId, token);
    } catch (error) {
      rethrow;
    }
  }

  Future<SaveAccountResponse> attemptSubmitAccountToApi(
      String jsonEncodeAccount) async {
    try {
      var token = await SecureStorage.getEmployeeToken();

      return _api.attemptSaveAccounts(jsonEncodeAccount, token);
    } catch (error) {
      rethrow;
    }
  }

  Future<BvnResponse> verifyBvn(String encodedBvn) async {
    try {
      var token = await SecureStorage.getEmployeeToken();

      return _api.verifyBvn(encodedBvn, token);
    } catch (error) {
      rethrow;
    }
  }
}
