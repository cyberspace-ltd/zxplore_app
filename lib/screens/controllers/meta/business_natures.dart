import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/business_natures.dart';

part 'business_natures.g.dart';

@Riverpod(keepAlive: true)

/// Get getAnticipatedAmount
Future<List<BusinessNaturesDatum>?> getBusinessNatures(
 GetBusinessNaturesRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <BusinessNaturesDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getBusinessNatures();

    if (response['status']==true) {
      final result = BusinessNaturesResponse.fromJson(response);
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
