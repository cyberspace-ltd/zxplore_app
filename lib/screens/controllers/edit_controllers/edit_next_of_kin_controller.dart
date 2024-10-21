import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/add_edit_next_of_kin.dart';
import 'package:zxplore_app/models/epma_models/delete_next_of_kin_model.dart';
import 'package:zxplore_app/models/epma_models/generic_response.dart';
import 'package:zxplore_app/models/epma_models/get_next_of_kin_to_edit.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_next_of_kin_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_next_of_kin_sreen.dart';

part 'edit_next_of_kin_controller.g.dart';

@riverpod
class EditNextOfKinController extends _$EditNextOfKinController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }
 
  Future<dynamic> editNok(
      {required AddNextOfKin? data,
      required BuildContext context}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.addNextOfKin(nok: data);

      if (requestResponse['status'] == true) {
        final result =
            AddNextOfKin.fromJson(requestResponse);

        // refresh the latest viewed item.
        ref
            .read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(result.requestId ?? '');
        state = AsyncValue.data(result);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ViewNextOfKinScreen(
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
                     throw Exception(requestResponse['message'] ??'Failed to complete request ');

        }
        state = AsyncValue.data(null);
                          throw Exception(requestResponse['message'] ??'Failed to complete request ');

      }
    } catch (e, stackTrace) {
      final ex =
          Exception('Failed to complete request: ${stackTrace.toString()} ');
      state = AsyncError(ex, stackTrace);
                           throw Exception('Failed to complete request ');

    }
  }

  Future<dynamic> addNok(
       {required AddNextOfKin? data,
      required BuildContext context}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.addNextOfKin(nok: data);

      if (requestResponse['status'] == true) {
        final result =
            GenericResponse.fromMap(requestResponse);

        // refresh the latest viewed item.
        ref
            .read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(data?.requestId ?? '');
        state = AsyncValue.data(result);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ViewNextOfKinScreen(
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

@riverpod
class ViewNextOfKinController extends _$ViewNextOfKinController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

  Future<dynamic> getEditData(BuildContext context,
      {required String? RequestId, required int? NextOfKinId}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.getNextOfKinToEdit(
          RequestId: RequestId,NextOfKinId:NextOfKinId );

      if (requestResponse['status'] == true) {
        final result =
            GetNextOfKinToEditResponse.fromJson(requestResponse);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EditNextOfKinScreen(
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

  Future<dynamic> deleteNok(BuildContext context,
      {required String? RequestId, required DeleteNextOfKin? delData}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.deleteNextOfKin(
          delnok: delData, );

      if (requestResponse['status'] == true) {
        final result =
            DeleteNextOfKin.fromJson(requestResponse);
        state = AsyncValue.data(result);

        // refresh the latest viewed item.
        ref.read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(RequestId!);
        state = AsyncValue.data(result);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (BuildContext context) => ViewNextOfKinScreen(
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
