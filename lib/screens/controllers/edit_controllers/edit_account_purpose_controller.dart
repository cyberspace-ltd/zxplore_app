import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/edit_account_purpose.dart';
import 'package:zxplore_app/models/epma_models/get_account_purpose_response.dart';
import 'package:zxplore_app/models/epma_models/get_funding_sources_response.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_account_purposes_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_funding_sources_sreen.dart';

part 'edit_account_purpose_controller.g.dart';

@riverpod
class EditAccountPurposeController extends _$EditAccountPurposeController {
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
        final result = GetAccountPurposeToEditResponse.fromJson(requestResponse);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EditAccountPurposeScreen(
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

  Future<dynamic> editAccountPurposeDaata({
    required EditAccountPurpose? data,
  }) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse =
          await repo.editAccountPurpose(data: data);

      if (requestResponse['status'] == true) {
        final result = GetAccountPurposeToEditResponse.fromJson(requestResponse);

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
