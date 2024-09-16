import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/utils/string_extentions.dart';

class ViewTazJurisdictionScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewTazJurisdictionScreen({Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewTazJurisdictionScreen> createState() =>
      _ViewTazJurisdictionScreenState();
}

class _ViewTazJurisdictionScreenState
    extends ConsumerState<ViewTazJurisdictionScreen> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.formIndividualData);
    final sectionData = requestData?.data?.taxJurisdiction ?? [];

    return BaseFormScreen(
        title: 'Tax Details',
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
                return Item(
                  data: sectionData[index],
                );
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

class Item extends StatelessWidget {
  const Item({super.key, this.data});
  final TaxJurisdiction? data;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ViewItem(title: 'Tax Jurisdiction Id', value: data?.taxJurisdictionId),
      ViewItem(title: 'Req Id', value: data?.reqId),
      ViewItem(
          title: 'Tax Residency Country Code',
          value: data?.taxResidencyCountryCode),
      ViewItem(title: 'Tax Number', value: data?.taxNumber),
      ViewItem(
          title: 'Tax Number Issue Country Code',
          value: data?.taxNumberIssueCountryCode),
      ViewItem(title: 'Row Version', value: data?.rowVersion),
      ViewItem(title: 'Action Flag', value: data?.actionFlag),
      ViewItem(
          title: 'Common Reporting Standard Id',
          value: data?.commonReportingStandardId),
      if (data?.reportingStandard != null &&
          data?.reportingStandard?.isNotEmpty == true) ...[
        // data?.reportingStandard.map((element)=>Text(data)).toList()
        SizedBox(
          child: Column(
            children: data?.reportingStandard!.map((entry) {
                  return Text('${entry.description}');
                }).toList() ??
                [],
          ),
        )
      ]
    ]);
  }
}
