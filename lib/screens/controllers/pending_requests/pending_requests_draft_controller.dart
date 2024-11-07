import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/pending_requests_all_response.dart';
import 'package:zxplore_app/models/epma_models/pending_requests_drafts.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/widgets/alert_dialogs.dart';

part 'pending_requests_draft_controller.g.dart';

@riverpod

/// Get getPendingRequestsDraftDatum
Future<List<PendingRequestsDatum>?> getPendingRequestsDraftDatum( GetPendingRequestsDraftDatumRef ref,BuildContext  ctx,
 
) async {
  final repo = ref.read(userInfoRepositoryImplProvider);

  final requestsList = <PendingRequestsDatum>[];

  try {
    const AsyncLoading();
    final draftPendingResponse = await repo.getUserPendingDraftRepo();

    if (draftPendingResponse['status'] == true) {
      final allDrats =
          PendingRequestsDraftsResponse.fromJson(draftPendingResponse);
      if (allDrats.data!.isNotEmpty == true) {
        for (final element in allDrats.data!) {
          requestsList.add(element);
        }
        AsyncData(requestsList.reversed);
        return requestsList;
      } else {
        const AsyncData([]);
           showErrorDialog(ctx, draftPendingResponse['message'] ?? 'Failed to complete request ');
          return null;
         
      }
    } else {
        if ( draftPendingResponse['message'] == 'token expired/invalid') {
          await ref.read(loginControllerProvider.notifier).extRenewToken();
          // Update state before showing error
           AsyncError(
            Exception('Session expired. Please try again.'),
            StackTrace.current,
          );
          showErrorDialog(ctx, 'Session expired. Please try again.');
          return null;
        }
        // Update state for other errors
        final errorMessage =  draftPendingResponse['message'] ?? 'Failed to complete request';
         AsyncError(
          Exception(errorMessage),
          StackTrace.current,
        );
        showErrorDialog(ctx, errorMessage);
        return null;
      }
  } catch (e, stackTrace) {
       AsyncError(e, stackTrace);
      showErrorDialog(ctx, e.toString());
      return null;
  }
}
