import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/customer_classification_response.dart';

part 'customer_classification.g.dart';

@Riverpod(keepAlive: true)

/// Get getCustomerClassification
Future<List<CustomerClassificationDatum>?> getCustomerClassification(
 GetCustomerClassificationRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <CustomerClassificationDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getCustomerClassification();

    if (response['status']==true) {
      final result = CustomerClassificationResponse.fromJson(response);
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
