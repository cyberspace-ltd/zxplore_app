import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/widgets/alert_dialogs.dart';
part 'view_request_controller.g.dart';

@riverpod
class ViewRequestController extends _$ViewRequestController {
  @override
  FutureOr<dynamic> build() {
    return null;
  }

  Future<dynamic> getRequestDetailAsync(BuildContext context,String requestId) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse =
          await repo.viewAccountRequest(RequestId: requestId);

      if (requestResponse['status'] == true) {
        final result = ViewAccountRequestResponse.fromMap(requestResponse);

        ref
            .read(activelyViewedRequestProvider.notifier)
            .updateRequestState(result);
        state = AsyncValue.data(result);
        return result;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
          await ref.read(loginControllerProvider.notifier).extRenewToken();
          // Update state before showing error
          state = AsyncError(
            Exception('Session expired. Please try again.'),
            StackTrace.current,
          );
          showErrorDialog(context, 'Session expired. Please try again.');
          return null;
        }
        // Update state for other errors
        final errorMessage = requestResponse['message'] ?? 'Failed to complete request';
        state = AsyncError(
          Exception(errorMessage),
          StackTrace.current,
        );
        showErrorDialog(context, errorMessage);
        return null;
      }
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      showErrorDialog(context, 'Something went wrong completing request,Try  again.');
      return null;
    }
  }
}
