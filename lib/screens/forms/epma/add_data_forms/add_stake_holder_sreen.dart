import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zxplore_app/models/epma_models/add_edit_stake_holder.dart';
import 'package:zxplore_app/models/epma_models/meta/business_natures.dart';
import 'package:zxplore_app/models/epma_models/meta/country_response.dart';
import 'package:zxplore_app/models/epma_models/meta/customer_classification_response.dart';
import 'package:zxplore_app/models/epma_models/meta/employment_type_response.dart';
import 'package:zxplore_app/models/epma_models/meta/gender_response.dart';
import 'package:zxplore_app/models/epma_models/meta/identification_types.dart';
import 'package:zxplore_app/models/epma_models/meta/marital_status_response.dart';
import 'package:zxplore_app/models/epma_models/meta/region_response.dart';
import 'package:zxplore_app/models/epma_models/meta/sub_business_natures_response.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_stake_holders_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/location_controller.dart';
import 'package:zxplore_app/screens/controllers/meta/regions.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/create_new_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/screens/controllers/meta/countries.dart';
import 'package:zxplore_app/screens/controllers/meta/gender.dart';
import 'package:zxplore_app/screens/controllers/meta/identification_types.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_stake_holder_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/utils/string_extentions.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';
import 'package:zxplore_app/models/epma_models/get_stake_holder_response.dart';

class AddStakeHolderScreen extends ConsumerStatefulWidget {
  const AddStakeHolderScreen({super.key, this.requestID});
  final String? requestID;

  @override
  ConsumerState<AddStakeHolderScreen> createState() =>
      _AddStakeHolderScreenState();
}

class _AddStakeHolderScreenState extends ConsumerState<AddStakeHolderScreen> {
  final _personalInfoEditFormKey = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final _surnameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _otherNamesController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  final _identificationTypeIdController = TextEditingController();
  final _identificationNoController = TextEditingController();
  final _idCountryCodeController = TextEditingController();
  final _idIssueAuthorityController = TextEditingController();
  final _idIssueDateController = TextEditingController();
  final _idExpiryDateController = TextEditingController();
  final _niaVerificationNoController = TextEditingController();
  final _permitIssueDateController = TextEditingController();
  final _permitExpiryDateController = TextEditingController();

  final _tinController = TextEditingController();
  final _homeTownController = TextEditingController();
  final _residencePermitNoController = TextEditingController();
  final _residencePermitPlaceCodeController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _residentialAddressController = TextEditingController();
  final _residentialAddress2Controller = TextEditingController();
  final _districtAssemblyAreaController = TextEditingController();
  final _cityController = TextEditingController();
  final _permanentResidentialAddressController = TextEditingController();
  final _permanentResidentialCityController = TextEditingController();
  final _permanentResidentialCountryCodeController = TextEditingController();
  final _gpsAddressController = TextEditingController();
  final _genderCodeController = TextEditingController();
  final _regionCodeController = TextEditingController();
  final _motherMaidenNameController = TextEditingController();
  final residencePermitExpiryDateController = TextEditingController();
  final residencePermitIssueDateController = TextEditingController();
  final occupationController = TextEditingController();
  final jobTitleController = TextEditingController();
  final businessPhoneNoController = TextEditingController();
  final _countryOrigCodeController = TextEditingController();

  bool hasPermanentResidence = false; //1
  bool setupEmailIndemnity = false; //2/
  bool setupStatementViaEmail = false; //3
  bool setupZPrompt = false; //4
  bool isDirector = false; //5
  bool isPrincipalOfficer = false; //6
  bool isSignatory = false; //7
  bool isNewRequest = false; //8

  GendersDatum? selectedGenderItem;
  String? selectedGenderCode;
  String? selectedGenderName;

  IdentificationTypesDatum? selectedIdentificationItem;
  int? selectedIdentificationCode;
  String? selectedIdentificationName;

  BusinessNaturesDatum? businessNaturesItem;
  String? selectedBusinessNaturesCode;
  String? selectedBusinessNaturesName;

  SubBusinessNatureDatum? subBusinessNaturesItem;
  String? subBusinessNaturesCode;
  String? subBusinessNaturesName;

  CustomerClassificationDatum? customerClassificationsItem;
  String? selectedCustomerClassificationsCode;
  String? selectedCustomerClassificationsName;

  EmploymentTypeDatum? employmentTypesItem;
  String? selectedEmploymentTypesCode;
  String? selectedEmploymentTypessName;

  RegionDatum? regionsItem;
  String? selectedRegionCode;
  String? selectedRegionName;

  MaritalStatusDatum? maritalStatusItem;
  String? maritalStatusCode;
  String? maritalStatusName;

  IdentificationTypesDatum? selectedIdType;
  int? selectedIdentificationTypeCode;
  String? selectedIdentificationTypeName;

  CountryDatum? selectedCountry;
  String? selectedCountryCode;
  String? selectedCountryName;

  CountryDatum? selectedPaCountry;
  String? selectedPaCountryCode;
  String? selectedPaCountryName;

  String? selectedCitizenshipCode;

  String? dob;
  String? datedIssued;
  String? dateExpire;
  String? residenctPermIssueDate;
  String? residenctPermExpiryDate;

  DateTime? dobInit = DateTime.now();
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
  final DateFormat sdateFormatter = DateFormat('yyyy/mm/dd');
  String dobFormattedDate = 'dd/mm/yyy';
  String sDobFormattedDate = 'yyyy/mm/dd';
  String? selectedItemStage;


  @override
  void initState() {
    super.initState();
    ref.read(newLocationControllerProvider.notifier).getCurrentLocation();
  }

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    _surnameController.dispose();
    _firstNameController.dispose();
    _otherNamesController.dispose();
    _birthDateController.dispose();
    _birthPlaceController.dispose();
    _identificationTypeIdController.dispose();
    _identificationNoController.dispose();
    _idCountryCodeController.dispose();
    _idIssueAuthorityController.dispose();
    _idIssueDateController.dispose();
    _idExpiryDateController.dispose();
    _niaVerificationNoController.dispose();
    _tinController.dispose();
    _emailAddressController.dispose();
    _residentialAddressController.dispose();
    _residentialAddress2Controller.dispose();
    _cityController.dispose();
    _permanentResidentialAddressController.dispose();
    _permanentResidentialCityController.dispose();
    _homeTownController.dispose();
    _residencePermitNoController.dispose();
    _residencePermitPlaceCodeController.dispose();
    _districtAssemblyAreaController.dispose();
    _permanentResidentialCountryCodeController.dispose();
    _gpsAddressController.dispose();
    _countryOrigCodeController.dispose();
    jobTitleController.dispose();
    occupationController.dispose();

    super.dispose();
  }

  // Method to handle checkbox state changes
  void _handleCheckboxChange(int checkboxNumber, bool? value) {
    setState(() {
      switch (checkboxNumber) {
        case 1:
          hasPermanentResidence = value ?? false;
          break;
        case 2:
          setupEmailIndemnity = value ?? false;
          break;
        case 3:
          setupStatementViaEmail = value ?? false;
          break;
        case 4:
          setupZPrompt = value ?? false;
          break;
        case 5:
          isDirector = value ?? false;
          break;
        case 6:
          isPrincipalOfficer = value ?? false;
          break;
        case 7:
          isSignatory = value ?? false;
          break;
        case 8:
          isNewRequest = value ?? false;
          break;
      }
    });
  }

  Future<void> addAccountRequest(BuildContext context) async {
 
    final stakeHolderDetails = AddStakeholder(
     
      requestId:widget.requestID,
      rimNo:0,// initialData?.rimNo,
      stakeHolderId: 0,//initialData?.stakeHolderId,
      itemStage: selectedItemStage,//initialData?.itemStage ?? '',
      rowVersion: 0,//initialData?.rowVersion ?? -1,
      actionFlag:'A', //initialData!.actionFlag,
      relAuthCode: 0,//initialData.relAuthCode,
      hasPermanentResidence: hasPermanentResidence,
      setupEmailIndemnity: setupEmailIndemnity,
      setupStatementViaEmail: setupStatementViaEmail,
      setupZPrompt: setupZPrompt,
      isDirector: isDirector,
      isPrincipalOfficer: isPrincipalOfficer,
      isSignatory: isSignatory,
      residentialAddress2: _residentialAddress2Controller.text,
      residentialAddress: _residentialAddressController.text,
      districtAssemblyArea: selectedRegionName,
      permanentResidentialAddress: _permanentResidentialAddressController.text,
      permanentResidentialCity: _permanentResidentialCityController.text,
      permanentResidentialCountryCode: selectedPaCountryCode,
      residencePermitNo: _residencePermitNoController.text,
      residencePermitPlaceCode: _residencePermitPlaceCodeController.text,
      genderCode: selectedGenderCode,
      niaVerificationNo: _niaVerificationNoController.text,
      tin: _tinController.text,
      gpsAddress: _gpsAddressController.text,
      lastName: _surnameController.text,
      firstName: _firstNameController.text,
      otherName: _otherNamesController.text,
      emailAddress: _emailAddressController.text,
      middleName: _middleNameController.text,
      regionCode: selectedRegionCode,
      idExpiryDate: stringToDate(dateExpire ?? ''),
      idIssueAuthority: _idIssueAuthorityController.text,
      idIssueDate: stringToDate(datedIssued ?? ''),
      homeTown: _homeTownController.text,
      isNewRequest: false,
      idCountryCode: selectedCountryCode,
      identificationNo: _identificationNoController.text,
      identificationTypeId: selectedIdentificationCode,
      birthDate: stringToDate(dob ?? ''),
      city: _cityController.text,
      birthPlace: _birthPlaceController.text,
      businessPhoneNo: businessPhoneNoController.text,
      countryCode: selectedCountryCode,
      jobTitle: jobTitleController.text,
      motherName: _motherMaidenNameController.text,
      occupation: occupationController.text,
      residencePermitExpiryDate:
          stringToDate(residenctPermExpiryDate),
      residencePermitIssueDate:
          stringToDate(residenctPermIssueDate),
    );

    await ref
        .read(editStakeHoldersControllerProvider.notifier)
        .addStakeHolder(context: context, editAccount: stakeHolderDetails);
  }


  /// Date Picker
  Future<void> _showDatePicker(BuildContext dateContext,
      {required String dateCategory}) async {
    if (mounted) {
      final DateTime? fPickedDate = await showDatePicker(
        context: context,
        initialDate: dobInit!,
        firstDate: DateTime(1900),
        lastDate: DateTime.now().add(Duration(days: 365 * 50)),
      );
      if (fPickedDate != null) {
        if (dateCategory == 'DOB') {
          setState(() {
            dobInit = fPickedDate;
            dob= fPickedDate.toIso8601String();
            dobFormattedDate = dateFormatter.format(dobInit!);
            sDobFormattedDate = sdateFormatter.format(dobInit!);
            _birthDateController.text = dobFormattedDate;
          });
        } else if (dateCategory == 'PERMITEXP') {
           setState(() {
          dobInit = fPickedDate;
        residenctPermExpiryDate=fPickedDate.toIso8601String();

          dobFormattedDate = dateFormatter.format(dobInit!);
          sDobFormattedDate = sdateFormatter.format(dobInit!);
          _permitExpiryDateController.text = dobFormattedDate;});
        //  print("PERMITEXP :: $fPickedDate");
        
      } else if (dateCategory == 'PERMITISSUE') {
         setState(() {
        dobInit = fPickedDate;
        residenctPermIssueDate=fPickedDate.toIso8601String();
        dobFormattedDate = dateFormatter.format(dobInit!);
        sDobFormattedDate = sdateFormatter.format(dobInit!);
        _permitIssueDateController.text = dobFormattedDate;
         });
        //  print("PERMITISSUE :: $fPickedDate");
      } else if (dateCategory == 'ISSUE') {
          setState(() {
        dobInit = fPickedDate;
            datedIssued= fPickedDate.toIso8601String();

        dobFormattedDate = dateFormatter.format(dobInit!);
        sDobFormattedDate = sdateFormatter.format(dobInit!);
        _idIssueDateController.text = dobFormattedDate;
          });
        //  print("ISSUE :: $fPickedDate");

      } else {
             setState(() {
            dateExpire= fPickedDate.toIso8601String();

        dobInit = fPickedDate;
        dobFormattedDate = dateFormatter.format(dobInit!);
        sDobFormattedDate = sdateFormatter.format(dobInit!);
        _idExpiryDateController.text = dobFormattedDate;
        });
        //  print("IDExp  :: $fPickedDate");

      
    }
  }
}}


  @override
  Widget build(BuildContext context) {
    ///check  for  errors here
    ref.listen<AsyncValue>(
      editStakeHoldersControllerProvider,
      (_, state) => state.showAlertDialogOnError(context,
          okAction: () {}, errorMsg: state.error),
    );

    return ZxploreProgress(
      inAsyncCall: ref.watch(editStakeHoldersControllerProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseAddForm(
        button: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: PrimaryButton(
              onPressed: () {
                if (!_personalInfoEditFormKey.currentState!.validate()) {
                  return;
                }
                    if (selectedItemStage == null) {
                  zXFlushBar(context, "Item stage is required");
                  return;
                }
                if (selectedCountry == null) {
                  zXFlushBar(context, "Country is required");
                  return;
                }
                if (selectedGenderItem == null) {
                  zXFlushBar(context, "Gender is required");
                  return;
                }

                if (selectedIdType == null) {
                  zXFlushBar(context, "ID type is required");
                  return;
                }
                if (dob == null) {
                  zXFlushBar(context, "Date of birth is required");
                  return;
                }
                if (dateExpire == null) {
                  zXFlushBar(context, "ID expiry date is required");
                  return;
                }

                if (datedIssued == null) {
                  zXFlushBar(context, "ID issued date is required");
                  return;
                }

                 if (residenctPermIssueDate == null) {
                  zXFlushBar(context, "Perm. Residence  issue date is required");
                  return;
                }

                if (residenctPermExpiryDate == null) {
                  zXFlushBar(context, "Perm. Residence expiry date is required");
                  return;
                }
                addAccountRequest(context);
              },
              title: 'Save'),
        ),
        title: 'Add Stake holder Information',
        widgetToGoOnSave: StackHolderdersScreen(
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
              key: _personalInfoEditFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  gapH24,
                  Text(
                    'Personal Data',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  div,
                  gapH16,
                       Row(children: [
                    Text(
                      "Item Stage",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
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
                 
                  gapH16,

                  CustomTextFormField(
                    title: 'First name',
                    fillColor: Colors.transparent,
                    controller: _firstNameController,
                    hint: 'Enter first name',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'first name is  required';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  CustomTextFormField(
                    title: 'Last name',
                    fillColor: Colors.transparent,
                    controller: _surnameController,
                    hint: 'Enter last name',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'last name is  required';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  CustomTextFormField(
                    title: 'Middle name',
                    fillColor: Colors.transparent,
                    controller: _middleNameController,
                    hint: 'Enter Middle name',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      // if (value.toString().isEmpty) {
                      //   return 'other name is  required';
                      // }
                      return null;
                    },
                  ),

                  gapH16,
                  CustomTextFormField(
                    title: 'Other name',
                    fillColor: Colors.transparent,
                    controller: _otherNamesController,
                    hint: 'Enter other name',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      // if (value.toString().isEmpty) {
                      //   return 'other name is  required';
                      // }
                      return null;
                    },
                  ),
               
                  gapH16,
                  CustomTextFormField(
                    title: 'Mother\'s name',
                    fillColor: Colors.transparent,
                    controller: _motherMaidenNameController,
                    hint: 'Enter Mother\'s name',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'other name is  required';
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
                    controller: _birthDateController,
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
                    title: "Place of birth",
                    fillColor: Colors.transparent,
                    controller: _birthPlaceController,
                    hint: 'Place of birth',
                    inputType: TextInputType.text,
                    // useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Place of birth is  required';
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
                                                      item.genderName ?? '',
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
                                          selectedGenderCode =
                                              newValue?.genderCode;
                                          selectedGenderName =
                                              newValue?.genderName;
                                          _genderCodeController.text =
                                              newValue?.genderName ?? '';
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
                                : Text('empty gender'),
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
                  gapH16,
  
                  CustomTextFormField(
                    title: "GPS Address",
                    fillColor: Colors.transparent,
                    controller: _gpsAddressController,
                    hint: 'GH-930030-3393',
                    inputType: TextInputType.text,
                    // useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'GPS Address is  required';
                      }
                      if (value.toString().length!=12) {
                        return 'Maximum lenght of 12';
                      }
                      return null;
                    },
                  ),
                    gapH16,
                  const Divider(
                    height: 16,
                    color: Color.fromARGB(255, 169, 189, 201),
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    title: 'Business Phone Number',
                    fillColor: Colors.transparent,
                    controller: businessPhoneNoController,
                    hint: 'Enter busines phone number',
                    inputType: TextInputType.phone,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Busines phone number is  required';
                      }
                      return null;
                    },
                  ),

                  gapH16,
                  CustomTextFormField(
                    title: 'Email Address',
                    fillColor: Colors.transparent,
                    controller: _emailAddressController,
                    hint: 'Enter email address',
                    inputType: TextInputType.emailAddress,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Email is  required';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  CustomTextFormField(
                    title: 'Residential Address',
                    fillColor: Colors.transparent,
                    controller: _residentialAddressController,
                    hint: 'Enter adress',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Address is  required';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  CustomTextFormField(
                    title: 'Residential Address 2',
                    fillColor: Colors.transparent,
                    controller: _residentialAddress2Controller,
                    hint: 'Enter adress',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      return null;
                    },
                  ),

                  gapH16,
                  CustomTextFormField(
                    title: 'District/Area',
                    fillColor: Colors.transparent,
                    controller: _districtAssemblyAreaController,
                    hint: 'Enter district',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      // if (value.toString().isEmpty) {
                      //   return 'Address is  required';
                      // }
                      return null;
                    },
                  ),

                  gapH16,
                  CustomTextFormField(
                    title: 'City',
                    fillColor: Colors.transparent,
                    controller: _cityController,
                    hint: 'Enter city',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'City is  required';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  CustomTextFormField(
                    title: 'Occupation',
                    fillColor: Colors.transparent,
                    controller: occupationController,
                    hint: 'Enter occupation',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Occupation is  required';
                      }
                      return null;
                    },
                  ),

                  gapH16,
                  CustomTextFormField(
                    title: 'Job Title',
                    fillColor: Colors.transparent,
                    controller: jobTitleController,
                    hint: 'Enter job title',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Job Title is  required';
                      }
                      return null;
                    },
                  ),
                  gapH16,

                  CustomTextFormField(
                    title: 'TIN',
                    fillColor: Colors.transparent,
                    controller: _tinController,
                    hint: 'Enter TIN code',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      return null;
                    },
                  ),
                  gapH16,

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
                                          _countryOrigCodeController.text =
                                              newValue?.countryCode ?? '';
                                          selectedCountryName =
                                              newValue?.countryName;
                                          selectedCitizenshipCode =
                                              newValue?.countryCode;
                                          _idCountryCodeController.text =
                                              newValue?.countryCode ?? '';
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

                  gapH16,
                  Text(
                    'Identification Types',
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  div,
                  const SizedBox(height: 6),
                  Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(getIdentificationTypesProvider).when(
                            data: (data) => (data != null &&
                                    data.isNotEmpty == true)
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton2<
                                        IdentificationTypesDatum>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select identification Types',
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
                                                      IdentificationTypesDatum>>(
                                              (item) => DropdownMenuItem<
                                                      IdentificationTypesDatum>(
                                                    value: item,
                                                    child: Text(
                                                      item.identificationTypeName ??
                                                          '',
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
                                      value: selectedIdType,
                                      onChanged:
                                          (IdentificationTypesDatum? newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          selectedIdType = newValue;
                                          selectedIdentificationCode =
                                              newValue!.identificationTypeId;
                                          selectedIdentificationName =
                                              newValue.identificationTypeName;
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
                                : Text('Empty types'),
                            error: (e, s) => GestureDetector(
                                onTap: () => ref
                                    .invalidate(getIdentificationTypesProvider),
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
                  gapH16,
                  CustomTextFormField(
                    title: 'ID Issuer',
                    fillColor: Colors.transparent,
                    controller: _idIssueAuthorityController,
                    hint: 'Enter ID Issuer',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'ID Issuer is  required';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  CustomTextFormField(
                    title: 'ID Number',
                    fillColor: Colors.transparent,
                    controller: _identificationNoController,
                    hint: 'Enter ID Number',
                    inputType: TextInputType.number,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'ID Number is  required';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  CustomTextFormField(
                    onTap: () {
                      _showDatePicker(context, dateCategory: 'ISSUE');
                    },
                    title: 'Issue Date',
                    showCursor: false,
                    readOnly: true,
                    fillColor: Colors.transparent,
                    controller: _idIssueDateController,
                    showDropDownSuffixIcon: true,
                    hint: 'ID Issue Date',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    suffixIcon: Icon(
                      Icons.calendar_today_rounded,
                      color: ZxplorePrimaryColor.withOpacity(.5),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ID Issue is required';
                      } else if (value == 'dd-mm-yyyy') {
                        return 'Enter a valid date';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  CustomTextFormField(
                    onTap: () {
                      _showDatePicker(context, dateCategory: 'EXPIRY');
                    },
                    title: 'Expiry Date',
                    readOnly: true,
                    showDropDownSuffixIcon: true,
                    showCursor: false,
                    suffixIcon: Icon(
                      Icons.calendar_today_rounded,
                      color: ZxplorePrimaryColor.withOpacity(.5),
                    ),
                    fillColor: Colors.transparent,
                    controller: _idExpiryDateController,
                    hint: 'ID Expiry Date',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ID Expiry is required';
                      } else if (value == 'dd-mm-yyyy') {
                        return 'Enter a valid date';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  CustomTextFormField(
                    title: 'NIA Number',
                    fillColor: Colors.transparent,
                    controller: _niaVerificationNoController,
                    hint: 'Enter NIA number',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      // if (value.toString().isEmpty) {
                      //   return 'other name is  required';
                      // }
                      return null;
                    },
                  ),
                  gapH16,
                  /// Region
                  Text(
                    'Region',
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
                      return ref.watch(getRegionsProvider).when(
                            data: (data) => (data != null &&
                                    data.isNotEmpty == true)
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton2<RegionDatum>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select region',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                          color: ZxplorePrimaryColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      items: data
                                          .map<DropdownMenuItem<RegionDatum>>(
                                              (item) =>
                                                  DropdownMenuItem<RegionDatum>(
                                                    value: item,
                                                    child: Text(
                                                      item.regionName ?? '',
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
                                      value: regionsItem,
                                      onChanged: (RegionDatum? newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          regionsItem = newValue;
                                          selectedRegionName =
                                              newValue?.regionName;
                                          selectedRegionCode =
                                              newValue?.regionCode;
                                          _regionCodeController.text =
                                              newValue?.regionCode ?? '';
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
                                : Text('Empty regions'),
                            error: (e, s) => GestureDetector(
                                onTap: () => ref.invalidate(getRegionsProvider),
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

                  CheckboxListTile(
                    title: Text('Has Permanent Residence'),
                    value: hasPermanentResidence,
                    onChanged: (value) => _handleCheckboxChange(1, value),
                  ),
                  if (hasPermanentResidence) ...[
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      title: "Permanet Residential Address",
                      fillColor: Colors.transparent,
                      controller: _permanentResidentialAddressController,
                      hint: 'Enter permanet address',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'permanet address is required';
                        }
                        return null;
                      },
                    ),
                    gapH16,
                    CustomTextFormField(
                      title: "Permanet Residential Address City",
                      fillColor: Colors.transparent,
                      controller: _permanentResidentialCityController,
                      hint: 'Enter permanet address city',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'permanet address is required';
                        }
                        return null;
                      },
                    ),
                    gapH16,
                    Text(
                      'Permanent Address Country',
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
                                          'Select permanent address country',
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
                                                    CountryDatum>>((item) =>
                                                DropdownMenuItem<CountryDatum>(
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
                                        value: selectedPaCountry,
                                        onChanged: (CountryDatum? newValue) {
                                          setState(() {
                                            /// Set selected item params
                                            selectedPaCountry = newValue;
                                            selectedPaCountryName =
                                                newValue?.countryName;
                                            selectedPaCountryCode =
                                                newValue?.countryCode;
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
                    gapH16,
                    CustomTextFormField(
                      title: " Residence Permit No.",
                      fillColor: Colors.transparent,
                      controller: _residencePermitNoController,
                      hint: 'Enter permit number',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        // if (value.toString().isEmpty) {
                        //   return 'permanet address is required';
                        // }
                        return null;
                      },
                    ),
                   
                    gapH16,
                    CustomTextFormField(
                      title: " Residence Permit Place Code",
                      fillColor: Colors.transparent,
                      controller: _residencePermitPlaceCodeController,
                      hint: 'Enter Place code',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        // if (value.toString().isEmpty) {
                        //   return 'permanet address is required';
                        // }
                        return null;
                      },
                    ),
                  
                    gapH16,
                    CustomTextFormField(
                      onTap: () {
                        _showDatePicker(context, dateCategory: 'PERMITISSUE');
                      },
                      title: 'Permit Issue Date',
                      readOnly: true,
                      showCursor: false,
                      suffixIcon: Icon(
                        Icons.calendar_today_rounded,
                        color: ZxplorePrimaryColor.withOpacity(.5),
                      ),
                      showDropDownSuffixIcon: true,
                      fillColor: Colors.transparent,
                      controller: _permitIssueDateController,
                      hint: 'Selected permit issue date ',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Permit Issue Date required';
                        } else if (value == 'dd-mm-yyyy') {
                          return 'Enter a valid date';
                        }
                        return null;
                      },
                    ),
                    gapH16,
                    CustomTextFormField(
                      onTap: () {
                        _showDatePicker(context, dateCategory: 'PERMITEXP');
                      },
                      title: 'Permit Exp. Date',
                      readOnly: true,
                      showCursor: false,
                      suffixIcon: Icon(
                        Icons.calendar_today_rounded,
                        color: ZxplorePrimaryColor.withOpacity(.5),
                      ),
                      showDropDownSuffixIcon: true,
                      fillColor: Colors.transparent,
                      controller: _permitExpiryDateController,
                      hint: 'Selected permit exp. Date ',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Permit exp. date required';
                        } else if (value == 'dd-mm-yyyy') {
                          return 'Enter a valid date';
                        }
                        return null;
                      },
                    ),
                  ],
                  gapH16,

                  Text(
                    'Other Information',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  gapH12,
                  div,
                  gapH16,
                  CheckboxListTile(
                    title: Text('Setup Email Indemnity'),
                    value: setupEmailIndemnity,
                    onChanged: (value) => _handleCheckboxChange(2, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Setup Statement Via Email'),
                    value: setupStatementViaEmail,
                    onChanged: (value) => _handleCheckboxChange(3, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Setup ZPrompt'),
                    value: setupZPrompt,
                    onChanged: (value) => _handleCheckboxChange(4, value),
                  ),

                  CheckboxListTile(
                    title: Text('Is Director'),
                    value: isDirector,
                    onChanged: (value) => _handleCheckboxChange(5, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Is  Principal'),
                    value: isPrincipalOfficer,
                    onChanged: (value) => _handleCheckboxChange(6, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Is Signatory'),
                    value: isSignatory,
                    onChanged: (value) => _handleCheckboxChange(7, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('NewRequest'),
                    value: isNewRequest,
                    onChanged: (value) => _handleCheckboxChange(8, value),
                  ),

                  gapH12,

                  CheckboxListTile(
                    title: Text('New Request?'),
                    value: isNewRequest,
                    onChanged: (value) => _handleCheckboxChange(11, value),
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
