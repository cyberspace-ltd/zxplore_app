import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/get_related_business_response.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_related_business_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/widgets/empty_view.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class ViewRelatedBusiness extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewRelatedBusiness(
      {Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewRelatedBusiness> createState() =>
      _ViewRelatedBusinessState();
}

class _ViewRelatedBusinessState
    extends ConsumerState<ViewRelatedBusiness> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.formIndividualData);
    final sectionData = requestData?.data?.relatedBusiness ?? [];

    return ZxploreProgress(
      inAsyncCall: ref.watch(editRelatedBusinessControllerProvider).isLoading
      ||ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseFormScreen(
          title: 'Related Business(es)',
          data: _flattenData(widget.formIndividualData),
          showEdit: sectionData.isNotEmpty,
          onTapEdit: () {
            // to navigate to edit this section
          },
         onTapAdd: (){
            // rroute to add new item page 
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:sectionData.isNotEmpty? ListView.builder(
                shrinkWrap: true,
                itemCount: sectionData.length,
                itemBuilder: (BuildContext context, index) {
                  return Item(data:sectionData[index] ,);
                }):EmptyViewWidget(),
          )),
    );
  }
  Map<String, String> _flattenData(Map<String, dynamic> data) {
    Map<String, String> flattened = {};
    data?.forEach((key, value) {
      if (value is Map) {
        value.forEach((subKey, subValue) {
          flattened['$key - $subKey'] = subValue.toString();
        });
      } else {
        flattened[key] = value.toString();
      }
    });
    return flattened;
  }
}

class  Item extends ConsumerWidget {
  const Item({super.key, this.data});
  final RelatedBusiness? data;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return
    FoldableItem(
      name: 'Name: ${data?.name ?? ''} / ${data?.relationshipNature ?? ''}',
      number: 'Address: ${data?.address ?? ''}',
      requestId: data?.reqId,
      subRequestId: data?.relatedBusinessId,
      onPressed: () {},
      onTapEdit: () {
        // to navigate to edit this section
        ref.read(editRelatedBusinessControllerProvider.notifier).getEditData(
            context,
            relatedBusinessId: data?.relatedBusinessId ?? -1,
            RequestId: data?.reqId);
      },
      onTapView: () {},
      onTapDelete: () {
        ref
            .read(editRelatedBusinessControllerProvider.notifier)
            .deleteRelatedBusiness(context,
                RequestId: data?.reqId ?? '',
               delData : DeleteRelatedBusiness(
                rowVersion: data?.rowVersion,
                relatedBusinessId:data?.relatedBusinessId ?? -1 ,
                requestId: data?.reqId
               ));
      },
      request: data,
    );
  //    Column(
  //     children: [
  //   ViewItem(title: 'Name', value: data?.name??''),
  //   ViewItem(title: 'Address', value: data?.address??''),
  //   ViewItem(title: 'Relationship Nature', value: data?.relationshipNature??''),
  //  ]);
}

 
  
}