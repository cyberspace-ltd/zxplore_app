import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/edit_account_purpose.dart';
import 'package:zxplore_app/models/epma_models/generic_response.dart';
import 'package:zxplore_app/models/epma_models/get_account_purpose_response.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_account_purposes_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_account_purposes_sreen.dart';
import 'package:zxplore_app/utils/app_strings.dart';
import 'package:zxplore_app/widgets/alert_dialogs.dart';

part 'edit_account_purpose_controller.g.dart';

@riverpod
class EditAccountPurposeController extends _$EditAccountPurposeController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

  Future<dynamic> editAccountPurposeDaata(
      {required EditAccountPurpose? data,
      required BuildContext context}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.editAccountPurpose(data: data);

      if (requestResponse['status'] == true) {
        final result = GenericResponse.fromMap(requestResponse);
        state = AsyncValue.data(result);

        // refresh the latest viewed item.
        ref
            .read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(context,data?.requestId ?? '');

        state = AsyncValue.data(result);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AccountPurposeScreen(
                    requestData:
                        ref.read(activelyViewedRequestProvider)!.toMap(),
                  )),
        );
        return result;
      }else {
        if (requestResponse['message'] == 'token expired/invalid') {
          // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
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
      showErrorDialog(context,  AppStrings.errorInProcessing);
      return null;

    }
  }



}

@riverpod
class ViewAccountPurposeController extends _$ViewAccountPurposeController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

  Future<dynamic> getEditData(BuildContext context,
      {required String? RequestId}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse =
          await repo.getAccountPurposeToEdit(RequestId: RequestId);

      if (requestResponse['status'] == true) {
        final result =
            GetAccountPurposeToEditResponse.fromJson(requestResponse);
        state = AsyncValue.data(result);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EditAccountPurposeScreen(
                    data: result,
                  )),
        );

        return result;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
          // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
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
      showErrorDialog(context,  AppStrings.errorInProcessing);
      return null;

    }
  }
}
