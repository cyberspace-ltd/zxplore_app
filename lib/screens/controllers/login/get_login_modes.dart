import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/auth_repo_provider.dart';
import 'package:zxplore_app/models/epma_models/login_modes_response.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/widgets/alert_dialogs.dart';

part 'get_login_modes.g.dart';

@riverpod

/// Get getLoginModes
Future<List<LoginModesData>?> getLoginModes(
  GetLoginModesRef ref,BuildContext context
) async {
  final repo = ref.read(authRespositoryImplProvider);
  final documentsLIst = <LoginModesData>[];

  try {
    const AsyncLoading();
    final loginModesResponse =    await repo.getLoginModesRepo();

    if (loginModesResponse.status==true) {
      if (loginModesResponse.data!.isNotEmpty == true) {
        for (final element in loginModesResponse.data!) {
          // final d = LoginModesData.fromJson(element!);
          documentsLIst.add(element);
        }
        AsyncData(documentsLIst);
        return documentsLIst;
      } else {
        const AsyncData([]);
        return [];
      }
    }
     else {
        if (loginModesResponse.message == 'token expired/invalid' ||
            loginModesResponse.code == 401) {
          ref.read(loginControllerProvider.notifier).extRenewToken();
       
          // Update state before showing error
        AsyncError(
            Exception('Session expired. Please try again.'),
            StackTrace.current,
          );
          showErrorDialog(context, 'Session expired. Please try again.');
          return null;
        }
        // Update state for other errors
        final errorMessage = loginModesResponse.message ?? 'Failed to complete request';
      AsyncError(
          Exception(errorMessage),
          StackTrace.current,
        );
        showErrorDialog(context, errorMessage);
        return null;
      }
    } catch (e, stackTrace) {
    AsyncError(e, stackTrace);
      showErrorDialog(context, e.toString());
      return null;
    }
}
