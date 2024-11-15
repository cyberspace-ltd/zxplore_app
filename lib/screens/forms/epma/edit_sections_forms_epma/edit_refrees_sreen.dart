import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/add_edit_refree.dart';
import 'package:zxplore_app/models/epma_models/get_refree_to_edit.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_refree_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/forms/epma/create_new_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_refrees_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/utils/string_extentions.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditRefereeScreen extends ConsumerStatefulWidget {
  const EditRefereeScreen({super.key, this.data});
  final GetRefereeToEditResponse? data;

  @override
  ConsumerState<EditRefereeScreen> createState() => _EditRefereeScreenState();
}

class _EditRefereeScreenState extends ConsumerState<EditRefereeScreen> {
  final _refereeFormkey = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final TextEditingController bankController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController prevItemStageController = TextEditingController();

  String? selectedItemStage;
  bool hidePrevItemStage = false;

  void togglePrevItemStage() {
    setState(() {
      hidePrevItemStage = !hidePrevItemStage;
    });
  }

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    bankController.dispose();
    branchController.dispose();
    addressController.dispose();
    accountNameController.dispose();
    accountNumberController.dispose();
    prevItemStageController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final userData = widget.data?.data;
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      try {
        bankController.text = userData?.bankers ?? '';
        addressController.text = userData?.address ?? '';
        accountNameController.text = userData?.accountName ?? '';
        nameController.text = userData?.name ?? '';
        accountNumberController.text = userData?.accountNo ?? '';
        selectedItemStage = userData?.itemStage;
        prevItemStageController.text = userData?.itemStage ?? 'No selection';
      } catch (e) {}
    });
  }

  Future<void> _submitForm(BuildContext context) async {
    final userData = widget.data?.data;
    final account = AddReferee(
      refereeId: userData?.refereeId,
      rowVersion: userData?.rowVersion,
      itemStage: selectedItemStage,
      requestId: userData?.reqId,
      accountName: accountNameController.text,
      name: nameController.text,
      accountNo: accountNumberController.text,
      actionFlag: userData?.actionFlag ?? 'A',
      address: addressController.text,
      bankers: bankController.text,
    );

    ref
        .read(editRefereeControllerProvider.notifier)
        .editReferee(context: context, data: account);
  }

  @override
  Widget build(BuildContext context) {
   
    return ZxploreProgress(
      inAsyncCall: ref.watch(editRefereeControllerProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Referee',
        button: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: PrimaryButton(
              onPressed: () {
                if (!_refereeFormkey.currentState!.validate()) {
                  return;
                }

                if (selectedItemStage == null) {
                  zXFlushBar(context, "Form stage is required");
                }

                /// perform trn if all is well
                _submitForm(context);
              },
              title: 'Save'),
        ),
        widgetToGoOnCancel: ViewRefreesScreen(
          formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap(),
        ),
        onCancel: () => Navigator.pop(context),
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
              key: _refereeFormkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  gapH24,
                  Wrap(
                    children: [
                      Text(
                        'Referee: ${widget.data?.data?.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ],
                  ),
                  div,
                  gapH16,
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
                  CustomTextFormField(
                    title: 'Name',
                    fillColor: Colors.transparent,
                    controller: nameController,
                    hint: 'Enter name',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value?.isEmpty == true) {
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
                      if (value?.isEmpty == true) {
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
                      if (value?.isEmpty == true) {
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
                      if (value?.isEmpty == true) {
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
                      if (value?.isEmpty == true) {
                        return 'Account number is required';
                      }
                      return null;
                    },
                  ),

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
