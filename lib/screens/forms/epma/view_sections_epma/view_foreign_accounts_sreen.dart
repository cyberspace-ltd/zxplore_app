import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/delete_foreign.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_foreign_accounts_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/widgets/empty_view.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';
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

    return ZxploreProgress(
      inAsyncCall: ref.watch(editForeignAaccountsControllerrProvider).isLoading||
     ref.watch(viewRequestControllerProvider).isLoading ,
      child: BaseFormScreen(
          title: 'Foreign Account',
          data: _flattenData(widget.formIndividualData),
         showEdit: false,//sectionData.isNotEmpty,
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
          )),
    );
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

class Item extends ConsumerWidget {
  const Item({super.key, this.data});
  final ForeignAccount? data;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  
    FoldableItem(
      userWrapper: true,
      name: 'Values: From Business Income-${data?.fundSourceBusinessIncome ?? ''},From Salary-${data?.fundSourceSalary ?? ''},Other sources-${data?.fundSourceOther ?? ''}...',
      number: 'More settings:On-Shore EUR ${data?.onShoreEur??''} , On-Shore GBP${data?.onShoreGbp??''},On-Shore USD ${data?.onShoreUsd??''},Off-Shore Eur ${data?.offShoreEur??''} ,Off-Shore USD-${data?.offShoreUsd??''},Off-Shore Gbp-${data?.offShoreGbp??''}, Off-Shore Usd-${data?.offShoreUsd??''}...',
      requestId: data?.reqId,
      subRequestId: data?.foreignAccountId,
     onTapEdit: () {
        // to navigate to edit this section
        ref.read(editForeignAaccountsControllerrProvider.notifier).getEditData(
            context,
            RequestId: data?.reqId ?? '',
          );
      },
      onTapView: () {},
      onTapDelete: () {
        ref
            .read(editForeignAaccountsControllerrProvider.notifier)
            .deleteForeignAccount(context,
                RequestId: data?.reqId ?? '',delData:DeleteForeignAccount(
                  foreignAccountId: data?.foreignAccountId,
                  requestId:data?.reqId ,
                  rowVersion:data?.rowVersion ,
                )
                );
      },
      request: data,
    );
    // Column(
    //   children: [
        // ViewItem(
        //   title: 'Fund Source Sender Invester',
        //   value: data?.fundSourceSenderInvester ?? '',
        // ),
        // ViewItem(
        //   title: 'Fund Source Other Specify',
        //   value: data?.fundSourceOtherSpecify ?? '',
        // ),
        // ViewItem(
        //   title: 'Fund Source Business Income',
        //   value: data?.fundSourceBusinessIncome ?? false,
        // ),
        // ViewItem(
        //   title: 'Inflow Frequency Fortnightly',
        //   value: data?.inflowFrequencyFortnightly ?? false,
        // ),
        // ViewItem(
        //   title: 'Inflow Frequency Monthly',
        //   value: data?.inflowFrequencyMonthly ?? false,
        // ),
        // ViewItem(
        //   title: 'Inflow Frequency Quarterly',
        //   value: data?.inflowFrequencyQuarterly ?? false,
        // ),
        // ViewItem(
        //   title: 'Inflow Frequency Other',
        //   value: data?.inflowFrequencyOther ?? false,
        // ),
        // ViewItem(
        //   title: 'Inflow Frequency Other Specify',
        //   value: data?.inflowFrequencyOtherSpecify ?? '',
        // ),
        // ViewItem(
        //   title: 'Inflow Frequency Weekly',
        //   value: data?.inflowFrequencyWeekly ?? false,
        // ),
        // ViewItem(
        //   title: 'Fund Source Other',
        //   value: data?.fundSourceOther ?? false,
        // ),
        // ViewItem(
        //   title: 'Has Related Account',
        //   value: data?.hasRelatedAccount ?? false,
        // ),
        // ViewItem(
        //   title: 'Fund Source Salary',
        //   value: data?.fundSourceSalary ?? false,
        // ),
        // ViewItem(
        //   title: 'Account Purpose Other Specify',
        //   value: data?.accountPurposeOtherSpecify ?? false,
        // ),
        // ViewItem(
        //   title: 'Account Purpose Other',
        //   value: data?.accountPurposeOther ?? false,
        // ),
        // ViewItem(
        //   title: 'Account Purpose Business',
        //   value: data?.accountPurposeBusiness ?? false,
        // ),
        // ViewItem(
        //   title: 'Account Purpose Salary',
        //   value: data?.accountPurposeSalary ?? false,
        // ),
        // ViewItem(
        //   title: 'Off Shore GBP',
        //   value: data?.offShoreGbp ?? false,
        // ),
        // ViewItem(
        //   title: 'Off Shore USD',
        //   value: data?.offShoreUsd ?? false,
        // ),
        // ViewItem(
        //   title: 'Off Shore USD',
        //   value: data?.offShoreUsd ?? false,
        // ),
        // ViewItem(
        //   title: 'On Shore EUR',
        //   value: data?.onShoreEur ?? false,
        // ),
        // ViewItem(
        //   title: 'On Shore USD',
        //   value: data?.onShoreUsd ?? false,
        // ),
        // ViewItem(
        //   title: 'On Shore GBP',
        //   value: data?.onShoreGbp ?? false,
        // ),
        // ViewItem(
        //   title: 'Malongain Mandate',
        //   value: data?.malongainMandate ?? 0.0,
        // ),
      // ],
    // );
  }
}
