import 'dart:io';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/upload_request.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
part 'document_upload_controller.g.dart';

@riverpod
class FileUploadController extends _$FileUploadController {
  @override
  FutureOr<void> build() {}

  Future<bool> uploadFile(
      {required File file,
      String? url,
      required String? requestId,
      required String? documentType,
      required BuildContext context,
      dynamic afterSuccess}) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncValue.loading();
      final requestResponse = await repo.uploadDocument(
          uploadRequest: UploadRequest(
              files: file,
              requestId: requestId ?? '',
              documentType: documentType ?? ''));
      if (requestResponse['status'] == true) {
        state = AsyncValue.data(null);
        afterSuccess();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ViewInitialCreationInfoScreen(
                    formIndividualData:
                        ref.read(activelyViewedRequestProvider)!.toMap(),
                  )),
        );
        return requestResponse;
      } else {
        if (requestResponse['message'] == 'token expired/invalid') {
          state = AsyncValue.data(requestResponse);
          // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
          final ex = Exception('Failed to complete request ');
          state = AsyncError(
              ex, StackTrace.fromString('An error occured please try again'));

          throw Exception("${requestResponse['message']}");
        }
        throw Exception("${requestResponse['message']}");
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      throw Exception("An error ocurred}");
    }
  }

  Future<bool> addSignature({
    required File file,
    String? url,
    required String? requestId,
    required String? documentType,
  }) async {
    final repo = ref.read(userInfoRepositoryImplProvider);

    try {
      state = const AsyncValue.loading();
      final requestResponse =
          await repo.uploadSignaature(RequestId: requestId, File: file);

      if (requestResponse['status'] == true) {
        state = AsyncValue.data(null);

        /// nav ack  to edit
        return requestResponse;
      } else {
        //check for token exp. and throw
        throw Exception("${requestResponse['message']}");
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      throw Exception("An error ocurred}");
    }
  }
}
