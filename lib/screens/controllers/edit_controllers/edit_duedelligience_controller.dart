import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/edit_duedeligience.dart';
import 'package:zxplore_app/models/epma_models/get_due_delligience_to_edit.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_due_deligience_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_due_deligience_sreen.dart';

part 'edit_duedelligience_controller.g.dart';

@riverpod
class EditDueDilligienceController extends _$EditDueDilligienceController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

  Future<dynamic> getEditData(BuildContext context,
      {required String? RequestId,}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.getDueDiligenceToEdit(
          RequestId: RequestId );

      if (requestResponse['status'] == true) {
        final result =
            GetDueDiligenceToEdit.fromJson(requestResponse);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EditDueDilligienceScreen(
                    data: result,
                  )),
        );
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
        state = AsyncError(Exception(requestResponse['message']),
            StackTrace.fromString(requestResponse['message']));
        return null;
      }
    } catch (e, stackTrace) {
      final ex =
          Exception('Failed to complete request: ${stackTrace.toString()} ');
      state = AsyncError(ex, stackTrace);
      return null;
    }
  }


  Future<dynamic> editDueDilligience(
      {required EditDueDiligence? data,
      required BuildContext context}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.editDueDiligence(dd: data);

      if (requestResponse['status'] == true) {
        final result =
            EditDueDiligence.fromJson(requestResponse);

        // refresh the latest viewed item.
        ref
            .read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(data?.requestId ?? '');
        state = AsyncValue.data(result);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ViewDueDilligience(
                    formIndividualData:
                        ref.read(activelyViewedRequestProvider)!.toMap(),
                  )),
        );
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
