import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/search_options_response.dart'; 

part 'search_options.g.dart';

@Riverpod(keepAlive: true)

/// Get getSearchOptions
Future<List<SearchOptionDatum>?> getSearchOptions(
 GetSearchOptionsRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <SearchOptionDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getSearchOptions();

    if (response['status']==true) {
      final result = SearchOptionResponse.fromJson(response);
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
