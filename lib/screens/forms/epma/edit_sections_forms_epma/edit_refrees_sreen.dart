import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/add_edit_refree.dart';
import 'package:zxplore_app/models/epma_models/get_refree_to_edit.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_refree_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_refrees_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class  EditRefereeScreen extends ConsumerStatefulWidget {
  const  EditRefereeScreen({super.key,this.data});
  final GetRefereeToEditResponse? data;

  @override
  ConsumerState< EditRefereeScreen> createState() => _EditRefereeScreenState();
}

class _EditRefereeScreenState extends ConsumerState< EditRefereeScreen> {
  final _formkeyOtherAcc = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final TextEditingController bankController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
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
        bankController.text = userData?.bankers??'';
        addressController.text = userData?.address??'';
        accountNameController.text = userData?.accountName??'';
        nameController.text = userData?.name??'';
        accountNumberController.text = userData?.accountNo??'';
      } catch (e) { }
    });
  }

  Future<void> _submitForm(BuildContext context)async {
    final userData = widget.data?.data;
    final account = AddReferee(
      refereeId: userData?.refereeId,
        rowVersion:userData?.rowVersion ,
        itemStage: userData?.itemStage,
        requestId: userData?.reqId,
        accountName: accountNameController.text,
        name:nameController.text ,
        accountNo:accountNumberController.text ,
        actionFlag: userData?.actionFlag,
        address:addressController.text ,
        bankers: bankController.text,
    );

    ref.read(editRefereeControllerProvider.notifier).editReferee(context:context, data: account);
    
  }

  @override
  Widget build(BuildContext context) {

                      ref.listen<AsyncValue>(
      editRefereeControllerProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {}),
    );
    return ZxploreProgress(
      inAsyncCall: ref.watch(editRefereeControllerProvider).isLoading||
      ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Referee',
        // widgetToGoOnCancel: Container(),
        widgetToGoOnCancel: ViewRefreesScreen(formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap(),),

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
                    Wrap(
                      children: [
                        Text(
                          'Referee: ${ widget.data?.data?.name}',
                          maxLines :2,
                        overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ],
                    ),
                    div,
                    gapH16,

                       CustomTextFormField(
                      title: 'Name',
                      fillColor: Colors.transparent,
                      controller: nameController,
                      hint: 'Enter name',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if(value?.isEmpty==true){
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
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
                    // gapH16,
                     
                    // CustomTextFormField(
                    //   title: 'Branch',
                    //   fillColor: Colors.transparent,
                    //   controller: branchController,
                    //   hint: 'Enter amount',
                    //   inputType: TextInputType.text,
                    //   useDefaultErrorText: false,
                    //   validator: (value) {
                    //     if(value?.isEmpty==true){
                    //       return 'Branch is required';
                    //     }
                    //     return null;
                    //   },
                    // ),
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
