import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/add_edit_child.dart';
import 'package:zxplore_app/models/epma_models/get_child_to_edite_response.dart';
import 'package:zxplore_app/models/epma_models/meta/country_response.dart';
import 'package:zxplore_app/models/epma_models/meta/gender_response.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_child_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/meta/countries.dart';
import 'package:zxplore_app/screens/controllers/meta/gender.dart';
import 'package:zxplore_app/screens/forms/epma/create_new_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_children_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/utils/string_extentions.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditChildScreen extends ConsumerStatefulWidget {
  const EditChildScreen({super.key, this.data});
  final GetChildToEditResponse? data;

  @override
  ConsumerState<EditChildScreen> createState() => _EditChildScreenState();
}

class _EditChildScreenState extends ConsumerState<EditChildScreen> {
  final _formkeyChild = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final TextEditingController surnameCtrl = TextEditingController();
  final TextEditingController otherNamesCtrl = TextEditingController();
  final TextEditingController birthDateCtrl = TextEditingController();
  final TextEditingController schoolCtrl = TextEditingController();
  final TextEditingController motherNameCtrl = TextEditingController();
  final TextEditingController maturityAgeCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();
  // final TextEditingController nationalityCodeCtrl = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  GendersDatum? selectedGenderItem;
  String? genderCode;
  String? genderName;
  CountryDatum? selectedCountry;
  String? selectedCountryCode;
  String? selectedCountryName;
    DateTime? dobInit = DateTime.now();
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
  final DateFormat sdateFormatter = DateFormat('yyyy/mm/dd');
  String dobFormattedDate = 'dd/mm/yyy';
  String sDobFormattedDate = 'yyyy/mm/dd';

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    surnameCtrl.dispose();
    otherNamesCtrl.dispose();
    birthDateCtrl.dispose();
    schoolCtrl.dispose();
    motherNameCtrl.dispose();
    maturityAgeCtrl.dispose();
    birthDateController.dispose();
    ageCtrl.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final userData = widget.data?.data;
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      try {
        surnameCtrl.text = userData?.surname ?? '';
        otherNamesCtrl.text = userData?.otherNames ?? '';
        birthDateCtrl.text =
            formatDate(userData?.birthDate?.toIso8601String() ?? '');
        schoolCtrl.text = userData?.school ?? '';
        motherNameCtrl.text = userData?.motherName ?? '';
        motherNameCtrl.text = userData?.motherName ?? '';
        ageCtrl.text = '${userData?.age ?? 0}';
      } catch (e) {}
    });
  }

  Future<void> _submitForm(BuildContext context) async {
    final userData = widget.data?.data;
    final childData = AddChild(
      childId: userData?.chidId,
      rowVersion: userData?.rowVersion,
      itemStage: userData?.itemStage,
      requestId: userData?.reqId,
      surname: surnameCtrl.text,
      otherNames: otherNamesCtrl.text,
      birthDate: dobInit,
      actionFlag: userData?.actionFlag,
      school: schoolCtrl.text,
      motherName: motherNameCtrl.text,
      maturityAge:int.parse( maturityAgeCtrl.text),
      age:int.parse(  ageCtrl.text),
      nationalityCode:selectedCountryCode ,
      countryOrigCode: selectedCountryCode ,
      genderCode:selectedGenderItem?.genderCode ,
       
    );

    ref
        .read(editChildControllerProvider.notifier)
        .editChild(context: context, data: childData);
  }

  @override
  Widget build(BuildContext context) {

       ref.listen<AsyncValue>(
      editChildControllerProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {}),
    );
    return ZxploreProgress(
      inAsyncCall: ref.watch(editChildControllerProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Child Details',
        // widgetToGoOnCancel: Container(),
        widgetToGoOnCancel: ViewChildrenScreen(formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap(),),

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
              key: _formkeyChild,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  gapH24,
                  Wrap(
                    children: [
                      Text(
                        'Child: ${widget.data?.data?.otherNames}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ],
                  ),
                  div,
                  gapH16,
                  CustomTextFormField(
                    title: 'Surname',
                    fillColor: Colors.transparent,
                    controller: surnameCtrl,
                    hint: 'Enter surname',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'surname is required';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  CustomTextFormField(
                    title: 'OtherNames',
                    fillColor: Colors.transparent,
                    controller: otherNamesCtrl,
                    hint: 'Enter Other Names',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Other Names is required';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                   CustomTextFormField( 
                    onTap: () {
                      _showDatePicker(context, dateCategory: 'DOB');
                    },
                    title: 'Date Of Birth',
                    readOnly: true,
                    showCursor: false,
                    suffixIcon: Icon(
                      Icons.calendar_today_rounded,
                      color: ZxplorePrimaryColor.withOpacity(.5),
                    ),
                    showDropDownSuffixIcon: true,
                    fillColor: Colors.transparent,
                    controller: birthDateController,
                    hint: 'Date Of Birth ',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Date Of Birth is required';
                      } else if (value == 'dd-mm-yyyy') {
                        return 'Enter a valid date';
                      }
                      return null;
                    },
                  ),
                
                  gapH16,
                  CustomTextFormField(
                    title: 'Mother\'s Name',
                    fillColor: Colors.transparent,
                    controller: motherNameCtrl,
                    hint: 'Enter Mother\'s Name',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Mother\'s Name is required';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  CustomTextFormField(
                    title: 'Maturity Age',
                    fillColor: Colors.transparent,
                    controller: maturityAgeCtrl,
                    hint: 'Enter Maturity Age',
                    inputType: TextInputType.number,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Maturity Age is required';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  CustomTextFormField(
                    title: 'Age',
                    fillColor: Colors.transparent,
                    controller: ageCtrl,
                    hint: 'Enter  Age',
                    inputType: TextInputType.number,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Age is required';
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
                                    child: DropdownButton2<GendersDatum>(
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
                                          .map<DropdownMenuItem<GendersDatum>>(
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
                                      onChanged: (GendersDatum? newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          selectedGenderItem = newValue;
                                          genderName = newValue?.genderName;
                                          genderCode = newValue?.genderCode;
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
                                    onPressed: () =>
                                        ref.invalidate(getGenderProvider),
                                    child: Text('Empty data, Tap to retry')),
                            error: (e, s) => GestureDetector(
                                onTap: () => ref.invalidate(getGenderProvider),
                                child: const Text(
                                  'An error occured',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            loading: () => SizedBox(height: 16.0),
                          );
                    },
                  ),
                  Text(
                    'Country',
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
                      return ref.watch(getCountriesProvider).when(
                            data: (data) => (data != null &&
                                    data.isNotEmpty == true)
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton2<CountryDatum>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select country',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                          color: ZxplorePrimaryColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      items: data
                                          .map<DropdownMenuItem<CountryDatum>>(
                                              (item) => DropdownMenuItem<
                                                      CountryDatum>(
                                                    value: item,
                                                    child: Text(
                                                      item.countryName ?? '',
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
                                      value: selectedCountry,
                                      onChanged: (CountryDatum? newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          selectedCountry = newValue;
                                          selectedCountryCode =
                                              newValue?.countryCode;

                                          selectedCountryName =
                                              newValue?.countryName;
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
                                : GestureDetector(
                                    child: Text(
                                        'No? countries?, Tap to refresh, '),
                                    onTap: () =>
                                        ref.invalidate(getCountriesProvider),
                                  ),
                            error: (e, s) => GestureDetector(
                                onTap: () =>
                                    ref.invalidate(getCountriesProvider),
                                child: const Text(
                                  'An error occured',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            loading: () => SizedBox(height: 16.0),
                          );
                    },
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                      onPressed: () {
                        if (!_formkeyChild.currentState!.validate()) {
                          return;
                        }
                        if(selectedGenderItem==null) {
                              zXFlushBar(context, "Date  of birth is required");
                          return;

                        }
                          if(selectedCountry==null) {
                               zXFlushBar(context, "Nationality is required");
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

  /// Date Picker
  Future<void> _showDatePicker(BuildContext dateContext,
      {required String dateCategory}) async {
    if (mounted) {
      final DateTime? fPickedDate = await showDatePicker(
        context: context,
        initialDate: dobInit!,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (fPickedDate != null) {
        if (dateCategory == 'DOB') {
          setState(() {
            dobInit = fPickedDate;
            dobFormattedDate = dateFormatter.format(dobInit!);
            sDobFormattedDate = sdateFormatter.format(dobInit!);
            birthDateController.text = dobFormattedDate;
          });
        }
      }
    }
  }
}
