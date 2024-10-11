import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/add_edit_stake_holder.dart';
import 'package:zxplore_app/models/epma_models/delete_stake_holder.dart';
import 'package:zxplore_app/models/epma_models/generic_response.dart';
import 'package:zxplore_app/models/epma_models/get_stake_holder_response.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_stake_holder_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_stake_holder_sreen.dart';

part 'edit_stake_holders_controller.g.dart';

@riverpod
class EditStakeHoldersController extends _$EditStakeHoldersController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

  
  Future<dynamic> addStakeHolder(
      {required AddStakeholder? editAccount,
      required BuildContext context}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse =
          await repo.addStakeHolder(holder: editAccount);

      if (requestResponse['status'] == true) {
        final result = GenericResponse.fromMap(requestResponse);
        // refresh the latest viewed item.
        ref.read(viewRequestControllerProvider.notifier).getRequestDetailAsync(editAccount?.requestId??'');

        state = AsyncValue.data(result);
       /// replace this present view to the last
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => StackHolderdersScreen(
                    formIndividualData:
                        ref.read(activelyViewedRequestProvider)!.toMap(),
                  )),
        );

        return result;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
          // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
          final ex = Exception(requestResponse['message']??'Failed to complete request ');
          state = AsyncError(
              ex, StackTrace.fromString(requestResponse['message']??'An error occured please try again'));
          return requestResponse;
        }
      final ex = Exception(requestResponse['message']??'Failed to complete request ');
          state = AsyncError(
              ex, StackTrace.fromString(requestResponse['message']??'An error occured please try again'));
       
        return requestResponse;
      }
    } catch (e, stackTrace) {
      final ex =
          Exception('Failed to complete request: ${stackTrace.toString()} ');
      state = AsyncError(ex, stackTrace);
      return null;
    }
  }

  Future<dynamic> editStakeHolder(
      {required AddStakeholder? editAccount,
      required BuildContext context}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.editStakeHolder(holder: editAccount);
      if (requestResponse['status'] == true) {
        final result = GenericResponse.fromMap(requestResponse);
        // refresh the latest viewed item.
        ref.read(viewRequestControllerProvider.notifier).getRequestDetailAsync(editAccount?.requestId??'');

        state = AsyncValue.data(result);
       /// replace this present view to the last
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => StackHolderdersScreen(
                    formIndividualData:
                        ref.read(activelyViewedRequestProvider)!.toMap(),
                  )),
        );
        return result;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
          // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
          final ex = Exception(requestResponse['message']??'Failed to complete request ');
          state = AsyncError(
              ex, StackTrace.fromString(requestResponse['message']??'An error occured please try again'));
         return requestResponse;
        }
           final ex = Exception('Failed to complete request ');
          state = AsyncError(
              ex, StackTrace.fromString('An error occured please try again'));
      
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
class ViewStakeHoldersController extends _$ViewStakeHoldersController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

  Future<dynamic> getEditData
  
  (BuildContext context,
      {required int? StakeHolderId,required String? RequestId}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse =
          await repo.getStakeHolderToEdit(StakeHolderId: StakeHolderId,RequestId:RequestId );

      if (requestResponse['status'] == true) {
        final result = GetStakeHolderToEditResponse.fromJson(requestResponse);
        state = AsyncValue.data(result);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EditStakeHolderScreen(
                    data: result,
                  )),
        );
        return result;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
            // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
          final ex = Exception(requestResponse['message']??'Failed to complete request ');
          state = AsyncError(
              ex, StackTrace.fromString(requestResponse['message']??'An error occured please try again'));
        
          return requestResponse;
        }else{
         final ex = Exception(requestResponse['message']??'Failed to complete request ');
          state = AsyncError(
              ex, StackTrace.fromString(requestResponse['message']??'An error occured please try again'));
       
        return requestResponse;
        }
      }
    } catch (e, stackTrace) {
      final ex =
          Exception('Failed to complete request: ${stackTrace.toString()} ');
      state = AsyncError(ex, stackTrace);
      return null;
    }
  }

    Future<dynamic> deleteStakeHolder(BuildContext context,
      {required String? RequestId, required DeleteStakeHolder? delData}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.deleteStakeHolder(
          holder: delData);

      if (requestResponse['status'] == true) {
        final result =
            DeleteStakeHolder.fromJson(requestResponse);
        state = AsyncValue.data(result);

        // refresh the latest viewed item.
        ref.read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(RequestId!);
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

}