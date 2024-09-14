import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/anticipated_amounts.dart';

part 'anticiapted_amount.g.dart';

@Riverpod(keepAlive: true)

/// Get getAnticipatedAmount
Future<List<AnticipatedAmountsDatum>?> getAnticipatedAmount(
 GetAnticipatedAmountRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final amountsList = <AnticipatedAmountsDatum>[];

  try {
    const AsyncLoading();
    final amountsResponse =    await repo.getAnticipatedAmounts();

    if (amountsResponse['status']==true) {
      final result = AnticipatedAmountsResponse.fromJson(amountsResponse);
      if (result.data.isNotEmpty == true) {
        for (final element in result.data) {
          amountsList.add(element);
        }
        AsyncData(amountsList);
        return amountsList;
      } else {
        const AsyncData([]);
        return [];
      }
    }
    return amountsList;
  } catch (e, stackTrace) {
    final ex =
        Exception('Failed to load contents: ${stackTrace.toString()} ');
    AsyncError(ex, stackTrace);
    return null;
  }
}
