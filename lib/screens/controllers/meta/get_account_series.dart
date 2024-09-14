import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/account_series_response.dart'; 

part 'get_account_series.g.dart';

@Riverpod(keepAlive: true)

/// Get getAccountSeries
Future<List<AccountSeriesDatum>?> getAccountSeries(
 GetAccountSeriesRef ref,String? requiestId, String? accountType
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <AccountSeriesDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getAccountSeries(requestId: requiestId,accountType: accountType);

    if (response['status']==true) {
      final result = AccountSeriesResponse.fromJson(response);
      if (result.data.isNotEmpty == true) {
        for (final element in response.data!) {
          responseList.add(element);
        }
        AsyncData(responseList);
        return responseList;
      } else {
        const AsyncData([]);
        return [];
      }
    }
    return responseList;
  } catch (e, stackTrace) {
    final ex =
        Exception('Failed to load contents: ${stackTrace.toString()} ');
    AsyncError(ex, stackTrace);
    return null;
  }
}
