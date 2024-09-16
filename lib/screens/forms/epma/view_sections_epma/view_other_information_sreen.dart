import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';

class ViewOtherInformationSreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> requestData;

  const ViewOtherInformationSreen(
      {Key? key, required this.requestData})
      : super(key: key);

  @override
  ConsumerState<ViewOtherInformationSreen> createState() =>
      _ViewOtherInformationSreenState();
}

class _ViewOtherInformationSreenState
    extends ConsumerState<ViewOtherInformationSreen> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.requestData);
    final sectionData = requestData?.data?.otherInformations ?? [];

    return BaseFormScreen(
        title: 'Other Information',
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
                return OtherInformationItem(data:sectionData[index] ,);
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

class OtherInformationItem extends StatelessWidget {
  const OtherInformationItem({super.key, this.data});
  final OtherInformation? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
   
       ViewItem(title: 'Major Products',value: data?.majorProducts??''),
       ViewItem(title: 'key Customers',value: data?.keyCustomers??''),
       ViewItem(title: 'Business Country Code One',value: data?.businessCountryCodeOne??''),
       ViewItem(title: 'Business Country Code Two',value: data?.businessCountryCodeTwo??''),
       ViewItem(title: 'Business Country Code Three',value: data?.businessCountryCodeThree??''),
       ViewItem(title: 'Business Country Code Four',value: data?.businessCountryCodeFour??''),
      ],
    );
  }
}