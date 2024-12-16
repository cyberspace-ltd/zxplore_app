import 'package:flutter/material.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';

class EditPersonalInfo extends StatefulWidget {
  const EditPersonalInfo({super.key});

  @override
  State<EditPersonalInfo> createState() => _EditPersonalInfoState();
}

class _EditPersonalInfoState extends State<EditPersonalInfo> {
  final _personalInfoEditFormKey = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _otherNamesController = TextEditingController();
  final TextEditingController _maidenNameController = TextEditingController();
  final TextEditingController _genderCodeController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _identificationTypeIdController = TextEditingController();
  final TextEditingController _identificationNoController = TextEditingController();
  final TextEditingController _idCountryCodeController = TextEditingController();
  final TextEditingController _idIssueAuthorityController = TextEditingController();
  final TextEditingController _idIssueDateController = TextEditingController();
  final TextEditingController _idExpiryDateController = TextEditingController();
  final TextEditingController _niaVerificationNoController = TextEditingController();
  final TextEditingController _ssnitNoController = TextEditingController();
  final TextEditingController _tinController = TextEditingController();
  final TextEditingController _citizenshipCodeController = TextEditingController();
  final TextEditingController _altCitizenshipCodeController = TextEditingController();
  final TextEditingController _countryOrigCodeController = TextEditingController();
  final TextEditingController _homeTownController = TextEditingController();
  final TextEditingController _residencePermitNoController = TextEditingController();
  final TextEditingController _residencePermitPlaceCodeController = TextEditingController();
  final TextEditingController _permitIssueDateController = TextEditingController();
  final TextEditingController _permitExpiryDateController = TextEditingController();
  final TextEditingController _iddCodeController = TextEditingController();
  final TextEditingController _telNoController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _residentialAddressController = TextEditingController();
  final TextEditingController _residentialAddress2Controller = TextEditingController();
  final TextEditingController _districtAssemblyAreaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _regionCodeController = TextEditingController();
  final TextEditingController _permanentResidentialAddressController = TextEditingController();
  final TextEditingController _permanentResidentialCityController = TextEditingController();
  final TextEditingController _permanentResidentialCountryCodeController = TextEditingController();
  final TextEditingController _mailingAddressController = TextEditingController();
  final TextEditingController _motherMaidenNameController = TextEditingController();
  final TextEditingController _maritalStatusController = TextEditingController();
  final TextEditingController _spouseNameController = TextEditingController();
  final TextEditingController _spouseOccupationController = TextEditingController();
  final TextEditingController _businessNatureIdController = TextEditingController();
  final TextEditingController _subBusinessNatureIdController = TextEditingController();
  final TextEditingController _employmentTypeCodeController = TextEditingController();
  final TextEditingController _employerNameController = TextEditingController();
  final TextEditingController _timeWithEmployerController = TextEditingController();
  final TextEditingController _employerAddressController = TextEditingController();
  final TextEditingController _employerEmailController = TextEditingController();
  final TextEditingController _employerTelController = TextEditingController();
  final TextEditingController _monthlyIncomeController = TextEditingController();
  final TextEditingController _accountOwnershipOtherController = TextEditingController();
  final TextEditingController _pepReasonController = TextEditingController();
  final TextEditingController _customerClassificationIdController = TextEditingController();
  final TextEditingController _gpsAddressController = TextEditingController();

  bool _hasPermanentResidence = false;
  bool _accountOwnership = false;
  // bool _customerResidentInGhana = false;
  // bool _customerIsPEP = false;
  // bool _setupIbank = false;
  // bool _setupZPrompt = false;
  // bool _setupStatementViaEmail = false;
  // bool _setupEmailIndemnity = false;
  // bool _isPhysicallyChallanged = false;
  // bool _isNewRequest = false;

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
      title: '',
      widgetToGoOnCancel: Container(),
      onCancel: (){},
      data: {},
      child:  Form(
            key: _personalInfoEditFormKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _surnameController,
                  decoration: InputDecoration(labelText: 'Surname'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your surname';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                // Add more TextFormFields for other fields...
      
                // Example for genderCode
                TextFormField(
                  controller: _genderCodeController,
                  decoration: InputDecoration(labelText: 'Gender Code'),
                ),
                TextFormField(
                  controller: _birthDateController,
                  decoration: InputDecoration(labelText: 'Birth Date'),
                ),
                TextFormField(
                  controller: _birthPlaceController,
                  decoration: InputDecoration(labelText: 'Birth Place'),
                ),
                // Add more fields as necessary...
      
                CheckboxListTile(
                  title: Text('Has Permanent Residence'),
                  value: _hasPermanentResidence,
                  onChanged: (bool? value) {
                    setState(() {
                      _hasPermanentResidence = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Account Ownership'),
                  value: _accountOwnership,
                  onChanged: (bool? value) {
                    setState(() {
                      _accountOwnership = value!;
                    });
                  },
                ),
                // Add more checkboxes as necessary...
      
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
      
    );
  }
}
