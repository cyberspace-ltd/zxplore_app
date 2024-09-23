// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:zxplore_app/models/epma_models/delete_other_bank_account.dart';
// import 'package:zxplore_app/models/epma_models/view_account_request.dart';
// import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
// import 'package:zxplore_app/screens/controllers/edit_controllers/edit_other_bank_controller.dart';
// import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
// import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
// import 'package:zxplore_app/widgets/empty_view.dart';
// import 'package:zxplore_app/widgets/zxplore_progress.dart';

// class ViewRelatedAccounts extends ConsumerStatefulWidget {
//   final Map<String, dynamic> requestData;

//   const ViewRelatedAccounts(
//       {Key? key, required this.requestData})
//       : super(key: key);

//   @override
//   ConsumerState<ViewRelatedAccounts> createState() =>
//       _ViewRelatedAccountsState();
// }

// class _ViewRelatedAccountsState
//     extends ConsumerState<ViewRelatedAccounts> {
//   @override
//   Widget build(BuildContext context) {
//     final ViewAccountRequestResponse? requestData =
//         ViewAccountRequestResponse.fromMap(widget.requestData);
//     final sectionData = requestData?.data?.o ?? [];

//     return ZxploreProgress(
//       inAsyncCall: ref.watch(editOtherBankControllerProvider).isLoading||
//     ref.watch(viewRequestControllerProvider).isLoading  ,
//        child: BaseFormScreen(
//           title: 'Other Accounts',
//           data: _flattenData(widget.requestData),
//          showEdit:false, //sectionData.isNotEmpty,
//           onTapEdit: () {
//             // to navigate to edit this section
//           },
//           onTapAdd: (){
//             // rroute to add new item page 
//           },
          
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: sectionData.isNotEmpty?ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: sectionData.length,
//                 itemBuilder: (BuildContext context, index) {
//                   return OtherAccountsItem
//                   (data:sectionData[index] ,);
//                 }):EmptyViewWidget(),
//           )),
//     );
//   }

//   Map<String, String> _flattenData(Map<String, dynamic> data) {
//     Map<String, String> flattened = {};
//     data.forEach((key, value) {
//       if (value is Map) {
//         value.forEach((subKey, subValue) {
//           flattened['$key - $subKey'] = subValue.toString();
//         });
//       } else {
//         flattened[key] = value.toString();
//       }
//     });
//     return flattened;
//   }
// }

// class OtherAccountsItem extends ConsumerWidget {
//   const OtherAccountsItem({super.key, this.data});
//   final OtherAccount? data;

//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     return 
//     FoldableItem(
//       name: 'Name: ${data?.accountName ?? ''}',
//       number: 'Account No ${data?.accountNumber ?? ''}',
//       requestId: data?.reqId,
//       subRequestId: data?.otherAccountsId,
//       onPressed: () {},
//       onTapEdit: () {
//         // to navigate to edit this section
//         ref.read(editOtherBankControllerProvider.notifier).getEditData(
//             context,
//             RequestId: data?.reqId ?? '',
//             OtherAccountsId: data?.otherAccountsId);
//       },
//       onTapView: () {},
//       onTapDelete: () {
//         ref
//             .read(editOtherBankControllerProvider.notifier)
//             .deleteOtherBankAccountData(context,
//                 RequestId: data?.reqId ?? '',
//                 delData: DeleteOtherBankAccount(
//                   requestId:data?.reqId ?? '' ,
//                   otherAccountsId:data?.otherAccountsId ?? -1 ,rowVersion: data?.rowVersion ?? -1,
//                 ));
//       },
//       request: data,
//     );
    
//     // Column(
//     //   children: [
//     //    ViewItem(title: 'Account Name',value: data?.accountName??''),
//     //    ViewItem(title: 'Account Number',value: data?.accountNumber??''),
//     //    ViewItem(title: 'Address',value: data?.address??''),
//     //    ViewItem(title: 'Bank',value: data?.bank??''),
//     //    ViewItem(title: 'Branch',value: data?.branch??''),
//     //   ],
//     // );
//   }
// }