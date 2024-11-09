import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/delete_document.dart';
import 'package:zxplore_app/models/epma_models/generic_response.dart';
import 'package:zxplore_app/models/epma_models/get_doc_obtained_response.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_attached_document.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_document_attached_sreen.dart';
import 'package:zxplore_app/utils/app_strings.dart';
import 'package:zxplore_app/widgets/alert_dialogs.dart';

part 'edit_documents_obtained_controller.g.dart';


@riverpod
class EditDocumentsObtainedController extends _$EditDocumentsObtainedController {

  @override
  FutureOr<dynamic> build() {
    //nadaa
  }
  

Future<dynamic> getEditData(BuildContext context,
      {required String? RequestId,required int? DocumentsAttachedId, }) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.getDocumentAttachedToEdit(
          RequestId: RequestId,DocumentsAttachedId:DocumentsAttachedId, );

      if (requestResponse['status'] == true) {
        final result =
            GetDocumentAttachedToEditResponse.fromJson(requestResponse);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EditAttachedDocument(
                  data  : result,
                  )),
        );
        state = AsyncValue.data(result);
        return result;
      }  else {
        if (requestResponse['message'] == 'token expired/invalid') {
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


Future<dynamic> deletDocument(BuildContext context,
      {required DeleteDocument? deleteDocumentData,required String? RequestId, }) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncLoading();
      final requestResponse = await repo.deleteDocumentAttached(
          deleteDocument:deleteDocumentData, );

      if (requestResponse['status'] == true) {
        final result =
            GenericResponse.fromMap(requestResponse);
        // refresh the latest viewed item.
        ref.read(viewRequestControllerProvider.notifier)
            .getRequestDetailAsync(context,RequestId!);
        state = AsyncValue.data(result);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ViewDocumentsAttachedScreen(
                    formIndividualData:
                        ref.read(activelyViewedRequestProvider)!.toMap(),
                  )));
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





}