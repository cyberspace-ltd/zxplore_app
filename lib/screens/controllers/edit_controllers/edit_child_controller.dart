import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/delete_child.dart';
import 'package:zxplore_app/models/epma_models/add_edit_child.dart';
import 'package:zxplore_app/models/epma_models/generic_response.dart';
import 'package:zxplore_app/models/epma_models/get_child_to_edite_response.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_children_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_children_sreen.dart';

part 'edit_child_controller.g.dart';

@riverpod
class EditChildController extends _$EditChildController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

  Future<dynamic> editChild(
      {required AddChild? data,
      required BuildContext context}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.editChild(child: data);

      if (requestResponse['status'] == true) {
             final result = GenericResponse.fromMap(requestResponse);
        // refresh the latest viewed item.
        ref
            .read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(data?.requestId ?? '');
        state = AsyncValue.data(result);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ViewChildrenScreen(
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
  Future<dynamic> addChild(
         {required AddChild? data,
      required BuildContext context}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.addChild(child: data);

      if (requestResponse['status'] == true) {
                  final result = GenericResponse.fromMap(requestResponse);
        // refresh the latest viewed item.
        ref
            .read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(data?.requestId ?? '');
        state = AsyncValue.data(result);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ViewChildrenScreen(
                    formIndividualData:
                        ref.watch(activelyViewedRequestProvider)!.toMap(),
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

@riverpod
class ViewChildController extends _$ViewChildController {
  @override
  FutureOr<dynamic> build() {
    //nadaa
  }

  Future<dynamic> getEditData(BuildContext context,
      {required String? RequestId, required int? ChildId}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.getChildToEdit(
          RequestId: RequestId,ChildId:ChildId );

      if (requestResponse['status'] == true) {
        final result =
            GetChildToEditResponse.fromJson(requestResponse);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EditChildScreen(
                  data  : result,
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

  Future<dynamic> deleteChild(BuildContext context,
      {required String? RequestId, required DeleteChild? delData}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.deleteChild(
          delchild: delData, );

      if (requestResponse['status'] == true) {
        final result =
            DeleteChild.fromJson(requestResponse);
        state = AsyncValue.data(result);

        // refresh the latest viewed item.
        ref.read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(RequestId!);
        state = AsyncValue.data(result);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (BuildContext context) => ViewChildrenScreen(
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
  }}
