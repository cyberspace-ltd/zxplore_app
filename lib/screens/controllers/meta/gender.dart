import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/business_natures.dart';
import 'package:zxplore_app/models/epma_models/meta/fatca_status_response.dart';
import 'package:zxplore_app/models/epma_models/meta/gender_response.dart';

part 'gender.g.dart';

@Riverpod(keepAlive: true)

/// Get getGender
Future<List<GendersDatum>?> getGender(
 GetGenderRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <GendersDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getGenders();

    if (response['status']==true) {
      final result = GendersResponse.fromJson(response);
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
