import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/country_response.dart';

part 'countries.g.dart';

@Riverpod(keepAlive: true)

/// Get getAnticipatedAmount
Future<List<CountryDatum>?> getCountries(
 GetCountriesRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <CountryDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getCountries();

    if (response['status']==true) {
      final result = CountryResponse.fromJson(response);
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


@riverpod
/// Get getAnticipatedAmount
Future<List<CountryDatum>?> getSeaarchableCountries(
 GetCountriesRef ref,searchName
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <CountryDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getCountries();

    if (response['status']==true) {
      final result = CountryResponse.fromJson(response);
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
