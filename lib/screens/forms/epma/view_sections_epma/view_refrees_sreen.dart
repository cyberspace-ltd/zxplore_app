import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/delete_refree.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_refree_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/add_data_forms/add_refrees_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/empty_view.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class ViewRefreesScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewRefreesScreen({Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewRefreesScreen> createState() => _ViewRefreesScreenState();
}

class _ViewRefreesScreenState extends ConsumerState<ViewRefreesScreen> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ref.watch(activelyViewedRequestProvider);
    final sectionData = requestData?.data?.referees ?? [];

     ref.listen<AsyncValue>(
      viewRefereeControllerProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {},errorMsg: state.error),
    );

    return ZxploreProgress(
      inAsyncCall: ref.watch(viewRefereeControllerProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseFormScreen(
          title: 'Referees',
          data: _flattenData(widget.formIndividualData),
          showEdit: false, //sectionData.isNotEmpty,
          onTapEdit: () {
            // to navigate to edit this section
          },
          onTapAdd: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddRefereeScreen(
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
                        subRequestId: sectionData[index].refereeId,
                        requestId: requestData?.data?.reqId,
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
  const Item(
      {super.key,
      this.data,
      required this.requestId,
      required this.subRequestId});
  final Referee? data;
  final String? requestId;
  final int? subRequestId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FoldableItem(
      name: 'Name: ${data?.name ?? ''}',
      number:
          'Account Name: ${data?.name ?? ''}\n\nAccount No ${data?.accountNo ?? ''} \n',
      requestId: requestId,
      subRequestId: subRequestId,
      onTapEdit: () {
        // to navigate to edit this section
        ref.read(viewRefereeControllerProvider.notifier).getEditData(context,
            RequestId: data?.reqId ?? '', RefereeId: data?.refereeId);
      },
      onTapView: () {},
      onTapDelete: () {
        ref.read(viewRefereeControllerProvider.notifier).deleteReferee(context,
            RequestId: data?.reqId ?? '',
            delData: DeleteReferee(
              refereeId: data?.refereeId,
              requestId: data?.reqId,
              rowVersion: data?.rowVersion,
            ));
      },
      request: data,
    );
  }
}
