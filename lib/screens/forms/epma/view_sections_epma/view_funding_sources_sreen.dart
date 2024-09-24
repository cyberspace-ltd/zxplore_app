import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_funding_sources_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/widgets/empty_view.dart';

class FundingSourcesScreen extends ConsumerStatefulWidget {
  final Map<String?, dynamic> requestData;

  const FundingSourcesScreen(
      {Key? key, required this.requestData})
      : super(key: key);

  @override
  ConsumerState<FundingSourcesScreen> createState() =>
      _FundingSourcesScreenState();
}

class _FundingSourcesScreenState
    extends ConsumerState<FundingSourcesScreen> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =  ref.watch(activelyViewedRequestProvider);
    final sectionData = requestData?.data?.fundingSources ?? [];

    return BaseFormScreen(
        title: 'Funding Sources',
        data: _flattenData(widget.requestData),
       showEdit: sectionData.isNotEmpty,
        onTapEdit: () {
         // to navigate to edit this section
         ref.read(editFundingSourcesControllerProvider.notifier).getEditData(context,
          RequestId: requestData?.data?.reqId??'');
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
                return FundingSourcesItem(data:sectionData[index] ,);
              }):EmptyViewWidget(),
        ));
  }

  Map<String, String> _flattenData(Map<String?, dynamic> data) {
    Map<String, String> flattened = {};
    data.forEach((key, value) {
      if (value is Map) {
        value.forEach((subKey, subValue) {
          flattened['$key - $subKey'] = subValue.toString();
        });
      } else {
        flattened[key??''] = value.toString();
      }
    });
    return flattened;
  }
}

class FundingSourcesItem extends StatelessWidget {
  const FundingSourcesItem({super.key, this.data});
  final FundingSource? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       ViewItem(title: 'commissions',value: data?.commissions??false,),
       ViewItem(title: 'Dividends',value: data?.dividends??false,),
       ViewItem(title: 'Business Income',value: data?.businessIncome??false,),
       ViewItem(title: 'Savings ',value: data?.personalSavings??false,),
       ViewItem(title: 'Trust Fund',value: data?.trustFund??false,),
       ViewItem(title: 'Salary',value: data?.salary??false,),
       ViewItem(title: 'Family Friends',value: data?.familyFriends??false,),
       ViewItem(title: 'Rental Income',value: data?.rentalIncome??false,),
       ViewItem(title: 'Inheritance/Gift',value: data?.inheritanceGift??false,),
       ViewItem(title: 'Others',value: data?.othersSpecify??''),
      ],
    );
  }
}