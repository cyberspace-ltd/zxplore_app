import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zxplore_app/models/epma_models/edit_personal_details_data.dart';
import 'package:zxplore_app/models/epma_models/get_edit_personal_details_response.dart';
import 'package:zxplore_app/models/epma_models/meta/business_natures.dart';
import 'package:zxplore_app/models/epma_models/meta/country_response.dart';
import 'package:zxplore_app/models/epma_models/meta/customer_classification_response.dart';
import 'package:zxplore_app/models/epma_models/meta/employment_type_response.dart';
import 'package:zxplore_app/models/epma_models/meta/gender_response.dart';
import 'package:zxplore_app/models/epma_models/meta/identification_types.dart';
import 'package:zxplore_app/models/epma_models/meta/marital_status_response.dart';
import 'package:zxplore_app/models/epma_models/meta/region_response.dart';
import 'package:zxplore_app/models/epma_models/meta/sub_business_natures_response.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_personal_details_controller.dart';
import 'package:zxplore_app/screens/controllers/location_controller.dart';
import 'package:zxplore_app/screens/controllers/meta/business_natures.dart';
import 'package:zxplore_app/screens/controllers/meta/customer_classification.dart';
import 'package:zxplore_app/screens/controllers/meta/employment_types.dart';
import 'package:zxplore_app/screens/controllers/meta/marital_status.dart';
import 'package:zxplore_app/screens/controllers/meta/regions.dart';
import 'package:zxplore_app/screens/controllers/meta/sub_business_natures.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/create_new_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/screens/controllers/meta/countries.dart';
import 'package:zxplore_app/screens/controllers/meta/gender.dart';
import 'package:zxplore_app/screens/controllers/meta/identification_types.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/utils/string_extentions.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
// import 'package:zxplore_app/utils/string_extentions.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

final div = Divider(
  height: 0,
  color: ZxplorePrimaryColor.withOpacity(0.5),
  thickness: 0.5,
);

class PersonalInfoEditSscreen extends ConsumerStatefulWidget {
  const PersonalInfoEditSscreen({super.key, required this.data});
  final PersonalDetailsResponse? data;

  @override
  ConsumerState<PersonalInfoEditSscreen> createState() =>
      _PersonalInfoEditSscreenState();
}

class _PersonalInfoEditSscreenState
    extends ConsumerState<PersonalInfoEditSscreen> {
  final _personalInfoEditFormKey = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _otherNamesController = TextEditingController();
  final TextEditingController _maidenNameController = TextEditingController();
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
  final TextEditingController _altCitizenshipCodeController =
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

  final TextEditingController _spouseNameController = TextEditingController();
  final TextEditingController _spouseOccupationController =
      TextEditingController();
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

  final TextEditingController _gpsAddressController = TextEditingController();
  final TextEditingController _genderCodeController = TextEditingController();
  final TextEditingController _countryOrigCodeController =
      TextEditingController();
  final TextEditingController _regionCodeController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _businessNatureIdController =
      TextEditingController();
  final TextEditingController _subBusinessNatureIdController =
      TextEditingController();
  final TextEditingController _employmentTypeCodeController =
      TextEditingController();
  final TextEditingController _citizenshipCodeController =
      TextEditingController();
  final TextEditingController _employerNameController = TextEditingController();
  final TextEditingController _customerClassificationIdController =
      TextEditingController();

  bool hasPermanentResidence = false; //1
  bool accountOwnership = false; //2
  bool customerResidentInGhana = false; //3
  bool isPhysicallyChallenged = false; //4
  bool customerIsPEP = false; //5
  bool setupIbank = false; //6
  bool setupZPrompt = false; //7
  bool setupStatementViaEmail = false; //8
  bool setupEmailIndemnity = false; //9
  bool isPhysicallyChallanged = false; //10
  bool isNewRequest = false; //11
  bool? customerIsPep = false; //12

  // DateTime? _selectedDate;

  GendersDatum? selectedGenderItem;
  String? selectedGenderCode;
  String? selectedGenderName;

  String? preRegionCode;
  // IdentificationTypesDatum? selectedIdentificationItem;
  // int? selectedIdentificationCode;
  // String? selectedIdentificationName;

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
  String? selectedCitizenshipCode;
  CountryDatum? permsSelectedCountry;
  String? permsSelectedCountryCode;
  String? permsSelectedCountryName;
  String? permsSelectedCitizenshipCode;

  String? dob;
  String? identityDateIssued;
  String? identityDateExpire;
  String? permIdentityDateIssued;
  String? permIdentityDateExpire;
  DateTime? dobInit = DateTime.now();
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
  final DateFormat sdateFormatter = DateFormat('yyyy/mm/dd');
  String dobFormattedDate = 'dd/mm/yyy';
  String sDobFormattedDate = 'yyyy/mm/dd';

  @override
  void initState() {
    super.initState();
    ref.read(newLocationControllerProvider.notifier).getCurrentLocation();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final userData = widget.data?.data;
        preRegionCode = userData?.regionCode ?? '';
        // Initialize each controller with a unique value
        _surnameController.text = "${userData?.surname ?? ''}";
        _firstNameController.text = "${userData?.firstName ?? ''}";
        _otherNamesController.text = "${userData?.otherNames ?? ''}";
        _maidenNameController.text = "${userData?.maidenName ?? ''}";
        _birthDateController.text = "${formatDate(userData?.birthDate ?? '')}";
        dob = userData?.birthDate ?? '';
        _birthPlaceController.text = "${userData?.birthPlace ?? ''}";
        // identfication
        _identificationTypeIdController.text =
            "${userData?.identificationNo ?? ''}";
        _identificationNoController.text =
            "${userData?.identificationNo ?? ''}";
        _idCountryCodeController.text = "${userData?.idCountryCode ?? ''}";
        _idIssueAuthorityController.text =
            "${userData?.idIssueAuthority ?? ''}";
        _idIssueDateController.text =
            "${formatDate(userData?.idIssueDate ?? '')}";
        identityDateIssued = userData?.idIssueDate ?? '';
        identityDateExpire = userData?.idExpiryDate ?? '';
        permIdentityDateExpire = userData?.permitExpiryDate ?? '';
        permIdentityDateIssued = userData?.permitIssueDate ?? '';
        _idExpiryDateController.text =
            "${formatDate(userData?.idExpiryDate ?? '')}";
        _niaVerificationNoController.text =
            "${userData?.niaVerificationNo ?? ''}";
        _ssnitNoController.text = "${userData?.ssnitNo ?? ''}";
        _tinController.text = "${userData?.tin ?? ''}";
        _genderCodeController.text = "${userData?.genderCode ?? ''}";
        _countryOrigCodeController.text = "${userData?.citizenshipCode ?? ''}";
        _regionCodeController.text = "${userData?.regionCode ?? ''}";
        _maritalStatusController.text = "${userData?.maritalStatus ?? ''}";
        _businessNatureIdController.text =
            "${userData?.businessNatureId ?? ''}";
        _subBusinessNatureIdController.text =
            "${userData?.subBusinessNatureId ?? ''}";
        _employmentTypeCodeController.text =
            "${userData?.employmentTypeCode ?? ''}";
        _citizenshipCodeController.text = "${userData?.citizenshipCode ?? ''}";
        _employerNameController.text = "${userData?.employerName ?? ''}";
        _customerClassificationIdController.text =
            "${userData?.customerClassificationId ?? ''}";

        _altCitizenshipCodeController.text =
            "${userData?.altCitizenshipCode ?? ''}";
        _homeTownController.text = "${userData?.homeTown ?? ''}";
        _residencePermitNoController.text =
            "${userData?.residencePermitNo ?? ''}";
        _residencePermitPlaceCodeController.text =
            "${userData?.residencePermitPlaceCode ?? ''}";
        _permitIssueDateController.text =
            "${formatDate(userData?.permitIssueDate ?? '')}";
        _permitExpiryDateController.text =
            "${formatDate(userData?.permitExpiryDate ?? '')}";
        _iddCodeController.text = "${userData?.iddCode ?? ''}";

        /// contact
        _telNoController.text = "${userData?.telNo ?? ''}";
        _mobileNoController.text = "${userData?.mobileNo ?? ''}";
        _emailAddressController.text = "${userData?.emailAddress ?? ''}";
        _residentialAddressController.text =
            "${userData?.residentialAddress ?? ''}";
        _residentialAddress2Controller.text =
            "${userData?.residentialAddress2 ?? ''}";
        _districtAssemblyAreaController.text =
            "${userData?.districtAssemblyArea ?? ''}";
        _cityController.text = "${userData?.city ?? ''}";
        _permanentResidentialAddressController.text =
            "${userData?.permanentResidentialAddress ?? ''}";
        _permanentResidentialCityController.text =
            "${userData?.permanentResidentialCity ?? ''}";
        _permanentResidentialCountryCodeController.text =
            "${userData?.permanentResidentialCountryCode ?? ''}";
        _mailingAddressController.text = "${userData?.mailingAddress ?? ''}";

        /// family
        _motherMaidenNameController.text =
            "${userData?.motherMaidenName ?? ''}";
        _spouseNameController.text = "${userData?.spouseName ?? ''}";
        _spouseOccupationController.text =
            "${userData?.spouseOccupation ?? ''}";
        _timeWithEmployerController.text =
            "${userData?.timeWithEmployer ?? ''}";
        _employerAddressController.text = "${userData?.emailAddress ?? ''}";
        _employerEmailController.text = "${userData?.emailAddress ?? ''}";
        _employerTelController.text = "${userData?.employerTel ?? ''}";
        _monthlyIncomeController.text = "${userData?.monthlyIncome ?? 0}";
        _accountOwnershipOtherController.text =
            "${userData?.accountOwnershipOther ?? ''}";
        _pepReasonController.text = "${userData?.pepReason ?? ''}";
        _gpsAddressController.text = "${userData?.gpsAddress ?? ''}";
        hasPermanentResidence = userData?.hasPermanentResidence ?? false;
        accountOwnership = userData?.accountOwnership ?? false;
        customerResidentInGhana = userData?.customerResidentInGhana ?? false;
        customerIsPEP = userData?.customerIsPep ?? false;
        setupIbank = userData?.setupIbank ?? false;
        setupZPrompt = userData?.setupZPrompt ?? false;
        setupStatementViaEmail = userData?.setupStatementViaEmail ?? false;
        setupEmailIndemnity = userData?.setupEmailIndemnity ?? false;
        isPhysicallyChallanged = userData?.isPhysicallyChallanged ?? false;
        isNewRequest = userData?.isNewRequest ?? false;
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    _surnameController.dispose();
    _firstNameController.dispose();
    _otherNamesController.dispose();
    _maidenNameController.dispose();
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
    _altCitizenshipCodeController.dispose();
    _iddCodeController.dispose();
    _telNoController.dispose();
    _mobileNoController.dispose();
    _emailAddressController.dispose();
    _residentialAddressController.dispose();
    _residentialAddress2Controller.dispose();
    _cityController.dispose();
    _permanentResidentialAddressController.dispose();
    _permanentResidentialCityController.dispose();

    _motherMaidenNameController.dispose();
    _spouseNameController.dispose();
    _spouseOccupationController.dispose();
    _timeWithEmployerController.dispose();
    _employerAddressController.dispose();
    _employerEmailController.dispose();
    _employerTelController.dispose();
    _monthlyIncomeController.dispose();
    _countryOrigCodeController.dispose();
    _homeTownController.dispose();
    _residencePermitNoController.dispose();
    _residencePermitPlaceCodeController.dispose();
    _permitIssueDateController.dispose();
    _permitExpiryDateController.dispose();
    _districtAssemblyAreaController.dispose();

    _permanentResidentialCountryCodeController.dispose();
    _mailingAddressController.dispose();
    _accountOwnershipOtherController.dispose();
    _pepReasonController.dispose();
    _gpsAddressController.dispose();

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
          accountOwnership = value ?? false;
          break;
        case 3:
          customerResidentInGhana = value ?? false;
          break;
        case 4:
          isPhysicallyChallenged = value ?? false;
          break;
        case 5:
          customerIsPEP = value ?? false;
          break;
        case 6:
          setupIbank = value ?? false;
          break;
        case 7:
          setupZPrompt = value ?? false;
          break;
        case 8:
          setupStatementViaEmail = value ?? false;
          break;
        case 9:
          setupEmailIndemnity = value ?? false;
          break;
        case 11:
          isNewRequest = value ?? false;
      }
    });
  }

  Future<void> editAccountRequest(BuildContext context) async {
    final lat = ref.read(userLatitudeProvider);
    final long = ref.read(userLongitudeProvider);
    final initialData = widget.data?.data;
    final editPersonalDetails = EditPersonalDetails(
        accountOwnershipOther: _accountOwnershipOtherController.text,
        formId: initialData?.formId ?? -1,
        citizenshipCode: selectedCountryCode,
        countryOrigCode: selectedCountryCode,
        customerIsPep: customerIsPep,
        customerResidentInGhana: customerResidentInGhana,
        setupEmailIndemnity: setupEmailIndemnity,
        setupStatementViaEmail: setupStatementViaEmail,
        setupZPrompt: setupZPrompt,
        residentialAddress2: _residentialAddress2Controller.text,
        residentialAddress: _residentialAddressController.text,
        isPhysicallyChallenged: isPhysicallyChallenged,
        setupIbank: setupIbank,
        mailingAddress: _mailingAddressController.text,
        districtAssemblyArea: selectedRegionName,
        permitExpiryDate:
            identityDateExpire, //_permitExpiryDateController.text,
        permitIssueDate:
            permIdentityDateIssued, //_permitIssueDateController.text,
        hasPermanentResidence: hasPermanentResidence,
        permanentResidentialAddress:
            _permanentResidentialAddressController.text,
        permanentResidentialCity: _permanentResidentialCityController.text,
        permanentResidentialCountryCode:
            _permanentResidentialCountryCodeController.text,
        residencePermitNo: _residencePermitNoController.text,
        residencePermitPlaceCode: _residencePermitPlaceCodeController.text,
        itemStage: initialData?.itemStage ?? '',
        businessNatureId: selectedBusinessNaturesCode,
        employerTel: _employerTelController.text,
        employmentTypeCode: selectedEmploymentTypesCode,
        employerName: _employerNameController.text,
        genderCode: selectedGenderCode,
        niaVerificationNo: _niaVerificationNoController.text,
        spouseName: _spouseNameController.text,
        spouseOccupation: _spouseOccupationController.text,
        subBusinessNatureId: subBusinessNaturesCode,
        timeWithEmployer: _timeWithEmployerController.text,
        tin: _tinController.text,
        gpsAddress: _gpsAddressController.text,
        surname: _surnameController.text,
        firstName: _firstNameController.text,
        otherNames: _otherNamesController.text,
        mobileNo: _mobileNoController.text,
        telNo: _telNoController.text,
        emailAddress: _emailAddressController.text,
        maidenName: _maidenNameController.text,
        employerAddress: _employerAddressController.text,
        employerEmail: _employerEmailController.text,
        ssnitNo: _ssnitNoController.text,
        regionCode: selectedRegionCode,
        iddCode: _iddCodeController.text,
        idExpiryDate: identityDateExpire,
        idIssueAuthority: _idIssueAuthorityController.text,
        idIssueDate: identityDateIssued,
        altCitizenshipCode: _altCitizenshipCodeController.text,
        homeTown: _homeTownController.text,
        requestId: widget.data?.data?.reqId ?? '',
        rowVersion: initialData?.rowVersion ?? -1,
        pepReason: _pepReasonController.text,
        isNewRequest: false,
        idCountryCode: selectedCountryCode,
        identificationNo: _identificationNoController.text,
        identificationTypeId: selectedIdentificationTypeCode,
        monthlyIncome: int.parse(_monthlyIncomeController.text),
        maritalStatus: maritalStatusName,
        motherMaidenName: _motherMaidenNameController.text,
        actionFlag: initialData!.actionFlag,
        accountOwnership: accountOwnership,
        birthDate: dob,
        city: _cityController.text,
        birthPlace: _birthPlaceController.text,
        customerClassificationId: selectedCustomerClassificationsCode);

    await ref
        .read(editPersonalDetailsControllerProvider.notifier)
        .editPersonalDetailsData(
            context: context,
            editPersonalDetails: editPersonalDetails,
            afterFailed: () {});
  }

  @override
  Widget build(BuildContext context) {
    // /check  for  errors here
    ref.listen<AsyncValue>(
      editPersonalDetailsControllerProvider,
      (_, state) => state.showAlertDialogOnError(context,
          okAction: () {}, errorMsg: state.error),
    );
//     ref.listen<AsyncValue<dynamic>>(editPersonalDetailsControllerProvider, (previous, next) {
//  if(next.hasError){
// next.showAlertDialogOnError(context, okAction: () {},errorMsg: next.error);
//  }
//   });

    return ZxploreProgress(
      inAsyncCall: ref.watch(editPersonalDetailsControllerProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Personal Information',
        widgetToGoOnCancel: ViewInitialCreationInfoScreen(
          formIndividualData: widget.data!.toMap(),
        ),
        onCancel: () => Navigator.pop(context),
        data: {},
        button: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryButton(
              onPressed: () {
                if (!_personalInfoEditFormKey.currentState!.validate()) {
                  zXFlushBar(context, "Required feilds are missing");

                  return;
                }
                if (permIdentityDateExpire == null ||
                    permIdentityDateIssued == null) {
                  zXFlushBar(
                      context, "Permanent ID isssue/expiry date is required");
                  return;
                }
                if (regionsItem == null) {
                  zXFlushBar(context, "Region is required");
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
                if (selectedBusinessNaturesCode == null) {
                  zXFlushBar(context, "Business/work class is required");
                  return;
                }
                if (subBusinessNaturesItem == null) {
                  zXFlushBar(context, "Business/work sub class is required");
                  return;
                }

                if (selectedIdType == null) {
                  zXFlushBar(context, "ID type is required");
                  return;
                }
                if (dob == null && widget.data?.data?.birthDate == null) {
                  zXFlushBar(context, "Date of birth is required");
                  return;
                }
                if (identityDateExpire == null &&
                    widget.data?.data?.idExpiryDate == null) {
                  zXFlushBar(context, "ID expiry date is required");
                  return;
                }

                if (identityDateIssued == null &&
                    widget.data?.data?.idIssueDate == null) {
                  zXFlushBar(context, "ID issued date is required");
                  return;
                }
                editAccountRequest(context);
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
              key: _personalInfoEditFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  gapH24,
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
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'Maiden name',
                    fillColor: Colors.transparent,
                    controller: _maidenNameController,
                    hint: 'Maiden name',
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
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  // const SizedBox(height: 16),
                  CustomTextFormField(
                    title: "Mother\'s maidenname",
                    fillColor: Colors.transparent,
                    controller: _motherMaidenNameController,
                    hint: 'Enter Mother\'s maidenname',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Mother\'s maidenname is  required';
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
                                ? 
                                DropdownButtonHideUnderline(
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
                  const SizedBox(height: 16),

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
                                                      //  preRegionCode!=null? data.where((item)=>item.regionCode==preRegionCode
                                                      //   ).first.regionName??'':
                                                      item.regionName ?? '',
                                                      // item.regionName. ?? '',
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
                                          // preRegionCode= newValue?.regionCode;
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
                                      //  dropdownSearchData: DropdownSearchData<CountryDatum>(
                                      //   searchController: ,
                                      //   searchMatchFn:(item,search){

                                      //   } ),
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
                                          _altCitizenshipCodeController.text =
                                              newValue?.countryName ?? '';
                                          _altCitizenshipCodeController.text =
                                              newValue?.countryName ?? '';
                                          _citizenshipCodeController.text =
                                              newValue?.countryName ?? '';
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

                  /// business Nature

                  const SizedBox(height: 16),
                  Text(
                    'Business Nature',
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
                      return ref.watch(getBusinessNaturesProvider).when(
                            data: (data) => (data == null ||
                                    data.isEmpty == true)
                                ? GestureDetector(
                                    onTap: () => ref.invalidate(
                                        getIdentificationTypesProvider),
                                    child: Text(
                                        'Empty classification.Tap  to refresh'))
                                : DropdownButtonHideUnderline(
                                    child:
                                        DropdownButton2<BusinessNaturesDatum>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select nature of business',
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
                                                      BusinessNaturesDatum>>(
                                              (item) => DropdownMenuItem<
                                                      BusinessNaturesDatum>(
                                                    value: item,
                                                    child: Text(
                                                      item.businessNatureName ??
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
                                      value: businessNaturesItem,
                                      onChanged:
                                          (BusinessNaturesDatum? newValue) {
                                        setState(() {
                                          subBusinessNaturesItem = null;

                                          /// Set selected item params
                                          businessNaturesItem = newValue;
                                          selectedBusinessNaturesName =
                                              newValue?.businessNatureName;
                                          selectedBusinessNaturesCode =
                                              newValue?.businessNatureId;
                                          _businessNatureIdController.text =
                                              newValue?.businessNatureId ?? '';
                                        });
                                        // refresh subs
                                        ref.invalidate(
                                            getSubBusinessNaturesProvider(
                                                int.parse(newValue!
                                                    .businessNatureId!)));
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
                                  ),
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
                  const SizedBox(height: 16),
                  if (selectedBusinessNaturesCode != null ||
                      subBusinessNaturesItem != null) ...[
                    /// Sub bus category
                    Text(
                      ' Sub  Business  class',
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                    ),

                    Consumer(
                      builder: (context, ref, child) {
                        return ref
                            .watch(getSubBusinessNaturesProvider(
                                int.parse(selectedBusinessNaturesCode!)))
                            .when(
                              data: (data) => (data == null || data.isEmpty)
                                  ? GestureDetector(
                                      child: Text('Empty  Sub-classification'),
                                      onTap: () => ref.invalidate(
                                          getSubBusinessNaturesProvider(
                                              int.parse(businessNaturesItem
                                                      ?.businessNatureId! ??
                                                  ''))))
                                  : DropdownButtonHideUnderline(
                                      key: ValueKey(subBusinessNaturesItem),
                                      child: DropdownButton2<
                                          SubBusinessNatureDatum>(
                                        isExpanded: true,
                                        hint: Text(
                                          'Select sub business class',
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
                                                        SubBusinessNatureDatum>>(
                                                (item) => DropdownMenuItem<
                                                        SubBusinessNatureDatum>(
                                                      value: item,
                                                      child: Text(
                                                        item.subBusinessNatureName ??
                                                            '',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color:
                                                              ZxplorePrimaryColor,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ))
                                            .toList(),
                                        value: subBusinessNaturesItem,
                                        onChanged:
                                            (SubBusinessNatureDatum? newValue) {
                                          // refresh subs
                                          ref.invalidate(
                                              getSubBusinessNaturesProvider(
                                                  int.parse(
                                                      selectedBusinessNaturesCode!)));
                                          setState(() {
                                            /// Set selected item params
                                            subBusinessNaturesItem = newValue;
                                            subBusinessNaturesName =
                                                newValue?.subBusinessNatureName;
                                            subBusinessNaturesCode =
                                                newValue?.subBusinessNatureId;
                                            _subBusinessNatureIdController
                                                    .text =
                                                newValue?.subBusinessNatureId ??
                                                    '';
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
                                    ),
                              error: (e, s) => GestureDetector(
                                  onTap: () => ref.invalidate(
                                      getSubBusinessNaturesProvider(int.parse(
                                          selectedBusinessNaturesCode!))),
                                  child: const Text(
                                    'An error occured',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              loading: () => SizedBox(height: 16.0),
                            );
                      },
                    ),
                  ],

                  /// Customer Classification category
                  const SizedBox(height: 16),
                  Text(
                    'Customer Class',
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
                      return ref.watch(getCustomerClassificationProvider).when(
                            data: (data) => (data != null &&
                                    data.isNotEmpty == true)
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton2<
                                        CustomerClassificationDatum>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select class',
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
                                                      CustomerClassificationDatum>>(
                                              (item) => DropdownMenuItem<
                                                      CustomerClassificationDatum>(
                                                    value: item,
                                                    child: Text(
                                                      item.description ?? '',
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
                                      value: customerClassificationsItem,
                                      onChanged: (CustomerClassificationDatum?
                                          newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          customerClassificationsItem =
                                              newValue;
                                          selectedCustomerClassificationsName =
                                              newValue
                                                  ?.customerClassificationId;
                                          _customerClassificationIdController
                                              .text = newValue
                                                  ?.customerClassificationId ??
                                              '';
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
                                : Text('Empty   classification'),
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
                  const SizedBox(height: 16),

                  /// EmploymentType
                  Text(
                    'Employment Type',
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
                      return ref.watch(getEmploymentTypeProvider).when(
                            data: (data) => (data != null &&
                                    data.isNotEmpty == true)
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton2<EmploymentTypeDatum>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select employment type',
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
                                                      EmploymentTypeDatum>>(
                                              (item) => DropdownMenuItem<
                                                      EmploymentTypeDatum>(
                                                    value: item,
                                                    child: Text(
                                                      item.employmentTypeName ??
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
                                      value: employmentTypesItem,
                                      onChanged:
                                          (EmploymentTypeDatum? newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          employmentTypesItem = newValue;
                                          selectedEmploymentTypessName =
                                              newValue?.employmentTypeName;
                                          selectedEmploymentTypesCode =
                                              newValue?.employmentTypeCode;
                                          _employmentTypeCodeController.text =
                                              newValue?.employmentTypeCode ??
                                                  '';
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
                                : Text('Empty   employment types'),
                            error: (e, s) => GestureDetector(
                                onTap: () =>
                                    ref.invalidate(getEmploymentTypeProvider),
                                child: const Text(
                                  'An error occured',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            loading: () => SizedBox(height: 16.0),
                          );
                    },
                  ),
                  if (selectedEmploymentTypessName == "EMPLOYED") ...[
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      title: "Employer Phone",
                      fillColor: Colors.transparent,
                      controller: _employerTelController,
                      hint: 'Enter employer\'s phone',
                      inputType: TextInputType.phone,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Employer phone is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      title: "Employer Email",
                      fillColor: Colors.transparent,
                      controller: _employerEmailController,
                      hint: 'Enter employer\'s Email',
                      inputType: TextInputType.emailAddress,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Employer email  required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      title: "Employer Address",
                      fillColor: Colors.transparent,
                      controller: _employerAddressController,
                      hint: 'Enter employer address',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Employer address  required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      title: "Time with Employer",
                      fillColor: Colors.transparent,
                      controller: _timeWithEmployerController,
                      hint: 'How long have you worked',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        // if (value.toString().isEmpty) {
                        //   return 'Employer email  required';
                        // }
                        return null;
                      },
                    ),
                  ],

                  const SizedBox(height: 16),

                  CustomTextFormField(
                    title: "Monthly Income",
                    fillColor: Colors.transparent,
                    controller: _monthlyIncomeController,
                    hint: 'How long have you worked',
                    inputType: TextInputType.number,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Monthly Income is required';
                      }
                      return null;
                    },
                  ),

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
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    Text(
                      'Permanent Res. Country ',
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
                                          'Select permanent country',
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
                                        value: permsSelectedCountry,
                                        onChanged: (CountryDatum? newValue) {
                                          setState(() {
                                            /// Set selected item params
                                            permsSelectedCountry = newValue;
                                            permsSelectedCountryCode =
                                                newValue?.countryCode;
                                            permsSelectedCountryName =
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
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      title: " Residence Permit (Place Code)",
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
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      onTap: () =>
                          _showDatePicker(context, dateCategory: 'PERMITISSUE'),
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
                    const SizedBox(height: 16),
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
                  const SizedBox(height: 16),

                  /// MaritalStatus
                  Text(
                    'Marital Status',
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
                      return ref.watch(getMaritalStatusProvider).when(
                            data: (data) => (data != null &&
                                    data.isNotEmpty == true)
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton2<MaritalStatusDatum>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select status',
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
                                                  MaritalStatusDatum>>((item) =>
                                              DropdownMenuItem<
                                                  MaritalStatusDatum>(
                                                value: item,
                                                child: Text(
                                                  item.maritalStatusDesc ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: ZxplorePrimaryColor,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList(),
                                      value: maritalStatusItem,
                                      onChanged:
                                          (MaritalStatusDatum? newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          maritalStatusItem = newValue;
                                          maritalStatusName =
                                              newValue?.maritalStatusDesc;
                                          _maritalStatusController.text =
                                              newValue?.maritalStatusDesc ?? '';
                                          maritalStatusCode =
                                              newValue?.maritalStatusCode;
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
                                onTap: () =>
                                    ref.invalidate(getMaritalStatusProvider),
                                child: const Text(
                                  'An error occured',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            loading: () => SizedBox(height: 16.0),
                          );
                    },
                  ),
                  if (maritalStatusName != null &&
                      maritalStatusName == "Married") ...[
                    CustomTextFormField(
                      title: 'Spouse Name',
                      fillColor: Colors.transparent,
                      controller: _spouseNameController,
                      hint: 'Spouse Name',
                      inputType: TextInputType.name,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Spouse Name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      title: 'Spouse Occupation',
                      fillColor: Colors.transparent,
                      controller: _spouseOccupationController,
                      hint: 'Spouse occupation',
                      inputType: TextInputType.name,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Spouse occupation is required';
                        }
                        return null;
                      },
                    ),
                  ],

                  const SizedBox(height: 16),
                  const Divider(
                    height: 16,
                    color: Color.fromARGB(255, 169, 189, 201),
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    title: 'Telephone Number',
                    fillColor: Colors.transparent,
                    controller: _telNoController,
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
                    controller: _mobileNoController,
                    hint: 'Enter mobile number',
                    inputType: TextInputType.phone,
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
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'Address',
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
                  CustomTextFormField(
                    title: "Home Town",
                    fillColor: Colors.transparent,
                    controller: _homeTownController,
                    hint: 'Enter home town',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Home Town is  required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'Other Address',
                    fillColor: Colors.transparent,
                    controller: _residentialAddress2Controller,
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

                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'GPS-Addresss',
                    fillColor: Colors.transparent,
                    controller: _gpsAddressController,
                    hint: 'GHA-00000000-0',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'GPS-Addresss is  required';
                      } else if (value.toString().length < 12) {
                        return 'Minimum 12 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  const Divider(
                    height: 16,
                    color: Color.fromARGB(255, 169, 189, 201),
                    thickness: 0.5,
                  ),
                  // const SizedBox(height: 8),
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
                                    child: DropdownButton2<
                                        IdentificationTypesDatum>(
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
                                          _identificationTypeIdController.text =
                                              '${newValue?.identificationTypeId ?? ''}';
                                          selectedIdentificationTypeName =
                                              newValue?.identificationTypeName;
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
                                    child: Text('No? types?, Tap to refresh, '),
                                    onTap: () => ref.invalidate(
                                        getIdentificationTypesProvider),
                                  ),
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
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'ID Number',
                    fillColor: Colors.transparent,
                    controller: _identificationNoController,
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
                      _showDatePicker(context, dateCategory: 'IDISSSUEDATE');
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
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    onTap: () {
                      _showDatePicker(context, dateCategory: 'IDEXPDATE');
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
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'NIA Number',
                    fillColor: Colors.transparent,
                    controller: _niaVerificationNoController,
                    hint: 'Enter NIA number',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'IDD Code',
                    fillColor: Colors.transparent,
                    controller: _iddCodeController,
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
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'SSNIT  Number',
                    fillColor: Colors.transparent,
                    controller: _ssnitNoController,
                    hint: 'Enter SSN code',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  Text(
                    'Other Informtion',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  div,
                  gapH12,

                  CheckboxListTile(
                    title: Text('Account Ownership (you/other)'),
                    value: accountOwnership,
                    onChanged: (value) => _handleCheckboxChange(2, value),
                  ),
                  if (accountOwnership) ...[
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      title: 'Account Ownership Other',
                      fillColor: Colors.transparent,
                      controller: _accountOwnershipOtherController,
                      hint: 'Enter Account Ownership',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        if (accountOwnership) {
                          if (value!.isEmpty) {
                            return 'Specify account ownership';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                  gapH12,
                  CheckboxListTile(
                    title: Text('Customer Resident In Ghana'),
                    value: customerResidentInGhana,
                    onChanged: (value) => _handleCheckboxChange(3, value),
                  ),
                  gapH12,

                  CheckboxListTile(
                    title: Text('Is Physically Challenged'),
                    value: isPhysicallyChallenged,
                    onChanged: (value) => _handleCheckboxChange(4, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Customer Is PEP'),
                    value: customerIsPEP,
                    onChanged: (value) => _handleCheckboxChange(5, value),
                  ),
                  gapH12,

                  CheckboxListTile(
                    title: Text('Setup Ibank'),
                    value: setupIbank,
                    onChanged: (value) => _handleCheckboxChange(6, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Setup ZPrompt'),
                    value: setupZPrompt,
                    onChanged: (value) => _handleCheckboxChange(7, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Setup Statement Via Email'),
                    value: setupStatementViaEmail,
                    onChanged: (value) => _handleCheckboxChange(8, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Setup Email Indemnity'),
                    value: setupEmailIndemnity,
                    onChanged: (value) => _handleCheckboxChange(9, value),
                  ),
                  gapH12,

                  CheckboxListTile(
                    title: Text('New Request?'),
                    value: isNewRequest,
                    onChanged: (value) => _handleCheckboxChange(11, value),
                  ),

                  const SizedBox(height: 16),
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
                  //  const SizedBox(height: 16),
                  // CustomTextFormField(
                  //   title: 'Citizenship',
                  //   fillColor: Colors.transparent,
                  //   controller: _tinController,
                  //   hint: 'Enter TIN code',
                  //   inputType: TextInputType.text,
                  //   useDefaultErrorText: false,
                  //   validator: (value) {

                  //     return null;
                  //   },
                  // ),
                  const SizedBox(height: 24),
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
    print("CAAT::$dateCategory");
    DateTime now = DateTime.now();
    final DateTime tempnow = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 200, now.month, now.day);
    final DateTime lastDate = DateTime(now.year + 200, now.month, now.day);
    if (mounted) {
      final DateTime? fPickedDate = await showDatePicker(
          context: context,
          initialDate: tempnow,
          firstDate: firstDate,
          lastDate: lastDate);

      if (fPickedDate != null) {
        dobFormattedDate = dateFormatter.format(fPickedDate);

        if (dateCategory == 'DOB') {
          setState(() {
            dob = fPickedDate.toIso8601String();
            _birthDateController.text = dobFormattedDate;
          });
        } else if (dateCategory == 'IDISSSUEDATE') {
          setState(() {
            identityDateIssued = fPickedDate.toIso8601String();
            _idIssueDateController.text = dobFormattedDate;
          });
        }
        else if (dateCategory == 'IDEXPDATE') {
        setState(() {
          identityDateExpire = fPickedDate.toIso8601String();
          _idExpiryDateController.text = dobFormattedDate;
        });
      } else if (dateCategory == 'PERMITEXP') {
        setState(() {
          permIdentityDateExpire = fPickedDate.toIso8601String();
          _permitExpiryDateController.text = dobFormattedDate;
        });
      } else if (dateCategory == 'PERMITISSUE') {
        setState(() {
          permIdentityDateIssued = fPickedDate.toIso8601String();
          _permitIssueDateController.text = dobFormattedDate;
        });
      }
      } 
    }
  }
}
