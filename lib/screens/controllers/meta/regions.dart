import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/region_response.dart'; 

part 'regions.g.dart';

@Riverpod(keepAlive: true)

/// Get getRegions
Future<List<RegionDatum>?> getRegions(
 GetRegionsRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <RegionDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getRegions();

    if (response['status']==true) {
      final result = RegionsResponse.fromJson(response);
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
