import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/recon_status.dart'; 

part 'recon_status.g.dart';

@Riverpod(keepAlive: true)

/// Get getReconStatus
Future<List<ReconStatusDatum>?> getReconStatus(
 GetReconStatusRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <ReconStatusDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getReconStatus();

    if (response['status']==true) {
      final result = ReconStatusResponse.fromJson(response);
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
