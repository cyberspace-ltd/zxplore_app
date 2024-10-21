import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/complete_request_response.dart';
import 'package:zxplore_app/models/epma_models/process_request_response.dart';
import 'package:zxplore_app/models/epma_models/validate_request_response.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
part 'submit_account_request_controller.g.dart';

@riverpod
class SubmitAccountRequestController extends _$SubmitAccountRequestController {
  FutureOr<dynamic> build() {
//nada
  }

  Future<dynamic> validateRequestForSubmission(
      {required String? RequestId}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse =
          await repo.validateRequestForSubmission(RequestId: RequestId);

      if (requestResponse['status'] == true) {
        final result = ValidateRequestRsponse.fromMap(requestResponse);

        state = AsyncValue.data(result);
        return result;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
          // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
          final ex = Exception('Failed to complete request ');
          state = AsyncError(
              ex, StackTrace.fromString('An error occured please try again'));
          throw Exception(
              requestResponse['message'] ?? 'Failed to complete request ');
        }
        state = AsyncError(Exception(requestResponse['message']),
            StackTrace.fromString(requestResponse['message']));
        throw Exception(
            requestResponse['message'] ?? 'Failed to complete request ');
      }
    } catch (e, stackTrace) {
      final ex =
          Exception('Failed to complete request: ${stackTrace.toString()} ');
      state = AsyncError(ex, stackTrace);
      throw Exception('Failed to complete request ');
    }
  }

  Future<dynamic> processRequestExternal({required String? RequestId}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse =
          await repo.processRequestExternal(RequestId: RequestId);

      if (requestResponse['status'] == true) {
        final result = ProcessRequestResponse.fromMap(requestResponse);

        state = AsyncValue.data(result);
        return result;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
          // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
          final ex = Exception('Failed to complete request ');
          state = AsyncError(
              ex, StackTrace.fromString('An error occured please try again'));
          throw Exception(
              requestResponse['message'] ?? 'Failed to complete request ');
        }
        state = AsyncError(Exception(requestResponse['message']),
            StackTrace.fromString(requestResponse['message']));
        throw Exception(
            requestResponse['message'] ?? 'Failed to complete request ');
      }
    } catch (e, stackTrace) {
      final ex =
          Exception('Failed to complete request: ${stackTrace.toString()} ');
      state = AsyncError(ex, stackTrace);
      throw Exception('Failed to complete request ');
    }
  }

  Future<dynamic> completeRequest({required String? RequestId}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.completeRequest(RequestId: RequestId);

      if (requestResponse['status'] == true) {
        final result = CompleteRequestRsponse.fromMap(requestResponse);

        state = AsyncValue.data(result);
        return result;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
          // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
          final ex = Exception('Failed to complete request ');
          state = AsyncError(
              ex, StackTrace.fromString('An error occured please try again'));
                     throw Exception(requestResponse['message'] ??'Failed to complete request ');

        }
        state = AsyncError(Exception(requestResponse['message']),
            StackTrace.fromString(requestResponse['message']));
                     throw Exception(requestResponse['message'] ??'Failed to complete request ');
       
      }
    } catch (e, stackTrace) {
      final ex =
          Exception('Failed to complete request: ${stackTrace.toString()} ');
      state = AsyncError(ex, stackTrace);
                          throw Exception('Failed to complete request ');

    }
  }
}
