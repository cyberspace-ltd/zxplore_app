import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/delete_assigned_acc.dart';
import 'package:zxplore_app/models/epma_models/add_account_model.dart';
import 'package:zxplore_app/models/epma_models/delete_other_bank_account.dart';
import 'package:zxplore_app/models/epma_models/generic_response.dart';
import 'package:zxplore_app/models/epma_models/get_other_bank_to_edit_response.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_other_accounts_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_other_accounts_sreen.dart';
import 'package:zxplore_app/widgets/alert_dialogs.dart';

part 'edit_other_account_controller.g.dart';

@riverpod
class EditOtherAccountController extends _$EditOtherAccountController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

  Future<dynamic> editOtherBankAccount(
      {required AddOtherBankAccount? data,
      required BuildContext context}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.editOtherBankAccount(data: data);

      if (requestResponse['status'] == true) {
        final result = GenericResponse.fromMap(requestResponse);

        // refresh the latest viewed item.
        ref
            .read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(context,data?.requestId ?? '');
        state = AsyncValue.data(result);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ViewOtherAccounts(
                    requestData:
                        ref.read(activelyViewedRequestProvider)!.toMap(),
                  )),
        );
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
      showErrorDialog(context, e.toString());
      return null;
    }
  }

  Future<dynamic> addOtherBankAccount(
      {required AddOtherBankAccount? data,
      required BuildContext context}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.addOtherBankAccount(data: data);

      if (requestResponse['status'] == true) {
        final result = GenericResponse.fromMap(requestResponse);

        // refresh the latest viewed item.
        ref
            .read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(context,data?.requestId ?? '');
        state = AsyncValue.data(result);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ViewOtherAccounts(
                    requestData:
                        ref.read(activelyViewedRequestProvider)!.toMap(),
                  )),
        );
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
      showErrorDialog(context, e.toString());
      return null;
    }
  }
}

@riverpod
class ViewOtherAccountController extends _$ViewOtherAccountController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

  Future<dynamic> getEditData(BuildContext context,
      {required String? RequestId, required int? OtherAccountsId}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.getOtherBankAccountToEdit(
          RequestId: RequestId, OtherAccountsId: OtherAccountsId);

      if (requestResponse['status'] == true) {
        final result =
            GetOtherBankAccountToEditResponse.fromJson(requestResponse);
        state = AsyncValue.data(result);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => EditOherBankAccountScreen(
              data: result,
            ),
          ),
          (Route<dynamic> route) => false,
        );
        return result;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
          // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
          final ex = Exception(
              requestResponse['message'] ?? 'Failed to complete request ');
          state = AsyncError(
              ex,
              StackTrace.fromString(requestResponse['message'] ??
                  'An error occured please try again'));
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

  Future<dynamic> deleteOtherBankAccountData(BuildContext context,
      {required String? RequestId,
      required DeleteOtherBankAccount? delData}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.deleteOtherBankAccount(
        data: delData,
      );

      if (requestResponse['status'] == true) {
        final result =
            DeleteAssignedAccountToEditResponse.fromJson(requestResponse);

        // refresh the latest viewed item.
        ref
            .read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(context,RequestId!);

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
}
