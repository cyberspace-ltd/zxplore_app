import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zxplore_app/src/api/remote_api.dart';
import 'package:zxplore_app/src/database/database.dart';
import 'package:zxplore_app/src/repositories/accounts_repository.dart';
import 'package:zxplore_app/src/repositories/auth_repository.dart';

part 'providers.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepository(remoteApi: ref.watch(remoteApiProvider));

@riverpod
AccountsRepository accountsRepository(AccountsRepositoryRef ref) =>
    AccountsRepository(
      remoteApi: ref.watch(remoteApiProvider),
      db: ref.watch(AppDatabase.provider),
    );

@riverpod
ByteData pemContent(PemContentRef ref) => throw UnimplementedError();

@riverpod
ByteData keyContent(KeyContentRef ref) => throw UnimplementedError();

@riverpod
ByteData crtContent(CrtContentRef ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) =>
    throw UnimplementedError();

@riverpod
class DarkMode extends _$DarkMode {
  late SharedPreferences prefs;

  @override
  bool build() {
    prefs = ref.read(sharedPreferencesProvider);
    var darkMode = prefs.getBool("darkMode");
    return darkMode ?? false;
  }

  void toggle() {
    state = !state;
    prefs.setBool("darkMode", state);
  }
}

@riverpod
class HideBalance extends _$HideBalance {
  late SharedPreferences prefs;

  @override
  bool build() {
    prefs = ref.read(sharedPreferencesProvider);
    var hideBalance = prefs.getBool("hideBalance");
    return hideBalance ?? true;
  }

  void toggle() {
    state = !state;
    prefs.setBool("hideBalance", state);
  }
}
