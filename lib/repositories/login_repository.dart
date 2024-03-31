
import 'package:zxplore_app/apis/zenithbank_api.dart';
import 'package:zxplore_app/models/login_response.dart';

class LoginRepository{

  ZenithBankApi _api = ZenithBankApi();

  Future<LoginResponse> attemptLogin(String username, String password){
    try {

      // return Future.delayed(const Duration(seconds: 4), (){
      //  return new LoginResponse(
      //       status: true,
      //       message: "Login was successful",
      //       data: new Data(
      //           responseCode: "00",
      //           responseMessage: "12345",
      //           user: new User(
      //             token: "david12345",
      //             userName: "David Eti",
      //             adUsername: "davideti",
      //             branchNumber: 0,
      //             employeeId: 12345,
      //           )
      //       )
      //   );
      // });

     return _api.attemptLogin(username, password);
 } catch (error) {
      rethrow;
    }
  }
}