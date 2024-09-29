import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/delete_next_of_kin_model.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_next_of_kin_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/add_data_forms/add_next_of_kin_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/widgets/empty_view.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';
// import 'package:zxplore_app/utils/app_sizes.dart';
// import 'package:zxplore_app/utils/string_extentions.dart';

class ViewNextOfKinScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewNextOfKinScreen(
      {Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewNextOfKinScreen> createState() =>
      _ViewNextOfKinScreenState();
}

class _ViewNextOfKinScreenState
    extends ConsumerState<ViewNextOfKinScreen> {
  @override
  Widget build(BuildContext context) {
      final ViewAccountRequestResponse? requestData =  ref.watch(activelyViewedRequestProvider);
 final sectionData = requestData?.data?.nextOfKin ?? [];

    return ZxploreProgress(
        inAsyncCall: ref.watch(viewNextOfKinControllerProvider).isLoading||
    ref.watch(viewRequestControllerProvider).isLoading
      ,
      child: ZxploreProgress(
        inAsyncCall: ref.watch(viewNextOfKinControllerProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
        child: BaseFormScreen(
            title: 'Next of Kin',
            data: _flattenData(widget.formIndividualData),
            showEdit: sectionData.isNotEmpty,
            onTapEdit: () {
              // to navigate to edit this section
            },
            onTapAdd: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AddNextOfKinScreen(
                          requestId: ref.read(activelyViewedRequestProvider)?.data?.reqId,
                        )),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: sectionData.isNotEmpty?ListView.builder(
                  shrinkWrap: true,
                  itemCount: sectionData.length,
                  itemBuilder: (BuildContext context, index) {
                    return Item(data:sectionData[index] ,);
                  }):EmptyViewWidget(),
            )),
      ),
    );
  }
  Map<String, String> _flattenData(Map<String, dynamic> data) {
    Map<String, String> flattened = {};
    data.forEach((key, value) {
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
  final NextOfKin? data;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return 
    FoldableItem(
      name: 'Name: ${data?.fullName ?? ''} - ${data?.relationship??''}',
      number: 'Adresss ${data?.residentialAddress??''}',
      requestId: data?.reqId,
      subRequestId: data?.nextOfKinId,
     onTapEdit: () {
        // to navigate to edit this section
        ref.read(viewNextOfKinControllerProvider.notifier).getEditData(
            context,
            RequestId: data?.reqId ?? '',
            NextOfKinId: data?.nextOfKinId);
      },
      onTapView: () {},
      onTapDelete: () {
        ref
            .read(viewNextOfKinControllerProvider.notifier)
            .deleteNok(context,
                RequestId: data?.reqId ?? '',
                delData:DeleteNextOfKin(
                  nextOfKinId: data?.nextOfKinId,
                  requestId:data?.reqId ,
                  rowVersion:data?.rowVersion ,
                )
                );
      },
      request: data,
    );
 
}

 
  
}