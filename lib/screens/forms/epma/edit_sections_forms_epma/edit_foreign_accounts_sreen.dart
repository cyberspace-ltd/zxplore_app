import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/add_edit_foreign_account.dart';
import 'package:zxplore_app/models/epma_models/get_foreign_accounts_response.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_foreign_accounts_controller.dart';
import 'package:zxplore_app/screens/forms/epma/create_new_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_funding_sources_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/utils/string_extentions.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditForeignAaccountScreen extends ConsumerStatefulWidget {
  const EditForeignAaccountScreen({super.key, this.data});
  final GetForeignAccountToEditResponse? data;

  @override
  ConsumerState<EditForeignAaccountScreen> createState() =>
      _EditForeignAaccountScreenState();
}

class _EditForeignAaccountScreenState
    extends ConsumerState<EditForeignAaccountScreen> {
  final _fundingFormFormKey = GlobalKey<FormState>();

  // funding TextEditingControllers
  final TextEditingController relatedAccountCtrl = TextEditingController();
  final TextEditingController fundSourceOtherSpecifyCtrl =
      TextEditingController();
  final TextEditingController fundSourceSenderInvesterCtrl =
      TextEditingController();
  final TextEditingController inflowFrequencyOtherSpecifyCtrl =
      TextEditingController();
  final TextEditingController accountPurposeOtherSpecifyCtrl =
      TextEditingController();
  final TextEditingController prevItemStageController = TextEditingController();

  bool hidePrevItemStage = false;
  String? selectedItemStage;

  void togglePrevItemStage() {
    setState(() {
      hidePrevItemStage = !hidePrevItemStage;
    });
  }
  bool hasRelatedAccount = false;
  bool maintainMandate = false;
  bool offShoreUSD = false;
  bool offShoreGBP = false;
  bool offShoreEUR = false;
  bool onShoreUSD = false;
  bool onShoreGBP = false;
  bool onShoreEUR = false;
  bool accountPurposeSalary = false;
  bool accountPurposeBusiness = false;
  bool accountPurposeOther = false;
  bool fundSourceSalary = false;
  bool fundSourceOther = false;
  bool inflowFrequencyWeekly = false;
  bool inflowFrequencyFortnightly = false;
  bool inflowFrequencyMonthly = false;
  bool inflowFrequencyQuarterly = false;
  bool inflowFrequencyOther = false;
  bool fundSourceBusinessIncome = false;
  

  @override
  void initState() {
    super.initState();
    try {
      final originalData = widget.data?.data;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          selectedItemStage= originalData?.itemStage??'No selection';
          hasRelatedAccount = originalData?.hasRelatedAccount ?? false;
          maintainMandate = originalData?.maintainMandate ?? false;
          offShoreUSD = originalData?.offShoreUsd ?? false;
          offShoreEUR = originalData?.offShoreEur ?? false;
          onShoreUSD = originalData?.onShoreUsd ?? false;
          onShoreGBP = originalData?.onShoreGbp ?? false;
          onShoreEUR = originalData?.onShoreEur ?? false;
               selectedItemStage = originalData?.itemStage;
        prevItemStageController.text = originalData?.itemStage ?? 'No selection';
     
          accountPurposeSalary = originalData?.accountPurposeSalary ?? false;
          accountPurposeBusiness =
              originalData?.accountPurposeBusiness ?? false;
          accountPurposeOther = originalData?.accountPurposeOther ?? false;
          fundSourceSalary = originalData?.fundSourceSalary ?? false;
          fundSourceBusinessIncome =
              originalData?.fundSourceBusinessIncome ?? false;
          fundSourceOther = originalData?.fundSourceOther ?? false;
          inflowFrequencyWeekly = originalData?.inflowFrequencyWeekly ?? false;
          inflowFrequencyFortnightly =
              originalData?.inflowFrequencyFortnightly ?? false;
          inflowFrequencyMonthly =
              originalData?.inflowFrequencyFortnightly ?? false;
          inflowFrequencyQuarterly =
              originalData?.inflowFrequencyQuarterly ?? false;
          inflowFrequencyOther = originalData?.inflowFrequencyOther ?? false;
              accountPurposeOtherSpecifyCtrl.text=originalData?.accountPurposeOtherSpecify??'';
         inflowFrequencyOtherSpecifyCtrl.text=originalData?.inflowFrequencyOtherSpecify??'';
          relatedAccountCtrl.text=originalData?.relatedAccount??'';
            fundSourceOtherSpecifyCtrl.text=originalData?.fundSourceOtherSpecify??'';
            fundSourceSenderInvesterCtrl.text=originalData?.fundSourceSenderInvester??'';

        });
      });
    } catch (e) {}
  }

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    relatedAccountCtrl.dispose();
    fundSourceOtherSpecifyCtrl.dispose();
    fundSourceSenderInvesterCtrl.dispose();
    inflowFrequencyOtherSpecifyCtrl.dispose();
    prevItemStageController.dispose();

    super.dispose();
  }

  // Method to handle checkbox state changes
  void _handleCheckboxChange(int checkboxNumber, bool? value) {
    setState(() {
      switch (checkboxNumber) {
        case 1:
          hasRelatedAccount = value ?? false;
          break;
        case 2:
          maintainMandate = value ?? false;
          break;
        case 3:
          offShoreUSD = value ?? false;
          break;
        case 4:
          offShoreGBP = value ?? false;
          break;
        case 5:
          offShoreEUR = value ?? false;
          break;
        case 6:
          onShoreUSD = value ?? false;
          break;
        case 7:
          onShoreGBP = value ?? false;
          break;
        case 8:
          onShoreEUR = value ?? false;
          break;
        case 9:
          accountPurposeSalary = value ?? false;
          break;
        case 10:
          accountPurposeBusiness = value ?? false;
          break;
        case 11:
          accountPurposeOther = value ?? false;
          break;
        case 12:
          fundSourceSalary = value ?? false;
          break;
        case 13:
          fundSourceBusinessIncome = value ?? false;
          break;
        case 14:
          fundSourceOther = value ?? false;
          break;
        case 15:
          inflowFrequencyWeekly = value ?? false;
          break;
        case 16:
       inflowFrequencyFortnightly    = value ?? false;
          break;
        case 17:
       
          inflowFrequencyMonthly = value ?? false;
          break;
        case 18:
           inflowFrequencyQuarterly= value ?? false;
          break;
        case 19:
          inflowFrequencyOther = value ?? false;
          break;
      }
    });
  }

  Future<void> _submitForm(BuildContext context) async {
    final originalData = widget.data?.data;
    await ref
        .read(editForeignAaccountsControllerrProvider.notifier)
        .editForeignAccount(
            context: context,
            editAccount: EditForeignAccount(
              itemStage: selectedItemStage,
              requestId: originalData?.reqId,
              rowVersion: originalData?.rowVersion,
              actionFlag:  originalData?.actionFlag,
              accountPurposeBusiness: accountPurposeBusiness,
              accountPurposeOther:accountPurposeOther ,
              fundSourceSalary:fundSourceSalary ,
              accountPurposeOtherSpecify: accountPurposeOtherSpecifyCtrl.text,
              inflowFrequencyOtherSpecify: inflowFrequencyOtherSpecifyCtrl.text,
              relatedAccount: relatedAccountCtrl.text,
              fundSourceOtherSpecify: fundSourceOtherSpecifyCtrl.text,
              fundSourceSenderInvester: fundSourceSenderInvesterCtrl.text,
              hasRelatedAccount: hasRelatedAccount,
               inflowFrequencyQuarterly:inflowFrequencyQuarterly , 
              inflowFrequencyWeekly:inflowFrequencyWeekly ,
              maintainMandate:maintainMandate , 
              inflowFrequencyFortnightly:inflowFrequencyFortnightly ,
              inflowFrequencyMonthly:inflowFrequencyMonthly ,
              inflowFrequencyOther: inflowFrequencyOther,
              accountPurposeSalary:accountPurposeSalary ,
              foreignAccountId:originalData?.foreignAccountId ,
              fundSourceBusinessIncome:fundSourceBusinessIncome ,
              fundSourceOther:fundSourceOther ,
              offShoreEur:offShoreEUR ,
              offShoreGbp:offShoreGBP ,
              offShoreUsd:offShoreUSD ,
              onShoreEur: onShoreEUR,
              onShoreGbp:onShoreGBP ,
              onShoreUsd:onShoreUSD ,

            ));
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen<AsyncValue>(
    //   editForeignAaccountsControllerrProvider,
    //   (_, state) => state.showAlertDialogOnError(context, okAction: () {},errorMsg: state.error),
    // );

    return ZxploreProgress(
      inAsyncCall: ref.watch(editForeignAaccountsControllerrProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Funding Sources',
        button:   Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryButton(
                        onPressed: () {
                              if (selectedItemStage == null) {
                  zXFlushBar(context, "Form stage is required");
                  return;
                }
                          if (!_fundingFormFormKey.currentState!.validate()) {
                            return;
                          }
                          //if non is selected
                          if(
                            !hasRelatedAccount&&
                            !maintainMandate&&
                            !offShoreUSD&&
                            !offShoreGBP&&
                            !offShoreEUR&&
                            !onShoreUSD&&
                            !onShoreGBP&&
                            !onShoreEUR&&
                            !accountPurposeSalary&&
                            !accountPurposeBusiness&&
                            !fundSourceSalary&&
                            !fundSourceBusinessIncome&&
                            !fundSourceOther&&
                            !inflowFrequencyWeekly&&
                            !inflowFrequencyFortnightly&&
                            !inflowFrequencyMonthly&&
                            !inflowFrequencyQuarterly&&
                            !inflowFrequencyOther==false
                            ){
                                  zXFlushBar(context, "Select values for this account");
                            return;
                          }
                                    if (selectedItemStage == null) {
                    zXFlushBar(context, "Item stage is required");
                  }
                          _submitForm(context);
                        },
                        title: 'Save'),
        ),
        widgetToGoOnCancel: FundingSourcesScreen(
          requestData: widget.data!.toJson(),
        ),
        onCancel: () =>Navigator.pop(context),
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
                  gapH24,
                  Text(
                    'Foreign Accounts',
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
                    title: Text('Has RelatedAccount'),
                    value: hasRelatedAccount,
                    onChanged: (value) => _handleCheckboxChange(1, value),
                  ),
                   const SizedBox(height: 12),
                   if(hasRelatedAccount)...[
                  CustomTextFormField(
                    title: 'Related Account ',
                    fillColor: Colors.transparent,
                    controller: relatedAccountCtrl,
                    hint: 'Enter related Account ',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                        if(hasRelatedAccount){
                         if (value.toString().isEmpty) {
                        return '  Related  account is Required';
                      }
                        }
                     
                      return null;
                    },
                  )],
                  gapH12,
                  CheckboxListTile(
                    title: Text('Maintain Mandate'),
                    value: maintainMandate,
                    onChanged: (value) => _handleCheckboxChange(2, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Off Shore USD'),
                    value: offShoreUSD,
                    onChanged: (value) => _handleCheckboxChange(3, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Off Shore GBP'),
                    value: offShoreGBP,
                    onChanged: (value) => _handleCheckboxChange(4, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Off Shore EUR'),
                    value: offShoreEUR,
                    onChanged: (value) => _handleCheckboxChange(5, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('On Shore USD'),
                    value: onShoreUSD,
                    onChanged: (value) => _handleCheckboxChange(6, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('On Shore GBP'),
                    value: onShoreGBP,
                    onChanged: (value) => _handleCheckboxChange(7, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('On Shore EUR'),
                    value: onShoreEUR,
                    onChanged: (value) => _handleCheckboxChange(8, value),
                  ),
                  gapH16,
                    Text(
                    'AccountPurpose',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  div,
                
                  gapH12,
                  CheckboxListTile(
                    title: Text('Salary'),
                    value: accountPurposeBusiness,
                    onChanged: (value) => _handleCheckboxChange(9, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Business'),
                    value: accountPurposeBusiness,
                    onChanged: (value) => _handleCheckboxChange(10, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Other'),
                    value: accountPurposeSalary,
                    onChanged: (value) => _handleCheckboxChange(11, value),
                  ),
                  if (accountPurposeOther) ...[
                    gapH12,
                    CustomTextFormField(
                      title: 'Specicy others',
                      fillColor: Colors.transparent,
                      controller: accountPurposeOtherSpecifyCtrl,
                      hint: 'Enter others',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if(accountPurposeOther){
                         if (value.toString().isEmpty) {
                        return '  Required';
                      }
                        }
                        
                        return null;
                      },
                    ),
                  ],
                    gapH16,
                    Text(
                    'Account Fund Sources',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  div,
                  gapH12,
                  CheckboxListTile(
                    title: Text('Salary'),
                    value: fundSourceSalary,
                    onChanged: (value) => _handleCheckboxChange(12, value),
                  ),
                  gapH12,
                   CheckboxListTile(
                    title: Text('Business Income'),
                    value: fundSourceBusinessIncome,
                    onChanged: (value) => _handleCheckboxChange(13, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Other'),
                    value: fundSourceOther,
                    onChanged: (value) => _handleCheckboxChange(14, value),
                  ),
                  if (fundSourceOther) ...[
                    gapH12,
                    CustomTextFormField(
                      title: 'Specicy other funds sources',
                      fillColor: Colors.transparent,
                      controller: fundSourceOtherSpecifyCtrl,
                      hint: 'Enter other account purpose',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                         if(fundSourceOther){
                         if (value.toString().isEmpty) {
                        return 'Other funds sources is Required';
                      }
                        }
                        return null;
                      },
                    ),
                  ],

                  gapH16,
                    Text(
                    'Inflow Frequency',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  div,

                    gapH12,
                  CheckboxListTile(
                    title: Text('Weekly'),
                    value: fundSourceSalary,
                    onChanged: (value) => _handleCheckboxChange(15, value),
                  ),
                    gapH12,
                  CheckboxListTile(
                    title: Text('Fortnightly'),
                    value: inflowFrequencyFortnightly,
                    onChanged: (value) => _handleCheckboxChange(16, value),
                  ),
                    gapH12,
                  CheckboxListTile(
                    title: Text('Monthly'),
                    value: inflowFrequencyMonthly,
                    onChanged: (value) => _handleCheckboxChange(17, value),
                  ),
                    gapH12,
                  CheckboxListTile(
                    title: Text('Quarterly'),
                    value: inflowFrequencyQuarterly,
                    onChanged: (value) => _handleCheckboxChange(18, value),
                  ),
                 
                    gapH12,
                  CheckboxListTile(
                    title: Text('Other'),
                    value: inflowFrequencyOther,
                    onChanged: (value) => _handleCheckboxChange(19, value),
                  ),
                     if (inflowFrequencyOther) ...[
                    gapH12,
                    CustomTextFormField(
                      title: 'Other ',
                      fillColor: Colors.transparent,
                      controller: inflowFrequencyOtherSpecifyCtrl,
                      hint: 'Enter other frequency',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                            if(inflowFrequencyOther){
                         if (value.toString().isEmpty) {
                        return 'Other funds sources is Required';
                      }
                        }
                        return null;
                      },
                    ),
                  ],
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
