import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/auth_repo_provider.dart';
import 'package:zxplore_app/models/epma_models/login_modes_response.dart';

part 'get_login_modes.g.dart';

@riverpod

/// Get kyc document type
Future<List<LoginModesData>?> getLoginModes(
  GetLoginModesRef ref,
) async {
  final repo = ref.read(authRespositoryImplProvider);
  final documentsLIst = <LoginModesData>[];

  try {
    const AsyncLoading();
    final loginModesResponse =
        await repo.getLoginModesRepo();

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
    return documentsLIst;
  } catch (e, stackTrace) {
    final ex =
        Exception('Failed to Docs Categories: ${stackTrace.toString()} ');
    print("RES::${e}");
    print("RES::${ex}");

    AsyncError(ex, stackTrace);
    return null;
  }
}
