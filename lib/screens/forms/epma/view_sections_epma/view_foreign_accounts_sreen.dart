import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/widgets/empty_view.dart';
// import 'package:zxplore_app/utils/app_sizes.dart';

class ViewForeignAccount extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewForeignAccount({Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewForeignAccount> createState() => _ViewForeignAccountState();
}

class _ViewForeignAccountState extends ConsumerState<ViewForeignAccount> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.formIndividualData);
    final sectionData = requestData?.data?.foreignAccounts ?? [];

    return BaseFormScreen(
        title: 'Foreign Account',
        data: _flattenData(widget.formIndividualData),
       showEdit: sectionData.isNotEmpty,
        onTapEdit: () {
          // to navigate to edit this section
        },
        onTapAdd: (){
          // rroute to add new item page 
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: sectionData.isNotEmpty?ListView.builder(
              shrinkWrap: true,
              itemCount: sectionData.length,
              itemBuilder: (BuildContext context, index) {
                return Item(
                  data: sectionData[index],
                );
              }):EmptyViewWidget()
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

class Item extends StatelessWidget {
  const Item({super.key, this.data});
  final ForeignAccount? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewItem(
          title: 'Fund Source Sender Invester',
          value: data?.fundSourceSenderInvester ?? '',
        ),
        ViewItem(
          title: 'Fund Source Other Specify',
          value: data?.fundSourceOtherSpecify ?? '',
        ),
        ViewItem(
          title: 'Fund Source Business Income',
          value: data?.fundSourceBusinessIncome ?? false,
        ),
        ViewItem(
          title: 'Inflow Frequency Fortnightly',
          value: data?.inflowFrequencyFortnightly ?? false,
        ),
        ViewItem(
          title: 'Inflow Frequency Monthly',
          value: data?.inflowFrequencyMonthly ?? false,
        ),
        ViewItem(
          title: 'Inflow Frequency Quarterly',
          value: data?.inflowFrequencyQuarterly ?? false,
        ),
        ViewItem(
          title: 'Inflow Frequency Other',
          value: data?.inflowFrequencyOther ?? false,
        ),
        ViewItem(
          title: 'Inflow Frequency Other Specify',
          value: data?.inflowFrequencyOtherSpecify ?? '',
        ),
        ViewItem(
          title: 'Inflow Frequency Weekly',
          value: data?.inflowFrequencyWeekly ?? false,
        ),
        ViewItem(
          title: 'Fund Source Other',
          value: data?.fundSourceOther ?? false,
        ),
        ViewItem(
          title: 'Has Related Account',
          value: data?.hasRelatedAccount ?? false,
        ),
        ViewItem(
          title: 'Fund Source Salary',
          value: data?.fundSourceSalary ?? false,
        ),
        ViewItem(
          title: 'Account Purpose Other Specify',
          value: data?.accountPurposeOtherSpecify ?? false,
        ),
        ViewItem(
          title: 'Account Purpose Other',
          value: data?.accountPurposeOther ?? false,
        ),
        ViewItem(
          title: 'Account Purpose Business',
          value: data?.accountPurposeBusiness ?? false,
        ),
        ViewItem(
          title: 'Account Purpose Salary',
          value: data?.accountPurposeSalary ?? false,
        ),
        ViewItem(
          title: 'Off Shore GBP',
          value: data?.offShoreGbp ?? false,
        ),
        ViewItem(
          title: 'Off Shore USD',
          value: data?.offShoreUsd ?? false,
        ),
        ViewItem(
          title: 'Off Shore USD',
          value: data?.offShoreUsd ?? false,
        ),
        ViewItem(
          title: 'On Shore EUR',
          value: data?.onShoreEur ?? false,
        ),
        ViewItem(
          title: 'On Shore USD',
          value: data?.onShoreUsd ?? false,
        ),
        ViewItem(
          title: 'On Shore GBP',
          value: data?.onShoreGbp ?? false,
        ),
        ViewItem(
          title: 'Malongain Mandate',
          value: data?.malongainMandate ?? 0.0,
        ),
      ],
    );
  }
}
