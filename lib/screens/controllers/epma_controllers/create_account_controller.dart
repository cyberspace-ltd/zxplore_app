import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/auth_repo_provider.dart';
import 'package:zxplore_app/models/epma_models/create_account.dart';
import 'package:zxplore_app/models/epma_models/create_account_response.dart';
part 'create_account_controller.g.dart';

@riverpod
class CreateAccountController extends _$CreateAccountController {
  @override
  FutureOr<dynamic> build() {
    return null;
  }

  Future<void> createNnewAAccount(
      {required CreateAccountData accountData,
      dynamic afterFetched,
      VoidCallback? onFailure}) async {
    try {
      state = const AsyncValue.loading();
      final authRepository = ref.read(authRespositoryImplProvider);

      final registerResponse =
          await authRepository.createAccount(accountData: accountData);

      if (registerResponse['status'] == true) {
        final result = CreateAccountResponse.fromMap(registerResponse);
        state = AsyncValue.data(result);

        afterFetched();
      } else {
        onFailure!.call();

        throw Exception('${registerResponse['message']}');
      }
    } catch (e, s) {
      state = AsyncError(e, s);
      onFailure!.call();
        throw Exception('Failed to complete request , try again.');
    }
  }
}
