import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' show BaseClient, IOClient;

import 'package:http/http.dart' as http;
import 'package:zxplore_app/apis/endpoints.dart';
import 'package:zxplore_app/models/account_class_model.dart';
import 'package:zxplore_app/models/account_details_response.dart';
import 'package:zxplore_app/models/accounts_response.dart';
import 'package:zxplore_app/models/bvn_response.dart';
import 'package:zxplore_app/models/login_response.dart';
import 'package:zxplore_app/models/occupation_model.dart';
import 'package:zxplore_app/models/save_account_response.dart';
import 'package:zxplore_app/models/state_model.dart';
import 'package:zxplore_app/models/title_model.dart';
import 'package:zxplore_app/models/verify_account_response.dart';

class ZenithBankApi {
  Future<Occupation> fetchOccupations() async {
    final response = await http.get(Endpoints.getOccupationUrl());

    if (response.statusCode == 200) {
      return Occupation.fromJson(json.decode(response.body));
    } else {
      throw CleanerException('Failed to load occupations');
    }
  }

  Future<AccountClass> fetchAccountClasses() async {
    final response = await http.get(Endpoints.getAccountClassesUrl());

    if (response.statusCode == 200) {
      return AccountClass.fromJson(json.decode(response.body));
    } else {
      throw CleanerException('Failed to load account classes');
    }
  }

  Future<Title> fetchTitles() async {
    final response = await http.get(Endpoints.getTitlesUrl());

    if (response.statusCode == 200) {
      return Title.fromJson(json.decode(response.body));
    } else {
      throw CleanerException('Failed to load titles');
    }
  }

  Future<State> fetchStates() async {
    final response = await http.get(Endpoints.getStatesUrl());

    if (response.statusCode == 200) {
      return State.fromJson(json.decode(response.body));
    } else {
      throw CleanerException('Failed to load states');
    }
  }

  Future<State> fetchCities() async {
    final response = await http.get(Endpoints.getCitiesUrl());

    if (response.statusCode == 200) {
      return State.fromJson(json.decode(response.body));
    } else {
      throw CleanerException('Failed to load cities');
    }
  }

  Future<State> fetchCountries() async {
    final response = await http.get(Endpoints.getCountriesUrl());

    if (response.statusCode == 200) {
      return State.fromJson(json.decode(response.body));
    } else {
      throw CleanerException('Failed to load countries');
    }
  }

  Future<LoginResponse> attemptLogin(String username, String password) async {
    Response response;
    Dio dio = new Dio();

    try {
      response = await dio.post(Endpoints.getLoginUrl(),
          data: {"UserName": username, "Password": password});

      print('$response');

      if (response.statusCode == 200) {
        print('${response.data}');

        return LoginResponse.fromJson(response.data);
      }
      if (response.statusCode == 400) {
        var value = LoginResponse.fromJson(response.data);
        throw CleanerException(value.data.responseMessage);
      } else {
        throw CleanerException('login failed.');
      }
    } on DioError catch (error) {
      if (error is DioError) {
        print(error.response);

        if (error.response?.statusCode == 400) {
          throw CleanerException("Invalid login details. Try again");
        } else if (error.response?.statusCode == 502) {
          var value = LoginResponse.fromJson(error.response?.data);
          throw CleanerException(value.message);
        } else {
          throw CleanerException(_handleError(error));
        }
      } else {
        throw CleanerException(
            'We are having issues sending the account to the server. Try again later. ');
      }
    }
  }

  Future<AccountsResponse> getAllAccountsByRsmId(
      String rsmId, String token) async {
    Response response;
    Dio dio = new Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      response =
          await dio.get("${Endpoints.getAccountsByRsmIdUrl()}$rsmId/All");

      return AccountsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw CleanerException(_handleError(error));
    }
  }

  Future<AccountDetailsResponse> getAccountsDetailsByReference(
      String referenceId, String token) async {
    Response response;
    Dio dio = new Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      response =
          await dio.get("${Endpoints.getAccountDetailsUrl()}$referenceId");

      return AccountDetailsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw CleanerException(_handleError(error));
    }
  }

  Future<VerifyAccountResponse> verifyAccountsByRefId(
      String referenceId, String token) async {
    final response = await http.get(
        "${Endpoints.getVerifyAccountsByRefIdUrl()}$referenceId",
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return VerifyAccountResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      var errorResponse =
          VerifyAccountResponse().fromErrorJson(json.decode(response.body));
      throw CleanerException(errorResponse.message);
    } else {
      throw CleanerException('Failed to load cities');
    }
  }

  Future<SaveAccountResponse> attemptSaveAccounts(
      String encodedJson, String token) async {
    Response response;
    Dio dio = new Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      response = await dio.post("${Endpoints.getSaveAccountsUrl()}",
          data: encodedJson);

      print('Response: $response');

      if (response.statusCode == 200) {
        print('${response.data}');
        return SaveAccountResponse.fromJson(response.data);
      } else if (response.statusCode == 400) {
        var value = SaveAccountResponse.fromJson(response.data);
        throw CleanerException(value.message);
      } else {
        return SaveAccountResponse.fromJson(response.data);
      }
    } catch (error, stacktrace) {
      print(error);

//      print("Exception occured: $error stackTrace: $stacktrace");
      if (error is DioError) {
        print(error.response);

        if (error.response?.statusCode == 400) {
          var value = SaveAccountResponse.fromJson(error.response?.data);
          throw CleanerException(value.message);
        } else if (error.response?.statusCode == 502) {
          var value = SaveAccountResponse.fromJson(error.response?.data);
          throw CleanerException(value.message);
        } else {
          throw CleanerException(_handleError(error));
        }
      } else {
        throw CleanerException(
            'We are having issues sending the account to the server. Try again later. ');
      }
    }
  }

  Future<BvnResponse> verifyBvn(String encodedBvn, String token) async {
    Response response;
    Dio dio = new Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    try {
      response =
      await dio.post(Endpoints.getBvnUrl(), data: {"BvnNew": encodedBvn});

      print('$response');

      if (response.statusCode == 200) {
        print('${response.data}');

        return BvnResponse.fromJson(response.data);
      }
      if (response.statusCode == 400) {
        var value = LoginResponse.fromJson(response.data);
        throw CleanerException(value.message);
      } else {
        throw CleanerException('BVN Verification failed in connecting to the server.');
      }
    }
    catch (error){
      if (error is DioError) {
        print(error.response);

        if (error.response?.statusCode == 400) {
          var value = SaveAccountResponse.fromJson(error.response?.data);
          throw CleanerException(value.message);
        } else if (error.response?.statusCode == 502) {
          var value = SaveAccountResponse.fromJson(error.response?.data);
          throw CleanerException(value.message);
        } else {
          throw CleanerException(_handleError(error));
        }
      } else {
        throw CleanerException(
            'We are having issues sending the account to the server. Try again later. ');
      }
    }

  }

  String _handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          if (error.response?.statusCode == 401) {
            errorDescription = "Session expired. Kindly login again.";
          } else {
            errorDescription =
                "Received invalid status code: ${error.response.statusCode}";
          }

          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }


}

class CleanerException implements Exception {
  String cause;
  CleanerException(this.cause);

  @override
  String toString() {
    return cause;
  }
}







