import 'package:rxdart/rxdart.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/models/accounts_response.dart';
import 'package:zxplore_app/models/verify_account_response.dart';
import 'package:zxplore_app/repositories/accounts_repository.dart';
import 'package:zxplore_app/utils/secure_storage.dart';

class AccountsBloc extends BlocBase {
  final AccountsRepository _accountsRepository = AccountsRepository();
  final BehaviorSubject<AccountsResponse> _subjectAccountsResponse =
      BehaviorSubject<AccountsResponse>();

  final BehaviorSubject<VerifyAccountResponse> _subjectVerifyAccountsResponse =
      BehaviorSubject<VerifyAccountResponse>();

  getAccounts() async {
    try {
      String rsmId = await SecureStorage.getEmployeeId();

      AccountsResponse response =
          await _accountsRepository.getAccountsByRsmId(rsmId);
      _subjectAccountsResponse.sink.add(response);
    } catch (error) {
      _subjectAccountsResponse.sink.addError('$error');
    }
  }

  verifyAccountByReferenceId(String referenceId) async {
    try {
      VerifyAccountResponse response =
          await _accountsRepository.verifyAccountsByRefId(referenceId);
      _subjectVerifyAccountsResponse.sink.add(response);
    } catch (error) {
      _subjectVerifyAccountsResponse.sink.addError(error);
    }
  }

  @override
  dispose() {
    _subjectAccountsResponse.close();
    _subjectVerifyAccountsResponse.close();
  }

  BehaviorSubject<AccountsResponse> get subjectAccountsResponse =>
      _subjectAccountsResponse;

  BehaviorSubject<VerifyAccountResponse> get subjectVerifyAccountsResponse =>
      _subjectVerifyAccountsResponse;
}
