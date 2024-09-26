import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/edit_funding_sources.dart';
import 'package:zxplore_app/models/epma_models/generic_response.dart';
import 'package:zxplore_app/models/epma_models/get_funding_sources_response.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/create_new_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_funding_sources_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_funding_sources_sreen.dart';

part 'edit_funding_sources_controller.g.dart';

@riverpod
class EditFundingSourcesController extends _$EditFundingSourcesController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }
 
  Future<dynamic> editFundingSourcesData(
      {required EditFundingSource? editFundingData,
      required BuildContext context}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse =
          await repo.editFundingSources(data: editFundingData);

      if (requestResponse['status'] == true) {
         zXFlushBar(context, requestResponse['status']);
        final result = GenericResponse.fromMap(requestResponse);
        // refresh the latest viewed item.
        ref
            .read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(editFundingData!.requestId!);

        state = AsyncValue.data(result);
       /// replace this present view to the last
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => FundingSourcesScreen(
                    requestData:
                        ref.read(activelyViewedRequestProvider)!.toMap(),
                  )),
        );
        return result;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
          state = AsyncValue.data(requestResponse);

          // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
          final ex = Exception('Failed to complete request ');
          state = AsyncError(
              ex, StackTrace.fromString('An error occured please try again'));
        }
            final ex = Exception(
            requestResponse['message'] ?? 'Failed to complete request');
        state = AsyncError(
            ex,
            StackTrace.fromString(
                requestResponse['message'] ?? 'Failed to complete request'));
        return requestResponse;
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
class ViewFundingSourcesController extends _$ViewFundingSourcesController {
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
          await repo.getFundingSourceToEdit(RequestId: RequestId);

      if (requestResponse['status'] == true) {
        final result = GetFundingSourceToEditResponse.fromJson(requestResponse);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EditFundingSourceScreen(
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

