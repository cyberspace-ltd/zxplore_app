import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/delete_child.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_child_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/add_data_forms/add_children_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/empty_view.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class ViewChildrenScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewChildrenScreen({Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewChildrenScreen> createState() => _ViewChildrenScreenState();
}

class _ViewChildrenScreenState extends ConsumerState<ViewChildrenScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      viewChildControllerProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {}),
    );

    final ViewAccountRequestResponse? requestData =
        ref.watch(activelyViewedRequestProvider);
    ViewAccountRequestResponse.fromMap(widget.formIndividualData);
    final sectionData = requestData?.data?.children ?? [];

    return ZxploreProgress(
      inAsyncCall: ref.watch(viewChildControllerProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseFormScreen(
          title: 'Children',
          data: _flattenData(widget.formIndividualData),
          showEdit: false, //sectionData.isNotEmpty,

          onTapEdit: () {
            // to navigate to edit this section
          },
          onTapAdd: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddChildScreen(
                        requestId: ref
                            .read(activelyViewedRequestProvider)
                            ?.data
                            ?.reqId,
                      )),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: sectionData.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: sectionData.length,
                    itemBuilder: (BuildContext context, index) {
                      return Item(
                        data: sectionData[index],
                      );
                    })
                : EmptyViewWidget(),
          )),
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

class Item extends ConsumerWidget {
  const Item({super.key, this.data});
  final Child? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FoldableItem(
      name: 'Name: ${data?.surname ?? ''} ${data?.otherNames ?? ''}',
      number:
          'Gender/Age: ${data?.gender?.genderName ?? ''} , Age:${data?.age ?? ''}',
      requestId: data?.reqId,
      subRequestId: data?.chidId,
      onTapEdit: () {
        // to navigate to edit this section
        ref.read(viewChildControllerProvider.notifier).getEditData(context,
            RequestId: data?.reqId ?? '', ChildId: data?.chidId);
      },
      onTapView: () {},
      onTapDelete: () {
        ref.read(viewChildControllerProvider.notifier).deleteChild(context,
            RequestId: data?.reqId ?? '',
            delData: DeleteChild(
              childId: data?.chidId,
              requestId: data?.reqId,
              rowVersion: data?.rowVersion,
            ));
      },
      request: data,
    );

//     Column(
//       children: [
// //  ViewItem(title: 'Chid Id', value: data?.chidId),
//     // ViewItem(title: 'Req Id', value: data?.reqId),
//     // ViewItem(title: 'Row Version', value: data?.rowVersion),
//     // ViewItem(title: 'Item Stage', value: data?.itemStage),
//     ViewItem(title: 'Surname', value: data?.surname??''),
//     ViewItem(title: 'Other Names', value: data?.otherNames??''),
//     ViewItem(title: 'Birth Date', value: formatDate(data?.birthDate??'')),
//     ViewItem(title: 'Gender Code', value: data?.genderCode??''),
//     ViewItem(title: 'Country Orig Code', value: data?.countryOrigCode??''),
//     ViewItem(title: 'Age', value: data?.age??0),
//     ViewItem(title: 'School', value: data?.school??''),
//     ViewItem(title: 'Mother Name', value: data?.motherName??''),
//     ViewItem(title: 'Maturity Age', value: data?.maturityAge??''),
//     ViewItem(title: 'Create Date', value: formatDate(data?.createDate)),
//     ViewItem(title: 'Action Flag', value: data?.actionFlag??''),
//     ViewItem(title: 'Gender', value: data?.gender?.genderName),
//     ViewItem(title: 'Nationality', value: data?.nationality?.countryName??''),
//     ViewItem(title: 'Origin Country', value: data?.originCountry?.countryName??''),

//    ]);
  }
}
