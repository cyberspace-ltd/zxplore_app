import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/utils/string_extentions.dart';

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
        ViewAccountRequestResponse.fromMap(widget.formIndividualData);
    final sectionData = requestData?.data?.documentsAttached ?? [];

    return BaseFormScreen(
        title: 'Documents Attached',
        data: _flattenData(widget.formIndividualData),
        onTapEdit: () {
          // to navigate to edit this section
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: sectionData.length,
              itemBuilder: (BuildContext context, index) {
                return Item(data:sectionData[index] ,);
              }),
        ));
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

class  Item extends StatelessWidget {
  const Item({super.key, this.data});
  final DocumentsAttached? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
//  ViewItem(title: 'Documents Attached Id', value: data?.documentsAttachedId),
    // ViewItem(title: 'Req Id', value: data?.reqId),
    ViewItem(title: 'File Name', value: data?.fileName??''),
    ViewItem(title: 'File Image', value: data?.fileImage??''),
    ViewItem(title: 'File Extension', value: data?.fileExtension??''),
    ViewItem(title: 'Document Type Id', value: data?.documentTypeId??0),
    ViewItem(title: 'Create Date', value: formatDate(data?.createDate??'')),
    ViewItem(title: 'Row Version', value: data?.rowVersion),
    ViewItem(title: 'Emp Id', value: data?.empId??0),
    ViewItem(title: 'Emp Full Name', value: data?.empFullName??''),
    ViewItem(title: 'Document Type Code', value: data?.documentType?.documentTypeCode??''),
    ViewItem(title: 'Document Type Name', value: data?.documentType?.documentTypeName??''),


   ]);
}

 
  
}