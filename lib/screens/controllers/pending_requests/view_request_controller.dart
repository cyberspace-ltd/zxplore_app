import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
part 'view_request_controller.g.dart';

@riverpod
class ViewRequestController extends _$ViewRequestController {
  @override
  FutureOr<ViewAccountRequestResponse?>  build() {
    return null;
  }

  Future<ViewAccountRequestResponse?> getRequestDetailAsync(
      String requestId) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      const AsyncLoading();
      final requestResponse =
          await repo.viewAccountRequest(requestId: requestId);

      if (requestResponse['status'] == true) {
        final result = ViewAccountRequestResponse.fromMap(requestResponse);
        AsyncValue.data(result);
        return result;
      } else {
        AsyncValue.data(null);
        return null;
      }
    } catch (e, stackTrace) {
      final ex =
          Exception('Failed to Docs Categories: ${stackTrace.toString()} ');
      AsyncError(ex, stackTrace);
      return null;
    }
  }
}
