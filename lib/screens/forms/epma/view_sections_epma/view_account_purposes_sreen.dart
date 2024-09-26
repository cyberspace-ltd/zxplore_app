import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_account_purpose_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/empty_view.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class AccountPurposeScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> requestData;

  const AccountPurposeScreen({Key? key, required this.requestData})
      : super(key: key);

  @override
  ConsumerState<AccountPurposeScreen> createState() =>
      _AccountPurposeScreenState();
}

class _AccountPurposeScreenState extends ConsumerState<AccountPurposeScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      editAccountPurposeControllerProvider,
      (_, state) => state.showAlertDialogOnError(context,
          okAction: () {}, errorMsg: state.error),
    );
    //    ref.listen<AsyncValue>(
    //   viewAccountPurposeControllerProvider,
    //   (_, state) => state.showAlertDialogOnError(context, okAction: () {},errorMsg: state.error),
    // );

    final ViewAccountRequestResponse? requestData =
        ref.watch(activelyViewedRequestProvider);

    final sectionData = requestData?.data?.accountPurposes ?? [];

    return ZxploreProgress(
      inAsyncCall: ref.watch(editAccountPurposeControllerProvider).isLoading ||
          ref.watch(viewAccountPurposeControllerProvider).isLoading,
      child: BaseFormScreen(
          title: 'Account  Purpose',
          data: _flattenData(widget.requestData),
          showEdit: sectionData.isNotEmpty,
          onTapEdit: () {
            // to navigate to edit this section
            ref.read(viewAccountPurposeControllerProvider.notifier).getEditData(
                context,
                RequestId: requestData?.data?.reqId ?? '');
          },
          onTapAdd: () {
            // rroute to add new item page
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: sectionData.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: sectionData.length,
                    itemBuilder: (BuildContext context, index) {
                      return AccountPurposeItem(
                        data: sectionData[index],
                      );
                    })
                : EmptyViewWidget(),
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

class AccountPurposeItem extends StatelessWidget {
  const AccountPurposeItem({super.key, this.data});
  final AccountPurpose? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewItem(
          title: 'Salary Processing',
          value: data?.salaryProcessing ?? false,
        ),
        ViewItem(
          title: 'toOtain Loan',
          value: data?.toOtainLoan ?? false,
        ),
        ViewItem(
          title: 'BusinessTransactional',
          value: data?.businessTransactional ?? false,
        ),
        ViewItem(
          title: 'Savings Investment',
          value: data?.savingsInvestment ?? false,
        ),
        ViewItem(
          title: 'Conduct Single Transaction',
          value: data?.conductSingleTransaction ?? false,
        ),
        ViewItem(
          title: 'Secutiry Safe Keeping',
          value: data?.secutirySafeKeeping ?? false,
        ),
        ViewItem(
          title: 'Access To BankingServices',
          value: data?.accessToBankingServices ?? false,
        ),
        ViewItem(
          title: 'Third Party Payment',
          value: data?.thirdPartyPayment ?? false,
        ),
        ViewItem(
          title: 'Secutiry Safe Keeping',
          value: data?.secutirySafeKeeping ?? false,
        ),
        ViewItem(
          title: 'Secutiry Safe Keeping',
          value: data?.secutirySafeKeeping ?? false,
        ),
      ],
    );
  }
}
