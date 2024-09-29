import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_monthly_activity_contrroller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/empty_view.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';
// import 'package:zxplore_app/utils/app_sizes.dart';
// import 'package:zxplore_app/utils/string_extentions.dart';

class AccountTypeMonthlyActivityScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> requestData;

  const AccountTypeMonthlyActivityScreen(
      {Key? key, required this.requestData})
      : super(key: key);

  @override
  ConsumerState<AccountTypeMonthlyActivityScreen> createState() =>
      _AccountTypeMonthlyActivityScreenState();
}

class _AccountTypeMonthlyActivityScreenState
    extends ConsumerState<AccountTypeMonthlyActivityScreen> {
  @override
  Widget build(BuildContext context) {   
       ref.listen<AsyncValue>(
      viewMonthlyActivityControllerProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {},errorMsg: state.error),
    );
 
     final ViewAccountRequestResponse? requestData =  ref.watch(activelyViewedRequestProvider);

    final sectionData = requestData?.data?.accountType ?? [];

    return ZxploreProgress(
      inAsyncCall:  ref.watch(viewMonthlyActivityControllerProvider).isLoading,
      child: BaseFormScreen(
          title: 'Account Type',
          data: _flattenData(widget.requestData),
          showEdit: sectionData.isNotEmpty,
          onTapEdit: () {
            // to navigate to edit this section
           ref.read(viewMonthlyActivityControllerProvider.notifier).getEditData(context,
            RequestId: requestData?.data?.reqId??'');
          },
          onTapAdd: (){
          
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:sectionData.isNotEmpty? ListView.builder(
                shrinkWrap: true,
                itemCount: sectionData.length,
                itemBuilder: (BuildContext context, index) {
                  return Item(data:sectionData[index] ,);
                }):EmptyViewWidget(),
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

class  Item extends StatelessWidget {
  const Item({super.key, this.data});
  final AccountType? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    ViewItem(title: 'Account Type Id', value: data?.accountTypeId??''),
    ViewItem(title: 'Req Id', value: data?.reqId??''),
    ViewItem(title: 'Current', value: data?.current??false),
    ViewItem(title: 'Savings', value: data?.savings??false),
    ViewItem(title: 'Cheque Save', value: data?.chequeSave??false),
    ViewItem(title: 'Thumbs Up', value: data?.thumbsUp??false),
    ViewItem(title: 'Zeca', value: data?.zeca??false),
    ViewItem(title: 'Zeca Plus', value: data?.zecaPlus??false),
    ViewItem(title: 'Anticipated Deposite Trans', value: data?.anticipatedDepositeTrans??''),
    ViewItem(title: 'Anticipated Deposite Amount', value: data?.anticipatedDepositeAmount??0),
    ViewItem(title: 'Anticipated Withdraw Trans', value: data?.anticipatedWithdrawTrans??''),
    ViewItem(title: 'Anticipated Withdraw Amount', value: data?.anticipatedWithdrawAmount??0),
    ViewItem(title: 'Foreign Transaction Expected', value: data?.foriegnTransactionExpected??''),
   ]);
}

 
  
}