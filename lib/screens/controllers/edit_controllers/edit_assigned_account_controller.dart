import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/delete_assigned_acc.dart';
import 'package:zxplore_app/models/epma_models/generic_response.dart';
import 'package:zxplore_app/models/epma_models/get_assigned_account_to_edit_response.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_assigned_type_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_assigned_type_sreen.dart';

part 'edit_assigned_account_controller.g.dart';

@riverpod
class EditAssignedAccountController extends _$EditAssignedAccountController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

 
 Future<dynamic> editAssignedAAccount(
      {required AssignedAccountToEditData? data,
      required BuildContext context}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.editAssignedAccount(data: data);

      if (requestResponse['status'] == true) {
          final result = GenericResponse.fromMap(requestResponse);
        state = AsyncValue.data(result);

          // refresh the latest viewed item.
        ref.read(viewRequestControllerProvider.notifier).getRequestDetailAsync(data?.reqId??'');
        state = AsyncValue.data(result);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ViewAssignedAccountScreen(
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
        return null;
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

 Future<dynamic> addAssignedAccount(
      {required GenerateAssignedAccount? data,String?  reqId,
      required BuildContext context}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.addAssignedAccount(data: data);

      if (requestResponse['status'] == true) {
          final result = GenericResponse.fromMap(requestResponse);
        state = AsyncValue.data(result);

          // refresh the latest viewed item.
        ref.read(viewRequestControllerProvider.notifier).getRequestDetailAsync(reqId??'');
        state = AsyncValue.data(result);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ViewAssignedAccountScreen(
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
        return null;
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


@riverpod
class ViewAssignedAccountController extends _$ViewAssignedAccountController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

  Future<dynamic> getEditData(BuildContext context,
      {required String? RequestId, required int? AssignedAcctId}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.getAssignedAccountToEdit(
          RequestId: RequestId, AssignedAcctId: AssignedAcctId);

      if (requestResponse['status'] == true) {
        final result =
            GetAssignedAccountToEditResponse.fromJson(requestResponse);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EditAssignedAccout(
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

 
  Future<dynamic> deleteAssignedAccountData(BuildContext context,
      {required String? RequestId, required int? AssignedAcctId}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.deleteAssignedAccount(
          RequestId: RequestId, AssignedAcctId: AssignedAcctId);

      if (requestResponse['status'] == true) {
        final result =
            DeleteAssignedAccountToEditResponse.fromJson(requestResponse);
        state = AsyncValue.data(result);

        // refresh the latest viewed item.
        ref.read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(RequestId!);
        state = AsyncValue.data(result);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (BuildContext context) => ViewAssignedAccountScreen(
        //             formIndividualData:
        //                 ref.read(activelyViewedRequestProvider)!.toMap(),
        //           )),
        // );
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
}
