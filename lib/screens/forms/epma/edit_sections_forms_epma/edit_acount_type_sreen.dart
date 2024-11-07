import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/get_edit_monthly_activity_res.dart';
import 'package:zxplore_app/models/epma_models/meta/anticipated_amounts.dart';
import 'package:zxplore_app/models/epma_models/meta/anticipated_transactions.dart';
import 'package:zxplore_app/models/epma_models/edit_monthly_activity_model.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_monthly_activity_contrroller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/meta/anticiapted_amount.dart';
import 'package:zxplore_app/screens/controllers/meta/anticipated_transactions.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/create_new_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_acount_type_monthly_activity_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/utils/string_extentions.dart';
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
  final TextEditingController prevItemStageController = TextEditingController();

  /// Deposits
  AnticipatedAmountsDatum? anticipatedDepositAmountItem;
  int? anticipatedDepositDepositAmount;
  String? anticipatedDepositAmountName;

  AnticipatedTransactionsDatum? selectedAnticipatedTransactionsItem;
  String? anticipaatedDepositTrxn;
  String? anticipaatedDepositTrxnName;

  /// Withdrawals
  AnticipatedAmountsDatum? anticipatedWithdrawalsAmountItem;
  int? anticipatedWithdrawalsAmount;
  String? anticipateWithdrawalsAmountName;

  AnticipatedTransactionsDatum? anticipatedWithdrawalTransactionsItem;
  String? anticipatedWithdrawalsTrxn;
  String? anticipatedWithdrawalsTrxnName;

  final prevADAStageController = TextEditingController();
  bool hidePrevADAStage = false; //pre  anticipated deposit amount
  void togglePrevADAStage() {
    setState(() {
      hidePrevADAStage = !hidePrevADAStage;
    });
  }

  final prevATAStageController = TextEditingController();
  bool hidePrevADTStage = false; //pre  anticipated  deposite trxn amount
  ///pre  anticipated  deposite trxn 
  void togglePrevADTStage() {
    setState(() {
      hidePrevADTStage = !hidePrevADTStage;
    });
  }

  final prevAWAStageController = TextEditingController();
  bool hidePrevAWAStage = false; //pre  anticipated withrawal amount
  void togglePrevAWAStage() {
    setState(() {
      hidePrevAWAStage = !hidePrevAWAStage;
    });
  }

  final prevAWTStageController = TextEditingController();
  bool hidePrevAWTStage = false; //pre  anticipated deposite trxn amount
  void togglePrevAWTStage() {
    setState(() {
      hidePrevAWTStage = !hidePrevAWTStage;
    });
  }

  String? selectedItemStage;
  bool hidePrevItemStage = false;
  void togglePrevItemStage() {
    setState(() {
      hidePrevItemStage = !hidePrevItemStage;
    });
  }

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
          selectedItemStage = originalData?.itemStage;
          prevItemStageController.text =
              originalData?.itemStage ?? 'No selection';

          /// deposits
          anticipatedDepositDepositAmount =
              originalData?.anticipatedDepositeAmount;
          anticipaatedDepositTrxn = originalData?.anticipatedDepositeTrans;
          prevADAStageController.text =
              '${originalData?.anticipatedDepositeAmount}';
          prevATAStageController.text =
              '${originalData?.anticipatedDepositeTrans}';
          //withdrawwals
          anticipatedWithdrawalsAmount = originalData?.anticipatedWithdrawAmount;
          anticipatedWithdrawalsTrxn = originalData?.anticipatedWithdrawTrans;
          prevAWAStageController.text= '${originalData?.anticipatedWithdrawAmount}';
          prevAWTStageController.text = '${originalData?.anticipatedWithdrawTrans}';
        });
      });
    } catch (e) {}
  }

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    anticipatedDepositeAmountController.dispose();
    anticipatedWithdrawAmountController.dispose();
    prevItemStageController.dispose();
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
        accountTypeId: originalData?.accountTypeId,
        requestId: originalData?.reqId,
        itemStage: selectedItemStage,
        rowVersion: originalData?.rowVersion,
        current: current,
        savings: savings,
        chequeSave: savings,
        thumbsUp: thumbsUp,
        zeca: zeca,
        zecaPlus: zecaPlus,
        anticipatedDepositeTrans: anticipaatedDepositTrxn, //drop down
        anticipatedDepositeAmount:
            anticipatedDepositDepositAmount, //int.parse(anticipatedDepositeAmountController.text),

        anticipatedWithdrawTrans:
           anticipatedWithdrawalsTrxn, //drop down
        anticipatedWithdrawAmount:
            anticipatedWithdrawalsAmount, //int.parse(anticipatedWithdrawAmountController.text),
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
      (_, state) => state.showAlertDialogOnError(context,
          okAction: () {}, errorMsg: state.error),
    );

    return ZxploreProgress(
      inAsyncCall: ref.watch(editMonthlyActivityControllerProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Monthly Expected Activity',
        widgetToGoOnCancel: AccountTypeMonthlyActivityScreen(
          requestData: ref.read(activelyViewedRequestProvider)!.toMap(),
        ),
        onCancel: () => Navigator.pop(context),
        button: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: PrimaryButton(
              onPressed: () {
                if (!_accTypeEditFormKey.currentState!.validate()) {
                  return;
                }
                if (selectedItemStage == null) {
                  zXFlushBar(context, "Item stage is required");
                }
                if ( anticipaatedDepositTrxn==null) {
                  zXFlushBar(context, "Anticipated transaction is required");
                  return;
                }

                if ( anticipatedDepositDepositAmount==null) {
                  zXFlushBar(context, "Anticipated Deposit amount is required");

                  return;
                }

                if (anticipatedWithdrawalsTrxn == null) {
                  zXFlushBar(context,
                      "Anticipated withdrawal transactions is required");
                  return;
                }

                if (anticipatedWithdrawalsAmount == null) {
                  zXFlushBar(
                      context, "Anticipated withdrawal amount is required");

                  return;
                }

                /// perform trn if all is well
                _submitForm(context);
              },
              title: 'Save'),
        ),
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
                  if (!hidePrevItemStage) ...[
                    CustomTextFormField(
                      title: "Item Stage",
                      fillColor: Colors.transparent,
                      controller: prevItemStageController,
                      hint: '',
                      readOnly: true,
                      showCursor: false,
                      suffixIcon: Icon(Icons.close_sharp),
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      showDropDownSuffixIcon: true,
                      onTap: () {
                        togglePrevItemStage();
                      },
                      validator: (value) {
                        return null;
                      },
                    )
                  ],
                  if (hidePrevItemStage) ...[
                    Row(children: [
                      Text(
                        "Item Stage",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      )
                    ]),
                    gapH4,
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String?>(
                        isExpanded: true,
                        hint: Text(
                          'Select stage',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            color: ZxplorePrimaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        items: itemStages
                            .map<DropdownMenuItem<String?>>(
                                (item) => DropdownMenuItem<String?>(
                                      value: item,
                                      child: Text(
                                        item ?? '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: ZxplorePrimaryColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                            .toList(),
                        value: selectedItemStage,
                        onChanged: (String? newValue) {
                          setState(() {
                            /// Set selected item params
                            selectedItemStage = newValue;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 60,
                          // width: 160,
                          padding: const EdgeInsets.only(left: 0, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
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
                            borderRadius: BorderRadius.circular(14),
                          ),
                          // offset: const Offset(0, 0),
                          scrollbarTheme: const ScrollbarThemeData(
                            radius: Radius.circular(40),
                            thickness: WidgetStatePropertyAll<double>(6),
                            thumbVisibility: WidgetStatePropertyAll<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ],
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
                  gapH16,

                  if (!hidePrevADAStage) ...[
                    CustomTextFormField(
                      title: "Anticipated Deposit Amount",
                      fillColor: Colors.transparent,
                      controller: prevADAStageController,
                      hint: '',
                      readOnly: true,
                      showCursor: false,
                      suffixIcon: Icon(Icons.close_sharp),
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      showDropDownSuffixIcon: true,
                      onTap: () {
                        togglePrevADAStage();
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                    gapH16,
                  ],
                  if (hidePrevADAStage) ...[
                    Text(
                      'Anticipated Deposit Amount',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
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
                                                        '${item.amountValue}',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color:
                                                              ZxplorePrimaryColor,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ))
                                            .toList(),
                                        value: anticipatedDepositAmountItem,
                                        onChanged: (AnticipatedAmountsDatum?
                                            newValue) {
                                          setState(() {
                                            /// Set selected item params
                                            anticipatedDepositAmountItem =
                                                newValue;
                                            anticipatedDepositDepositAmount =
                                                newValue?.amountValue;
                                            anticipatedDepositAmountName =
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
                                                WidgetStatePropertyAll<double>(
                                                    6),
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
                    const SizedBox(height: 16)
                  ],

                  if (!hidePrevADTStage) ...[
                    CustomTextFormField(
                      title: "Anticipated Deposit Transactions",
                      fillColor: Colors.transparent,
                      controller: prevATAStageController,
                      hint: '',
                      readOnly: true,
                      showCursor: false,
                      suffixIcon: Icon(Icons.close_sharp),
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      showDropDownSuffixIcon: true,
                      onTap: () {
                        togglePrevADTStage();
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                    gapH16,
                  ],
                  if (hidePrevADTStage) ...[
                    Row(
                      children: [
                        Text(
                          'Anticipated Deposit Transactions',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Consumer(
                      builder: (context, ref, child) {
                        return ref
                            .watch(getAnticipatedTransactionProvider)
                            .when(
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
                                                        '${item.transactionValue}',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color:
                                                              ZxplorePrimaryColor,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ))
                                            .toList(),
                                        value:
                                            selectedAnticipatedTransactionsItem,
                                        onChanged:
                                            (AnticipatedTransactionsDatum?
                                                newValue) {
                                          setState(() {
                                            /// Set selected item params
                                            selectedAnticipatedTransactionsItem =
                                                newValue;
                                            anticipaatedDepositTrxn =
                                                newValue?.transactionValue;
                                            anticipaatedDepositTrxnName =
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
                                                WidgetStatePropertyAll<double>(
                                                    6),
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
                  ],
                  
if (!hidePrevAWAStage) ...[
     gapH16,
                    CustomTextFormField(
                      title: "Anticipated Deposit Amount",
                      fillColor: Colors.transparent,
                      controller: prevAWAStageController,
                      hint: '',
                      readOnly: true,
                      showCursor: false,
                      suffixIcon: Icon(Icons.close_sharp),
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      showDropDownSuffixIcon: true,
                      onTap: () {
                        togglePrevAWAStage();
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                    gapH16,
                  ],
               
                if (hidePrevAWAStage) ... [ 
                     gapH16,
                   Text(
                    'Anticipated Withdrawal Amount',
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
                                        'Select anticipated withdrawals amount',
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
                                                      ' ${item.amountValue}',
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
                                      value: anticipatedWithdrawalsAmountItem,
                                      onChanged:
                                          (AnticipatedAmountsDatum? newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          anticipatedWithdrawalsAmountItem =
                                              newValue;
                                          anticipatedWithdrawalsAmount =
                                              newValue?.amountValue;
                                          anticipateWithdrawalsAmountName =
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
                 ],
if (!hidePrevAWTStage) ...[
                     gapH16,

                    CustomTextFormField(
                      title: "Anticipated Withdrawal Transactions",
                      fillColor: Colors.transparent,
                      controller: prevAWTStageController,
                      hint: '',
                      readOnly: true,
                      showCursor: false,
                      suffixIcon: Icon(Icons.close_sharp),
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      showDropDownSuffixIcon: true,
                      onTap: () {
                        togglePrevAWTStage();
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                    gapH16,
                  ],
                  const SizedBox(height: 16),
                 if (hidePrevAWTStage) ... [ 
                   Text(
                    'Anticipated withdrawal Transactions',
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
                                        'Select anticipated transactions',
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
                                                      '${item.transactionValue}',
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
                                      value:
                                          anticipatedWithdrawalTransactionsItem,
                                      onChanged: (AnticipatedTransactionsDatum?
                                          newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          anticipatedWithdrawalTransactionsItem =
                                              newValue;
                                          anticipatedWithdrawalsTrxn =
                                              newValue?.transactionValue;
                                          anticipatedWithdrawalsTrxnName =
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
                  ],
                  gapH16,
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
