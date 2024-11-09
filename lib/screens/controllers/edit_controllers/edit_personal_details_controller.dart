import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/edit_personal_details_data.dart';
import 'package:zxplore_app/models/epma_models/generic_response.dart';
import 'package:zxplore_app/models/epma_models/get_edit_personal_details_response.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/utils/app_strings.dart';
import 'package:zxplore_app/widgets/alert_dialogs.dart';
part 'edit_personal_details_controller.g.dart';

@riverpod
class EditPersonalDetailsController extends _$EditPersonalDetailsController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

  Future<dynamic> editPersonalDetailsData({
    required EditPersonalDetails? editPersonalDetails,
    required context,
    VoidCallback? afterSuccess,
    VoidCallback? afterFailed,
  }) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      debugPrint('PASSED::${editPersonalDetails.toString()}');
      final requestResponse =
          await repo.editPersonalDetail(data: editPersonalDetails);

      if (requestResponse['status'] == true) {
        final result = GenericResponse.fromMap(requestResponse);
        state = AsyncValue.data(result);

        // refresh the latest viewed item.
        ref
            .read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(context,editPersonalDetails?.requestId ?? '');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ViewInitialCreationInfoScreen(
                    formIndividualData:
                        ref.read(activelyViewedRequestProvider)!.toMap(),
                  )),
        );

        return result;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
          state = AsyncValue.data(requestResponse);
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
class ViewPersonalDetailsController extends _$ViewPersonalDetailsController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

  Future<dynamic> getEditData(
    BuildContext context, {
    required String? RequestId,
    VoidCallback? afterSuccess,
    VoidCallback? afterFailed,
  }) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse =
          await repo.getPersonalDetailToEdit(RequestId: RequestId);

      if (requestResponse['status'] == true) {
        final result = PersonalDetailsResponse.fromMap(requestResponse);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PersonalInfoEditSscreen(
                    data: result,
                  )),
        );
        state = AsyncValue.data(result);
        return result;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
          state = AsyncValue.data(requestResponse);

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
