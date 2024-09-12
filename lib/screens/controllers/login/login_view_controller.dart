import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/auth_repo_provider.dart';
import 'package:zxplore_app/models/epma_models/rennew_token_response.dart';
import 'package:zxplore_app/utils/app_exception.dart';
import 'package:zxplore_app/utils/preferences.dart';
import 'package:zxplore_app/utils/shared_preference_keys.dart';
part 'login_view_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }
  var prefs = Preference();

  Future<dynamic> loginUser({
    required VoidCallback? onSuccess,
    required String? loginMode,
    required String? username,
    required String? password,
  }) async {
    // final sharedPreferences = ref.read(sharedPreferencesProvider).requireValue;
    try {
      state = const AsyncValue.loading();
      final repo = ref.read(authRespositoryImplProvider);

      final loginRes = await repo.loginRepo(
          loginMode: loginMode!, username: username!, password: password!);

      if (loginRes.status) {
        state = AsyncValue.data(loginRes);
        //  perssist the token here
        await prefs.load();
        prefs.setString(SharedPreferencesKeys.accessTokenKey, loginRes.data);
        onSuccess!.call();
        return loginRes;
      } else {
        if (loginRes.message == 'token expired/invalid' ||
            loginRes.code == 401) {
          renewToken(
              onSuccess: onSuccess,
              loginMode: loginMode,
              username: username,
              password: password);
        } else {
          throw AppException('${loginRes.message}');
        }
      }
    } catch (e, s) {
      state = AsyncError(e, s);
      throw AppException('${s.toString()}');

      // return null;
    }
  }

  Future<RenewTokenResponse> renewToken({
    required VoidCallback? onSuccess,
    required String? loginMode,
    required String? username,
    required String? password,
  }) async {
    // final sharedPreferences = ref.read(sharedPreferencesProvider).requireValue;
    try {
      state = const AsyncValue.loading();
      final repo = ref.read(authRespositoryImplProvider);

      final renewTokenRes = await repo.renewToken(oldToken: '');

      if (renewTokenRes.status) {
        state = AsyncValue.data(renewTokenRes);
        loginUser(
            onSuccess: onSuccess,
            loginMode: loginMode,
            username: username,
            password: password);
        return renewTokenRes;
      } else {
        throw AppException('${renewTokenRes.message}');
      }
    } catch (e, s) {
      state = AsyncError(e, s);
      throw AppException('${s.toString()}');

      // return null;
    }
  }

  Future<dynamic> extRenewToken() async {
    // final sharedPreferences = ref.read(sharedPreferencesProvider).requireValue;
    try {
      state = const AsyncValue.loading();
        await prefs.load();
      final oldToken=  prefs.getString(SharedPreferencesKeys.accessTokenKey);

      final repo = ref.read(authRespositoryImplProvider);

      final renewTokenRes = await repo.renewToken(oldToken:oldToken);

      if (renewTokenRes.data['status']) {
        state = AsyncValue.data(renewTokenRes.data['data']);
        prefs.setString(SharedPreferencesKeys.accessTokenKey, renewTokenRes.data['data']);
   
        return renewTokenRes;
      } else {
        throw AppException('${renewTokenRes.message}');
      }
    } catch (e, s) {
      // state = AsyncError(e, s);
      throw AppException('${s.toString()}');

      // return null;
    }
  }
}
