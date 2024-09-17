import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
import 'package:zxplore_app/models/epma_models/user_pending_statistics_ressponse.dart';

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
      final result  = UserPendingStatisticsResponse.fromJson(statsResponse);
      AsyncValue.data(result.data);
      return result.data;
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
