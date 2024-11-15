import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/account_types.dart';

part 'get_account_types.g.dart';

@Riverpod(keepAlive: true)

/// Get getAccountTypes
Future<List< AccountTypesDatum>?> getAccountTypes(
 GetAccountTypesRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <AccountTypesDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getDocumentTypes();
    print("TYPES:: $response");

    if (response['status']==true) {
      final result = AccountTypesResponse.fromJson(response);
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
