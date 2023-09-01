import 'package:drift/drift.dart';
import 'package:zxplore_app/src/api/dio_error_handler.dart';
import 'package:zxplore_app/src/api/models/account_class_response.dart';
import 'package:zxplore_app/src/api/models/account_details_response.dart';
import 'package:zxplore_app/src/api/models/accounts_response.dart';
import 'package:zxplore_app/src/api/models/bvn_response.dart';
import 'package:zxplore_app/src/api/models/offline_account_model.dart';
import 'package:zxplore_app/src/api/models/save_account_response.dart';
import 'package:zxplore_app/src/api/models/verify_account_response.dart';
import 'package:zxplore_app/src/api/remote_api.dart';
import 'package:zxplore_app/src/database/database.dart';
import 'package:zxplore_app/src/database/extensions/account_class_extensions.dart';
import 'package:zxplore_app/src/database/extensions/offline_account_extensions.dart';
import 'package:zxplore_app/src/shared/app_exception.dart';

class AccountsRepository {
  AccountsRepository({required this.remoteApi, required this.db});

  final RemoteApi remoteApi;
  final AppDatabase db;

  Future<AccountsResponse> getAccountsByRsmId(String? rsmId) async {
    try {
      return remoteApi.getAllAccountsByRsmId(rsmId: rsmId);
    } catch (e) {
      throw AppException(getErrorMessage(e));
    }
  }

  Future<AccountClassResponse> getAccountClasses() async {
    try {
      return remoteApi.fetchAccountClasses();
    } catch (e) {
      throw AppException(getErrorMessage(e));
    }
  }

  Future<AccountDetailsResponse> getAccountsDetailsByReference(
    String? referenceId,
  ) async {
    try {
      return remoteApi.getAccountsDetailsByReference(referenceId: referenceId);
    } catch (e) {
      throw AppException(getErrorMessage(e));
    }
  }

  Future<VerifyAccountResponse> verifyAccountsByRefId(
    String? referenceId,
  ) async {
    try {
      return remoteApi.verifyAccountsByRefId(referenceId: referenceId);
    } catch (e) {
      throw AppException(getErrorMessage(e));
    }
  }

  Future<SaveAccountResponse> attemptSubmitAccountToApi(
    String jsonEncodeAccount,
  ) async {
    try {
      return remoteApi.attemptSaveAccounts(encodedJson: jsonEncodeAccount);
    } catch (e) {
      throw AppException(getErrorMessage(e));
    }
  }

  Future<BvnResponse> verifyBvn(String encodedBvn) async {
    try {
      return remoteApi.verifyBvn(encodedBvn: encodedBvn);
    } catch (e) {
      throw AppException(getErrorMessage(e));
    }
  }

  Future<List<String>> getOccupations() async {
    try {
      final response = await remoteApi.fetchOccupations();
      return response.menu ?? [];
    } catch (e) {
      throw AppException(getErrorMessage(e));
    }
  }

  Future<List<String>> getCountries() async {
    try {
      final response = await remoteApi.fetchCountries();
      return response.menu ?? [];
    } catch (e) {
      throw AppException(getErrorMessage(e));
    }
  }

  Future<List<String>> getStates() async {
    try {
      final response = await remoteApi.fetchStates();
      return response.menu ?? [];
    } catch (e) {
      throw AppException(getErrorMessage(e));
    }
  }

  Future<List<String>> getCities() async {
    try {
      final response = await remoteApi.fetchCities();
      return response.menu ?? [];
    } catch (e) {
      throw AppException(getErrorMessage(e));
    }
  }

  Future<List<String>> getTitles() async {
    try {
      final response = await remoteApi.fetchTitles();
      return response.menu ?? [];
    } catch (e) {
      throw AppException(getErrorMessage(e));
    }
  }

  Future<int> insertAccountOffline(OfflineAccountModel offlineAccount) =>
      db.insertOfflineAccountEntity(offlineAccount.toEntityCompanion());

  Future<bool> updateAccountOffline(OfflineAccountModel offlineAccount) =>
      db.updateOfflineAccountEntity(offlineAccount.toDBModel());

  Future<bool> deleteOfflineAccount(int id) =>
      db.deleteOfflineAccountEntity(id);

  Future<OfflineAccountModel?> getOfflineAccountByRefId(
    String referenceId,
  ) async {
    final account = await db.getOfflineAccount(referenceId);
    return account?.toDomainModel();
  }

  Future<List<OfflineAccountModel>> getOfflineAccounts() async {
    final accounts = await db.getOfflineAccounts();
    return accounts.map((e) => e.toDomainModel()).toList();
  }

  Future<void> insertOccupations(List<String> occupations) {
    final list = occupations
        .map((e) => OccupationEntityCompanion(name: Value(e)))
        .toList();
    return db.insertOccupations(list);
  }

  Future<List<String>> getOccupationsFromDB() async {
    final occupations = await db.getOccupations();
    final list = occupations.map((e) => e.name).toList();
    list.removeWhere((element) => element == null);
    return list as List<String>;
  }

  Future<void> insertCountriesFromDB(List<String> countries) {
    final list =
        countries.map((e) => CountryEntityCompanion(name: Value(e))).toList();
    return db.insertCountries(list);
  }

  Future<List<String>> getCountriesFromDB() async {
    final countries = await db.getCountries();
    final list = countries.map((e) => e.name).toList();
    list.removeWhere((element) => element == null);
    return list as List<String>;
  }

  Future<void> insertStates(List<String> states) {
    final list =
        states.map((e) => StateEntityCompanion(name: Value(e))).toList();
    return db.insertStates(list);
  }

  Future<List<String>> getStatesFromDB() async {
    final states = await db.getStates();
    final list = states.map((e) => e.name).toList();
    list.removeWhere((element) => element == null);
    return list as List<String>;
  }

  Future<void> insertCities(List<String> cities) {
    final list =
        cities.map((e) => CityEntityCompanion(name: Value(e))).toList();
    return db.insertCities(list);
  }

  Future<List<String>> getCitiesFromDB() async {
    final cities = await db.getCities();
    final list = cities.map((e) => e.name).toList();
    list.removeWhere((element) => element == null);
    return list as List<String>;
  }

  Future<void> insertAccountClasses(List<AccountClassCode> accounts) async {
    final list = accounts.map((e) => e.toEntityCompanion()).toList();
    return db.insertAccountClasses(list);
  }

  Future<List<AccountClassCode>> getAccountClassesFromDB() async {
    final accounts = await db.getAccountClasses();
    return accounts.map((e) => e.toDomainModel()).toList();
  }
}
