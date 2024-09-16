import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';

class AccountPurposeScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> requestData;

  const AccountPurposeScreen(
      {Key? key, required this.requestData})
      : super(key: key);

  @override
  ConsumerState<AccountPurposeScreen> createState() =>
      _AccountPurposeScreenState();
}

class _AccountPurposeScreenState
    extends ConsumerState<AccountPurposeScreen> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.requestData);
    final sectionData = requestData?.data?.accountPurposes ?? [];

    return BaseFormScreen(
        title: 'Product Services',
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
                return AccountPurposeItem(data:sectionData[index] ,);
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

class AccountPurposeItem extends StatelessWidget {
  const AccountPurposeItem({super.key, this.data});
  final AccountPurpose? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       ViewItem(title: 'Salary Processing',value: data?.salaryProcessing??false,),
       ViewItem(title: 'toOtain Loan',value: data?.toOtainLoan??false,),
       ViewItem(title: 'BusinessTransactional',value: data?.businessTransactional??false,),
       ViewItem(title: 'Savings Investment',value: data?.savingsInvestment??false,),
       ViewItem(title: 'Conduct Single Transaction',value: data?.conductSingleTransaction??false,),
       ViewItem(title: 'Secutiry Safe Keeping',value: data?.secutirySafeKeeping??false,),
       ViewItem(title: 'Access To BankingServices',value: data?.accessToBankingServices??false,),
       ViewItem(title: 'Third Party Payment',value: data?.thirdPartyPayment??false,),
       ViewItem(title: 'Secutiry Safe Keeping',value: data?.secutirySafeKeeping??false,),
       ViewItem(title: 'Secutiry Safe Keeping',value: data?.secutirySafeKeeping??false,),
      ],
    );
  }
}