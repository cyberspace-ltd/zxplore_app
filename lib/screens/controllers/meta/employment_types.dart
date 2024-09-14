import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/employment_type_response.dart';

part 'employment_types.g.dart';

@Riverpod(keepAlive: true)

/// Get getCustomerClassification
Future<List<EmploymentTypeDatum>?> getEmploymentType(
 GetEmploymentTypeRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <EmploymentTypeDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getEmployTypes();

    if (response['status']==true) {
      final result = EmploymentTypeResponse.fromJson(response);
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
