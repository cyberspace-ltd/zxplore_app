import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/repository/providers/meta_data_provider.dart';
import 'package:zxplore_app/models/epma_models/meta/sub_business_natures_response.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart'; 

part 'sub_business_natures.g.dart';

@Riverpod(keepAlive: true)

/// Get getSubBusinessNatures
Future<List<SubBusinessNatureDatum>?> getSubBusinessNatures(
 GetSubBusinessNaturesRef ref,int? businessNatureId
) async {
  final repo = ref.read(metaRepositoryImplProvider);
  final responseList = <SubBusinessNatureDatum>[];

  try {
    const AsyncLoading();
    final response =    await repo.getSubBusinessNatures(businessNatureId:businessNatureId);

    if (response['status']==true) {
      final result = SubBusinessNatureResponse.fromJson(response);
      
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
    }else{
       if (response['message'] == 'token expired/invalid') {
          AsyncValue.data([]);
          // renew token
          ref.read(loginControllerProvider.notifier).extRenewToken();
        final res2=  await repo.getSubBusinessNatures(businessNatureId:businessNatureId);
        final result2 = SubBusinessNatureResponse.fromJson(response);
        if(result2.status){
            for (final element in res2.data) {
          responseList.add(element);
        }
        AsyncData(responseList);
        }
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
