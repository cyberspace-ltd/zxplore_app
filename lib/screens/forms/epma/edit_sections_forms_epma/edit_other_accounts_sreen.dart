import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/add_account_model.dart';
import 'package:zxplore_app/models/epma_models/get_other_bank_to_edit_response.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_other_bank_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_other_accounts_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditOherBankAccountScreen extends ConsumerStatefulWidget {
  const EditOherBankAccountScreen({super.key,this.data});
  final GetOtherBankAccountToEditResponse? data;

  @override
  ConsumerState<EditOherBankAccountScreen> createState() => _EditOherBankAccountScreenState();
}

class _EditOherBankAccountScreenState extends ConsumerState<EditOherBankAccountScreen> {
  final _formkeyOtherAcc = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final TextEditingController bankController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
 

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    bankController.dispose();
    branchController.dispose();
    addressController.dispose();
    accountNameController.dispose();
    accountNumberController.dispose();
    
    super.dispose();
  }
 
  @override
  void initState() {
    super.initState();
    final userData = widget.data?.data;
    WidgetsBinding.instance.addPostFrameCallback((callback){
      try {
        bankController.text = userData?.bank??'';
        branchController.text = userData?.branch??'';
        addressController.text = userData?.address??'';
        accountNameController.text = userData?.accountName??'';
        accountNumberController.text = userData?.accountNumber??'';
      } catch (e) { }
    });
  }

  Future<void> _submitForm(BuildContext context)async {
    final userData = widget.data?.data;
    final account = AddOtherBankAccount(
        requestId: userData?.reqId,
        accountName: userData?.accountName,
        accountNumber:userData?.accountNumber ,
        actionFlag: userData?.actionFlag,
        address:userData?.address ,
        bank: userData?.bank,
        branch: userData?.branch,
        itemStage: userData?.itemStage,
        otherAccountsId: userData?.otherAccountsId,
        rowVersion:userData?.rowVersion ,
    );

    ref.read(editOtherBankControllerProvider.notifier).editOtherBankAccount(context:context, data: account);
    
  }

  @override
  Widget build(BuildContext context) {
                  ref.listen<AsyncValue>(
      editOtherBankControllerProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {}),
    );
    
    return ZxploreProgress(
      inAsyncCall: ref.watch(editOtherBankControllerProvider).isLoading||
      ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Other Account',
        widgetToGoOnCancel: ViewOtherAccounts(requestData: ref.read(activelyViewedRequestProvider)!.toMap(),),
        onCancel: (){},
        data: {}, 
        child:     SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                // Add bottom padding to ensure content is above the keyboard
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Form(
                key: _formkeyOtherAcc,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    gapH24,
                    Text(
                      'Other Accounts',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    div,
                    gapH16,
                     
                    CustomTextFormField(
                      title: 'Bank',
                      fillColor: Colors.transparent,
                      controller: bankController,
                      hint: 'Enter bank',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if(value?.isEmpty==true){
                          return 'Bank is required';
                        }
                        return null;
                      },
                    ),
                    gapH16,
                     
                    CustomTextFormField(
                      title: 'Branch',
                      fillColor: Colors.transparent,
                      controller: branchController,
                      hint: 'Enter amount',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if(value?.isEmpty==true){
                          return 'Branch is required';
                        }
                        return null;
                      },
                    ),
                    gapH16,
                     
                    CustomTextFormField(
                      title: 'Address',
                      fillColor: Colors.transparent,
                      controller: addressController,
                      hint: 'Enter Address',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if(value?.isEmpty==true){
                          return 'Address is required';
                        }
                        return null;
                      },
                    ),
                    gapH16,
                     
                    CustomTextFormField(
                      title: 'Account Name',
                      fillColor: Colors.transparent,
                      controller: accountNameController,
                      hint: 'Enter account name',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if(value?.isEmpty==true){
                          return 'Account Name is required';
                        }
                        return null;
                      },
                    ),
                    gapH16,
                        CustomTextFormField(
                      title: 'Account Number',
                      fillColor: Colors.transparent,
                      controller: accountNumberController,
                      hint: 'Enter account number',
                      inputType: TextInputType.number,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if(value?.isEmpty==true){
                          return 'Account number is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),
                    PrimaryButton(
                        onPressed: () {
                          if (!_formkeyOtherAcc.currentState!.validate()) {
                            return;
                          }
                       
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
