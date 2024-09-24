import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
part 'view_request_controller.g.dart';

@riverpod
class ViewRequestController extends _$ViewRequestController {
  @override
  FutureOr<ViewAccountRequestResponse?> build() {
    return null;
  }

  Future<ViewAccountRequestResponse?> getRequestDetailAsync(
      String requestId) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse =
          await repo.viewAccountRequest(RequestId: requestId);

      if (requestResponse['status'] == true) {
        final result = ViewAccountRequestResponse.fromMap(requestResponse);
        ref.read(activelyViewedRequestProvider.notifier).updateRequestState(result);
        state = AsyncValue.data(result);
        return result;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
          // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
          final ex = Exception('Failed to complete request ');
          state = AsyncError(
              ex, StackTrace.fromString('An error occured please try again'));
        }
        state = AsyncValue.data(null);
        return null;
      }
    } catch (e, stackTrace) {
      final ex =
          Exception('Failed to complete request: ${stackTrace.toString()} ');
      state = AsyncError(ex, stackTrace);
      return null;
    }
  }
}
