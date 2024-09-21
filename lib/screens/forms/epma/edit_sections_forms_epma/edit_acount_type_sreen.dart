import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/get_edit_monthly_activity_res.dart';
import 'package:zxplore_app/models/epma_models/meta/anticipated_amounts.dart';
import 'package:zxplore_app/models/epma_models/meta/anticipated_transactions.dart';
import 'package:zxplore_app/models/epma_models/meta/edit_monthly_activity_model.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_monthly_activity_contrroller.dart';
import 'package:zxplore_app/screens/controllers/meta/anticiapted_amount.dart';
import 'package:zxplore_app/screens/controllers/meta/anticipated_transactions.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditAccountTypeScreen extends ConsumerStatefulWidget {
  const EditAccountTypeScreen({super.key, this.data});
  final GetMonthlyActivityToEditResponse? data;

  @override
  ConsumerState<EditAccountTypeScreen> createState() =>
      _EditAccountTypeScreenState();
}

class _EditAccountTypeScreenState extends ConsumerState<EditAccountTypeScreen> {
  final _accTypeEditFormKey = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final TextEditingController anticipatedDepositeAmountController =
      TextEditingController();
  final TextEditingController anticipatedWithdrawAmountController =
      TextEditingController();
  AnticipatedAmountsDatum? selectedAnticipatedAmountItem;
  int? selectedAmount;
  String? selectedAmountName;
  AnticipatedTransactionsDatum? selectedAnticipatedTransactionsItem;
  String? selectedTrxn;
  String? selectedTrxnName;

  bool current = false;
  bool chequeSave = false;
  bool savings = false;
  bool thumbsUp = false;
  bool zeca = false;
  bool zecaPlus = false;
  bool foriegnTransactionExpected = false;
  @override
  void initState() {
    super.initState();
    try {
      final originalData = widget.data?.data;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          current = originalData?.current ?? false;
          chequeSave = originalData?.chequeSave ?? false;
          savings = originalData?.savings ?? false;
          thumbsUp = originalData?.thumbsUp ?? false;
          zecaPlus = originalData?.zecaPlus ?? false;
          foriegnTransactionExpected =
              originalData?.foriegnTransactionExpected ?? false;
          anticipatedDepositeAmountController.text =
              '${originalData?.anticipatedDepositeAmount ?? 0}';
          anticipatedDepositeAmountController.text =
              '${originalData?.foriegnTransactionExpected ?? 0}';
        });
      });
    } catch (e) {}
  }

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    anticipatedDepositeAmountController.dispose();
    anticipatedWithdrawAmountController.dispose();
    super.dispose();
  }

  // Method to handle checkbox state changes
  void _handleCheckboxChange(int checkboxNumber, bool? value) {
    setState(() {
      switch (checkboxNumber) {
        case 1:
          current = value ?? false;
          break;
        case 2:
          chequeSave = value ?? false;
          break;
        case 3:
          savings = value ?? false;
          break;
        case 4:
          thumbsUp = value ?? false;
          break;
        case 5:
          zeca = value ?? false;
          break;
        case 6:
          foriegnTransactionExpected = value ?? false;
          break;
      }
    });
  }

  Future<void> _submitForm(BuildContext context) async {
    final originalData = widget.data?.data;

    final editeData = EditMonthlyActivity(
        accountTypeId: 0,
        requestId: originalData?.reqId,
        itemStage: originalData?.itemStage,
        rowVersion: originalData?.rowVersion,
        current: current,
        savings: savings,
        chequeSave: savings,
        thumbsUp: thumbsUp,
        zeca: zeca,
        zecaPlus: zecaPlus,
        anticipatedDepositeTrans: selectedAmountName, //drop down
        anticipatedDepositeAmount:
            int.parse(anticipatedDepositeAmountController.text),
        anticipatedWithdrawTrans: selectedTrxnName, //drop down
        anticipatedWithdrawAmount:
            int.parse(anticipatedDepositeAmountController.text),
        foriegnTransactionExpected: foriegnTransactionExpected,
        actionFlag: originalData?.actionFlag);

    ref
        .read(editMonthlyActivityControllerProvider.notifier)
        .editAccountTypeDaata(data: editeData, context: context);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      editMonthlyActivityControllerProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {}),
    );

    return ZxploreProgress(
      inAsyncCall: ref.watch(editMonthlyActivityControllerProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Monthly Expected Activity',
        widgetToGoOnCancel: Container(),
        onCancel: () {},
        data: {},
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              // Add bottom padding to ensure content is above the keyboard
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Form(
              key: _accTypeEditFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  gapH24,
                  Text(
                    'Account Type',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  div,
                  gapH16,
                  CheckboxListTile(
                    title: Text('Current'),
                    value: current,
                    onChanged: (value) => _handleCheckboxChange(1, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Cheque Save'),
                    value: chequeSave,
                    onChanged: (value) => _handleCheckboxChange(2, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Savings'),
                    value: savings,
                    onChanged: (value) => _handleCheckboxChange(3, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('ThumbsUp'),
                    value: thumbsUp,
                    onChanged: (value) => _handleCheckboxChange(4, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Zeca'),
                    value: zeca,
                    onChanged: (value) => _handleCheckboxChange(5, value),
                  ),
                  CheckboxListTile(
                    title: Text('zecaPlus'),
                    value: zecaPlus,
                    onChanged: (value) => _handleCheckboxChange(6, value),
                  ),
                  gapH16,
                    Text(
                    'Transactions',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  div,
                  Text(
                    'Anticipated Deposit Amount',
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(getAnticipatedAmountProvider).when(
                            data: (data) => (data != null &&
                                    data.isNotEmpty == true)
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton2<
                                        AnticipatedAmountsDatum>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select amount',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                          color: ZxplorePrimaryColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      items: data
                                          .map<
                                                  DropdownMenuItem<
                                                      AnticipatedAmountsDatum>>(
                                              (item) => DropdownMenuItem<
                                                      AnticipatedAmountsDatum>(
                                                    value: item,
                                                    child: Text(
                                                      '${item.amountName}- ${item.amountValue}',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            ZxplorePrimaryColor,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                          .toList(),
                                      value: selectedAnticipatedAmountItem,
                                      onChanged:
                                          (AnticipatedAmountsDatum? newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          selectedAnticipatedAmountItem = newValue;
                                          selectedAmount =
                                              newValue?.amountValue;
                                          selectedAmountName =
                                              newValue?.amountName;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 60,
                                        // width: 160,
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                            color: ZxplorePrimaryColor,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          CupertinoIcons.chevron_down,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: ZxplorePrimaryColor,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        // width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        // offset: const Offset(0, 0),
                                        scrollbarTheme:
                                            const ScrollbarThemeData(
                                          radius: Radius.circular(40),
                                          thickness:
                                              WidgetStatePropertyAll<double>(6),
                                          thumbVisibility:
                                              WidgetStatePropertyAll<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () => ref.invalidate(
                                        getAnticipatedAmountProvider),
                                    child: Text('Empty data, Tap to retry')),
                            error: (e, s) => GestureDetector(
                                onTap: () => ref
                                    .invalidate(getAnticipatedAmountProvider),
                                child: const Text(
                                  'An error occured',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            loading: () => SizedBox(height: 16.0),
                          );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Anticipated Transactions',
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(getAnticipatedTransactionProvider).when(
                            data: (data) => (data != null &&
                                    data.isNotEmpty == true)
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton2<
                                        AnticipatedTransactionsDatum>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select amount',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                          color: ZxplorePrimaryColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      items: data
                                          .map<
                                                  DropdownMenuItem<
                                                      AnticipatedTransactionsDatum>>(
                                              (item) => DropdownMenuItem<
                                                      AnticipatedTransactionsDatum>(
                                                    value: item,
                                                    child: Text(
                                                      '${item.transactionName}-${item.transactionValue}',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            ZxplorePrimaryColor,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                          .toList(),
                                      value: selectedAnticipatedTransactionsItem,
                                      onChanged: (AnticipatedTransactionsDatum?
                                          newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          selectedAnticipatedTransactionsItem =
                                              newValue;
                                          selectedTrxn =
                                              newValue?.transactionValue;
                                          selectedAmountName =
                                              newValue?.transactionName;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 60,
                                        // width: 160,
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                            color: ZxplorePrimaryColor,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          CupertinoIcons.chevron_down,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: ZxplorePrimaryColor,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        // width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        // offset: const Offset(0, 0),
                                        scrollbarTheme:
                                            const ScrollbarThemeData(
                                          radius: Radius.circular(40),
                                          thickness:
                                              WidgetStatePropertyAll<double>(6),
                                          thumbVisibility:
                                              WidgetStatePropertyAll<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () => ref.invalidate(
                                        getAnticipatedTransactionProvider),
                                    child: Text('Empty data, Tap to retry')),
                            error: (e, s) => GestureDetector(
                                onTap: () => ref.invalidate(
                                    getAnticipatedTransactionProvider),
                                child: const Text(
                                  'An error occured',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            loading: () => SizedBox(height: 16.0),
                          );
                    },
                  ),
                  const SizedBox(height: 16),
                  gapH16,
                  CustomTextFormField(
                    title: 'Anticipated Deposit Amount',
                    fillColor: Colors.transparent,
                    controller: anticipatedDepositeAmountController,
                    hint: 'Enter aamount',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'Anticipated Deposit WWidthrawal',
                    fillColor: Colors.transparent,
                    controller: anticipatedWithdrawAmountController,
                    hint: 'Enter aamount',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                      onPressed: () {
                        if (!_accTypeEditFormKey.currentState!.validate()) {
                          return;
                        }
                        if (selectedAnticipatedTransactionsItem == null) return;
                        if (selectedAnticipatedAmountItem == null) return;

                        /// perform trn if all is well
                        _submitForm(context);
                      },
                      title: 'Save')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
