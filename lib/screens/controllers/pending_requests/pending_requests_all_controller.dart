import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/pending_requests_all_response.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/utils/app_exception.dart';

part 'pending_requests_all_controller.g.dart';

@riverpod

/// Get getPendingRequestsAllDatum
Future<List<PendingRequestsDatum>?> getPendingRequestsAllDatum(
    GetPendingRequestsAllDatumRef ref, ) async {
  final repo = ref.read(userInfoRepositoryImplProvider);

  final requestsList = <PendingRequestsDatum>[];

  try {
    const AsyncLoading();
    final allPendingResponse = await repo.getUserPendingAllRepo();

    if (allPendingResponse['status'] == true) {
      final allPending= PendingRequestAllResponse.fromJson(allPendingResponse);
      if (allPending.data!.isNotEmpty == true) {
        for (final element in allPending.data!) {
          requestsList.add(element);
        }
        AsyncData(requestsList);
        return requestsList;
      } else {
        const AsyncData([]);
        return [];
      }
    } else {
      if (allPendingResponse['message'] == 'token expired/invalid' ||
          allPendingResponse['code'] == 401) {
            ref.read(loginControllerProvider.notifier).extRenewToken();
        throw AppException('${allPendingResponse['message']}');
       
      } else {
        throw AppException('${allPendingResponse['message']}');
      }
    }

  } catch (e, stackTrace) {
    final ex = Exception('Failed to requests: ${stackTrace.toString()} ');
    AsyncError(ex, stackTrace);
    return null;
  }
}
