import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_assigned_account_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/widgets/empty_view.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class ViewAssignedAccountScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewAssignedAccountScreen({Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewAssignedAccountScreen> createState() =>
      _ViewAssignedAccountScreenState();
}

class _ViewAssignedAccountScreenState
    extends ConsumerState<ViewAssignedAccountScreen> {
  @override
  Widget build(BuildContext context) {
     final ViewAccountRequestResponse? requestData =  ref.watch(activelyViewedRequestProvider);
 final sectionData = requestData?.data?.assignedAccts ?? [];

    return ZxploreProgress(
      inAsyncCall: ref.watch(editAssignedAccountControllerProvider).isLoading||
    ref.watch(viewRequestControllerProvider).isLoading  ,
      child: BaseFormScreen(
          title: 'Assigned AccountTypes',
          data: _flattenData(widget.formIndividualData),
          showEdit: false ,//sectionData.isNotEmpty,
          onTapEdit: () {},
          onTapAdd: () {
            // rroute to add new item page
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

class Item extends ConsumerWidget {
  const Item({super.key, this.data, this.assignedAcctId, this.requestId});
  final AssignedAcct? data;
  final String? requestId;
  final int? assignedAcctId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FoldableItem(
      name: 'Name: ${data?.accountName ?? ''}',
      number: 'Account No: ${data?.accountNo ?? ''}',
      requestId: requestId,
      subRequestId: assignedAcctId,
      onPressed: () {},
      onTapEdit: () {
        // to navigate to edit this section
        ref.read(editAssignedAccountControllerProvider.notifier).getEditData(
            context,
            RequestId: data?.reqId ?? '',
            AssignedAcctId: data?.assignedAcctId);
      },
      onTapView: () {},
      onTapDelete: () {
        ref
            .read(editAssignedAccountControllerProvider.notifier)
            .deleteAssignedAccountData(context,
                RequestId: data?.reqId ?? '',
                AssignedAcctId: data?.assignedAcctId);
      },
      request: data,
    );
  }
}
