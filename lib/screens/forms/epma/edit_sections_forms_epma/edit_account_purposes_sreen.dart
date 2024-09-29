import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/edit_account_purpose.dart';
import 'package:zxplore_app/models/epma_models/get_account_purpose_response.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_account_purpose_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/create_new_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_funding_sources_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/utils/string_extentions.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditAccountPurposeScreen extends ConsumerStatefulWidget {
  const EditAccountPurposeScreen({super.key, this.data});
  final GetAccountPurposeToEditResponse? data;

  @override
  ConsumerState<EditAccountPurposeScreen> createState() =>
      _EditAccountPurposeScreenState();
}

class _EditAccountPurposeScreenState
    extends ConsumerState<EditAccountPurposeScreen> {
  final _fundingFormFormKey = GlobalKey<FormState>();

  // funding TextEditingControllers
  final TextEditingController othersController = TextEditingController();
  final TextEditingController prevItemStageController = TextEditingController();
  final TextEditingController actionFlagController = TextEditingController();

  bool salaryProcessing = false;
  bool toOtainLoan = false;
  bool businessTransactional = false;
  bool savingsInvestment = false;
  bool conductSingleTransaction = false;
  bool secutirySafeKeeping = false;
  bool accessToBankingServices = false;
  bool thirdPartyPayment = false;
  bool recieptOfInflows = false;
  bool others = false;

  bool hidePrevItemStage = false;

  void togglePrevItemStage() {
    setState(() {
      hidePrevItemStage = !hidePrevItemStage;
    });
  }

  String? selectedItemStage;

  @override
  void initState() {
    super.initState();
    try {
      final originalData = widget.data?.data;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          salaryProcessing = originalData?.salaryProcessing ?? false;
          toOtainLoan = originalData?.toOtainLoan ?? false;
          businessTransactional = originalData?.businessTransactional ?? false;
          savingsInvestment = originalData?.savingsInvestment ?? false;
          conductSingleTransaction =
              originalData?.conductSingleTransaction ?? false;
          secutirySafeKeeping = originalData?.secutirySafeKeeping ?? false;
          accessToBankingServices =
              originalData?.accessToBankingServices ?? false;
          thirdPartyPayment = originalData?.thirdPartyPayment ?? false;
          recieptOfInflows = originalData?.recieptOfInflows ?? false;
          others = originalData?.others ?? false;
          selectedItemStage = originalData?.itemStage;
          prevItemStageController.text =
              originalData?.itemStage ?? 'No selection';
        });
      });
    } catch (e) {}
  }

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    othersController.dispose();
    actionFlagController.dispose();
    super.dispose();
  }

  // Method to handle checkbox state changes
  void _handleCheckboxChange(int checkboxNumber, bool? value) {
    setState(() {
      switch (checkboxNumber) {
        case 1:
          salaryProcessing = value ?? false;
          break;
        case 2:
          toOtainLoan = value ?? false;
          break;
        case 3:
          businessTransactional = value ?? false;
          break;
        case 4:
          savingsInvestment = value ?? false;
          break;
        case 5:
          conductSingleTransaction = value ?? false;
          break;
        case 6:
          secutirySafeKeeping = value ?? false;
          break;
        case 7:
          accessToBankingServices = value ?? false;
          break;
        case 8:
          thirdPartyPayment = value ?? false;
          break;
        case 9:
          recieptOfInflows = value ?? false;
          break;
        case 10:
          others = value ?? false;
          break;
      }
    });
  }

  Future<void> _submitForm(BuildContext context) async {
    final originalData = widget.data?.data;
    await ref
        .read(editAccountPurposeControllerProvider.notifier)
        .editAccountPurposeDaata(
            context: context,
            data: EditAccountPurpose(
              accessToBankingServices: accessToBankingServices,
              accountPurposesId: originalData?.accountPurposesId,
              actionFlag: originalData?.actionFlag,
              businessTransactional: businessTransactional,
              conductSingleTransaction: conductSingleTransaction,
              itemStage: selectedItemStage,
              others: others,
              othersSpecify: othersController.text,
              recieptOfInflows: recieptOfInflows,
              requestId: originalData?.reqId,
              rowVersion: originalData?.rowVersion,
              salaryProcessing: salaryProcessing,
              savingsInvestment: savingsInvestment,
              secutirySafeKeeping: secutirySafeKeeping,
              thirdPartyPayment: thirdPartyPayment,
              toOtainLoan: toOtainLoan,
              
            ));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      editAccountPurposeControllerProvider,
      (_, state) => state.showAlertDialogOnError(context,
          okAction: () {}, errorMsg: state.error),
    );
 


    return 
    ZxploreProgress(
      inAsyncCall: ref.watch(editAccountPurposeControllerProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        showAddMore: false,
        button: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryButton(
              onPressed: () {
                if (!_fundingFormFormKey.currentState!.validate()) {
                  return;
                }
                if (selectedItemStage == null) {
                  zXFlushBar(context, "Item stage is required");
                }
                _submitForm(context);
              },
              title: 'Save'),
        ),
        title: 'Editing Account Purposes',
        widgetToGoOnCancel: FundingSourcesScreen(
          requestData: widget.data!.toJson(),
        ),
        onCancel: () => Navigator.pop(context),
        data: widget.data?.toJson(),
        addMore: IconButton(onPressed: () {}, icon: Icon(Icons.add_box)),
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
              key: _fundingFormFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Account Purpose',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  gapH16,

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
                    title: Text('Salary Processing'),
                    value: salaryProcessing,
                    onChanged: (value) => _handleCheckboxChange(1, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('To Obtain Loan'),
                    value: toOtainLoan,
                    onChanged: (value) => _handleCheckboxChange(2, value),
                  ),
                  gapH12,

                  CheckboxListTile(
                    title: Text('Business Transactional'),
                    value: businessTransactional,
                    onChanged: (value) => _handleCheckboxChange(3, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Savings Investment'),
                    value: savingsInvestment,
                    onChanged: (value) => _handleCheckboxChange(4, value),
                  ),
                  gapH12,

                  CheckboxListTile(
                    title: Text('Conduct Single Transaction'),
                    value: conductSingleTransaction,
                    onChanged: (value) => _handleCheckboxChange(5, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Secutiry Safe Keeping'),
                    value: secutirySafeKeeping,
                    onChanged: (value) => _handleCheckboxChange(6, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Access To Banking Services'),
                    value: accessToBankingServices,
                    onChanged: (value) => _handleCheckboxChange(7, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Third Party Payment'),
                    value: thirdPartyPayment,
                    onChanged: (value) => _handleCheckboxChange(8, value),
                  ),
                  gapH12,

                  CheckboxListTile(
                    title: Text('Reciept Of Inflows'),
                    value: recieptOfInflows,
                    onChanged: (value) => _handleCheckboxChange(9, value),
                  ),
                  gapH12,

                  CheckboxListTile(
                    title: Text('Others'),
                    value: others,
                    onChanged: (value) => _handleCheckboxChange(10, value),
                  ),

                  if (others) ...[
                    gapH12,
                    CustomTextFormField(
                      title: 'Specicy others',
                      fillColor: Colors.transparent,
                      controller: actionFlagController,
                      hint: 'Enter others',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        return null;
                      },
                    ),
                  ],

                  // const SizedBox(height: 16),
                  // CustomTextFormField(
                  //   title: 'Action Flag',
                  //   fillColor: Colors.transparent,
                  //   controller: actionFlagController,
                  //   hint: 'Action Flag',
                  //   inputType: TextInputType.text,
                  //   useDefaultErrorText: false,
                  //   validator: (value) {
                  //     return null;
                  //   },
                  // ),

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
