import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/marital_status_response.dart'; 

part 'marital_status.g.dart';

@Riverpod(keepAlive: true)

/// Get getMaritalStatus
Future<List<MaritalStatusDatum>?> getMaritalStatus(
 GetMaritalStatusRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <MaritalStatusDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getMaritalStatus();

    if (response['status']==true) {
      final result = MaritalStatusResponse.fromJson(response);
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
