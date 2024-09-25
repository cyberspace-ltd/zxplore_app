import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/delete_document.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_documents_obtained_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_attached_document.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/widgets/empty_view.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class ViewDocumentsAttachedScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewDocumentsAttachedScreen(
      {Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewDocumentsAttachedScreen> createState() =>
      _ViewDocumentsAttachedScreenState();
}

class _ViewDocumentsAttachedScreenState
    extends ConsumerState<ViewDocumentsAttachedScreen> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ref.watch(activelyViewedRequestProvider);
    final sectionData = requestData?.data?.documentsAttached ?? [];

    return ZxploreProgress(
      inAsyncCall: ref.watch(editDocumentsObtainedControllerProvider).isLoading,
      child: BaseFormScreen(
          title: 'Documents Attached',
          data: _flattenData(widget.formIndividualData),
          showEdit: sectionData.isNotEmpty,
          onTapEdit: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => EditAttachedDocument()),
            );
          },
          onTapAdd: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => EditAttachedDocument()),
            );

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
  const Item({super.key, this.data});
  final DocumentsAttached? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FoldableItem(
      name: 'File Name: ${data?.fileImage ?? ''}.${data?.fileExtension ?? ''}',
      number: 'Document Type: ${data?.documentType?.documentTypeName ?? ''}',
      requestId: data?.reqId,
      subRequestId: data?.documentsAttachedId,
      onTapEdit: () {
        // to navigate to edit this section EditAttachedDocument
        ref.read(editDocumentsObtainedControllerProvider.notifier).getEditData(
            context,
            RequestId: data?.reqId,
            DocumentsAttachedId: data?.documentsAttachedId);
      },
      onTapView: () {},
      onTapDelete: () {
        ref
            .read(editDocumentsObtainedControllerProvider.notifier)
            .deletDocument(context,
                RequestId: data?.reqId ?? '',
                deleteDocumentData: DeleteDocument(
                  documentsAttachedId: data?.documentsAttachedId,
                  requestId: data?.reqId,
                  rowVersion: data?.rowVersion,
                ));
      },
      request: data,
    );

//     Column(
//       children: [
// //  ViewItem(title: 'Documents Attached Id', value: data?.documentsAttachedId),
//     // ViewItem(title: 'Req Id', value: data?.reqId),
//     ViewItem(title: 'File Name', value: data?.fileName??''),
//     ViewItem(title: 'File Image', value: data?.fileImage??''),
//     ViewItem(title: 'File Extension', value: data?.fileExtension??''),
//     ViewItem(title: 'Document Type Id', value: data?.documentTypeId??0),
//     ViewItem(title: 'Create Date', value: formatDate(data?.createDate??'')),
//     ViewItem(title: 'Row Version', value: data?.rowVersion),
//     ViewItem(title: 'Emp Id', value: data?.empId??0),
//     ViewItem(title: 'Emp Full Name', value: data?.empFullName??''),
//     ViewItem(title: 'Document Type Code', value: data?.documentType?.documentTypeCode??''),
//     ViewItem(title: 'Document Type Name', value: data?.documentType?.documentTypeName??''),

//    ]);
  }
}
