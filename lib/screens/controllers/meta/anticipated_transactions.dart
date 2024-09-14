import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/anticipated_transactions.dart';

part 'anticipated_transactions.g.dart';

@Riverpod(keepAlive: true)

/// Get getAnticipatedAmount
Future<List<AnticipatedTransactionsDatum>?> getAnticipatedTransaction(
 GetAnticipatedTransactionRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final trxnList = <AnticipatedTransactionsDatum>[];

  try {
    const AsyncLoading();
    final trxnResponse =    await repo.getAnticipatedTransactions();

    if (trxnResponse['status']==true) {
      final result = AnticipatedTransactionsResponse.fromJson(trxnResponse);
      if (result.data.isNotEmpty == true) {
        for (final element in result.data) {
          trxnList.add(element);
        }
        AsyncData(trxnList);
        return trxnList;
      } else {
        const AsyncData([]);
        return [];
      }
    }
    return trxnList;
  } catch (e, stackTrace) {
    final ex =
        Exception('Failed to load contents: ${stackTrace.toString()} ');
    AsyncError(ex, stackTrace);
    return null;
  }
}
