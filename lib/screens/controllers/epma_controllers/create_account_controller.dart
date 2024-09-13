import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/auth_repo_provider.dart';
import 'package:zxplore_app/models/epma_models/create_account.dart';
import 'package:zxplore_app/models/epma_models/create_account_response.dart';
import 'package:zxplore_app/utils/app_exception.dart';
part 'create_account_controller.g.dart';

@riverpod
class CreateAccountController extends _$CreateAccountController {
  @override
  FutureOr<dynamic> build() {
    return null;
  }

  Future<void> createNnewAAccount({required CreateAccountData accountData,      dynamic afterFetched,}) async {

    try {
        state = const AsyncValue.loading();
      final authRepository = ref.read(authRespositoryImplProvider);


        final registerResponse = await authRepository.createAccount(accountData: accountData);
             
        if (registerResponse['status'] == true) {
          final result = CreateAccountResponse.fromMap(registerResponse);
          state = AsyncValue.data(result);
       
          afterFetched();
        } else {
           throw AppException('${registerResponse['message']}');
        }
     
    } catch (e,s) {
         state = AsyncError(e, s);  
        return null;
    }

  }
}
