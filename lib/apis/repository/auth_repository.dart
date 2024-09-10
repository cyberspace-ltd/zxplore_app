abstract class AuthRepository {

     Future <dynamic> loginRepo({required String loginMode, 
     required String username,
     required String password,});
     Future <dynamic> getLoginModesRepo();
     Future <dynamic> reneToken({required String oldToken});

}