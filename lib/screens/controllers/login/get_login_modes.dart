import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/auth_repo_provider.dart';
import 'package:zxplore_app/models/epma_models/login_modes_response.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';

part 'get_login_modes.g.dart';

@riverpod

/// Get getLoginModes
Future<List<LoginModesData>?> getLoginModes(
  GetLoginModesRef ref,
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
    }else{
      if (loginModesResponse.message == 'token expired/invalid') {
          // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
          final ex = Exception('Failed to complete request ');
           AsyncError(
              ex, StackTrace.fromString('An error occured please try again'));
              throw  Exception('Failed to complete request\n${loginModesResponse.message} ');
        }
    }
    return documentsLIst;
  } catch (e, stackTrace) {
    final ex =
        Exception('Failed to Docs Categories: ${stackTrace.toString()} ');
    AsyncError(ex, stackTrace);
    return null;
  }
}
