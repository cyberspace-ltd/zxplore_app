import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/document_types.dart'; 

part 'get_documents_types.g.dart';

@Riverpod(keepAlive: true)

/// Get getDocumentTypes
Future<List< DocumentTypesDatum>?> getDocumentTypes(
 GetDocumentTypesRef ref,
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <DocumentTypesDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getDocumentTypes();

    if (response['status']==true) {
      final result = DocumentTypesResponse.fromJson(response);
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
