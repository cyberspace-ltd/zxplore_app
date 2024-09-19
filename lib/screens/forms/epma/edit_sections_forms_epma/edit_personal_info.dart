import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zxplore_app/models/epma_models/get_edit_personal_details_response.dart';
import 'package:zxplore_app/models/epma_models/meta/country_response.dart';
import 'package:zxplore_app/models/epma_models/meta/gender_response.dart';
import 'package:zxplore_app/models/epma_models/meta/identification_types.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/forms/epma/create_new_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/screens/controllers/meta/countries.dart';
import 'package:zxplore_app/screens/controllers/meta/gender.dart';
import 'package:zxplore_app/screens/controllers/meta/identification_types.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';

final div =  
    Divider(
      height: 0,
      color: ZxplorePrimaryColor.withOpacity(0.5),
      thickness: 0.5,
  
  
);

class PersonalInfoEditSscreen extends ConsumerStatefulWidget {
  const PersonalInfoEditSscreen({super.key, required this.data});
  final PersonalDetailsResponse? data;

  @override
  ConsumerState<PersonalInfoEditSscreen> createState() => _PersonalInfoEditSscreenState();
}

class _PersonalInfoEditSscreenState extends ConsumerState<PersonalInfoEditSscreen> {
  final _personalInfoEditFormKey = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _otherNamesController = TextEditingController();
  final TextEditingController _maidenNameController = TextEditingController();
  final TextEditingController _genderCodeController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _identificationTypeIdController =
      TextEditingController();
  final TextEditingController _identificationNoController =
      TextEditingController();
  final TextEditingController _idCountryCodeController =
      TextEditingController();
  final TextEditingController _idIssueAuthorityController =
      TextEditingController();
  final TextEditingController _idIssueDateController = TextEditingController();
  final TextEditingController _idExpiryDateController = TextEditingController();
  final TextEditingController _niaVerificationNoController =
      TextEditingController();
  final TextEditingController _ssnitNoController = TextEditingController();
  final TextEditingController _tinController = TextEditingController();
  final TextEditingController _citizenshipCodeController =
      TextEditingController();
  final TextEditingController _altCitizenshipCodeController =
      TextEditingController();
  final TextEditingController _countryOrigCodeController =
      TextEditingController();
  final TextEditingController _homeTownController = TextEditingController();
  final TextEditingController _residencePermitNoController =
      TextEditingController();
  final TextEditingController _residencePermitPlaceCodeController =
      TextEditingController();
  final TextEditingController _permitIssueDateController =
      TextEditingController();
  final TextEditingController _permitExpiryDateController =
      TextEditingController();
  final TextEditingController _iddCodeController = TextEditingController();
  final TextEditingController _telNoController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _residentialAddressController =
      TextEditingController();
  final TextEditingController _residentialAddress2Controller =
      TextEditingController();
  final TextEditingController _districtAssemblyAreaController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _regionCodeController = TextEditingController();
  final TextEditingController _permanentResidentialAddressController =
      TextEditingController();
  final TextEditingController _permanentResidentialCityController =
      TextEditingController();
  final TextEditingController _permanentResidentialCountryCodeController =
      TextEditingController();
  final TextEditingController _mailingAddressController =
      TextEditingController();
  final TextEditingController _motherMaidenNameController =
      TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _spouseNameController = TextEditingController();
  final TextEditingController _spouseOccupationController =
      TextEditingController();
  final TextEditingController _businessNatureIdController =
      TextEditingController();
  final TextEditingController _subBusinessNatureIdController =
      TextEditingController();
  final TextEditingController _employmentTypeCodeController =
      TextEditingController();
  final TextEditingController _employerNameController = TextEditingController();
  final TextEditingController _timeWithEmployerController =
      TextEditingController();
  final TextEditingController _employerAddressController =
      TextEditingController();
  final TextEditingController _employerEmailController =
      TextEditingController();
  final TextEditingController _employerTelController = TextEditingController();
  final TextEditingController _monthlyIncomeController =
      TextEditingController();
  final TextEditingController _accountOwnershipOtherController =
      TextEditingController();
  final TextEditingController _pepReasonController = TextEditingController();
  final TextEditingController _customerClassificationIdController =
      TextEditingController();
  final TextEditingController _gpsAddressController = TextEditingController();

  bool _hasPermanentResidence = false;
  bool _accountOwnership = false;
  bool _customerResidentInGhana = false;
  bool _customerIsPEP = false;
  bool _setupIbank = false;
  bool _setupZPrompt = false;
  bool _setupStatementViaEmail = false;
  bool _setupEmailIndemnity = false;
  bool _isPhysicallyChallanged = false;
  bool _isNewRequest = false;
  DateTime? _selectedDate;

  final creatFrmKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final otherNameController = TextEditingController();
  final idIssueAuthorityController = TextEditingController();
  final identificationNoController = TextEditingController();
  final niaVerificationNoController = TextEditingController();
  final iddCodeController = TextEditingController();
  final telNoController = TextEditingController();
  final mobileNoController = TextEditingController();
  final residentialAddressController = TextEditingController();
  final residentialAddressController2 = TextEditingController();
  final cityController = TextEditingController();
  final dateExpireController = TextEditingController();
  final dobController = TextEditingController();
  final datedIssuedController = TextEditingController();

  GendersDatum? selectedGenderItem;
  String? selectedGenderCode;
  String? selectedGenderName;

  IdentificationTypesDatum? selectedIdType;
  int? selectedIdentificationTypeCode;
  String? selectedIdentificationTypeName;

  CountryDatum? selectedCountry;
  String? selectedCountryCode;
  String? selectedCountryName;
  String? selectedCitizenshipCode;
  String? dob;
  String? datedIssued;
  String? dateExpire;
  DateTime? dobInit = DateTime.now();
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
  final DateFormat sdateFormatter = DateFormat('yyyy/mm/dd');
  String dobFormattedDate = 'dd/mm/yyy';
  String sDobFormattedDate = 'yyyy/mm/dd';

 
  @override
  void initState() {
    super.initState();

    // Initialize each controller with a unique value
    _surnameController.text = "Doe";
    _firstNameController.text = "John";
    _otherNamesController.text = "Michael";
    _maidenNameController.text = "Smith";
    _genderCodeController.text = "M";
    _birthDateController.text = "2024-09-19T13:06:08.877Z";
    _birthPlaceController.text = "New York";
    _identificationTypeIdController.text = "1";
    _identificationNoController.text = "A123456789";
    _idCountryCodeController.text = "US";
    _idIssueAuthorityController.text = "Department of State";
    _idIssueDateController.text = "2024-09-19T13:06:08.877Z";
    _idExpiryDateController.text = "2025-09-19T13:06:08.877Z";
    _niaVerificationNoController.text = "NIA123456";
    _ssnitNoController.text = "SSN123456";
    _tinController.text = "TIN123456";
    _citizenshipCodeController.text = "US Citizen";
    _altCitizenshipCodeController.text = "N/A";
    _countryOrigCodeController.text = "US";
    _homeTownController.text = "New York";
    _residencePermitNoController.text = "RP123456";
    _residencePermitPlaceCodeController.text = "NYC";
    _permitIssueDateController.text = "2024-09-19T13:06:08.877Z";
    _permitExpiryDateController.text = "2025-09-19T13:06:08.877Z";
    _iddCodeController.text = "IDD123456";
    _telNoController.text = "123-456-7890";
    _mobileNoController.text = "098-765-4321";
    _emailAddressController.text = "john.doe@example.com";
    _residentialAddressController.text = "123 Main St";
    _residentialAddress2Controller.text = "Apt 4B";
    _districtAssemblyAreaController.text = "Downtown";
    _cityController.text = "New York";
    _regionCodeController.text = "NY";
    _permanentResidentialAddressController.text = "456 Park Ave";
    _permanentResidentialCityController.text = "New York";
    _permanentResidentialCountryCodeController.text = "US";
    _mailingAddressController.text = "789 Broadway";
    _motherMaidenNameController.text = "Johnson";
    _maritalStatusController.text = "Single";
    _spouseNameController.text = "N/A";
    _spouseOccupationController.text = "N/A";
    _businessNatureIdController.text = "Retail";
    _subBusinessNatureIdController.text = "Clothing";
    _employmentTypeCodeController.text = "Employed";
    _employerNameController.text = "XYZ Corp";
    _timeWithEmployerController.text = "2 years";
    _employerAddressController.text = "101 Elm St";
    _employerEmailController.text = "hr@xyzcorp.com";
    _employerTelController.text = "321-654-0987";
    _monthlyIncomeController.text = "5000";
    _accountOwnershipOtherController.text = "N/A";
    _pepReasonController.text = "N/A";
    _customerClassificationIdController.text = "Regular";
    _gpsAddressController.text = "40.7128, -74.0060";
  }

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    _surnameController.dispose();
    _firstNameController.dispose();
    _otherNamesController.dispose();
    _maidenNameController.dispose();
    _genderCodeController.dispose();
    _birthDateController.dispose();
    _birthPlaceController.dispose();
    _identificationTypeIdController.dispose();
    _identificationNoController.dispose();
    _idCountryCodeController.dispose();
    _idIssueAuthorityController.dispose();
    _idIssueDateController.dispose();
    _idExpiryDateController.dispose();
    _niaVerificationNoController.dispose();
    _ssnitNoController.dispose();
    _tinController.dispose();
    _citizenshipCodeController.dispose();
    _altCitizenshipCodeController.dispose();
    _countryOrigCodeController.dispose();
    _homeTownController.dispose();
    _residencePermitNoController.dispose();
    _residencePermitPlaceCodeController.dispose();
    _permitIssueDateController.dispose();
    _permitExpiryDateController.dispose();
    _iddCodeController.dispose();
    _telNoController.dispose();
    _mobileNoController.dispose();
    _emailAddressController.dispose();
    _residentialAddressController.dispose();
    _residentialAddress2Controller.dispose();
    _districtAssemblyAreaController.dispose();
    _cityController.dispose();
    _regionCodeController.dispose();
    _permanentResidentialAddressController.dispose();
    _permanentResidentialCityController.dispose();
    _permanentResidentialCountryCodeController.dispose();
    _mailingAddressController.dispose();
    _motherMaidenNameController.dispose();
    _maritalStatusController.dispose();
    _spouseNameController.dispose();
    _spouseOccupationController.dispose();
    _businessNatureIdController.dispose();
    _subBusinessNatureIdController.dispose();
    _employmentTypeCodeController.dispose();
    _employerNameController.dispose();
    _timeWithEmployerController.dispose();
    _employerAddressController.dispose();
    _employerEmailController.dispose();
    _employerTelController.dispose();
    _monthlyIncomeController.dispose();
    _accountOwnershipOtherController.dispose();
    _pepReasonController.dispose();
    _customerClassificationIdController.dispose();
    _gpsAddressController.dispose();

    super.dispose();
  }

  void _submitForm() {
    if (_personalInfoEditFormKey.currentState!.validate()) {
      // Process the input data
      // Example: Print the data
      print('Surname: ${_surnameController.text}');
      print('First Name: ${_firstNameController.text}');
      // Add prints for other fields as needed...

      // Clear the form
      _surnameController.clear();
      _firstNameController.clear();
      // Clear other fields as needed...
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseEditForm(
      title: 'Editing Personal Information',
      widgetToGoOnCancel: Container(),
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
            key: _personalInfoEditFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Personal',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                div,
                gapH16,
                CustomTextFormField(
                  title: 'First name',
                  fillColor: Colors.transparent,
                  controller: firstNameController,
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
                const SizedBox(height: 16),
                CustomTextFormField(
                  title: 'Last name',
                  fillColor: Colors.transparent,
                  controller: lastNameController,
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
                const SizedBox(height: 16),
                CustomTextFormField(
                  title: 'Other name',
                  fillColor: Colors.transparent,
                  controller: otherNameController,
                  hint: 'Enter other name',
                  inputType: TextInputType.text,
                  useDefaultErrorText: false,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'other name is  required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
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
                  controller: dobController,
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
                const SizedBox(height: 16),
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
                                            (item) =>
                                                DropdownMenuItem<GendersDatum>(
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
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 60,
                                      // width: 160,
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 14),
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
                                        thickness:
                                            WidgetStatePropertyAll<double>(6),
                                        thumbVisibility:
                                            WidgetStatePropertyAll<bool>(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                )
                              : Text('empty gender'),
                          error: (e, s) => GestureDetector(
                              onTap: () => ref.invalidate(getGenderProvider),
                              child: const Text(
                                'An error occured fetch login modes.Tap to refresh',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              )),
                          loading: () => SizedBox(height: 16.0),
                        );
                  },
                ),
                const SizedBox(height: 16),
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
                                            (item) =>
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
                                    value: selectedCountry,
                                    onChanged: (CountryDatum? newValue) {
                                      setState(() {
                                        /// Set selected item params
                                        selectedCountry = newValue;
                                        selectedCountryCode =
                                            newValue?.countryCode;
                                        selectedCountryName =
                                            newValue?.countryName;
                                        selectedCitizenshipCode =
                                            newValue?.countryCode;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 60,
                                      // width: 160,
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 14),
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
                                        thickness:
                                            WidgetStatePropertyAll<double>(6),
                                        thumbVisibility:
                                            WidgetStatePropertyAll<bool>(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  child:
                                      Text('No? countries?, Tap to refresh, '),
                                  onTap: () =>
                                      ref.invalidate(getCountriesProvider),
                                ),
                          error: (e, s) => GestureDetector(
                              onTap: () => ref.invalidate(getCountriesProvider),
                              child: const Text(
                                'An error occured fetch login modes.Tap to refresh',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              )),
                          loading: () => SizedBox(height: 16.0),
                        );
                  },
                ),
                const SizedBox(height: 8),
                const Divider(
                  height: 16,
                  color: Color.fromARGB(255, 169, 189, 201),
                  thickness: 0.5,
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  title: 'Telephone Number',
                  fillColor: Colors.transparent,
                  controller: telNoController,
                  hint: 'Enter telephone number',
                  inputType: TextInputType.phone,
                  useDefaultErrorText: false,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'Telephone Number is  required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  title: 'Mobile Number',
                  fillColor: Colors.transparent,
                  controller: mobileNoController,
                  hint: 'Enter mobile number',
                  inputType: TextInputType.text,
                  useDefaultErrorText: false,
                  validator: (value) {
                    // if (value.toString().isEmpty) {
                    //   return 'other name is  required';
                    // }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  title: 'Address',
                  fillColor: Colors.transparent,
                  controller: residentialAddressController,
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
                const SizedBox(height: 16),
                CustomTextFormField(
                  title: 'Other Address',
                  fillColor: Colors.transparent,
                  controller: residentialAddressController2,
                  hint: 'Enter other adress',
                  inputType: TextInputType.text,
                  useDefaultErrorText: false,
                  validator: (value) {
                    // if (value.toString().isEmpty) {
                    //   return 'Address is  required';
                    // }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  title: 'City',
                  fillColor: Colors.transparent,
                  controller: residentialAddressController2,
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
                const SizedBox(height: 8),
                const Divider(
                  height: 16,
                  color: Color.fromARGB(255, 169, 189, 201),
                  thickness: 0.5,
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 16),
                Text(
                  'ID Type',
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
                    return ref.watch(getIdentificationTypesProvider).when(
                          data: (data) => (data != null &&
                                  data.isNotEmpty == true)
                              ? DropdownButtonHideUnderline(
                                  child:
                                      DropdownButton2<IdentificationTypesDatum>(
                                    isExpanded: true,
                                    hint: Text(
                                      'Select ID type',
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
                                        selectedIdentificationTypeCode =
                                            newValue?.identificationTypeId;
                                        selectedCountryName =
                                            newValue?.identificationTypeName;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 60,
                                      // width: 160,
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 14),
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
                                        thickness:
                                            WidgetStatePropertyAll<double>(6),
                                        thumbVisibility:
                                            WidgetStatePropertyAll<bool>(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  child: Text('No? types?, Tap to refresh, '),
                                  onTap: () => ref.invalidate(
                                      getIdentificationTypesProvider),
                                ),
                          error: (e, s) => GestureDetector(
                              onTap: () => ref
                                  .invalidate(getIdentificationTypesProvider),
                              child: const Text(
                                'An error occured fetch login modes.Tap to refresh',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              )),
                          loading: () => SizedBox(height: 16.0),
                        );
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  title: 'ID Issuer',
                  fillColor: Colors.transparent,
                  controller: idIssueAuthorityController,
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
                const SizedBox(height: 16),
                CustomTextFormField(
                  title: 'ID Number',
                  fillColor: Colors.transparent,
                  controller: identificationNoController,
                  hint: 'Enter ID Number',
                  inputType: TextInputType.text,
                  useDefaultErrorText: false,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'ID Number is  required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  onTap: () {
                    _selectDate(context);
                    // _showDatePicker(context, dateCategory: 'ISSUE');
                  },
                  title: 'Issue Date',
                  showCursor: false,
                  readOnly: true,
                  fillColor: Colors.transparent,
                  controller: datedIssuedController,
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
                const SizedBox(height: 16),
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
                  controller: dateExpireController,
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
                const SizedBox(height: 16),
                CustomTextFormField(
                  title: 'NIA Number',
                  fillColor: Colors.transparent,
                  controller: niaVerificationNoController,
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
                const SizedBox(height: 16),
                CustomTextFormField(
                  title: 'IDD Code',
                  fillColor: Colors.transparent,
                  controller: iddCodeController,
                  hint: 'Enter IDD code',
                  inputType: TextInputType.text,
                  useDefaultErrorText: false,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'IDD Code is  required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                    onPressed: () {
                      if (!creatFrmKey.currentState!.validate()) {
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
                        zXFlushBar(context, "ID expiry date id required");
                        return;
                      }

                      if (datedIssued == null) {
                        zXFlushBar(context, "ID issued date id required");
                        return;
                      }
                      // editAccountRequest();
                    },
                    title: 'Create Account')
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to show the DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
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
            dobController.text = dobFormattedDate;
          });
        } else if (dateCategory == 'ISSUE') {
          dobInit = fPickedDate;
          dobFormattedDate = dateFormatter.format(dobInit!);
          sDobFormattedDate = sdateFormatter.format(dobInit!);
          datedIssuedController.text = dobFormattedDate;
        } else {
          dobInit = fPickedDate;
          dobFormattedDate = dateFormatter.format(dobInit!);
          sDobFormattedDate = sdateFormatter.format(dobInit!);
          dateExpireController.text = dobFormattedDate;
        }
      }
    }
  }
}
