import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';

class ViewOtherAccounts extends ConsumerStatefulWidget {
  final Map<String, dynamic> requestData;

  const ViewOtherAccounts(
      {Key? key, required this.requestData})
      : super(key: key);

  @override
  ConsumerState<ViewOtherAccounts> createState() =>
      _ViewOtherAccountsState();
}

class _ViewOtherAccountsState
    extends ConsumerState<ViewOtherAccounts> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.requestData);
    final sectionData = requestData?.data?.otherAccounts ?? [];

    return BaseFormScreen(
        title: 'Other Accounts',
        data: _flattenData(widget.requestData),
        onTapEdit: () {
          // to navigate to edit this section
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: sectionData.length,
              itemBuilder: (BuildContext context, index) {
                return OtherAccountsItem
                (data:sectionData[index] ,);
              }),
        ));
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

class OtherAccountsItem extends StatelessWidget {
  const OtherAccountsItem({super.key, this.data});
  final OtherAccount? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       ViewItem(title: 'Account Name',value: data?.accountName??''),
       ViewItem(title: 'Account Number',value: data?.accountNumber??''),
       ViewItem(title: 'Address',value: data?.address??''),
       ViewItem(title: 'Bank',value: data?.bank??''),
       ViewItem(title: 'Branch',value: data?.branch??''),
      ],
    );
  }
}