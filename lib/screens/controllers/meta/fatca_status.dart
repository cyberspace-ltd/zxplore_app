import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/business_natures.dart';
import 'package:zxplore_app/models/epma_models/meta/fatca_status_response.dart';

part 'fatca_status.g.dart';

@Riverpod(keepAlive: true)

/// Get FatcaStatusDatum
Future<List<FatcaStatusDatum>?> getFatcaStatus(
 GetFatcaStatusRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <FatcaStatusDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getFatcaStatus();

    if (response['status']==true) {
      final result = FatcaStatusResponse.fromJson(response);
      if (result.data.isNotEmpty == true) {
        for (final element in result.data) {
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
