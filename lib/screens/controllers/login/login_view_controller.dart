import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/auth_repo_provider.dart';
import 'package:zxplore_app/models/epma_models/rennew_token_response.dart';
import 'package:zxplore_app/utils/app_exception.dart';
import 'package:zxplore_app/utils/preferences.dart';
import 'package:zxplore_app/utils/shared_preference_keys.dart';
import 'package:zxplore_app/widgets/alert_dialogs.dart';
part 'login_view_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {
    return null;
  }

  var prefs = Preference();

  Future<dynamic> loginUser(BuildContext context,{
    required VoidCallback? onSuccess,
    required String? loginMode,
    required String? username,
    required String? password,
  }) async {
    try {
      state = const AsyncValue.loading();
      final repo = ref.read(authRespositoryImplProvider);

      final loginRes = await repo.loginRepo(
          loginMode: loginMode!, username: username!, password: password!);

      if (loginRes.status) {
        state = AsyncValue.data(loginRes.data);
        onSuccess!.call();
        return loginRes;
      }   else {
        if (loginRes.message == 'token expired/invalid' ||
            loginRes.code == 401) {
         renewToken(context,
              onSuccess: onSuccess,
              loginMode: loginMode,
              username: username,
              password: password);
          // Update state before showing error
          state = AsyncError(
            Exception('Session expired. Please try again.'),
            StackTrace.current,
          );
          showErrorDialog(context, 'Session expired. Please try again.');
          return null;
        }
        // Update state for other errors
        final errorMessage = loginRes.message ?? 'Failed to complete request';
        state = AsyncError(
          Exception(errorMessage),
          StackTrace.current,
        );
        showErrorDialog(context, errorMessage);
        return null;
      }
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      showErrorDialog(context, e.toString());
      return null;
    }
  }

  Future<RenewTokenResponse> renewToken(BuildContext context,{
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
          context,
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
    try {
      state = const AsyncValue.loading();
      await prefs.load();
      final oldToken = prefs.getString(SharedPreferencesKeys.accessTokenKey);
      final repo = ref.read(authRespositoryImplProvider);
      final renewTokenRes = await repo.renewToken(oldToken: oldToken);
      if (renewTokenRes['status']) {
        prefs.setString(
            SharedPreferencesKeys.accessTokenKey, renewTokenRes['data']);
        state = AsyncValue.data(renewTokenRes['data']);
        return renewTokenRes['data'];
      } else {
        state = AsyncError('${renewTokenRes['message']}',
            StackTrace.fromString('An error occurred please try again'));
        return null;

        // throw AppException('${renewTokenRes['message']}');/
      }
    } catch (ex, s) {
      state = AsyncError(
          ex, StackTrace.fromString('An error occurred please try again'));
      return null;
      // throw AppException('${s.toString()}');
    }
  }
}
