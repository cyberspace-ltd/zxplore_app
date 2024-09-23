import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/get_related_business_response.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_other_bank_controller.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_related_business_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_related_business_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditRelatedBusinessScreen extends ConsumerStatefulWidget {
  const EditRelatedBusinessScreen({super.key,this.data});
  final GetRelatedBusinessToEditResponse? data;

  @override
  ConsumerState<EditRelatedBusinessScreen> createState() => _EditRelatedBusinessScreenState();
}

class _EditRelatedBusinessScreenState extends ConsumerState<EditRelatedBusinessScreen> {
  final _formkeyOtherAcc = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController relationshipNatureController = TextEditingController();
 
  @override
  void dispose() {
    // Dispose the controllers to free up resources
    addressController.dispose();
    nameController.dispose();
    relationshipNatureController.dispose();
    
    super.dispose();
  }
 
  @override
  void initState() {
    super.initState();
    final userData = widget.data?.data;
    WidgetsBinding.instance.addPostFrameCallback((callback){
      try {
        addressController.text = userData?.address??'';
        nameController.text = userData?.name??'';
        relationshipNatureController.text = userData?.relationshipNature??'';
      } catch (e) { }
    });
  }
 
  Future<void> _submitForm(BuildContext context)async {
    final userData = widget.data?.data;
    final account = RelatedBusinessData(
        reqId: userData?.reqId,
        actionFlag: userData?.actionFlag,
        address:userData?.address ,
        itemStage: userData?.itemStage,
        rowVersion:userData?.rowVersion ,
         name:userData?.name,
 relationshipNature:userData?.relationshipNature,
    );

    ref.read(editRelatedBusinessControllerProvider.notifier).editRelatedBusiness(context:context, data: account);
    
  }

  @override
  Widget build(BuildContext context) {
                          ref.listen<AsyncValue>(
      editRelatedBusinessControllerProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {}),
    );
    return ZxploreProgress(
      inAsyncCall: ref.watch(editRelatedBusinessControllerProvider).isLoading||
      ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Related Business',
                widgetToGoOnCancel: ViewRelatedBusiness(formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap(),),

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
                      'Related Business',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    div,
                    gapH16,
                     
                  CustomTextFormField(
                      title: 'Name',
                      fillColor: Colors.transparent,
                      controller: nameController,
                      hint: 'Enter   name',
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
                     
                   
                    gapH16,
                        CustomTextFormField(
                      title: 'Relationship',
                      fillColor: Colors.transparent,
                      controller: relationshipNatureController,
                      hint: 'Enter business relationship',
                      inputType: TextInputType.number,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if(value?.isEmpty==true){
                          return 'business relationship is required';
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
