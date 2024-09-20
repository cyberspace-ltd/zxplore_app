import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/edit_personal_details_data.dart';
import 'package:zxplore_app/models/epma_models/get_edit_personal_details_response.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
part 'edit_personal_details_controller.g.dart';


@riverpod
class EditPersonalDetailsController extends _$EditPersonalDetailsController {
  @override
  FutureOr<dynamic> build(){
    //nadaa
  }

  Future<dynamic> getEditData(BuildContext context,{required String? RequestId})async{
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
                builder: (BuildContext context) =>PersonalInfoEditSscreen(data:result ,)
                    ),
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

  Future<dynamic> editPersonalDetailsData({required EditPersonalDetails? editPersonalDetails,})async{
 final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse =
          await repo.editPersonalDetail(editPersonalDetails: editPersonalDetails);

      if (requestResponse['status'] == true) {
        final result = PersonalDetailsResponse.fromMap(requestResponse);
         
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