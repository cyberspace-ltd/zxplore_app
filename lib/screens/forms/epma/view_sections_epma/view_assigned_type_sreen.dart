import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/utils/string_extentions.dart';

class ViewAssignedAccountScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewAssignedAccountScreen(
      {Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewAssignedAccountScreen> createState() =>
      _ViewAssignedAccountScreenState();
}

class _ViewAssignedAccountScreenState
    extends ConsumerState<ViewAssignedAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.formIndividualData);
    final sectionData = requestData?.data?.assignedAccts ?? [];

    return BaseFormScreen(
        title: 'Assigned AccountTypes',
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
  final AssignedAcct? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
//  ViewItem(title: 'Assigned Account Id', value: data?.assignedAcctId),
    // ViewItem(title: 'Req Id', value: data?.reqId),
    // ViewItem(title: 'Item Stage', value: data?.itemStage),
    ViewItem(title: 'Account Name', value: data?.accountName??''),
    ViewItem(title: 'RIM No', value: data?.rimNo??0),
    ViewItem(title: 'Account Class', value: data?.accountClass??''),
    ViewItem(title: 'Currency', value: data?.currency??''),
    ViewItem(title: 'Account Type', value: data?.accountType??''),
    ViewItem(title: 'Account Series', value: data?.accountSeries??''),
    ViewItem(title: 'Account No', value: data?.accountNo??''),
    ViewItem(title: 'Create Date', value: formatDate(data?.createDate??'')),
    // ViewItem(title: 'Auth Code', value: data?.authCode),
    ViewItem(title: 'Recon', value: data?.recon??''),
    ViewItem(title: 'Recon Status', value: data?.reconStatus??0),
    // ViewItem(title: 'Action Flag', value: data?.actionFlag),
  
   ]);
}

 
  
}