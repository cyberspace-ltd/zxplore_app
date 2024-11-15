import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/account_class_response.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';

part 'get_account_class.g.dart';

@Riverpod(keepAlive: true)

/// Get getGender
Future<List<AccountClassDatum>?> getAccountClass(
 GetAccountClassRef ref,  String? accountTypeValue ,String? seriesCodeValue
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <AccountClassDatum>[];
  final reqId = ref.read(activelyViewedRequestProvider);


  try {
    const AsyncLoading();
    final response =    await repo.getAccountClass(requestId: reqId?.data?.reqId??'',accountType: accountTypeValue,seriesCode:seriesCodeValue);

    if (response['status']==true) {
      final result = AccountClassResponse.fromJson(response);
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
