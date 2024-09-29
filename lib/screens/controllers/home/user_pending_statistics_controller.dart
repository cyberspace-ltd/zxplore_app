import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/user_pending_statistics_ressponse.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';

part 'user_pending_statistics_controller.g.dart';

@riverpod
Future<StatisticsData?> getUserStatisticsData(
  GetUserStatisticsDataRef ref,
) async {
  final repo = ref.read(userInfoRepositoryImplProvider);

  try {
    const AsyncLoading();
    final statsResponse = await repo.getUserPendingStatisticsRepo();

    if (statsResponse['status'] == true) {
      final result = UserPendingStatisticsResponse.fromJson(statsResponse);
      AsyncValue.data(result.data);
      return result.data;
    } else if (statsResponse['message'] == 'token expired/invalid') {
      AsyncValue.data(statsResponse);
      // renew token
      ref.read(loginControllerProvider.notifier).extRenewToken();
      final ex = Exception('Failed to complete request ');
      AsyncError(
          ex, StackTrace.fromString('An error occured please try again'));
      return statsResponse;
    } else {
      AsyncValue.data(null);
      return null;
    }
  } catch (e, stackTrace) {
    final ex =
        Exception('Failed to Docs Categories: ${stackTrace.toString()} ');
    AsyncError(ex, stackTrace);
    return null;
  }
}
