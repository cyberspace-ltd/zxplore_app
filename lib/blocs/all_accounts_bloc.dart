import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/data/database.dart';
import 'package:zxplore_app/data/entities/offline_form_entity.dart';
import 'package:zxplore_app/models/accounts_response.dart';
import 'package:zxplore_app/models/verify_account_response.dart';
import 'package:zxplore_app/repositories/accounts_repository.dart';
import 'package:zxplore_app/utils/secure_storage.dart';

import '../models/account_datum.dart';

class AccountsBloc extends BlocBase {
  final AccountsRepository _accountsRepository = AccountsRepository();
  final BehaviorSubject<AccountsResponse> _subjectAccountsResponse =
      BehaviorSubject<AccountsResponse>();

  final PublishSubject<VerifyAccountResponse> _subjectVerifyAccountsResponse =
      PublishSubject<VerifyAccountResponse>();

  final _offlineAccountsController =
      StreamController<List<OfflineAccountEntity>>.broadcast();

  Stream<List<OfflineAccountEntity>> get offlineAccounts =>
      _offlineAccountsController.stream;

  StreamSink<List<OfflineAccountEntity>> get _offlineAccounts =>
      _offlineAccountsController.sink;

  Future<void> getAccounts() async {
    try {
      //  String? rsmId = await SecureStorage.getEmployeeId();
      String? username = await SecureStorage.getUsername();

/*
      AccountsResponse response =
          await _accountsRepository.getAccountsByRsmId(rsmId);
*/

      AccountsResponse response =
          await _accountsRepository.getAccountsByUsernameRepo(username);

      List<AccountDatum> acctDatum = await DBProvider.db.getAccountDatum();
      for (int i = 0; i < acctDatum.length; i++) {
        response.data?.add(Datum(
            refId: acctDatum[i].refId.toString(),
            phoneNumber: acctDatum[i].phoneNumber,
            accountName: acctDatum[i].accountName,
            status: acctDatum[i].status));
      }

      _subjectAccountsResponse.sink.add(response);
    } catch (error) {
      _subjectAccountsResponse.sink.addError('$error');
    }
  }

/*
  getOfflineAccounts() async {
    List<OfflineAccountEntity> offlineAcccounts =
        await DBProvider.db.getOfflineAccounts();
    _offlineAccounts.add(offlineAcccounts);
  }

  deleteOfflineAccount(int? id) async {
    await _accountsRepository.deleteOfflineAccount(id);
  }
  */

  verifyAccountByReferenceId(String? referenceId) async {
    try {
      VerifyAccountResponse response =
          await _accountsRepository.verifyAccountsByRefId(referenceId);
      _subjectVerifyAccountsResponse.sink.add(response);
    } catch (error) {
      _subjectVerifyAccountsResponse.sink.addError(error);
    }
  }

  fetchAccountClasses() {
    _accountsRepository
        .getAccountClasses()
        .then((result) {})
        .catchError((error) {
      //todo: fetch account classes
    });
  }

  @override
  dispose() {
    _subjectAccountsResponse.close();
    _subjectVerifyAccountsResponse.close();
    _offlineAccountsController.close();
  }

  BehaviorSubject<AccountsResponse> get subjectAccountsResponse =>
      _subjectAccountsResponse;

  PublishSubject<VerifyAccountResponse> get subjectVerifyAccountsResponse =>
      _subjectVerifyAccountsResponse;
}
