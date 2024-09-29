import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/get_related_business_response.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_related_business_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/create_new_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_related_business_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/utils/string_extentions.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditRelatedBusinessScreen extends ConsumerStatefulWidget {
  const EditRelatedBusinessScreen({super.key, this.data});
  final GetRelatedBusinessToEditResponse? data;

  @override
  ConsumerState<EditRelatedBusinessScreen> createState() =>
      _EditRelatedBusinessScreenState();
}

class _EditRelatedBusinessScreenState
    extends ConsumerState<EditRelatedBusinessScreen> {
  final _bizFormkey = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController relationshipNatureController =
      TextEditingController();
  final TextEditingController prevItemStageController = TextEditingController();

  bool hidePrevItemStage = false;
  String? selectedItemStage;

  void togglePrevItemStage() {
    setState(() {
      hidePrevItemStage = !hidePrevItemStage;
    });
  }

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    addressController.dispose();
    nameController.dispose();
    relationshipNatureController.dispose();
    prevItemStageController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final userData = widget.data?.data;
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      try {
        addressController.text = userData?.address ?? '';
        nameController.text = userData?.name ?? '';
        relationshipNatureController.text = userData?.relationshipNature ?? '';
        selectedItemStage = userData?.itemStage;
        prevItemStageController.text = userData?.itemStage ?? 'No selection';
      } catch (e) {}
    });
  }

  Future<void> _submitForm(BuildContext context) async {
    final userData = widget.data?.data;
    final account = RelatedBusinessData(
      reqId: userData?.reqId,

      actionFlag: userData?.actionFlag,
      address: userData?.address,
      itemStage: selectedItemStage, //userData?.itemStage,
      rowVersion: userData?.rowVersion,
      name: userData?.name,
      relationshipNature: userData?.relationshipNature,
    );

    ref
        .read(editRelatedBusinessControllerProvider.notifier)
        .editRelatedBusiness(context: context, data: account);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      editRelatedBusinessControllerProvider,
      (_, state) => state.showAlertDialogOnError(context,
          okAction: () {}, errorMsg: state.error),
    );
    
    return ZxploreProgress(
      inAsyncCall: ref.watch(editRelatedBusinessControllerProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Related Business',
        widgetToGoOnCancel: ViewRelatedBusiness(
          formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap(),
        ),
        onCancel: () => Navigator.pop(context),
        data: {},
        button: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: PrimaryButton(
              onPressed: () {
                if (!_bizFormkey.currentState!.validate()) {
                  return;
                }
                if (selectedItemStage == null) {
                  zXFlushBar(context, "Item stage is required");
                }

                /// perform trn if all is well
                _submitForm(context);
              },
              title: 'Save'),
        ),
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
              key: _bizFormkey,
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
                    hint: 'Enter   name',
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
                  gapH16,
                  CustomTextFormField(
                    title: 'Relationship',
                    fillColor: Colors.transparent,
                    controller: relationshipNatureController,
                    hint: 'Enter business relationship',
                    inputType: TextInputType.number,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'business relationship is required';
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
