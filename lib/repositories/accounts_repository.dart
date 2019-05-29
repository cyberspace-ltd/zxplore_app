import 'package:zxplore_app/apis/zenithbank_api.dart';
import 'package:zxplore_app/data/database.dart';
import 'package:zxplore_app/data/entities/offline_form_entity.dart';
import 'package:zxplore_app/models/account_class_model.dart';
import 'package:zxplore_app/models/account_details_response.dart';
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

  Future<AccountClass> getAccountClasses() async {
    try {
      return _api.fetchAccountClasses();
    } catch (error) {
      rethrow;
    }
  }

  Future<AccountDetailsResponse> getAccountsDetailsByReference(
      String referenceId) async {
    try {
      var token = await SecureStorage.getEmployeeToken();

      return _api.getAccountsDetailsByReference(referenceId, token);
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

  Future<String> saveAccountOffline(
      OfflineAccountEntity offlineAccount) async {
    try {
     var updateOfflineAccount = DBProvider.db.insertOfflineAccount(offlineAccount);
      return updateOfflineAccount.toString();//number of rows updated
    } catch (error) {
      rethrow;
    }
  }

}
