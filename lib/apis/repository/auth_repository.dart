import 'package:zxplore_app/models/epma_models/create_account.dart';
import 'package:zxplore_app/models/epma_models/epma_login_response.dart';
import 'package:zxplore_app/models/epma_models/login_modes_response.dart';

abstract class AuthRepository {

     Future <EpmaLoginResponse> loginRepo({required String loginMode, 
     required String username,
     required String password,});
     Future <LoginModesResponse> getLoginModesRepo();
     Future <dynamic> renewToken({required String oldToken});
     Future <dynamic> createAccount({required CreateAccountData accountData});

}