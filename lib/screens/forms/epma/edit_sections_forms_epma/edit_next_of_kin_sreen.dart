import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/add_edit_next_of_kin.dart';
import 'package:zxplore_app/models/epma_models/get_next_of_kin_to_edit.dart';
import 'package:zxplore_app/models/epma_models/meta/gender_response.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_next_of_kin_controller.dart';
import 'package:zxplore_app/screens/controllers/meta/gender.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/add_edit_refree.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_refree_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';


class EditNextOfKinScreen extends ConsumerStatefulWidget {
  const EditNextOfKinScreen({super.key,this.data});
 final GetNextOfKinToEditResponse? data;

  @override
  ConsumerState<EditNextOfKinScreen> createState() => _EditNextOfKinScreenState();
}

class _EditNextOfKinScreenState extends ConsumerState<EditNextOfKinScreen> {
  final _nokEditFormKey = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController telNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController relationshipeController = TextEditingController();
   GendersDatum? selectedGenderItem;
 String? genderCode;
    String? genderName;

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    fullNameController.dispose();
    telNoController.dispose();
    addressController.dispose();
    relationshipeController.dispose();
    
    super.dispose();
  }
 
  @override
  void initState() {
    super.initState();
    final userData = widget.data?.data;
    WidgetsBinding.instance.addPostFrameCallback((callback){
      try {
        fullNameController.text = userData?.fullName??'';
        addressController.text = userData?.residentialAddress??'';
        relationshipeController.text = userData?.relationship??'';
        telNoController.text = userData?.telNo??'';
      } catch (e) { }
    });
  }

  Future<void> _submitForm(BuildContext context)async {
    final userData = widget.data?.data;
    final account = AddNextOfKin(
      nextOfKinId: userData?.nextOfKinId,
        rowVersion:userData?.rowVersion ,
        itemStage: userData?.itemStage,
        requestId: userData?.reqId,
        fullName: fullNameController.text,
        relationship:relationshipeController.text ,
        genderCode:genderCode ,
        actionFlag: userData?.actionFlag,
        telNo:telNoController.text ,
        residentialAddress: addressController.text,
    );

    ref.read(editNextOfKinControllerProvider.notifier).editNok(context:context, data: account);
    
  }

  @override
  Widget build(BuildContext context) {
              ref.listen<AsyncValue>(
      editNextOfKinControllerProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {}),
    );
    return ZxploreProgress(
      inAsyncCall: ref.watch(editNextOfKinControllerProvider).isLoading||
      ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Next Of Kin',
        widgetToGoOnCancel: Container(),
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
                key: _nokEditFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    gapH24,
                    Wrap(
                      children: [
                        Text(
                          'Next Of Kin: ${ widget.data?.data?.fullName}',
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
                      controller: fullNameController,
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
                       Text(
                      'Gender',
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
                        return ref.watch(getGenderProvider).when(
                              data: (data) => (data != null &&
                                      data.isNotEmpty == true)
                                  ? DropdownButtonHideUnderline(
                                      child: DropdownButton2<
                                          GendersDatum>(
                                        isExpanded: true,
                                        hint: Text(
                                          'Select gender',
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
                                                        GendersDatum>>(
                                                (item) => DropdownMenuItem<
                                                        GendersDatum>(
                                                      value: item,
                                                      child: Text(
                                                        '${item.genderName}',
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
                                        value: selectedGenderItem,
                                        onChanged:
                                            (GendersDatum? newValue) {
                                          setState(() {
                                            /// Set selected item params
                                            selectedGenderItem = newValue;
                                            genderName =
                                                newValue?.genderName;
                                            genderCode =
                                                newValue?.genderCode;
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
                                          getGenderProvider),
                                      child: Text('Empty data, Tap to retry')),
                              error: (e, s) => GestureDetector(
                                  onTap: () => ref
                                      .invalidate(getGenderProvider),
                                  child: const Text(
                                    'An error occured',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              loading: () => SizedBox(height: 16.0),
                            );
                      },
                    ),
                        
                    gapH16,
                    CustomTextFormField(
                      title: 'Residential Address',
                      fillColor: Colors.transparent,
                      controller: addressController,
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
                      title: 'Telephone Number',
                      fillColor: Colors.transparent,
                      controller: addressController,
                      hint: 'Enter number',
                      inputType: TextInputType.phone,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if(value?.isEmpty==true){
                          return 'Telephone Number is required';
                        }
                        return null;
                      },
                    ),
                    gapH16,
                     
                    CustomTextFormField(
                      title: 'Relationship',
                      fillColor: Colors.transparent,
                      controller: relationshipeController,
                      hint: 'Enter account name',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if(value?.isEmpty==true){
                          return 'Relationship is required';
                        }
                        return null;
                      },
                    ),
                    

                    const SizedBox(height: 24),
                    PrimaryButton(
                        onPressed: () {
                          if (!_nokEditFormKey.currentState!.validate()||
                          selectedGenderItem==null) {
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
