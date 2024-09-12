import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/pending_requests_all_response.dart';
import 'package:zxplore_app/models/epma_models/pending_requests_drafts.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/utils/app_exception.dart';

part 'pending_requests_draft_controller.g.dart';

@riverpod

/// Get getPendingRequestsDraftDatum
Future< List<PendingRequestsDatum>?> getPendingRequestsDraftDatum(
  GetPendingRequestsDraftDatumRef ref,
) async {
  final repo = ref.read(userInfoRepositoryImplProvider);

  final requestsList = <PendingRequestsDatum>[];

  try {
    const AsyncLoading();
    final draftPendingResponse =
        await repo.getUserPendingDraftRepo();

    if (draftPendingResponse['status']==true) {
      final allDrats = PendingRequestsDraftsResponse.fromJson(draftPendingResponse);
      if (allDrats.data!.isNotEmpty == true) {
        for (final element in allDrats.data!) {
          requestsList.add(element);
        }
        AsyncData(requestsList);
        return requestsList;
      } else {
        const AsyncData([]);
        return [];
      }
    }else {
      if (draftPendingResponse['message'] == 'token expired/invalid' ||
          draftPendingResponse['code'] == 401) {
            ref.read(loginControllerProvider.notifier).extRenewToken();
        throw AppException('${draftPendingResponse['message']}');
       
      } else {
        throw AppException('${draftPendingResponse['message']}');
      }
}
  } catch (e, stackTrace) {
    final ex =
        Exception('Failed to requests: ${stackTrace.toString()} ');
    AsyncError(ex, stackTrace);
    return null;
  }
}
