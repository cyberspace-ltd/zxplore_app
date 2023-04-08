import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:location/location.dart';
import 'package:zxplore_app/apis/zenithbank_api.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/category.dart';
import 'package:zxplore_app/data/database.dart';
import 'package:zxplore_app/data/entities/account_class_entity.dart';
import 'package:zxplore_app/data/entities/offline_form_entity.dart';
import 'package:zxplore_app/data/entities/state_entity.dart';
import 'package:zxplore_app/models/account_details_response.dart';
import 'package:zxplore_app/models/account_purposes.dart';
import 'package:zxplore_app/models/bvn_response.dart';
import 'package:zxplore_app/models/form_model.dart';
import 'package:zxplore_app/models/place_prediction.dart';
import 'package:zxplore_app/models/save_account_response.dart';
import 'package:zxplore_app/models/transaction_type.dart';
import 'package:zxplore_app/models/verify_id_response.dart';
import 'package:zxplore_app/repositories/accounts_repository.dart';
import 'package:zxplore_app/utils/const.dart';
import 'package:zxplore_app/utils/secure_storage.dart';
import 'package:zxplore_app/utils/zxplore_crypto_helper.dart';

import '../models/account_datum.dart';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class AccountFormBloc extends BlocBase with Validators {
  Pattern pattern = r'[!₦$/@#<>?":_`~;[\]\\|=+)(*&^%0-9]';

  //Account Information
  final AccountsRepository _accountsRepository = AccountsRepository();

  final _referenceIdController =
      BehaviorSubject<String?>(); // used in the case of updating accounts.

  final _currentFormCategoryController = BehaviorSubject<Category>();

  final _isDateOfBirthChangeController = BehaviorSubject<bool>();
  final _isStateOfOriginChangeController = BehaviorSubject<bool>();
  final _isStateOfResidenceChangeController = BehaviorSubject<bool>();
  final _isGenderChangeController = BehaviorSubject<bool>();
  final _isMaritalStatusChangeController = BehaviorSubject<bool>();
  final BehaviorSubject<LocationData> _subjectLocation =
      BehaviorSubject<LocationData>();

  final _idController = BehaviorSubject<int?>();
  final _isEditModeController = BehaviorSubject<bool?>();
  final databaseRowIDController = BehaviorSubject<int?>();

  final _accountTypeController = BehaviorSubject<String?>();

  final _accountHolderTypeController = BehaviorSubject<String?>();

  final _riskRankController = BehaviorSubject<String?>();

  final _accountCategoryController = BehaviorSubject<String?>();

  //Personal Information

  final _tinController = BehaviorSubject<String?>();

  final _titleController = BehaviorSubject<String?>();

  final _purposeOfAcctController = BehaviorSubject<List<String>>();

  final _anticipatedNoTranController = BehaviorSubject<String?>();
  final _anticipatedAmountController = BehaviorSubject<String?>();

  final _anticipatedWithdrawTranController = BehaviorSubject<String?>();
  final _anticipatedAmountWithdrawController = BehaviorSubject<String?>();

// Purpose of account
  final _salaryProcessingController = BehaviorSubject<bool?>();
  final _bankingServiceController = BehaviorSubject<bool?>();
  final _businessController = BehaviorSubject<bool?>();
  final _singleTransactionController = BehaviorSubject<bool?>();
  final _safeKeepingController = BehaviorSubject<bool?>();
  final _savingAndInvestmentController = BehaviorSubject<bool?>();
  final _receiptController = BehaviorSubject<bool?>();
  final _othersController = BehaviorSubject<bool?>();
  final othersPurposeController = BehaviorSubject<String?>();

// Source of funds
  final _salaryController = BehaviorSubject<bool?>();
  final _rentalIncomeController = BehaviorSubject<bool?>();
  final _personalSavingController = BehaviorSubject<bool?>();
  final _familyFriendController = BehaviorSubject<bool?>();
  final _dividendsController = BehaviorSubject<bool?>();
  final _commissionController = BehaviorSubject<bool?>();
  final _businessProceedController = BehaviorSubject<bool?>();
  final _otherSourceController = BehaviorSubject<bool?>();
  final enterOtherSourceController = BehaviorSubject<String?>();

  final _showOtherOccupationController = BehaviorSubject<bool?>();

  // Edit form
  final _editableFormController = BehaviorSubject<bool?>();

  final _employmentTypeController = BehaviorSubject<String?>();

  final _monthlyIncomeController = BehaviorSubject<String?>();
  final _sourceOfFundController = BehaviorSubject<List<String>>();

  final _transactionTypeController = BehaviorSubject<String?>();

  final _surnameController = BehaviorSubject<String?>();

  final _firstNameController = BehaviorSubject<String?>();

  final _otherNameController = BehaviorSubject<String?>();

  final _mothersMaidenNameController = BehaviorSubject<String?>();

  final _dateOfBirthController = BehaviorSubject<String?>();

  final _homeTownController = BehaviorSubject<String?>();
  final _placeOfBirthController = BehaviorSubject<String?>();

  final _countryOfOriginController = BehaviorSubject<String?>();
  final _countryOfIDCountryIssueController = BehaviorSubject<String?>();

  //Contact Details

  final _emailController = BehaviorSubject<String?>();

  final _latitudeController = BehaviorSubject<String>();

  final _longitudeController = BehaviorSubject<String>();

  final _phoneNumberController = BehaviorSubject<String?>();

  final _nextOfKinController = BehaviorSubject<String?>();
  final _nextOfKinPhoneController = BehaviorSubject<String?>();
  final _nextOfKinRelationshipController = BehaviorSubject<String?>();

  final _nextOfKinAddressController = BehaviorSubject<String?>();

  final _nextOfKinGenderController = BehaviorSubject<String?>();

  final _address1Controller = BehaviorSubject<String?>();

  final _address2Controller = BehaviorSubject<String?>();

  final _countryOfResidenceController = BehaviorSubject<String?>();

  final _stateOfResidenceController = BehaviorSubject<String?>();

  final _mmdaController = BehaviorSubject<String?>();

  final _cityOfResidenceController = BehaviorSubject<String?>();

  final _genderController = BehaviorSubject<String?>();

  final occupationController = BehaviorSubject<String?>();

  final occupationCategoryController = BehaviorSubject<String?>();

  final othersOccupationController = BehaviorSubject<String?>();

  final _maritalStatusController = BehaviorSubject<String?>();

  //Means of Identification
  final _idTypeController = BehaviorSubject<String?>();

  final _idIssuerController = BehaviorSubject<String?>();
  final _idIssuerOthersController = BehaviorSubject<String?>();

  final _admissionNoController = BehaviorSubject<String?>();

  final _idNumberController = BehaviorSubject<String?>();

  final _idPlaceOfIssueController = BehaviorSubject<String?>();

  final _idIssueDateController = BehaviorSubject<String?>();

  final _idExpiryDateController = BehaviorSubject<String?>();

//  final _isSendEmailController = BehaviorSubject<bool>();
//
//  final _isReceiveSmsController = BehaviorSubject<bool>();
//
//  final _isRequestHardwareTokenController = BehaviorSubject<bool>();
//
//  final _isRequestInternetBankingController = BehaviorSubject<bool>();

// E-PRODUCT LIST
  //TODO: GHANA SPECIFIC SERVICES STREAM
  final _isScanToPayController = BehaviorSubject<bool?>();

  final _isZMobileController = BehaviorSubject<bool?>();

  final _isZPromptController = BehaviorSubject<bool?>();

  final _isStatementViaEmailController = BehaviorSubject<bool?>();

  final _isUssdController = BehaviorSubject<bool?>();

  final _isBankToWalletController = BehaviorSubject<bool?>();

  final _isCardRequestController = BehaviorSubject<bool?>();

  final cardTypeController = BehaviorSubject<String?>();

  final _requestingBranchController = BehaviorSubject<String?>();

  final _destinationBranchController = BehaviorSubject<String?>();

  final _preferredNameOnCardController = BehaviorSubject<String?>();

  final _uploadIdImageController = BehaviorSubject<String?>();
  final _uploadIdImageController2 = BehaviorSubject<String?>();

  final _uploadPassportController = BehaviorSubject<String?>();

  final uploadAdmissionLetterController = BehaviorSubject<String?>();

  final _uploadUtilityBillController = BehaviorSubject<String?>();
  final _uploadResidentPermitController = BehaviorSubject<String?>();

  final _uploadSignatureController = BehaviorSubject<String?>();

  final BehaviorSubject<SaveAccountResponse> _subjectSaveAccountResponse =
      BehaviorSubject<SaveAccountResponse>();

  final PublishSubject<AccountDetailsResponse> _subjectAccountsDetailsResponse =
      PublishSubject<AccountDetailsResponse>();

  final PublishSubject<String> _subjectSaveOfflineAccountResponse =
      PublishSubject<String>();

  final PublishSubject<String> _subjectDeleteOfflineAccountResponse =
      PublishSubject<String>();

  // Add data to stream

  final PublishSubject<BvnResponse> bvnVerificationResponse =
      PublishSubject<BvnResponse>();

  late PublishSubject<VerifyIdResponse> driverLicenseVerificationResponse;

  Stream<bool> get bvnStateOfOrigin => _isStateOfOriginChangeController.stream;

  Stream<bool> get bvnDateOfBirth => _isDateOfBirthChangeController.stream;

  Stream<bool> get bvnStateOfResidences =>
      _isStateOfResidenceChangeController.stream;

  Stream<bool> get bvnGenders => _isGenderChangeController.stream;

  Stream<bool> get bvnMaritalStatuses =>
      _isMaritalStatusChangeController.stream;

  // ignore: non_constant_identifier_names
  String easy_classic = "344";
  bool bvnlastNameValue = true;
  bool bvnFirstName = true;
  bool bvnStateOfResidence = true;

  bool bvnResidentialAddress = true;
  bool bvnMaritalStatus = true;
  bool bvnPhone = true;
  bool bvnGender = true;
  bool bvnState = true;

  bool bvnDateOfBirths = true;

  bool bvnTitle = true;
  bool bvnEmail = true;
  bool bvnOtherName = true;

  bool processCenter = true;
  bool country = true;
  bool lsIssueDate = true;
  bool expiryDate = true;

  Stream<String?> get accountType =>
      _accountTypeController.stream.transform(validateAccountType);

  Stream<String?> get accountHolderType =>
      _accountHolderTypeController.stream.transform(validateAccountHolderType);

  Stream<String?> get riskRankType =>
      _riskRankController.stream.transform(validateRiskRank);

  Stream<String?> get accountCategoryType =>
      _accountCategoryController.stream.transform(validateAccountCategory);

  String? bvv() {
    return _accountCategoryController.valueOrNull;
  }

  Stream<String?> get tin => _tinController.stream.transform(validateBvn);
// validateBvn
  Stream<String?> get title => _titleController.stream.transform(validateTitle);

  Stream<int?> get rowID => databaseRowIDController.stream;

  Stream<List<String>> get purposeAcct => _purposeOfAcctController.stream;

  Stream<String?> get anticipatedNoTran => _anticipatedNoTranController.stream;
  Stream<String?> get anticipatedAmountTran =>
      _anticipatedAmountController.stream;

  Stream<String?> get anticipatedNoWithdraw =>
      _anticipatedWithdrawTranController.stream;
  Stream<String?> get anticipatedAmountWithdraw =>
      _anticipatedAmountWithdrawController.stream;

  // Purpose of account
  Stream<bool?> get salaryProcessing => _salaryProcessingController.stream;
  Stream<bool?> get bankingService => _bankingServiceController.stream;
  Stream<bool?> get business => _businessController.stream;
  Stream<bool?> get singleTransaction => _singleTransactionController.stream;
  Stream<bool?> get safeKeeping => _safeKeepingController.stream;
  Stream<bool?> get savingAndInvestment =>
      _savingAndInvestmentController.stream;
  Stream<bool?> get receipt => _receiptController.stream;
  Stream<bool?> get others => _othersController.stream;
  Stream<String?> get othersPurpose => othersPurposeController.stream;

  // Source of funds

  Stream<bool?> get salary => _salaryController.stream;
  Stream<bool?> get rentalIncome => _rentalIncomeController.stream;
  Stream<bool?> get personalSaving => _personalSavingController.stream;
  Stream<bool?> get familyFriend => _familyFriendController.stream;
  Stream<bool?> get dividends => _dividendsController.stream;
  Stream<bool?> get commission => _commissionController.stream;
  Stream<bool?> get businessProceed => _businessProceedController.stream;
  Stream<bool?> get otherSource => _otherSourceController.stream;

  Stream<String?> get enteredOtherSource => enterOtherSourceController.stream;

  // Stream<String?> get otherspurpose => othersPurposeController.stream;

  Stream<String?> get employmentType => _employmentTypeController.stream;

  Stream<String?> get monthlyIncome => _monthlyIncomeController.stream;
  // Stream<List<String>> get sourceOfFund => _sourceOfFundController.stream;

  //.transform(validateAccountPurpose);

  Stream<String?> get transactionType =>
      _transactionTypeController.stream.transform(validateTitle);

  Stream<bool?> get formIsEditable => _editableFormController.stream;

  Stream<String?> get surname =>
      _surnameController.stream.transform(validateSurname);

  Stream<String?> get firstName =>
      _firstNameController.stream.transform(validateFirstName);

  Stream<String?> get otherName =>
      _otherNameController.stream.transform(validateOtherName);

  Stream<String?> get mothersMaidenName =>
      _mothersMaidenNameController.stream.transform(validateMothersMaidenName);

  Stream<String?> get dateOfBirth =>
      _dateOfBirthController.stream.transform(validateDateOfBirth);

  Stream<String?> get placeOfBirth =>
      _placeOfBirthController.stream.transform(validatePlaceOfBirth);

  Stream<String?> get homeTown =>
      _homeTownController.stream.transform(validatePlaceOfBirth);

  Stream<String?> get mmda => _mmdaController.stream.transform(validateMMDA);

  Stream<String?> get countryOfOrigin =>
      _countryOfOriginController.stream.transform(validateCountryOfOrigin);

  Stream<String?> get countryIDIssuer =>
      _countryOfIDCountryIssueController.stream
          .transform(validateCountryOfOrigin);

  //  _countryOfIDCountryIssueController

  Stream<String?> get phoneNumber =>
      _phoneNumberController.stream.transform(validatePhoneNumber);

  Stream<String?> get nextOfKin =>
      _nextOfKinController.stream.transform(validateNextOfKin);

  Stream<String?> get nextOfKinPhone =>
      _nextOfKinPhoneController.stream.transform(validatePhoneNumber);

  Stream<String?> get nextOfKinRelationShip =>
      _nextOfKinRelationshipController.stream.transform(validateNextOfKin);

  Stream<String?> get nextOfKinAddress =>
      _nextOfKinAddressController.stream.transform(nextOfKinAddressValidate);

  Stream<String?> get nextOfKinGender =>
      _nextOfKinGenderController.stream.transform(validateNextOfKin);

  Stream<String?> get email => _emailController.stream.transform(validateEmail);

  BehaviorSubject<LocationData> get subjectLocationResponse => _subjectLocation;

  Stream<Category> get currentFormCategory =>
      _currentFormCategoryController.stream;

  Stream<String> get latitude => _latitudeController.stream;

  Stream<String> get longitude => _longitudeController.stream;

  Stream<String?> get address1 =>
      _address1Controller.stream.transform(validateAddress1);

  Stream<String?> get address2 => _address2Controller.stream;

  Stream<String?> get countryOfResidence => _countryOfResidenceController.stream
      .transform(validateCountryOfResidence);

  Stream<String?> get stateOfResidence =>
      _stateOfResidenceController.stream.transform(validateStateOfResidence);

  Stream<String?> get cityOfResidence =>
      _cityOfResidenceController.stream.transform(validateCityOfResidence);

  Stream<String?> get gender =>
      _genderController.stream.transform(validateGender);

  Stream<String?> get occupation =>
      occupationController.stream.transform(validateOccupation);

  Stream<String?> get occupationCategory =>
      occupationCategoryController.stream.transform(validateOccupation);

  Stream<String?> get otherOccupation =>
      othersOccupationController.stream.transform(validateOccupation);

  Stream<String?> get maritalStatus =>
      _maritalStatusController.stream.transform(validateMaritalStatus);

  Stream<String?> get idType =>
      _accountCategoryController.valueOrNull == easy_classic
          ? _idTypeController.stream
          : _idTypeController.stream.transform(validateIdType);

  Stream<String?> get idIssuer =>
      _accountCategoryController.valueOrNull == easy_classic
          ? _idIssuerController.stream
          : _idIssuerController.stream.transform(validateIdIssuer);

  Stream<String?> get idOthersIssuer =>
      _accountCategoryController.valueOrNull == easy_classic
          ? _idIssuerOthersController.stream
          : _idIssuerOthersController.stream.transform(validateIdIssuer);

  Stream<String?> get admissionNo =>
      _accountCategoryController.valueOrNull == easy_classic
          ? _admissionNoController.stream
          : _admissionNoController.stream.transform(validateAdmNo);

  Stream<String?> get idNumber =>
      _accountCategoryController.valueOrNull == easy_classic
          ? _idNumberController.stream
          : _idNumberController.stream.transform(validateIdNumber);

  Stream<String?> get idPlaceOfIssue =>
      _accountCategoryController.valueOrNull == easy_classic
          ? _idPlaceOfIssueController.stream
          : _idPlaceOfIssueController.stream.transform(validateIdPlaceOfIssue);

  Stream<String?> get idIssueDate =>
      _accountCategoryController.valueOrNull == easy_classic
          ? _idIssueDateController.stream
          : _idIssueDateController.stream.transform(validateIdIssueDate);

  Stream<String?> get idExpiryDate =>
      _accountCategoryController.valueOrNull == easy_classic
          ? _idExpiryDateController.stream
          : _idExpiryDateController.stream.transform(validateIdExpiryDate);

  //TODO: GHANA SPECIFIC SERVICES STREAM BOOL

  Stream<bool?> get isScanToPay => _isScanToPayController.stream;

  Stream<bool?> get isZMobile => _isZMobileController.stream;

  Stream<bool?> get isZPrompt => _isZPromptController.stream;

  Stream<bool?> get isStatementViaEmail =>
      _isStatementViaEmailController.stream;

  Stream<bool?> get isUssd => _isUssdController.stream;

  Stream<bool?> get isBankToWallet => _isBankToWalletController.stream;

  Stream<bool?> get isCardRequest => _isCardRequestController.stream;

  Stream<String?> get cardType => _isCardRequestController.valueOrNull ?? false
      ? cardTypeController.stream.transform(validateCardType)
      : cardTypeController.stream;

  Stream<String?> get requestingBranch =>
      _isCardRequestController.valueOrNull ?? false
          ? _requestingBranchController.stream
              .transform(validateRequestingBranch)
          : _requestingBranchController.stream;

  Stream<String?> get destinationBranch =>
      _isCardRequestController.valueOrNull ?? false
          ? _destinationBranchController.stream
              .transform(validateDestinationBranch)
          : _destinationBranchController.stream;

  Stream<String?> get preferredNameOnCard =>
      _isCardRequestController.valueOrNull ?? false
          ? _preferredNameOnCardController.stream
              .transform(validatePreferredNameOnCard)
          : _preferredNameOnCardController.stream;

  Stream<String?> get idCard => _uploadIdImageController.stream;
  Stream<String?> get idCard2 => _uploadIdImageController2.stream;

  Stream<String?> get passport => _uploadPassportController.stream;

  Stream<String?> get admissionLetter => uploadAdmissionLetterController.stream;

  Stream<String?> get signature => _uploadSignatureController.stream;

  Stream<LocationData> get location => _subjectLocation.stream;

//  Stream<bool> get submitValid => Observable.combineLatest4(
//      accountType,
//      accountHolderType,
//      riskRankType,
//      accountCategoryType,
//      (a, ac, r, act) => true);

  Stream<bool> get submitValid =>
      Rx.combineLatest2(phoneNumber, signature, (dynamic e, dynamic p) => true);

  // change data

  Function(String?) get changeAccountType => _accountTypeController.sink.add;

  Function(String) get changeLatitude => _latitudeController.sink.add;

  Function(Category) get changeFormCategory =>
      _currentFormCategoryController.sink.add;

  Function(String) get changeLongitude => _longitudeController.sink.add;

  Function(String?) get changeHolderType =>
      _accountHolderTypeController.sink.add;

  Function(String?) get changeRiskRank => _riskRankController.sink.add;

  Function(String?) get changeAccountCategory =>
      _accountCategoryController.sink.add;

  Function(String?) get changeTin => _tinController.sink.add;

  Function(String?) get changeTitle => _titleController.sink.add;
  // Function(String?) get changeRowID => databaseRowIDController.sink.add;

  void setRowID(int id) {
    databaseRowIDController.sink.add(id);
  }

  Stream<int?> getRowID() {
    return databaseRowIDController.stream;
  }

  List<String>? _purposeOfAcct;
  List<String>? get purposeOfAcct => _purposeOfAcct;

  bool? formStatus;
  bool? get getFormStatus => formStatus;

  void setChangeOtherOccupation(bool otherOccup) {
    _showOtherOccupationController.sink.add(otherOccup);
  }

  Stream<bool?> getChangeOtherOccupation() {
    return _showOtherOccupationController.stream;
  }

  void setPurposeOfAcct(List<String> list) {
    _purposeOfAcctController.sink.add(list);
  }

  void setAnticipatedNoTransaction(String list) {
    _anticipatedNoTranController.sink.add(list);
  }

  void setAnticipatedAmountTransaction(String list) {
    _anticipatedAmountController.sink.add(list);
  }

  Function(String?) get setAnticipatedNoWithdraw =>
      _anticipatedWithdrawTranController.sink.add;
  Function(String?) get setAnticipatedAmountWithdraw =>
      _anticipatedAmountWithdrawController.sink.add;

  void setEmploymentType(String list) {
    _employmentTypeController.sink.add(list);
  }

  void setFormStatus(bool? list) {
    _editableFormController.sink.add(list);
  }

  bool? getFormStatusBeforeSubmission() {
    return _editableFormController.valueOrNull;
  }

  // Function(String?) get setEmploymentType => _employmentTypeController.sink.add;

  void setMonthlyIncome(String list) {
    _monthlyIncomeController.sink.add(list);
  }

  void setSourceOfFund(List<String> list) {
    _sourceOfFundController.sink.add(list);
  }

  // Purpose of account
  Function(bool?) get changeSalaryProcessing =>
      _salaryProcessingController.sink.add;
  Function(bool?) get changeBankingService =>
      _bankingServiceController.sink.add;
  Function(bool?) get changeBusiness => _businessController.sink.add;
  Function(bool?) get changeSingleTransaction =>
      _singleTransactionController.sink.add;
  Function(bool?) get changeSafeKeeping => _safeKeepingController.sink.add;
  Function(bool?) get changeSavingAndInvestment =>
      _savingAndInvestmentController.sink.add;
  Function(bool?) get changeReceipt => _receiptController.sink.add;
  Function(bool?) get changeOthers => _othersController.sink.add;
  Function(String?) get changeOthersPurpose => othersPurposeController.sink.add;

  // Source of funds
  Function(bool?) get changeSalary => _salaryController.sink.add;
  Function(bool?) get changeRentalIncome => _rentalIncomeController.sink.add;
  Function(bool?) get changePersonalSaving =>
      _personalSavingController.sink.add;
  Function(bool?) get changeFamilyFriend => _familyFriendController.sink.add;
  Function(bool?) get changeDividends => _dividendsController.sink.add;
  Function(bool?) get changeCommission => _commissionController.sink.add;
  Function(bool?) get changeBusinessProceed =>
      _businessProceedController.sink.add;
  Function(bool?) get changeOtherSource => _otherSourceController.sink.add;

  Function(String?) get changeEnterOtherSource =>
      enterOtherSourceController.sink.add;

  Function(String?) get changeTransactionType =>
      _transactionTypeController.sink.add;

  Function(String?) get changeSurname => _surnameController.sink.add;

  Function(String?) get changeFirstName => _firstNameController.sink.add;

  Function(String?) get changeOtherName => _otherNameController.sink.add;

  Function(String?) get changeMothersMaidenName =>
      _mothersMaidenNameController.sink.add;

  Function(String?) get changeDateOfBirth => _dateOfBirthController.sink.add;

  Function(String?) get changePlaceOfBirth => _placeOfBirthController.sink.add;

  Function(String?) get changeHomeTown => _homeTownController.sink.add;

  Function(String?) get changeMMDA => _mmdaController.sink.add;

  // Function(String?) get changeCountryOfOrigin =>
  //   _countryOfOriginController.sink.add;
  String? countryOfResident;

  changeCountryOfOrigin(String? value) {
    // _idTypeController.sink.add(value);
    countryOfResident = value;
    _countryOfOriginController.sink.add(value);
  }

  Function(String?) get changeCountryIDIssue =>
      _countryOfIDCountryIssueController.sink.add;

  Function(String?) get changeEmail => _emailController.sink.add;

  Function(String?) get changePhone => _phoneNumberController.sink.add;

  Function(String?) get changeNextOfKin => _nextOfKinController.sink.add;
  Function(String?) get changeNextOfKinPhone =>
      _nextOfKinPhoneController.sink.add;
  Function(String?) get changeNextOfKinRelationShip =>
      _nextOfKinRelationshipController.sink.add;

  Function(String?) get changeNextOfKinAddress =>
      _nextOfKinAddressController.sink.add;

  Function(String?) get changeNextOfKinGender =>
      _nextOfKinGenderController.sink.add;

  Function(String?) get changeAddress1 => _address1Controller.sink.add;

  Function(String?) get changeAddress2 => _address2Controller.sink.add;

  Function(String?) get changeCountryOfResidence =>
      _countryOfResidenceController.sink.add;

  Function(String?) get changeStateOfResidence =>
      _stateOfResidenceController.sink.add;

  updateStateRegion(String? value) {
    _stateOfResidenceController.sink.add(value);
  }

  Function(String?) get changeCityOfResidence =>
      _cityOfResidenceController.sink.add;

  Function(String?) get changeGender => _genderController.sink.add;

  Function(String?) get changeOccupation => occupationController.sink.add;

  Function(String?) get changeOccupationCategory =>
      occupationCategoryController.sink.add;

  Function(String?) get changeOtherOccupation =>
      othersOccupationController.sink.add;

  Function(String?) get changeMaritalStatus =>
      _maritalStatusController.sink.add;

  Function(String?) get changeIdType => _idTypeController.sink.add;

  Function(String?) get changeIdIssuer => _idIssuerController.sink.add;

  Function(String?) get changeIdOtherIssuer =>
      _idIssuerOthersController.sink.add;

  Function(String?) get changeAdmissionNo => _admissionNoController.sink.add;

  Function(String?) get changeIdNumber => _idNumberController.sink.add;

  Function(String?) get changePlaceOfIssue =>
      _idPlaceOfIssueController.sink.add;

  Function(String?) get changeIssueDate => _idIssueDateController.sink.add;

  Function(String?) get changeExpiryDate => _idExpiryDateController.sink.add;

//  Function(bool) get changeIsSendEmail => _isSendEmailController.sink.add;
//
//  Function(bool) get changeIsReceiveSms => _isReceiveSmsController.sink.add;

  //TODO: Newly added GHANA change functions
  Function(bool?) get changeIsScanToPay => _isScanToPayController.sink.add;

  Function(bool?) get changeIsZMobile => _isZMobileController.sink.add;

  Function(bool?) get changeIsZPrompt => _isZPromptController.sink.add;

  Function(bool?) get changeIsStatementViaEmail =>
      _isStatementViaEmailController.sink.add;

  Function(bool?) get changeIsUssd => _isUssdController.sink.add;

  Function(bool?) get changeIsBankToWallet =>
      _isBankToWalletController.sink.add;

  Function(bool?) get changeIsCardRequest => _isCardRequestController.sink.add;

  Function(String?) get changeCardType => cardTypeController.sink.add;

  Function(String?) get changeRequestingBranch =>
      _requestingBranchController.sink.add;

  Function(String?) get changeDestinationBranch =>
      _destinationBranchController.sink.add;

  Function(String?) get changePreferredNameOnCard =>
      _preferredNameOnCardController.sink.add;

  Function(bool) get changeMaritalStatusValue =>
      _isMaritalStatusChangeController.sink.add;

//  Function(bool) get changeIsRequestHardwareToken =>
//      _isRequestHardwareTokenController.sink.add;
//
//  Function(bool) get changeIsRequestInternetBanking =>
//      _isRequestInternetBankingController.sink.add;

  Function(String?) get changeSignature => _uploadSignatureController.sink.add;

  setAccountType(String? value) {
    _accountTypeController.sink.add(value);
  }

  setAccountHolderType(String? value) {
    _accountHolderTypeController.sink.add(value);
  }

  setRiskRankType(String? value) {
    _riskRankController.sink.add(value);
  }

  setAccountCategory(String? value) {
    _accountCategoryController.sink.add(value);
  }

  setDateOfBirth(String? value) {
    _dateOfBirthController.sink.add(value);
  }

  setUploadIdForm(String? value) {
    _uploadIdImageController.sink.add(value);
  }

  setUploadIdForm2(String? value) {
    _uploadIdImageController2.sink.add(value);
  }

  setUploadPassportForm(String? value) {
    _uploadPassportController.sink.add(value);
  }

  setUploadAdmissionLetter(String? value) {
    uploadAdmissionLetterController.sink.add(value);
  }

  setUploadUtilityBillForm(String? value) {
    _uploadUtilityBillController.sink.add(value);
  }

  setUploadResidentPermit(String? value) {
    _uploadResidentPermitController.sink.add(value);
  }

  setSignature(String? value) {
    _uploadSignatureController.sink.add(value);
    changeSignature(value);
  }

  setOccupation(String? value) {
    occupationController.sink.add(value);
    changeOccupation;
  }

  setOccupationCategory(String? value) {
    occupationCategoryController.sink.add(value);
    changeOccupationCategory;
  }

  setCardType(String? value) {
    cardTypeController.sink.add(value);
    changeCardType;
  }

/*
  saveOffline() async {
    var validId = _idController.valueOrNull;
    var validRefenceId = _referenceIdController.valueOrNull;

    var validAccountType = _accountTypeController.valueOrNull;
    final validAccountHolderType =
        _accountHolderTypeController.valueOrNull ?? 'INDIVIDUAL';
    final validAccountRiskRank = _riskRankController.valueOrNull;
    final validAccountCategory = _accountCategoryController.valueOrNull;

    var validTin = _tinController.valueOrNull;
    final validTitle = _titleController.valueOrNull;
    final validSurname = _surnameController.valueOrNull;
    final validFirstName = _firstNameController.valueOrNull;
    var validOtherName = _otherNameController.valueOrNull;
    final validMothersMaidenName = _mothersMaidenNameController.valueOrNull;
    final validDateOfBirth = _dateOfBirthController.valueOrNull;
    final validPlaceOfBirth = _placeOfBirthController.valueOrNull;
    final validMMDA = _mmdaController.valueOrNull;
    final validCountryOfOrigin = _countryOfOriginController.valueOrNull == null
        ? 'GHANA'
        : _countryOfOriginController.valueOrNull; //workaround for bug

    final countryIDIssuer =
        _countryOfIDCountryIssueController.valueOrNull == null
            ? 'GHANA'
            : _countryOfIDCountryIssueController.valueOrNull;

    var validEmail = _emailController.valueOrNull;
    final validPhone = _phoneNumberController.valueOrNull;
    var validLatitude = _latitudeController.valueOrNull;
    var validLongitude = _longitudeController.valueOrNull;
    final validNextOfKin = _nextOfKinController.valueOrNull;
    final validAddress1 = _address1Controller.valueOrNull;
    var validAddress2 = _address2Controller.valueOrNull;
    final validCountryOfResidence =
        _countryOfResidenceController.valueOrNull == null
            ? 'GHANA'
            : _countryOfResidenceController.valueOrNull; //workaround for bug

    final validStateOfResidence = _stateOfResidenceController.valueOrNull;
    final validCityOfResidence = _cityOfResidenceController.valueOrNull;
    final validGender = _genderController.valueOrNull;
    var validOccupation = occupationController.valueOrNull;
    if (validOccupation == "OTHERS") {
      validOccupation = othersOccupationController.valueOrNull;
    }
    final validMaritalStatus = _maritalStatusController.valueOrNull;

    final validIdType = _idTypeController.valueOrNull;
    var validIdIssuer = _idIssuerController.valueOrNull;
    if (validIdIssuer == "OTHERS") {
      validIdIssuer = _idIssuerOthersController.valueOrNull;
    }

    final admmissionNumber = _admissionNoController.valueOrNull;

    final validIdNumber = _idNumberController.valueOrNull;
    final validIdPlaceOfIssue = _idPlaceOfIssueController.valueOrNull;
    final validIdIssueDate = _idIssueDateController.valueOrNull;
    final validIdExpiryDate = _idExpiryDateController.valueOrNull;
//    final validIsSendEmail =
//        _isSendEmailController.value == null ? false : true;
//    final validIsReceiveSms =
//        _isReceiveSmsController.value == null ? false : true;
//    final validIsRequestHardwareToken =
//        _isRequestHardwareTokenController.value == null ? false : true;
//    final validIsRequestInternetBanking =
//        _isRequestInternetBankingController.value == null ? false : true;
    final validIsScanToPay = _isScanToPayController.valueOrNull;
    final validIsZMobile = _isZMobileController.valueOrNull;
    final validIsZPrompt = _isZPromptController.valueOrNull;
    final validIsStatementViaEmail = _isStatementViaEmailController.valueOrNull;
    final validIsUssd = _isUssdController.valueOrNull;
    final validIsBankToWallet = _isBankToWalletController.valueOrNull;

    final validIsCardRequest = _isCardRequestController.valueOrNull;
    final validCardType = cardTypeController.valueOrNull;
    final validRequestingBranch = _requestingBranchController.valueOrNull;
    final validDestinationBranch = _destinationBranchController.valueOrNull;
    final validPreferredNameOnCard = _preferredNameOnCardController.valueOrNull;

    final validUploadIdImageInBase64 = _uploadIdImageController.valueOrNull;
    //  final validUploadIdImage2InBase64 = _uploadIdImageController2.valueOrNull;

    final validUploadPassportInBase64 = _uploadPassportController.valueOrNull;

    final validUploadAdmissionLetterInBase64 =
        uploadAdmissionLetterController.valueOrNull;

    final validUploadUtilityBillInBase64 =
        _uploadUtilityBillController.valueOrNull;

    final validUploadResidentPermitInBase64 =
        _uploadResidentPermitController.valueOrNull;

    final validUploadSignatureInBase64 = _uploadSignatureController.valueOrNull;

    var currentTimeStamp = new DateTime.now().millisecondsSinceEpoch;

    var employeeId = await SecureStorage.getEmployeeId();

    var referenceId;

    if (validRefenceId != null) {
      referenceId = validRefenceId; //for updating accounts.
    } else {
      referenceId = '$employeeId${currentTimeStamp.toString().substring(7)}';
    }

    OfflineAccountEntity _offlineAccount = OfflineAccountEntity(
      id: validId,
      referenceId: referenceId,
      accountType: validAccountType,
      accountHolderType: validAccountHolderType,
      riskRank: validAccountRiskRank,
      accountCategory: validAccountCategory,
      tin: validTin,
      title: validTitle,
      surname: validSurname,
      firstName: validFirstName,
      otherName: validOtherName,
      mothersMaidenName: validMothersMaidenName,
      dateOfBirth: validDateOfBirth,
      stateOfOrigin: "$validStateOfResidence REGION",
      placeOfBirth: validPlaceOfBirth,
      mmda: validMMDA,
      countryOfOrigin: validCountryOfOrigin,
      email: validEmail,
      phone: validPhone,
      nextOfKin: validNextOfKin,
      address1: validAddress1,
      address2: validAddress2,
      countryOfResidence: validCountryOfResidence,
      stateOfResidence: "$validStateOfResidence REGION",
      cityOfResidence: validCityOfResidence,
      gender: validGender,
      latitude: validLatitude,
      longitude: validLongitude,
      occupation: validOccupation,
      maritalStatus: validMaritalStatus,
      idType: validIdType,
      idIssuer: validIdIssuer,
      idNumber: validIdNumber,
      idPlaceOfIssue: validIdPlaceOfIssue,
      idIssueDate: validIdIssueDate,
      idExpiryDate: validIdExpiryDate,
//        isSendEmail: validIsSendEmail,
//        isReceiveAlert: validIsReceiveSms,
//        isRequestHardwareToken: validIsRequestHardwareToken,
//        isRequestInternetBanking: validIsRequestInternetBanking,
      isScanToPay: validIsScanToPay,
      //  == true ? "Y" : "N",
      isZMobile: validIsZMobile,
      // == true ? "Y" : "N",
      isZPrompt: validIsZPrompt,
      // == true ? "Y" : "N",
      isStatementViaEmail: validIsStatementViaEmail,
      // == true ? "Y" : "N",
      isUSSD: validIsUssd,
      // == true ? "Y" : "N",
      isBankToWallet: validIsBankToWallet,
      // == true ? "Y" : "N",

      isCardRequest: validIsCardRequest,
      cardType: validIsCardRequest! ? validCardType : null,
      requestingBranch: validIsCardRequest ? validRequestingBranch : null,
      destinationBranch: validIsCardRequest ? validDestinationBranch : null,
      preferredNameOnCard: validIsCardRequest ? validPreferredNameOnCard : null,
      idCard: validUploadIdImageInBase64,
      passport: validUploadPassportInBase64,
      utility: validUploadUtilityBillInBase64,
      signature: validUploadSignatureInBase64,
    );

    insertFormOffline(_offlineAccount);
  }
*/

  updateAccountCategoryType(String? value) {
    _accountCategoryController.sink.add(value);
    if (value == null) {
      _accountCategoryController.sink.addError("Field is required");
    }
  }

  updateMMDA(String? value) {
    _mmdaController.sink.add(value);
    if (value == null) {
      _mmdaController.sink.addError("Field is required");
    }
  }

  updateIDIssuerType(String? value) {
    _idIssuerController.sink.add(value);
  }

  updateOccupation(String? value) {
    if (value == null) {
      occupationController.sink.addError("Occupation is required");
    } else {
      occupationController.sink.add(value);
    }
  }

  updateOccupationCategory(String? value) {
    if (value == null) {
      occupationCategoryController.sink
          .addError("Occupation category is required");
    } else {
      occupationCategoryController.sink.add(value);
    }
  }

  updateAccountType(String? value) {
    _accountTypeController.sink.add(value);
  }

  updateIdentityType(String? value) {
    _idTypeController.sink.add(value);
  }

/*
  insertFormOffline(OfflineAccountEntity offlineForm) async {
    var isEditMode = _isEditModeController.valueOrNull == null
        ? false
        : _isEditModeController.value;
    try {
      if (isEditMode!) {
        await _accountsRepository.updateAccountOffline(offlineForm);
      } else {
        await _accountsRepository.saveAccountOffline(offlineForm);
      }

      _subjectSaveOfflineAccountResponse.sink
          .add('Account has been saved offline successfully');
    } catch (error) {
      _subjectSaveOfflineAccountResponse.sink.addError(error);
    }
  }


  deleteFormOffline(int id) async {
    try {
      await _accountsRepository.deleteOfflineAccount(id);

      _subjectDeleteOfflineAccountResponse.sink.add('Account has been deleted');
    } catch (error) {
      _subjectDeleteOfflineAccountResponse.sink.addError(error);
    }
  }
  */

  saveForm() async {
    var rowId = databaseRowIDController.valueOrNull;
    var validRefenceId = _referenceIdController.valueOrNull;

    var validAccountType = _accountTypeController.valueOrNull;
    final validAccountHolderType =
        _accountHolderTypeController.valueOrNull ?? 'INDIVIDUAL';
    final validAccountRiskRank = _riskRankController.valueOrNull != null
        ? _riskRankController.valueOrNull
        : '';
    String? validAccountCategory = _accountCategoryController.valueOrNull;

    List<AccountClassEntity> accountClasses =
        await DBProvider.db.getAccountClasses();

    validAccountCategory = accountClasses
        .firstWhere((x) => x.name == validAccountCategory)
        .id
        .toString(); //hotfix: to solve issue of account category filter from account type
    var validTIN = _tinController.valueOrNull;
    final validTitle = _titleController.valueOrNull;
    final validSurname = _surnameController.valueOrNull;
    final validFirstName = _firstNameController.valueOrNull;
    var validOtherName = _otherNameController.valueOrNull;
    final validMothersMaidenName = _mothersMaidenNameController.valueOrNull;
    final validDateOfBirth = _dateOfBirthController.valueOrNull;
//    final validStateOfOrigin = _stateOfOriginController.value;
    final validPlaceOfBirth = _placeOfBirthController.valueOrNull;

    var validMMDA = _mmdaController.valueOrNull;

    final validCountryOfOrigin = _countryOfOriginController.valueOrNull == null
        ? 'GHANA'
        : _countryOfOriginController.valueOrNull; //workaround for bug

    final countryIDIssuer = _countryOfIDCountryIssueController.valueOrNull;

    var validEmail = _emailController.valueOrNull;

    double validLatitude = double.parse(
        _latitudeController.hasValue ? _latitudeController.value : "0");

    double validLongitude = double.parse(
        _longitudeController.hasValue ? _longitudeController.value : "0");

    final validPhone = _phoneNumberController.valueOrNull;

    final validNextOfKin = _nextOfKinController.valueOrNull;
    final validNextOfKinPhone = _nextOfKinPhoneController.valueOrNull;
    final validNextOfKinRelationship =
        _nextOfKinRelationshipController.valueOrNull;

    final validNextOfKinAddress = _nextOfKinAddressController.valueOrNull;

    final nextOfKinGender = _nextOfKinGenderController.valueOrNull;

    final monthlyIncome = _monthlyIncomeController.valueOrNull;
    final homeTown = _homeTownController.valueOrNull;

    final validAddress1 = _address1Controller.valueOrNull;
    var validAddress2 = _address2Controller.valueOrNull;
    final validCountryOfResidence =
        _countryOfResidenceController.valueOrNull == null
            ? 'GHANA'
            : _countryOfResidenceController.valueOrNull; //workaround for bug

    final validStateOfResidence = _stateOfResidenceController.valueOrNull;
    final validCityOfResidence = _cityOfResidenceController.valueOrNull;
    final validGender = _genderController.valueOrNull;
    var validOccupation = occupationController.valueOrNull;
    var validOtherOccupation = othersOccupationController.valueOrNull;
    if (validOccupation == "OTHER (PLEASE SPECIFY)") {
      validOccupation = validOccupation! + "-" + (validOtherOccupation ?? " ");
    }
    final validMaritalStatus = _maritalStatusController.valueOrNull;

    var validIdType = _idTypeController.valueOrNull;
    var validIdIssuer = _idIssuerController.valueOrNull;
    if (validIdIssuer == "OTHERS") {
      validIdIssuer = _idIssuerOthersController.valueOrNull;
    }
    var admissionNo = _admissionNoController.valueOrNull;

    var validIdNumber = _idNumberController.valueOrNull;
    var validIdPlaceOfIssue = _idPlaceOfIssueController.valueOrNull != null
        ? _idPlaceOfIssueController.valueOrNull
        : null;
    var validIdIssueDate = _idIssueDateController.valueOrNull;
    var validIdExpiryDate = _idExpiryDateController.valueOrNull;

    bool idBool = idTypesWithDates.contains(validIdType);

/*
    if(idBool && (validIdIssueDate == null
    || validIdExpiryDate == null)){

    _idIssueDateController.addError("Field is required");
    _idExpiryDateController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("Ensure you enter a valid ID card issue and expiry date");
      return;

    }

     if(validIdType == 'VOTER\'S ID CARD' && validIdIssueDate == null){

    _idIssueDateController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("Ensure you enter a valid ID card issue date");
      return;
      
    }
    
    */

    final validIsScanToPay = _isScanToPayController.valueOrNull;
    final validIsZMobile = _isZMobileController.valueOrNull;
    final validIsZPrompt = _isZPromptController.valueOrNull;
    final validIsStatementViaEmail = _isStatementViaEmailController.valueOrNull;
    final validUSSD = _isUssdController.valueOrNull;
    final validBankToWallet = _isBankToWalletController.valueOrNull;

    final validIsCardRequest = _isCardRequestController.valueOrNull;
    String? validCardType = cardTypeController.valueOrNull;
    String? validRequestingBranch = _requestingBranchController.valueOrNull;
    String? validDestinationBranch = _destinationBranchController.valueOrNull;
    String? validPreferredNameOnCard =
        _preferredNameOnCardController.valueOrNull;

    final validUploadIdImageInBase64 = _uploadIdImageController.valueOrNull;
    final validUploadIdImage2InBase64 = _uploadIdImageController2.valueOrNull;

    final validUploadPassportInBase64 = _uploadPassportController.valueOrNull;

    final validUploadAdmissionLetterInBase64 =
        uploadAdmissionLetterController.valueOrNull;

    final validUploadUtilityBillInBase64 =
        _uploadUtilityBillController.valueOrNull;

    final validUploadResidentPermitInBase64 =
        _uploadResidentPermitController.valueOrNull;

    final validUploadSignatureInBase64 = _uploadSignatureController.valueOrNull;

/*
    if (validAccountType == null) {
      _accountTypeController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected an account type.");
      return;
    }

        if (monthlyIncome == null) {
      _accountTypeController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected an monthly income");
      return;
    }

        if (homeTown == null) {
      _homeTownController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not entered home town");
      return;
    }

    if (validAccountCategory.isEmpty) {
      _accountCategoryController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected an account category.");
      return;
    }

     if (validAccountCategory == 'ASPIRE ACCOUNT' && admissionNo==null) {
      _admissionNoController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("enter Admission number");
      return;
    }

    if (validTitle == null) {
      _titleController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid title");

      return;
    }

    if (validSurname == null) {
      _surnameController.addError("Field is required");
      _subjectSaveAccountResponse.addError("You have not filled in a surname");
      return;
    }

*/

    final anticipatedAmountDepositTran =
        _anticipatedAmountController.valueOrNull;
    final anticipatedNoDepositTran = _anticipatedNoTranController.valueOrNull;
    final anticipatedNoWithdraw =
        _anticipatedWithdrawTranController.valueOrNull;
    final anticipatedAmountWithdraw =
        _anticipatedAmountWithdrawController.valueOrNull;

/*
    if (anticipatedNoDepositTran == null) {
      _anticipatedNoTranController.addError("Field is required");
      _subjectSaveAccountResponse.addError("You have not filled in a Anticipated number of deposit transaction");
      return;
    }
 if (anticipatedAmountDepositTran == null) {
      _anticipatedAmountController.addError("Field is required");
      _anticipatedAmountController.addError("You have not filled in a Anticipated amount of deposit transaction");
      return;
    }

  if (anticipatedNoWithdraw == null) {
      _anticipatedWithdrawTranController.addError("Field is required");
      _anticipatedWithdrawTranController.addError("You have not filled in a Anticipated number of withdrawal transaction");
      return;
    }

if (anticipatedAmountWithdraw == null) {
      _anticipatedAmountWithdrawController.addError("Field is required");
      _anticipatedAmountWithdrawController.addError("You have not filled in a Anticipated amount of deposit transaction");
      return;
    }
    */

    List<TransactionTypes> transactionTypesList = [];
    TransactionTypes transactionTypes = TransactionTypes(
      transactionType: "Deposit",
      transactionCount: anticipatedNoDepositTran.toString(),
      expectedAmount: anticipatedAmountDepositTran.toString(),
    );
    transactionTypesList.add(transactionTypes);
    TransactionTypes withdrawalTransactionTypes = TransactionTypes(
      transactionType: "Withdraw",
      transactionCount: anticipatedNoWithdraw.toString(),
      expectedAmount: anticipatedAmountWithdraw.toString(),
    );

    transactionTypesList.add(withdrawalTransactionTypes);

// Account Purposes

    final salaryProcessing = _salaryProcessingController.valueOrNull;
    final bankingService = _bankingServiceController.valueOrNull;
    final business = _businessController.valueOrNull;
    final singleTransaction = _singleTransactionController.valueOrNull;
    final safeKeeping = _safeKeepingController.valueOrNull;
    final savingAndInvestment = _savingAndInvestmentController.valueOrNull;
    final receipt = _receiptController.valueOrNull;
    final others = _othersController.valueOrNull;
    final othersPurpose = othersPurposeController.valueOrNull;

    List<AccountPurposes> accountPurposeList = [];
    if (salaryProcessing != null && salaryProcessing == true) {
      accountPurposeList.add(AccountPurposes("Salary processing"));
    }
    if (bankingService != null && bankingService == true) {
      accountPurposeList.add(AccountPurposes("Access to banking services"));
    }
    if (business != null && business == true) {
      accountPurposeList.add(AccountPurposes("Business/Transactional"));
    }
    if (singleTransaction != null && singleTransaction == true) {
      accountPurposeList
          .add(AccountPurposes("Facilitation of a single transaction"));
    }
    if (safeKeeping != null && safeKeeping == true) {
      accountPurposeList.add(AccountPurposes("Security/Safekeeping"));
    }
    if (savingAndInvestment != null && savingAndInvestment == true) {
      accountPurposeList.add(AccountPurposes("Savings & Investment"));
    }
    if (receipt != null && receipt == true) {
      accountPurposeList
          .add(AccountPurposes("Receipt of inflows for Personal upkeep"));
    }

    if (others != null && others == true) {
      accountPurposeList.add(AccountPurposes("Other"));
    }

    if (others != null && others == true) {
      if (othersPurpose != null) {
        accountPurposeList.add(AccountPurposes("Other-$othersPurpose"));
      }
    }

// Source of funds

    final salary = _salaryController.valueOrNull;
    final rental = _rentalIncomeController.valueOrNull;
    final personalS = _personalSavingController.valueOrNull;
    final familyFriend = _familyFriendController.valueOrNull;
    final dividends = _dividendsController.valueOrNull;
    final commission = _commissionController.valueOrNull;
    final businessProceed = _businessProceedController.valueOrNull;
    final otherSource = _otherSourceController.valueOrNull;
    final enterOther = enterOtherSourceController.valueOrNull;

    final employmentType = _employmentTypeController.valueOrNull;

    List<SourceOfFundsObj> sourceList = [];
    if (salary != null && salary == true) {
      sourceList.add(SourceOfFundsObj("Salary"));
    }
    if (rental != null && rental == true) {
      sourceList.add(SourceOfFundsObj("Rental Income"));
    }
    if (personalS != null && personalS == true) {
      sourceList.add(SourceOfFundsObj("Personal Savings"));
    }
    if (familyFriend != null && familyFriend == true) {
      sourceList.add(SourceOfFundsObj("Family & Friends"));
    }
    if (dividends != null && dividends == true) {
      sourceList.add(SourceOfFundsObj("Dividends"));
    }
    if (commission != null && commission == true) {
      sourceList.add(SourceOfFundsObj("Commissions"));
    }
    if (businessProceed != null && businessProceed == true) {
      sourceList.add(SourceOfFundsObj("Business Proceeds"));
    }

    if (otherSource != null && otherSource == true) {
      sourceList.add(SourceOfFundsObj("Other"));
    }

    if (otherSource != null && otherSource == true) {
      if (enterOther != null) {
        sourceList.add(SourceOfFundsObj("Other-$enterOther"));
      }
    }

    RegExp regex = new RegExp(pattern as String);

/*
    if (regex.hasMatch(validSurname)) {
      _surnameController.addError("Enter a valid surname");
      _subjectSaveAccountResponse
          .addError("You have not entered a valid surname");
      return;
    }

    if (validFirstName == null) {
      _firstNameController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a valid firstname");

      return;
    }

    if (regex.hasMatch(validFirstName)) {
      _firstNameController.addError("Enter a valid first name");
      _subjectSaveAccountResponse
          .addError("You have not entered in a valid firstname");

      return;
    }

    if (validMothersMaidenName == null) {
      _mothersMaidenNameController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a valid the mother\'s maiden name");

      return;
    }

    if (regex.hasMatch(validMothersMaidenName)) {
      _mothersMaidenNameController
          .addError("Enter a valid mother\'s maiden name");
      _subjectSaveAccountResponse.addError(
          "You have not entered in a valid the mother\'s maiden name");

      return;
    }

    if (validDateOfBirth == null) {
      _dateOfBirthController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid date of birth");

      return;
    }

    if (validPlaceOfBirth == null) {
      _placeOfBirthController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid Place of Birth");

      return;
    }

    if (validMMDA == null) {
      _mmdaController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid MMDA");

      return;
    }

    if (validCountryOfOrigin == null) {
      _countryOfOriginController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid country of origin");

      return;
    }

    if (countryIDIssuer == null) {
      _countryOfIDCountryIssueController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid country of origin");

      return;
    }

    if (validPhone == null) {
      _phoneNumberController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid phone number");

      return;
    }

    if (validNextOfKin == null) {
      _nextOfKinController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a next of kin");

      return;
    }

    if (validNextOfKinPhone == null) {
      _nextOfKinPhoneController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a next of kin phone number");

      return;
    }

    if (validNextOfKinRelationship == null) {
      _nextOfKinRelationshipController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a next of kin relationship");

      return;
    }

    if (nextOfKinGender == null) {
      _nextOfKinGenderController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a next of kin gender");

      return;
    }


    if (regex.hasMatch(validNextOfKin)) {
      _nextOfKinController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a valid next of kin");

      return;
    }
    

    if (employmentType == null) {
      _employmentTypeController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled a employment type");

      return;
    }

    if (validAddress1 == null) {
      _address1Controller.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled a valid main address");

      return;
    }

    if (validCountryOfResidence == null) {
      _countryOfResidenceController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid country of residence");

      return;
    }
    if (validStateOfResidence == null) {
      _stateOfResidenceController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a Region of Residence");
      return;
    }

    if (validCityOfResidence == null) {
      _cityOfResidenceController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid city of residence");
      return;
    }

    if (validGender == null) {
      _genderController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not chosen a valid gender");
      return;
    }

    if (validOccupation == null) {
      occupationController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid occupation");
      return;
    }

    if (validMaritalStatus == null) {
      _maritalStatusController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a marital status");

      return;
    }
*/

    if (validIdType == null && validAccountCategory != easy_classic) {
      /*
      _idTypeController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid ID type");
      return;
      */
    } else if (validIdType == null && validAccountCategory == easy_classic) {
      validIdType = "";
    }

    if (validIdIssuer == null && validAccountCategory != easy_classic) {
/*
      _idIssuerController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled a valid ID Issuer");
      return;
      */
    } else if (validIdIssuer == null && validAccountCategory == easy_classic) {
      validIdIssuer = "";
    }

    if (validIdNumber == null && validAccountCategory != easy_classic) {
      /*
      _idNumberController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid ID number");

      return;
      */
    } else if (validIdNumber == null && validAccountCategory == easy_classic) {
      validIdNumber = "";
    }

    if (validIdPlaceOfIssue == null && validAccountCategory != easy_classic) {
    } else if (validIdPlaceOfIssue == null &&
        validAccountCategory == easy_classic) {
      //  validIdPlaceOfIssue = countryIDIssuer;
    }

    if (validIdIssueDate == null &&
        (validIdType == STUDENT_ID ||
            validIdType == OTHERS ||
            validIdType == SSNIT_CARD)) {
      validIdIssueDate = "";
    } else if (validIdIssueDate != null) {
      validIdIssueDate = validIdIssueDate;
    } else {
      /*
      _idIssueDateController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid issue date");

      return;
      */
    }

    if (validIdExpiryDate == null &&
        (validIdType == STUDENT_ID ||
            validIdType == OTHERS ||
            validIdType == SSNIT_CARD ||
            validIdType == VOTERS_CARD)) {
      validIdExpiryDate = "";
    } else if (validIdExpiryDate != null) {
      validIdExpiryDate = validIdExpiryDate;
    } else {
      /*
      _idExpiryDateController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid expiry date");
      return;
      */
    }

    if (validIsCardRequest == true && validCardType == null) {
      /*
      cardTypeController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid card type");
      return;
      */
    }

    if (validIsCardRequest == true && validRequestingBranch == null) {
      /*
      _requestingBranchController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid requesting branch");
      return;
      */
    }

    if (validIsCardRequest == true && validDestinationBranch == null) {
      /*
      _destinationBranchController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid destination branch");
      return;
      */
    }

    if (validIsCardRequest == true && validPreferredNameOnCard == null) {
      /*
      _preferredNameOnCardController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid preferred name on card");
      return;
      */
    }

    validAccountType = validAccountType != null
        ? validAccountType.startsWith('S')
            ? "SA"
            : "CA"
        : "CA";

    validOtherName = validOtherName != null ? validOtherName : "";

    validAddress2 = validAddress2 != null ? validAddress2 : "";

    validEmail = validEmail != null ? validEmail : "";

    validTIN = validTIN != null ? validTIN : "";

    var validSexAcronym = validGender != null
        ? validGender.startsWith('M')
            ? "M"
            : "F"
        : 'M';

    var validBranchNumber = await SecureStorage.getBranchNumber();
    var employeeId = await SecureStorage.getEmployeeId();

    var encryptedAccountName =
        CryptoHelper.encrypt('$validFirstName $validOtherName $validSurname');

    var currentTimeStamp = new DateTime.now().millisecondsSinceEpoch;

    var referenceId;

    if (validRefenceId != null) {
      referenceId = validRefenceId; //for updating accounts.
    } else {
      referenceId = '$employeeId${currentTimeStamp.toString().substring(7)}';
    }

//    var isAlertRequest = validIsReceiveSms == true ? "Y" : "N";
//    var isTokenRequest = validIsRequestHardwareToken == true ? "Y" : "N";
//    var isIBankRequest = validIsRequestInternetBanking == true ? "Y" : "N";
//    var isEmailStatement = validIsSendEmail == true ? "Y" : "N";
    var isZMobile = validIsZMobile == true ? "Y" : "N";
    var isZprompt = validIsZPrompt == true ? "Y" : "N";
    var isIsStatementViaEmail = validIsStatementViaEmail == true ? "Y" : "N";
    var isScanToPay = validIsScanToPay == true ? "Y" : "N";
    var isUssD = validUSSD == true ? "Y" : "N";
    var isBankToWallet = validBankToWallet == true ? "Y" : "N";
    var isCardRequest = validIsCardRequest == true ? "Y" : "N";

    List<Attachment> _attachments = [];

    Attachment _idCardAttachment;
    Attachment _idCard2Attachment;
    Attachment _passportAttachment;
    Attachment _utilityBillAttachment;
    Attachment _signatoryAttachment;
    Attachment _admissionLetterAttachment;
    Attachment _residentPermitAttachment;

    //  validUploadResidentPermitInBase64

    if (validUploadResidentPermitInBase64 != null) {
      _residentPermitAttachment = new Attachment(
          encodedImage: validUploadResidentPermitInBase64,
          type: 'ResidentPermit');
      _attachments.add(_residentPermitAttachment);
    }

    if (validUploadIdImageInBase64 != null) {
      _idCardAttachment = new Attachment(
          encodedImage: validUploadIdImageInBase64, type: 'IdentityCard');
      _attachments.add(_idCardAttachment);
    }

    if (validUploadIdImage2InBase64 != null) {
      _idCard2Attachment = new Attachment(
          encodedImage: validUploadIdImage2InBase64, type: 'IdentityCard2');
      _attachments.add(_idCard2Attachment);
    }

    if (validUploadPassportInBase64 != null) {
      _passportAttachment = new Attachment(
          encodedImage: validUploadPassportInBase64, type: 'PassportPhoto');
      _attachments.add(_passportAttachment);
    }

    if (validUploadAdmissionLetterInBase64 != null) {
      _admissionLetterAttachment = new Attachment(
          encodedImage: validUploadAdmissionLetterInBase64,
          type: 'AdmissionLetter');
      _attachments.add(_admissionLetterAttachment);
    }

    if (validUploadUtilityBillInBase64 != null) {
      _utilityBillAttachment = new Attachment(
          encodedImage: validUploadUtilityBillInBase64, type: 'UtilityBill');
      _attachments.add(_utilityBillAttachment);
    }

    if (validUploadSignatureInBase64 != null) {
      _signatoryAttachment = new Attachment(
          encodedImage: validUploadSignatureInBase64, type: 'Signatory');
      _attachments.add(_signatoryAttachment);
    }

    SignatoryDetail _signatoryDetail = SignatoryDetail(
      firstName:
          validFirstName != null ? CryptoHelper.encrypt(validFirstName) : null,
      middleName: (validOtherName.isNotEmpty)
          ? CryptoHelper.encrypt(validOtherName)
          : '',
      lastName: validSurname != null ? CryptoHelper.encrypt(validSurname) : "",
      sex: validSexAcronym,
      dateOfBirth: validDateOfBirth != null
          ? CryptoHelper.encrypt(validDateOfBirth)
          : null,
      motherMaidenName: validMothersMaidenName != null
          ? CryptoHelper.encrypt(validMothersMaidenName)
          : null,
      title: validTitle,
      stateOfOrigin: validStateOfResidence,
      countryOfOrigin: validCountryOfOrigin,
      mmda: validMMDA,
      placeOfBirth: validPlaceOfBirth,
      meansOfId: validIdType,
      idNumber: validIdNumber,
      idIssuer: validIdIssuer,
      idPlaceOfIssue: validIdPlaceOfIssue,
      foreignAddress1: countryIDIssuer,
      idIssueDate: validIdIssueDate,
      idExpiryDate: validIdExpiryDate,
      tin: admissionNo,
      occupation: validOccupation,
      addressLine1:
          validAddress1 != null ? CryptoHelper.encrypt(validAddress1) : null,
      addressLine2:
          (validAddress2.isNotEmpty) ? CryptoHelper.encrypt(validAddress2) : '',
      city: validCityOfResidence,
      state: validStateOfResidence,
      emailAddress:
          (validEmail.isNotEmpty) ? CryptoHelper.encrypt(validEmail) : '',
      phoneNumber: validPhone != null ? CryptoHelper.encrypt(validPhone) : '',
      amlCustType: '10',
      amlCustNatureBusiness: '4',
      amlCustNature: '14',
      useEmailForStatement: isIsStatementViaEmail,
      bvn: (validTIN.isNotEmpty) ? CryptoHelper.encrypt(validTIN) : '',
      maritalStatus: validMaritalStatus,
      nextOfKin:
          validNextOfKin != null ? CryptoHelper.encrypt(validNextOfKin) : '',
      nextOfKinPhone: validNextOfKinPhone != null
          ? CryptoHelper.encrypt(validNextOfKinPhone)
          : '',
      nextOfKinGender: nextOfKinGender,
      nextOfKinRelationship: validNextOfKinRelationship != null
          ? CryptoHelper.encrypt(validNextOfKinRelationship)
          : '',

      cerpacRPplaceofIssue: validNextOfKinAddress != null
          ? CryptoHelper.encrypt(validNextOfKinAddress)
          : '',

      homeTown: homeTown, // temporary property
      // temporary property
      //   attachments: null
      attachments: _attachments,
    );

    List<SignatoryDetail> _signatoryDetails = [];
    _signatoryDetails.add(_signatoryDetail);

    AccountForm _accountForm = AccountForm(
        id: rowId,
        accountType: validAccountType,
        accountHolderType: validAccountHolderType,
        classCode: validAccountCategory,
        branchNumber: validBranchNumber,
        phoneNumber: validPhone != null ? CryptoHelper.encrypt(validPhone) : '',
        rsmId: employeeId,
        accountName: encryptedAccountName,
        sex: validSexAcronym,
        title: validTitle,
        dateOfBirth: validDateOfBirth != null
            ? CryptoHelper.encrypt(validDateOfBirth)
            : '',
        dateOfIncorporation: '',
        businessNature: '',
        sector: '',
        industry: '',
        tin: validTIN,
        riskRank: validAccountRiskRank,
        addressLine1:
            validAddress1 != null ? CryptoHelper.encrypt(validAddress1) : '',
        city: validCityOfResidence,
        state: validStateOfResidence,
        countryOfOrigin: validCountryOfOrigin,
        signatoryDetails: _signatoryDetails,
        refId: referenceId,
//        alertZRequest: isAlertRequest,
        masterCardRequest: 'N',
        visaCardRequest: 'N',
        verveCardRequest: 'N',
//        tokenRequest: isTokenRequest,
//        ibankRequest: isIBankRequest,
        scanToPay: isScanToPay,
        zPromptRequest: isZprompt,
        statementByEmailRequest: isIsStatementViaEmail,
        zMobileRequest: isZMobile,
        uSSDRequest: isUssD,
        bankWalletRequest: isBankToWallet,
        cardRequest: isCardRequest,
        cardType: isCardRequest == "Y" ? validCardType : null,
        requestingBranch: isCardRequest == "Y" ? validRequestingBranch : null,
        destinationBranch: isCardRequest == "Y" ? validDestinationBranch : null,
        preferredNameOnCard:
            isCardRequest == "Y" ? validPreferredNameOnCard : null,
        latitude: validLatitude,
        longitude: validLongitude,
        employmentTypes: employmentType,
        monthlyIncome: monthlyIncome,
        accountPurposes: accountPurposeList,
        sourceOfFunds: sourceList,
        transactionTypes: transactionTypesList);

    AccountDatum acct =
        await DBProvider.db.insertAccountFormOffline(_accountForm);
    // sendAccountsToApi(json);
    // int a = await DBProvider.db.deleteAccountDatum(acct.id);
    // int b = await DBProvider.db.deleteAccountFormOffline(acct.id);

    print('Final Object: $json');

    print(
        'Account type is $validAccountType, and Account Holder is $validAccountHolderType, '
        'valid Risk rank $validAccountRiskRank, valid category  = $validAccountCategory, upload id (base 64) - $validUploadIdImageInBase64');
  }

  submit() async {
    var rowId = databaseRowIDController.valueOrNull;
    var validRefenceId = _referenceIdController.valueOrNull;

    var validAccountType = _accountTypeController.valueOrNull;
    final validAccountHolderType =
        _accountHolderTypeController.valueOrNull ?? 'INDIVIDUAL';
    final validAccountRiskRank = _riskRankController.valueOrNull != null
        ? _riskRankController.valueOrNull
        : '';
    String? validAccountCategory = _accountCategoryController.valueOrNull;

    List<AccountClassEntity> accountClasses =
        await DBProvider.db.getAccountClasses();

    validAccountCategory = accountClasses
        .firstWhere((x) => x.name == validAccountCategory)
        .id
        .toString(); //hotfix: to solve issue of account category filter from account type
    var validTIN = _tinController.valueOrNull;
    final validTitle = _titleController.valueOrNull;
    final validSurname = _surnameController.valueOrNull;
    final validFirstName = _firstNameController.valueOrNull;
    var validOtherName = _otherNameController.valueOrNull;
    final validMothersMaidenName = _mothersMaidenNameController.valueOrNull;
    final validDateOfBirth = _dateOfBirthController.valueOrNull;
//    final validStateOfOrigin = _stateOfOriginController.value;
    final validPlaceOfBirth = _placeOfBirthController.valueOrNull;

    var validMMDA = _mmdaController.valueOrNull;

    final validCountryOfOrigin = _countryOfOriginController.valueOrNull == null
        ? 'GHANA'
        : _countryOfOriginController.valueOrNull; //workaround for bug

    final countryIDIssuer = _countryOfIDCountryIssueController.valueOrNull;

    var validEmail = _emailController.valueOrNull;

    double validLatitude = double.parse(
        _latitudeController.hasValue ? _latitudeController.value : "0");

    double validLongitude = double.parse(
        _longitudeController.hasValue ? _longitudeController.value : "0");

    final validPhone = _phoneNumberController.valueOrNull;

    final validNextOfKin = _nextOfKinController.valueOrNull;
    final validNextOfKinPhone = _nextOfKinPhoneController.valueOrNull;
    final validNextOfKinRelationship =
        _nextOfKinRelationshipController.valueOrNull;

    final validNextOfKinAddress = _nextOfKinAddressController.valueOrNull;

    final nextOfKinGender = _nextOfKinGenderController.valueOrNull;

    final monthlyIncome = _monthlyIncomeController.valueOrNull;
    final homeTown = _homeTownController.valueOrNull;

    final validAddress1 = _address1Controller.valueOrNull;
    var validAddress2 = _address2Controller.valueOrNull;
    final validCountryOfResidence =
        _countryOfResidenceController.valueOrNull == null
            ? 'GHANA'
            : _countryOfResidenceController.valueOrNull; //workaround for bug

    final validStateOfResidence = _stateOfResidenceController.valueOrNull;
    final validCityOfResidence = _cityOfResidenceController.valueOrNull;
    final validGender = _genderController.valueOrNull;
    var validOccupation = occupationController.valueOrNull;
    var validOtherOccupation = othersOccupationController.valueOrNull;
    if (validOccupation == "OTHER (PLEASE SPECIFY)") {
      validOccupation = validOccupation! + "-" + (validOtherOccupation ?? " ");
    }
    final validMaritalStatus = _maritalStatusController.valueOrNull;

    var validIdType = _idTypeController.valueOrNull;
    var validIdIssuer = _idIssuerController.valueOrNull;
    if (validIdIssuer == "OTHERS") {
      validIdIssuer = _idIssuerOthersController.valueOrNull;
    }
    var admissionNo = _admissionNoController.valueOrNull;

    var validIdNumber = _idNumberController.valueOrNull;
    var validIdPlaceOfIssue = _idPlaceOfIssueController.valueOrNull != null
        ? _idPlaceOfIssueController.valueOrNull
        : null;
    var validIdIssueDate = _idIssueDateController.valueOrNull;
    var validIdExpiryDate = _idExpiryDateController.valueOrNull;

    bool idBool = idTypesWithDates.contains(validIdType);

    if (idBool && (validIdIssueDate == null || validIdExpiryDate == null)) {
      _idIssueDateController.addError("Field is required");
      _idExpiryDateController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("Ensure you enter a valid ID card issue and expiry date");
      return;
    }

    if (validIdType == 'VOTER\'S ID CARD' && validIdIssueDate == null) {
      _idIssueDateController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("Ensure you enter a valid ID card issue date");
      return;
    }

//    final validIsSendEmail = _isSendEmailController.value;
//    final validIsReceiveSms = _isReceiveSmsController.value;
//    final validIsRequestHardwareToken = _isRequestHardwareTokenController.value;
//    final validIsRequestInternetBanking =
//        _isRequestInternetBankingController.value;
    final validIsScanToPay = _isScanToPayController.valueOrNull;
    final validIsZMobile = _isZMobileController.valueOrNull;
    final validIsZPrompt = _isZPromptController.valueOrNull;
    final validIsStatementViaEmail = _isStatementViaEmailController.valueOrNull;
    final validUSSD = _isUssdController.valueOrNull;
    final validBankToWallet = _isBankToWalletController.valueOrNull;

    final validIsCardRequest = _isCardRequestController.valueOrNull;
    String? validCardType = cardTypeController.valueOrNull;
    String? validRequestingBranch = _requestingBranchController.valueOrNull;
    String? validDestinationBranch = _destinationBranchController.valueOrNull;
    String? validPreferredNameOnCard =
        _preferredNameOnCardController.valueOrNull;

    final validUploadIdImageInBase64 = _uploadIdImageController.valueOrNull;
    final validUploadIdImage2InBase64 = _uploadIdImageController2.valueOrNull;

    final validUploadPassportInBase64 = _uploadPassportController.valueOrNull;

    final validUploadAdmissionLetterInBase64 =
        uploadAdmissionLetterController.valueOrNull;

    final validUploadUtilityBillInBase64 =
        _uploadUtilityBillController.valueOrNull;

    final validUploadResidentPermitInBase64 =
        _uploadResidentPermitController.valueOrNull;

    final validUploadSignatureInBase64 = _uploadSignatureController.valueOrNull;

    if (validAccountType == null) {
      _accountTypeController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected an account type.");
      return;
    }

    if (monthlyIncome == null) {
      _accountTypeController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected an monthly income");
      return;
    }

    if (homeTown == null) {
      _homeTownController.addError("Field is required");
      _subjectSaveAccountResponse.addError("You have not entered home town");
      return;
    }

    // ACCOUNT HOLDER TYPE DEFAULTS TO 'INDIVIDUAL'
    // if (validAccountHolderType == null) {
    //   _accountHolderTypeController.addError("Field is required");
    //   _subjectSaveAccountResponse
    //       .addError("You have not selected a valid account holder type.");
    //   return;
    // }

    if (validAccountRiskRank == null) {
      // _riskRankController.addError("Field is required");
      // _subjectSaveAccountResponse
      //     .addError("You have not selected a risk rank.");
      // return;
    }

    if (validAccountCategory.isEmpty) {
      _accountCategoryController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected an account category.");
      return;
    }

    if (validAccountCategory == 'ASPIRE ACCOUNT' && admissionNo == null) {
      _admissionNoController.addError("Field is required");
      _subjectSaveAccountResponse.addError("enter Admission number");
      return;
    }

    if (validTitle == null) {
      _titleController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid title");

      return;
    }

    if (validSurname == null) {
      _surnameController.addError("Field is required");
      _subjectSaveAccountResponse.addError("You have not filled in a surname");
      return;
    }

    final anticipatedNoDepositTran = _anticipatedNoTranController.valueOrNull;

    if (anticipatedNoDepositTran == null) {
      _anticipatedNoTranController.addError("Field is required");
      _subjectSaveAccountResponse.addError(
          "You have not filled in a Anticipated number of deposit transaction");
      return;
    }
    final anticipatedAmountDepositTran =
        _anticipatedAmountController.valueOrNull;

    if (anticipatedAmountDepositTran == null) {
      _anticipatedAmountController.addError("Field is required");
      _anticipatedAmountController.addError(
          "You have not filled in a Anticipated amount of deposit transaction");
      return;
    }

    final anticipatedNoWithdraw =
        _anticipatedWithdrawTranController.valueOrNull;

    if (anticipatedNoWithdraw == null) {
      _anticipatedWithdrawTranController.addError("Field is required");
      _anticipatedWithdrawTranController.addError(
          "You have not filled in a Anticipated number of withdrawal transaction");
      return;
    }
    final anticipatedAmountWithdraw =
        _anticipatedAmountWithdrawController.valueOrNull;

    if (anticipatedAmountWithdraw == null) {
      _anticipatedAmountWithdrawController.addError("Field is required");
      _anticipatedAmountWithdrawController.addError(
          "You have not filled in a Anticipated amount of deposit transaction");
      return;
    }

    List<TransactionTypes> transactionTypesList = [];
    TransactionTypes transactionTypes = TransactionTypes(
      transactionType: "Deposit",
      transactionCount: anticipatedNoDepositTran.toString(),
      expectedAmount: anticipatedAmountDepositTran.toString(),
    );
    transactionTypesList.add(transactionTypes);
    TransactionTypes withdrawalTransactionTypes = TransactionTypes(
      transactionType: "Withdraw",
      transactionCount: anticipatedNoWithdraw.toString(),
      expectedAmount: anticipatedAmountWithdraw.toString(),
    );

    transactionTypesList.add(withdrawalTransactionTypes);

// Account Purposes

    final salaryProcessing = _salaryProcessingController.valueOrNull;
    final bankingService = _bankingServiceController.valueOrNull;
    final business = _businessController.valueOrNull;
    final singleTransaction = _singleTransactionController.valueOrNull;
    final safeKeeping = _safeKeepingController.valueOrNull;
    final savingAndInvestment = _savingAndInvestmentController.valueOrNull;
    final receipt = _receiptController.valueOrNull;
    final others = _othersController.valueOrNull;
    final othersPurpose = othersPurposeController.valueOrNull;

    List<AccountPurposes> accountPurposeList = [];
    if (salaryProcessing != null && salaryProcessing == true) {
      accountPurposeList.add(AccountPurposes("Salary processing"));
    }
    if (bankingService != null && bankingService == true) {
      accountPurposeList.add(AccountPurposes("Access to banking services"));
    }
    if (business != null && business == true) {
      accountPurposeList.add(AccountPurposes("Business/Transactional"));
    }
    if (singleTransaction != null && singleTransaction == true) {
      accountPurposeList
          .add(AccountPurposes("Facilitation of a single transaction"));
    }
    if (safeKeeping != null && safeKeeping == true) {
      accountPurposeList.add(AccountPurposes("Security/Safekeeping"));
    }
    if (savingAndInvestment != null && savingAndInvestment == true) {
      accountPurposeList.add(AccountPurposes("Savings & Investment"));
    }
    if (receipt != null && receipt == true) {
      accountPurposeList
          .add(AccountPurposes("Receipt of inflows for Personal upkeep"));
    }

    if (others != null && others == true) {
      accountPurposeList.add(AccountPurposes("Other"));
    }

    if (others != null && others == true) {
      if (othersPurpose != null) {
        accountPurposeList.add(AccountPurposes("Other-$othersPurpose"));
      }
    }

// Source of funds

    final salary = _salaryController.valueOrNull;
    final rental = _rentalIncomeController.valueOrNull;
    final personalS = _personalSavingController.valueOrNull;
    final familyFriend = _familyFriendController.valueOrNull;
    final dividends = _dividendsController.valueOrNull;
    final commission = _commissionController.valueOrNull;
    final businessProceed = _businessProceedController.valueOrNull;
    final otherSource = _otherSourceController.valueOrNull;
    final enterOther = enterOtherSourceController.valueOrNull;

    final employmentType = _employmentTypeController.valueOrNull;

    List<SourceOfFundsObj> sourceList = [];
    if (salary != null && salary == true) {
      sourceList.add(SourceOfFundsObj("Salary"));
    }
    if (rental != null && rental == true) {
      sourceList.add(SourceOfFundsObj("Rental Income"));
    }
    if (personalS != null && personalS == true) {
      sourceList.add(SourceOfFundsObj("Personal Savings"));
    }
    if (familyFriend != null && familyFriend == true) {
      sourceList.add(SourceOfFundsObj("Family & Friends"));
    }
    if (dividends != null && dividends == true) {
      sourceList.add(SourceOfFundsObj("Dividends"));
    }
    if (commission != null && commission == true) {
      sourceList.add(SourceOfFundsObj("Commissions"));
    }
    if (businessProceed != null && businessProceed == true) {
      sourceList.add(SourceOfFundsObj("Business Proceeds"));
    }

    if (otherSource != null && otherSource == true) {
      sourceList.add(SourceOfFundsObj("Other"));
    }

    if (otherSource != null && otherSource == true) {
      if (enterOther != null) {
        sourceList.add(SourceOfFundsObj("Other-$enterOther"));
      }
    }

    RegExp regex = new RegExp(pattern as String);

    if (regex.hasMatch(validSurname)) {
      _surnameController.addError("Enter a valid surname");
      _subjectSaveAccountResponse
          .addError("You have not entered a valid surname");
      return;
    }

    if (validFirstName == null) {
      _firstNameController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a valid firstname");

      return;
    }

    if (regex.hasMatch(validFirstName)) {
      _firstNameController.addError("Enter a valid first name");
      _subjectSaveAccountResponse
          .addError("You have not entered in a valid firstname");

      return;
    }

    if (validMothersMaidenName == null) {
      _mothersMaidenNameController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a valid the mother\'s maiden name");

      return;
    }

    if (regex.hasMatch(validMothersMaidenName)) {
      _mothersMaidenNameController
          .addError("Enter a valid mother\'s maiden name");
      _subjectSaveAccountResponse.addError(
          "You have not entered in a valid the mother\'s maiden name");

      return;
    }

    if (validDateOfBirth == null) {
      _dateOfBirthController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid date of birth");

      return;
    }

    if (validPlaceOfBirth == null) {
      _placeOfBirthController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid Place of Birth");

      return;
    }

    if (validMMDA == null) {
      _mmdaController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid MMDA");

      return;
    }

    if (validCountryOfOrigin == null) {
      _countryOfOriginController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid country of origin");

      return;
    }

    if (countryIDIssuer == null) {
      _countryOfIDCountryIssueController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid country of origin");

      return;
    }

    if (validPhone == null) {
      _phoneNumberController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid phone number");

      return;
    }

    if (validNextOfKin == null) {
      _nextOfKinController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a next of kin");

      return;
    }

    if (validNextOfKinPhone == null) {
      _nextOfKinPhoneController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a next of kin phone number");

      return;
    }

    if (validNextOfKinRelationship == null) {
      _nextOfKinRelationshipController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a next of kin relationship");

      return;
    }

    if (validNextOfKinAddress == null) {
      _nextOfKinAddressController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a next of kin Address");

      return;
    }

    if (nextOfKinGender == null) {
      _nextOfKinGenderController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a next of kin gender");

      return;
    }

/*
    if (regex.hasMatch(validNextOfKin)) {
      _nextOfKinController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a valid next of kin");

      return;
    }
    */

    if (employmentType == null) {
      _employmentTypeController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled a employment type");

      return;
    }

    if (validAddress1 == null) {
      _address1Controller.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled a valid main address");

      return;
    }

    if (validCountryOfResidence == null) {
      _countryOfResidenceController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid country of residence");

      return;
    }
    if (validStateOfResidence == null) {
      _stateOfResidenceController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a Region of Residence");
      return;
    }

    if (validCityOfResidence == null) {
      _cityOfResidenceController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid city of residence");
      return;
    }

    if (validGender == null) {
      _genderController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not chosen a valid gender");
      return;
    }

    if (validOccupation == null) {
      occupationController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid occupation");
      return;
    }

    if (validMaritalStatus == null) {
      _maritalStatusController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a marital status");

      return;
    }
    if (validIdType == null && validAccountCategory != easy_classic) {
      _idTypeController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid ID type");
      return;
    } else if (validIdType == null && validAccountCategory == easy_classic) {
      validIdType = "";
    }

    if (validIdIssuer == null && validAccountCategory != easy_classic) {
      _idIssuerController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled a valid ID Issuer");
      return;
    } else if (validIdIssuer == null && validAccountCategory == easy_classic) {
      validIdIssuer = "";
    }

    if (validIdNumber == null && validAccountCategory != easy_classic) {
      _idNumberController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid ID number");

      return;
    } else if (validIdNumber == null && validAccountCategory == easy_classic) {
      validIdNumber = "";
    }

    if (validIdPlaceOfIssue == null && validAccountCategory != easy_classic) {
    } else if (validIdPlaceOfIssue == null &&
        validAccountCategory == easy_classic) {
      //  validIdPlaceOfIssue = countryIDIssuer;
    }

    if (validIdIssueDate == null &&
        (validIdType == STUDENT_ID ||
            validIdType == OTHERS ||
            validIdType == SSNIT_CARD)) {
      validIdIssueDate = "";
    } else if (validIdIssueDate != null) {
      validIdIssueDate = validIdIssueDate;
    } else {
      _idIssueDateController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid issue date");

      return;
    }

    if (validIdExpiryDate == null &&
        (validIdType == STUDENT_ID ||
            validIdType == OTHERS ||
            validIdType == SSNIT_CARD ||
            validIdType == VOTERS_CARD)) {
      validIdExpiryDate = "";
    } else if (validIdExpiryDate != null) {
      validIdExpiryDate = validIdExpiryDate;
    } else {
      _idExpiryDateController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid expiry date");
      return;
    }

    if (validIsCardRequest == true && validCardType == null) {
      cardTypeController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid card type");
      return;
    }

    if (validIsCardRequest == true && validRequestingBranch == null) {
      _requestingBranchController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid requesting branch");
      return;
    }

    if (validIsCardRequest == true && validDestinationBranch == null) {
      _destinationBranchController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid destination branch");
      return;
    }

    if (validIsCardRequest == true && validPreferredNameOnCard == null) {
      _preferredNameOnCardController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected a valid preferred name on card");
      return;
    }

    validAccountType = validAccountType.startsWith('S') ? "SA" : "CA";

    validOtherName = validOtherName != null ? validOtherName : "";

    validAddress2 = validAddress2 != null ? validAddress2 : "";

    validEmail = validEmail != null ? validEmail : "";

    validTIN = validTIN != null ? validTIN : "";

    var validSexAcronym = validGender.startsWith('M') ? "M" : "F";

    var validBranchNumber = await SecureStorage.getBranchNumber();
    var employeeId = await SecureStorage.getEmployeeId();

    var encryptedAccountName =
        CryptoHelper.encrypt('$validFirstName $validOtherName $validSurname');

    var currentTimeStamp = new DateTime.now().millisecondsSinceEpoch;

    var referenceId;

    if (validRefenceId != null) {
      referenceId = validRefenceId; //for updating accounts.
    } else {
      referenceId = '$employeeId${currentTimeStamp.toString().substring(7)}';
    }

//    var isAlertRequest = validIsReceiveSms == true ? "Y" : "N";
//    var isTokenRequest = validIsRequestHardwareToken == true ? "Y" : "N";
//    var isIBankRequest = validIsRequestInternetBanking == true ? "Y" : "N";
//    var isEmailStatement = validIsSendEmail == true ? "Y" : "N";
    var isZMobile = validIsZMobile == true ? "Y" : "N";
    var isZprompt = validIsZPrompt == true ? "Y" : "N";
    var isIsStatementViaEmail = validIsStatementViaEmail == true ? "Y" : "N";
    var isScanToPay = validIsScanToPay == true ? "Y" : "N";
    var isUssD = validUSSD == true ? "Y" : "N";
    var isBankToWallet = validBankToWallet == true ? "Y" : "N";
    var isCardRequest = validIsCardRequest == true ? "Y" : "N";

    List<Attachment> _attachments = [];

    Attachment _idCardAttachment;
    Attachment _idCard2Attachment;
    Attachment _passportAttachment;
    Attachment _utilityBillAttachment;
    Attachment _signatoryAttachment;
    Attachment _admissionLetterAttachment;
    Attachment _residentPermitAttachment;

    //  validUploadResidentPermitInBase64

    if (validUploadResidentPermitInBase64 != null) {
      _residentPermitAttachment = new Attachment(
          encodedImage: validUploadResidentPermitInBase64,
          type: 'ResidentPermit');
      _attachments.add(_residentPermitAttachment);
    }

    if (validUploadIdImageInBase64 != null) {
      _idCardAttachment = new Attachment(
          encodedImage: validUploadIdImageInBase64, type: 'IdentityCard');
      _attachments.add(_idCardAttachment);
    }

    if (validUploadIdImage2InBase64 != null) {
      _idCard2Attachment = new Attachment(
          encodedImage: validUploadIdImage2InBase64, type: 'IdentityCard2');
      _attachments.add(_idCard2Attachment);
    }

    if (validUploadPassportInBase64 != null) {
      _passportAttachment = new Attachment(
          encodedImage: validUploadPassportInBase64, type: 'PassportPhoto');
      _attachments.add(_passportAttachment);
    }

    if (validUploadAdmissionLetterInBase64 != null) {
      _admissionLetterAttachment = new Attachment(
          encodedImage: validUploadAdmissionLetterInBase64,
          type: 'AdmissionLetter');
      _attachments.add(_admissionLetterAttachment);
    }

    if (validUploadUtilityBillInBase64 != null) {
      _utilityBillAttachment = new Attachment(
          encodedImage: validUploadUtilityBillInBase64, type: 'UtilityBill');
      _attachments.add(_utilityBillAttachment);
    }

    if (validUploadSignatureInBase64 != null) {
      _signatoryAttachment = new Attachment(
          encodedImage: validUploadSignatureInBase64, type: 'Signatory');
      _attachments.add(_signatoryAttachment);
    }

    SignatoryDetail _signatoryDetail = SignatoryDetail(
      firstName: CryptoHelper.encrypt(validFirstName),
      middleName: (validOtherName.isNotEmpty)
          ? CryptoHelper.encrypt(validOtherName)
          : '',
      lastName: CryptoHelper.encrypt(validSurname),
      sex: validSexAcronym,
      dateOfBirth: CryptoHelper.encrypt(validDateOfBirth),
      motherMaidenName: CryptoHelper.encrypt(validMothersMaidenName),
      title: validTitle,
      stateOfOrigin: validStateOfResidence,
      countryOfOrigin: validCountryOfOrigin,
      mmda: validMMDA,
      placeOfBirth: validPlaceOfBirth,
      meansOfId: validIdType,
      idNumber: validIdNumber,
      idIssuer: validIdIssuer,
      idPlaceOfIssue: validIdPlaceOfIssue,
      foreignAddress1: countryIDIssuer,
      idIssueDate: validIdIssueDate,
      idExpiryDate: validIdExpiryDate,
      tin: admissionNo,
      occupation: validOccupation,
      addressLine1: CryptoHelper.encrypt(validAddress1),
      addressLine2:
          (validAddress2.isNotEmpty) ? CryptoHelper.encrypt(validAddress2) : '',
      city: validCityOfResidence,
      state: validStateOfResidence,
      emailAddress:
          (validEmail.isNotEmpty) ? CryptoHelper.encrypt(validEmail) : '',
      phoneNumber: CryptoHelper.encrypt(validPhone),
      amlCustType: '10',
      amlCustNatureBusiness: '4',
      amlCustNature: '14',
      useEmailForStatement: isIsStatementViaEmail,
      bvn: (validTIN.isNotEmpty) ? CryptoHelper.encrypt(validTIN) : '',
      maritalStatus: validMaritalStatus,
      nextOfKin: CryptoHelper.encrypt(validNextOfKin),
      nextOfKinPhone: CryptoHelper.encrypt(validNextOfKinPhone),
      nextOfKinGender: nextOfKinGender,
      nextOfKinRelationship: CryptoHelper.encrypt(validNextOfKinRelationship),

      cerpacRPplaceofIssue: CryptoHelper.encrypt(validNextOfKinAddress),

      homeTown: homeTown, // temporary property
      // temporary property
      //   attachments: null
      attachments: _attachments,
    );

    List<SignatoryDetail> _signatoryDetails = [];
    _signatoryDetails.add(_signatoryDetail);

    AccountForm _accountForm = AccountForm(
        accountType: validAccountType,
        accountHolderType: validAccountHolderType,
        classCode: validAccountCategory,
        branchNumber: validBranchNumber,
        phoneNumber: CryptoHelper.encrypt(validPhone),
        rsmId: employeeId,
        accountName: encryptedAccountName,
        sex: validSexAcronym,
        title: validTitle,
        dateOfBirth: CryptoHelper.encrypt(validDateOfBirth),
        dateOfIncorporation: '',
        businessNature: '',
        sector: '',
        industry: '',
        tin: validTIN,
        riskRank: validAccountRiskRank,
        addressLine1: CryptoHelper.encrypt(validAddress1),
        city: validCityOfResidence,
        state: validStateOfResidence,
        countryOfOrigin: validCountryOfOrigin,
        signatoryDetails: _signatoryDetails,
        refId: referenceId,
//        alertZRequest: isAlertRequest,
        masterCardRequest: 'N',
        visaCardRequest: 'N',
        verveCardRequest: 'N',
//        tokenRequest: isTokenRequest,
//        ibankRequest: isIBankRequest,
        scanToPay: isScanToPay,
        zPromptRequest: isZprompt,
        statementByEmailRequest: isIsStatementViaEmail,
        zMobileRequest: isZMobile,
        uSSDRequest: isUssD,
        bankWalletRequest: isBankToWallet,
        cardRequest: isCardRequest,
        cardType: isCardRequest == "Y" ? validCardType : null,
        requestingBranch: isCardRequest == "Y" ? validRequestingBranch : null,
        destinationBranch: isCardRequest == "Y" ? validDestinationBranch : null,
        preferredNameOnCard:
            isCardRequest == "Y" ? validPreferredNameOnCard : null,
        latitude: validLatitude,
        longitude: validLongitude,
        employmentTypes: employmentType,
        monthlyIncome: monthlyIncome,
        accountPurposes: accountPurposeList,
        sourceOfFunds: sourceList,
        transactionTypes: transactionTypesList);
    // String bdh= _accountForm.toJson().toString();
    String json = jsonEncode(_accountForm);

    log('Final Object: $json');

    sendAccountsToApi(json);

    if (rowId != null) {
      int a = await DBProvider.db.deleteAccountDatum(rowId!);
      int b = await DBProvider.db.deleteAccountFormOffline(rowId!);
    }

    //  print('Final Object: $json');

    print(
        'Account type is $validAccountType, and Account Holder is $validAccountHolderType, '
        'valid Risk rank $validAccountRiskRank, valid category  = $validAccountCategory, upload id (base 64) - $validUploadIdImageInBase64');
  }

  BehaviorSubject<SaveAccountResponse> get subjectSaveAccountResponse =>
      _subjectSaveAccountResponse;

  PublishSubject<String> get subjectSaveOfflineAccountResponse =>
      _subjectSaveOfflineAccountResponse;

  PublishSubject<String> get subjectDeleteOfflineAccountResponse =>
      _subjectDeleteOfflineAccountResponse;

  PublishSubject<AccountDetailsResponse> get subjectAccountsDetailsResponse =>
      _subjectAccountsDetailsResponse;

  BehaviorSubject<String?> get uploadIdImageController =>
      _uploadIdImageController;

  BehaviorSubject<String?> get uploadIdImageController2 =>
      _uploadIdImageController2;

  BehaviorSubject<String?> get uploadUtilityBillController =>
      _uploadUtilityBillController;

  BehaviorSubject<String?> get uploadResidentPermitController =>
      _uploadResidentPermitController;

  BehaviorSubject<String?> get uploadPassportController =>
      _uploadPassportController;

  BehaviorSubject<String?> get uploadAdmLetterController =>
      uploadAdmissionLetterController;

  BehaviorSubject<String?> get uploadSignatureController =>
      _uploadSignatureController;

  sendAccountsToApi(String encodedAccount) async {
    try {
      SaveAccountResponse response =
          await _accountsRepository.attemptSubmitAccountToApi(encodedAccount);

      var offlineId = _idController.valueOrNull;
      if (offlineId != null) {
        //  await _accountsRepository.deleteOfflineAccount(offlineId);
      }

      _subjectSaveAccountResponse.sink.add(response);
    } catch (error) {
      _subjectSaveAccountResponse.sink.addError(error);
    }
  }

  verifyBvn() async {
    var encodedBVN = CryptoHelper.encrypt(_tinController.valueOrNull!);

    await _accountsRepository.verifyBvn(encodedBVN).then((bvnResponse) {
      bvnVerificationResponse.add(bvnResponse);

      if (bvnResponse.responseCode == '00') {
        if (bvnResponse.lastName != null && bvnResponse.lastName!.isNotEmpty) {
          _surnameController.add(CryptoHelper.decrypt(bvnResponse.lastName!));
          bvnlastNameValue = bvnResponse.lastName != null ? false : true;
        }
        if (bvnResponse.firstName != null &&
            bvnResponse.firstName!.isNotEmpty) {
          _firstNameController
              .add(CryptoHelper.decrypt(bvnResponse.firstName!));
          bvnFirstName = bvnResponse.firstName!.isNotEmpty ? false : true;
        }
        if (bvnResponse.middleName != null &&
            bvnResponse.middleName!.isNotEmpty) {
          _otherNameController
              .add(CryptoHelper.decrypt(bvnResponse.middleName!));
          bvnOtherName = bvnResponse.email!.isNotEmpty ? false : true;
        }
        if (bvnResponse.email != null && bvnResponse.email!.isNotEmpty) {
          _emailController.add(CryptoHelper.decrypt(bvnResponse.email!));
          bvnEmail = bvnResponse.email!.isNotEmpty ? false : true;
        }
        if (bvnResponse.title != null && bvnResponse.title.isNotEmpty) {
          _titleController.add(bvnResponse.title);
          bvnTitle = bvnResponse.title.isNotEmpty ? false : true;
        }
        if (bvnResponse.dateOfBirth != null &&
            bvnResponse.dateOfBirth!.isNotEmpty) {
          _dateOfBirthController
              .add(CryptoHelper.decrypt(bvnResponse.dateOfBirth!));

          bvnDateOfBirths = bvnResponse.dateOfBirth!.isNotEmpty ? false : true;
          _isDateOfBirthChangeController.add(bvnDateOfBirths);
        }
        if (bvnResponse.gender != null && bvnResponse.gender!.isNotEmpty) {
          _genderController.add(bvnResponse.gender);
          bvnGender = bvnResponse.gender!.isNotEmpty ? false : true;
          _isGenderChangeController.add(bvnGender);
        }
        if (bvnResponse.phoneNumber != null &&
            bvnResponse.phoneNumber!.isNotEmpty) {
          var decryptedPhone = CryptoHelper.decrypt(bvnResponse.phoneNumber!);
          if (decryptedPhone.startsWith('0')) {
            decryptedPhone = decryptedPhone.replaceFirst('0', '');
            _phoneNumberController.add(decryptedPhone);
            bvnPhone = bvnResponse.phoneNumber!.isNotEmpty ? false : true;
          }
        }
        if (bvnResponse.stateOfOrigin != null &&
            bvnResponse.stateOfOrigin!.isNotEmpty) {
          _stateOfResidenceController
              .add(bvnResponse.stateOfOrigin!.toUpperCase());
          bvnState = bvnResponse.phoneNumber!.isNotEmpty ? false : true;
          _isStateOfOriginChangeController.add(bvnState);
        }
        if (bvnResponse.maritalStatus != null &&
            bvnResponse.maritalStatus!.isNotEmpty) {
          _maritalStatusController.add(bvnResponse.maritalStatus);
          bvnMaritalStatus =
              bvnResponse.maritalStatus!.isNotEmpty ? false : true;
          _isMaritalStatusChangeController.add(bvnMaritalStatus);
        }
        if (bvnResponse.residentialAddress != null &&
            bvnResponse.residentialAddress!.isNotEmpty) {
          _address1Controller
              .add(CryptoHelper.decrypt(bvnResponse.residentialAddress!));
          bvnResidentialAddress =
              bvnResponse.residentialAddress!.isNotEmpty ? false : true;
        }
        if (bvnResponse.stateOfResidence != null &&
            bvnResponse.stateOfResidence!.isNotEmpty) {
          _stateOfResidenceController.add(bvnResponse.stateOfResidence);
          bvnStateOfResidence =
              bvnResponse.stateOfResidence!.isNotEmpty ? false : true;
          _isStateOfResidenceChangeController.add(bvnStateOfResidence);
        }
      } else {
        bvnVerificationResponse.addError('Could not verify the BVN provided. ');
      }
    }).catchError((error) {
      bvnVerificationResponse.addError(error);
    });
  }

  setCurrentFormCategory(Category category) {
    // changeFormCategory(category);
    _currentFormCategoryController.sink.add(category);
  }

  final _placeController = BehaviorSubject<List<Prediction>>();
  Stream<List<Prediction>> get place => _placeController.stream;

  getPlaces(String place) async {
    try {
      List<Prediction> prediction = await ZenithBankApi().fetchPlaces(place);
      if (prediction.length != 0) {
        _placeController.sink.add(prediction);
      }
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      final Location location = Location();

      LocationData _location;
      late StreamSubscription<LocationData> _locationSubscription;
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return null;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }

      _location = await location.getLocation();

      _locationSubscription =
          location.onLocationChanged.handleError((dynamic err) {
        _locationSubscription.cancel();
      }).listen((LocationData currentLocation) {
        _location = currentLocation;
        // return currentLocation;
      });
      _subjectLocation.sink.add(_location);
      _latitudeController.sink.add(_location.latitude.toString());
      _longitudeController.sink.add(_location.longitude.toString());
    } catch (error) {
      _subjectLocation.sink.addError(error);
    }
  }

  verifyNumber(int idType) async {
    driverLicenseVerificationResponse = PublishSubject<VerifyIdResponse>();
    // var encodedBVN = CryptoHelper.encrypt(_idNumberController.value);
    var identity = _idNumberController.valueOrNull;

    await _accountsRepository
        .verifyIdentity(identity, idType)
        .then((identityResponse) {
      driverLicenseVerificationResponse.add(identityResponse);

      if (identityResponse.responseCode == '200') {
        // print(CryptoHelper.decrypt("bNxR3JQR9SQLUZZydVzQuw=="));
        // print(CryptoHelper.decrypt("rOSmtmXdFkOWi1rRBsQ/aA=="));
        // print(CryptoHelper.decrypt("VW+vu5PSeRRqxIHk6Gkj5w=="));
        // print(CryptoHelper.decrypt("mowRSoiP3yiJ7vxaoRqUfQ=="));
        // print(CryptoHelper.decrypt("cAjVqZrxDJO01zjVe4SV6Q=="));
        // print(CryptoHelper.decrypt(
        //     "m/p8hrMIVm76MoR7fpGSfqqKGnt2e7zOUt5EFdEJfoQ="));
        print(CryptoHelper.decrypt(identityResponse.fullName!));

        print(identityResponse.photo);
      } else {
        driverLicenseVerificationResponse
            .addError('Could not verify the Driver License provided. ');
      }
    }).catchError((error) {
      driverLicenseVerificationResponse.addError(error);
    });
  }

  @override
  dispose() {
    _subjectSaveOfflineAccountResponse.close();
    _subjectSaveAccountResponse.close();
    _accountTypeController.close();
    _accountHolderTypeController.close();
    _riskRankController.close();
    _accountCategoryController.close();
    _tinController.close();
    _titleController.close();
    _purposeOfAcctController.close();
    _transactionTypeController.close();

    _monthlyIncomeController.close();
    _sourceOfFundController.close();
    _showOtherOccupationController.close();
    _editableFormController.close();

    _anticipatedNoTranController.close();
    _employmentTypeController.close();
    _anticipatedWithdrawTranController.close();
    _anticipatedAmountWithdrawController.close();

    _surnameController.close();
    _firstNameController.close();
    _otherNameController.close();
    _mothersMaidenNameController.close();
    _dateOfBirthController.close();
    _placeOfBirthController.close();
    _homeTownController.close();
    _mmdaController.close();
    _countryOfOriginController.close();
    _countryOfIDCountryIssueController.close();

    _anticipatedAmountController.close();

    _salaryProcessingController.close();
    _rentalIncomeController.close();
    _personalSavingController.close();
    _familyFriendController.close();
    _dividendsController.close();
    _commissionController.close();
    _businessProceedController.close();
    _othersController.close();
    othersPurposeController.close();
    _salaryProcessingController.close();
    _businessController.close();
    _singleTransactionController.close();
    _safeKeepingController.close();
    _savingAndInvestmentController.close();
    _receiptController.close();
    _salaryController.close();
    _bankingServiceController.close();
    _otherSourceController.close();
    enterOtherSourceController.close();

    _emailController.close();
    _phoneNumberController.close();
    _nextOfKinController.close();

    _nextOfKinRelationshipController.close();
    _nextOfKinAddressController.close();
    _nextOfKinPhoneController.close();
    _nextOfKinGenderController.close();

    _address1Controller.close();
    _subjectLocation.close();
    _latitudeController.close();
    _longitudeController.close();
    _address2Controller.close();
    _countryOfResidenceController.close();
    _stateOfResidenceController.close();
    _cityOfResidenceController.close();
    _genderController.close();
    occupationController.close();
    occupationCategoryController.close();
    _maritalStatusController.close();
    _idTypeController.close();
    _idIssuerController.close();
    _idIssuerOthersController.close();
    _admissionNoController.close();

    othersOccupationController.close();
    _idNumberController.close();
    _idPlaceOfIssueController.close();
    _idIssueDateController.close();
    _idExpiryDateController.close();
    _isScanToPayController.close();
    _isZMobileController.close();
    _isZPromptController.close();
    _isStatementViaEmailController.close();
    _isUssdController.close();
    _isBankToWalletController.close();

    _isCardRequestController.close();
    cardTypeController.close();
    _requestingBranchController.close();
    _destinationBranchController.close();
    _preferredNameOnCardController.close();
    _uploadIdImageController.close();
    _uploadIdImageController2.close();
    _uploadPassportController.close();
    uploadAdmissionLetterController.close();
    _uploadUtilityBillController.close();
    _uploadResidentPermitController.close();
    _uploadSignatureController.close();
    bvnVerificationResponse.close();
    _subjectAccountsDetailsResponse.close();
    _referenceIdController.close();
    uploadSignatureController.close();
    _subjectOfflineDetailsResponse.close();
    _isEditModeController.close();
    _idController.close();
    _subjectDeleteOfflineAccountResponse.close();
    _currentFormCategoryController.close();

    _placeController.close();
  }

  final PublishSubject<String> _subjectOfflineDetailsResponse =
      PublishSubject<String>();

  PublishSubject<String> get subjectOfflineDetailsResponse =>
      _subjectOfflineDetailsResponse;

  getSavedAccountFormDetailsByRefId(String? referenceId) async {
    _isEditModeController.add(true);

    await _accountsRepository
        .getSavedAccountFormByRefId(int.parse(referenceId!))
        .then((offlineAccount) async {
      if (offlineAccount != null) {
        databaseRowIDController.add(int.parse(referenceId!));
        //  databaseRowIDController.sink.add(id);
        if (offlineAccount.accountType == 'SA') {
          _accountTypeController.add('SAVINGS ACCOUNT');
        } else {
          _accountTypeController.add('CURRENT ACCOUNT');
        }

        _accountHolderTypeController.add('INDIVIDUAL');
        if (offlineAccount!.riskRank != null &&
            offlineAccount.riskRank!.isNotEmpty) {
          _riskRankController.add(offlineAccount.riskRank);
        }

        if (offlineAccount.signatoryDetails?.first.mmda != null &&
            offlineAccount.signatoryDetails!.first.mmda!.isNotEmpty) {
          try {
            List<StateEntity> states = await DBProvider.db.getStates();

            print("REPORT " + offlineAccount.signatoryDetails!.first.mmda!);

            _mmdaController.add(offlineAccount.signatoryDetails?.first.mmda!);
          } catch (err) {
            _mmdaController.add(offlineAccount.classCode);
          }
        }
        if (offlineAccount.signatoryDetails?.first.placeOfBirth != null &&
            offlineAccount.signatoryDetails!.first.placeOfBirth!.isNotEmpty) {}
        if (offlineAccount.classCode != null &&
            offlineAccount.classCode!.isNotEmpty) {
          print('log class code ${offlineAccount.classCode}');

          try {
            List<AccountClassEntity> accountClasses =
                await DBProvider.db.getAccountClasses();

            var accountCategory = accountClasses
                .firstWhere((x) => x.id.toString() == offlineAccount.classCode)
                .name
                .toString();

            _accountCategoryController.add(accountCategory);
          } catch (err) {
            _accountCategoryController.add(offlineAccount.classCode);
          }
        }
        if (offlineAccount.tin != null && offlineAccount.tin!.isNotEmpty) {
          _tinController.add(offlineAccount.tin);
        }

        if (offlineAccount.title != null && offlineAccount.title!.isNotEmpty) {
          _titleController.add(offlineAccount.title);
        }
        if (offlineAccount.signatoryDetails.first.lastName != null &&
            offlineAccount.signatoryDetails!.first.lastName!.isNotEmpty) {
          _surnameController.add(CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.lastName!));
        }
        if (offlineAccount.signatoryDetails?.first.firstName != null &&
            offlineAccount.signatoryDetails!.first.firstName!.isNotEmpty) {
          _firstNameController.add(CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.firstName!));
        }

        if (offlineAccount.signatoryDetails?.first.tin != null &&
            offlineAccount.signatoryDetails!.first.tin!.isNotEmpty) {
          _admissionNoController
              .add(offlineAccount.signatoryDetails!.first.tin!);
        }

        if (offlineAccount.signatoryDetails?.first.middleName != null &&
            offlineAccount.signatoryDetails!.first.middleName!.isNotEmpty) {
          _otherNameController.add(CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.middleName!));
        }

//        if (accountResponse.data.signatoryDetails?.first?.middleName != null &&
//            accountResponse.data.signatoryDetails.first.middleName.isNotEmpty) {
//          _otherNameController.add(CryptoHelper.decrypt(
//              accountResponse.data.signatoryDetails.first.middleName));
//        }

        if (offlineAccount.signatoryDetails?.first.nextOfKinPhone != null &&
            offlineAccount.signatoryDetails!.first.nextOfKinPhone!.isNotEmpty) {
          String dd = CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.nextOfKinPhone!);

          _nextOfKinPhoneController.add(CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.nextOfKinPhone!));
        }

        if (offlineAccount.signatoryDetails?.first.nextOfKinRelationship !=
                null &&
            offlineAccount
                .signatoryDetails!.first.nextOfKinRelationship!.isNotEmpty) {
          String dd = CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.nextOfKinRelationship!);

          _nextOfKinRelationshipController.add(CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.nextOfKinRelationship!));
        }

        if (offlineAccount.signatoryDetails?.first.cerpacRPplaceofIssue !=
                null &&
            offlineAccount
                .signatoryDetails!.first.cerpacRPplaceofIssue!.isNotEmpty) {
          String dd = CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.cerpacRPplaceofIssue!);

          _nextOfKinAddressController.add(CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.cerpacRPplaceofIssue!));
        }

        if (offlineAccount.signatoryDetails?.first.nextOfKinGender != null &&
            offlineAccount
                .signatoryDetails!.first.nextOfKinGender!.isNotEmpty) {
          _nextOfKinGenderController
              .add(offlineAccount.signatoryDetails!.first.nextOfKinGender!);
        }

        if (offlineAccount.monthlyIncome != null &&
            offlineAccount.monthlyIncome!.isNotEmpty) {
          _monthlyIncomeController.add(offlineAccount.monthlyIncome!);
        }

        if (offlineAccount.signatoryDetails?.first.homeTown != null &&
            offlineAccount.signatoryDetails!.first.homeTown!.isNotEmpty) {
          _homeTownController
              .add(offlineAccount.signatoryDetails!.first.homeTown!);
        }

        if (offlineAccount.signatoryDetails?.first.motherMaidenName != null &&
            offlineAccount
                .signatoryDetails!.first.motherMaidenName!.isNotEmpty) {
          _mothersMaidenNameController.add(CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.motherMaidenName!));
        }

        if (offlineAccount.signatoryDetails?.first.dateOfBirth != null &&
            offlineAccount.signatoryDetails!.first.dateOfBirth!.isNotEmpty) {
          _dateOfBirthController.add(CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.dateOfBirth!));
        }

//        if (accountResponse.data.signatoryDetails?.first?.dateOfBirth != null &&
//            accountResponse
//                .data.signatoryDetails.first.dateOfBirth.isNotEmpty) {
//          _dateOfBirthController.add(CryptoHelper.decrypt(
//              accountResponse.data.signatoryDetails.first.dateOfBirth));
//        }

        if (offlineAccount.signatoryDetails?.first.stateOfOrigin != null &&
            offlineAccount.signatoryDetails!.first.stateOfOrigin!.isNotEmpty) {
          //    print("REPORT " + offlineAccount.signatoryDetails!.first.stateOfOrigin!);
          _placeOfBirthController
              .add(offlineAccount.signatoryDetails!.first.stateOfOrigin!);
        }

        if (offlineAccount.signatoryDetails?.first.stateOfOrigin != null &&
            offlineAccount.signatoryDetails!.first.stateOfOrigin!.isNotEmpty) {
          //    print("REPORT " + offlineAccount.signatoryDetails!.first.stateOfOrigin!);
          _placeOfBirthController
              .add(offlineAccount.signatoryDetails!.first.stateOfOrigin!);
        }

        //   _countryOfOriginController.add('GHANA');

        if (offlineAccount.countryOfOrigin != null &&
            offlineAccount.countryOfOrigin!.isNotEmpty) {
          //     print("TIN " + offlineAccount.tin);
          countryOfResident = offlineAccount.countryOfOrigin;
          _countryOfOriginController.add(offlineAccount.countryOfOrigin);
        }

        if (offlineAccount.signatoryDetails?.first.emailAddress != null &&
            offlineAccount.signatoryDetails!.first.emailAddress!.isNotEmpty) {
          _emailController.add(CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.emailAddress!));
        }

        if (offlineAccount.signatoryDetails?.first.phoneNumber != null &&
            offlineAccount.signatoryDetails!.first.phoneNumber!.isNotEmpty) {
          String bgd = CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.phoneNumber!);
          _phoneNumberController.add(CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.phoneNumber!));
        }

        if (offlineAccount.signatoryDetails?.first.nextOfKin != null &&
            offlineAccount.signatoryDetails!.first.nextOfKin!.isNotEmpty) {
          String ggds = CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.nextOfKin!);

          _nextOfKinController.add(CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.nextOfKin!));
        }

        if (offlineAccount.signatoryDetails?.first.addressLine1 != null &&
            offlineAccount.signatoryDetails!.first.addressLine1!.isNotEmpty) {
          _address1Controller.add(CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.addressLine1!));
        }

        if (offlineAccount.signatoryDetails?.first.addressLine2 != null &&
            offlineAccount.signatoryDetails!.first.addressLine2!.isNotEmpty) {
          _address2Controller.add(CryptoHelper.decrypt(
              offlineAccount.signatoryDetails!.first.addressLine2!));
        }
        _countryOfResidenceController.add('GHANA');

        if (offlineAccount.signatoryDetails?.first.state != null &&
            offlineAccount.signatoryDetails!.first.state!.isNotEmpty) {
          _stateOfResidenceController
              .add(offlineAccount.signatoryDetails!.first.state);
        }

        if (offlineAccount.cardType != null &&
            offlineAccount.cardType!.isNotEmpty) {
          cardTypeController.add(offlineAccount.cardType);
        }

        if (offlineAccount.requestingBranch != null &&
            offlineAccount.requestingBranch!.isNotEmpty) {
          _requestingBranchController.add(offlineAccount.requestingBranch);
        }

        if (offlineAccount.employmentTypes != null &&
            offlineAccount.employmentTypes!.isNotEmpty) {
          _employmentTypeController.add(offlineAccount.employmentTypes);
        }

        List<AccountPurposes>? acctPurposes = offlineAccount.accountPurposes;
        if (acctPurposes != null) {
          for (AccountPurposes acct in acctPurposes) {
            switch (acct.accountPurpose!.toLowerCase()) {
              case 'salary processing':
                _salaryProcessingController.add(true);
                break;
              case 'access to banking services':
                _bankingServiceController.add(true);
                break;
              case 'business/transactional':
                _businessController.add(true);
                break;
              case 'facilitation of a single transaction':
                _singleTransactionController.add(true);
                break;
              case 'security/safekeeping':
                _safeKeepingController.add(true);
                break;
              case 'savings & investment':
                _savingAndInvestmentController.add(true);
                break;
              case 'receipt of inflows for personal upkeep':
                _receiptController.add(true);
                break;
              case 'other':
                _othersController.add(true);
                break;
              default:
                {
                  if (acct.accountPurpose!.toLowerCase().contains("other-")) {
                    List otherP = acct.accountPurpose!.split('-');
                    othersPurposeController.add(otherP[1]);
                  }
                }
            }
          }
        }

        List<SourceOfFundsObj>? sourceFunds = offlineAccount.sourceOfFunds;
        if (sourceFunds != null) {
          for (SourceOfFundsObj srcF in sourceFunds) {
            switch (srcF.sourceOfFunds!.toLowerCase()) {
              case 'salary':
                _salaryController.add(true);
                break;
              case 'rental income':
                _rentalIncomeController.add(true);
                break;
              case 'personal savings':
                _personalSavingController.add(true);
                break;
              case 'family & friends':
                _familyFriendController.add(true);
                break;
              case 'dividends':
                _dividendsController.add(true);
                break;
              case 'commissions':
                _commissionController.add(true);
                break;
              case 'business proceeds':
                _businessProceedController.add(true);
                break;
              case 'other':
                _otherSourceController.add(true);
                break;
              default:
                {
                  if (srcF.sourceOfFunds!.toLowerCase().contains("other-")) {
                    List otherP = srcF.sourceOfFunds!.split('-');
                    enterOtherSourceController.add(otherP[1]);
                  }
                }
            }
          }
        }

        List<TransactionTypes>? transTypes = offlineAccount.transactionTypes;
        if (transTypes != null) {
          for (TransactionTypes trans in transTypes) {
            if (trans.transactionType!.toLowerCase() == "deposit") {
              _anticipatedNoTranController.add(trans.transactionCount);
              _anticipatedAmountController.add(trans.expectedAmount);
            } else {
              _anticipatedWithdrawTranController.add(trans.transactionCount);
              _anticipatedAmountWithdrawController.add(trans.expectedAmount);
            }
          }
        }

        if (offlineAccount.destinationBranch != null &&
            offlineAccount.destinationBranch!.isNotEmpty) {
          _destinationBranchController.add(offlineAccount.destinationBranch);
        }

        if (offlineAccount.preferredNameOnCard != null &&
            offlineAccount.preferredNameOnCard!.isNotEmpty) {
          _preferredNameOnCardController
              .add(offlineAccount.preferredNameOnCard);
        }

        if (offlineAccount.signatoryDetails?.first.city != null &&
            offlineAccount.signatoryDetails!.first.city!.isNotEmpty) {
          _cityOfResidenceController
              .add(offlineAccount.signatoryDetails!.first.city);
        }
        if (offlineAccount.signatoryDetails?.first.sex != null &&
            offlineAccount.signatoryDetails!.first.sex!.isNotEmpty) {
          if (offlineAccount.signatoryDetails!.first.sex == 'M') {
            _genderController.add('MALE');
          } else {
            _genderController.add('FEMALE');
          }
        }
        if (offlineAccount.signatoryDetails?.first.occupation != null &&
            offlineAccount.signatoryDetails!.first.occupation!.isNotEmpty) {
          if (offlineAccount.signatoryDetails!.first.occupation!
              .contains("OTHER (PLEASE SPECIFY)")) {
            List<String> occupationList =
                offlineAccount.signatoryDetails!.first.occupation!.split("-");
            occupationController.add(occupationList[0]);
            if (occupationList.length > 1) {
              othersOccupationController.add(occupationList[1]);
            }
          } else {
            occupationController
                .add(offlineAccount.signatoryDetails!.first.occupation);
          }
        }

        if (offlineAccount.signatoryDetails?.first.maritalStatus != null &&
            offlineAccount.signatoryDetails!.first.maritalStatus!.isNotEmpty) {
          _maritalStatusController
              .add(offlineAccount.signatoryDetails!.first.maritalStatus);
        }

        if (offlineAccount.signatoryDetails?.first.meansOfId != null &&
            offlineAccount.signatoryDetails!.first.meansOfId!.isNotEmpty) {
          _idTypeController
              .add(offlineAccount.signatoryDetails!.first.meansOfId);
        }
        if (offlineAccount.signatoryDetails?.first.idIssuer != null &&
            offlineAccount.signatoryDetails!.first.idIssuer!.isNotEmpty) {
          _idIssuerController
              .add(offlineAccount.signatoryDetails!.first.idIssuer);

          _idIssuerOthersController
              .add(offlineAccount.signatoryDetails!.first.idIssuer);
        }
        if (offlineAccount.signatoryDetails?.first.idNumber != null &&
            offlineAccount.signatoryDetails!.first.idNumber!.isNotEmpty) {
          _idNumberController
              .add(offlineAccount.signatoryDetails!.first.idNumber);
        }
        if (offlineAccount.signatoryDetails?.first.idPlaceOfIssue != null &&
            offlineAccount.signatoryDetails!.first.idPlaceOfIssue!.isNotEmpty) {
          _idPlaceOfIssueController
              .add(offlineAccount.signatoryDetails!.first.idPlaceOfIssue);
        }

        if (offlineAccount.signatoryDetails?.first.foreignAddress1 != null &&
            offlineAccount
                .signatoryDetails!.first.foreignAddress1!.isNotEmpty) {
          _countryOfIDCountryIssueController
              .add(offlineAccount.signatoryDetails!.first.foreignAddress1);
        }

        if (offlineAccount.signatoryDetails?.first.idIssueDate != null &&
            offlineAccount.signatoryDetails!.first.idIssueDate!.isNotEmpty) {
          _idIssueDateController
              .add(offlineAccount.signatoryDetails!.first.idIssueDate);
        }
        if (offlineAccount.signatoryDetails?.first.idExpiryDate != null &&
            offlineAccount.signatoryDetails!.first.idExpiryDate!.isNotEmpty) {
          _idExpiryDateController
              .add(offlineAccount.signatoryDetails!.first.idExpiryDate);
        }
        if (offlineAccount.signatoryDetails?.first.useEmailForStatement !=
                null &&
            offlineAccount
                .signatoryDetails!.first.useEmailForStatement!.isNotEmpty) {
          if (offlineAccount.signatoryDetails!.first.useEmailForStatement ==
              "Y") {
            _isScanToPayController.add(true);
          }
        }

/*
        if (offlineAccount.alertZRequest != null &&
            offlineAccount.alertZRequest!.isNotEmpty) {
          if (offlineAccount.alertZRequest == "Y") {
            _isZMobileController.add(true);
          }
        }
        if (offlineAccount?.tokenRequest != null &&
            offlineAccount.tokenRequest!.isNotEmpty) {
          if (offlineAccount.tokenRequest == "Y") {
            _isZPromptController.add(true);
          }
        }
        if (offlineAccount.ibankRequest != null &&
            offlineAccount.ibankRequest!.isNotEmpty) {
          if (offlineAccount.ibankRequest == "Y") {
            _isStatementViaEmailController.add(true);
          }
        }

        //Todo get the right details
        if (offlineAccount.tokenRequest != null &&
            offlineAccount.tokenRequest!.isNotEmpty) {
          if (offlineAccount.tokenRequest == "Y") {
            _isUssdController.add(true);
          }
        }
        if (offlineAccount.ibankRequest != null &&
            offlineAccount.ibankRequest!.isNotEmpty) {
          if (offlineAccount.ibankRequest == "Y") {
            _isBankToWalletController.add(true);
          }
        }
*/

//----------E-product List--------------------------------------------

        if (offlineAccount.uSSDRequest != null &&
            offlineAccount.uSSDRequest!.isNotEmpty) {
          if (offlineAccount.uSSDRequest! == "Y") {
            _isUssdController.add(true);
          }
        }
/*
        if (offlineAccount.scanToPayRequest != null &&
            offlineAccount.scanToPayRequest!.isNotEmpty) {
          if (offlineAccount.scanToPayRequest! == "Y") {
            _isScanToPayController.add(true);
          }
        }
        */

        if (offlineAccount.zMobileRequest != null &&
            offlineAccount.zMobileRequest!.isNotEmpty) {
          if (offlineAccount.zMobileRequest! == "Y") {
            _isZMobileController.add(true);
          }
        }

        if (offlineAccount.zPromptRequest != null &&
            offlineAccount.zPromptRequest!.isNotEmpty) {
          if (offlineAccount.zPromptRequest! == "Y") {
            _isZPromptController.add(true);
          }
        }

        if (offlineAccount.statementByEmailRequest != null &&
            offlineAccount.statementByEmailRequest!.isNotEmpty) {
          if (offlineAccount.statementByEmailRequest! == "Y") {
            _isStatementViaEmailController.add(true);
          }
        }

        if (offlineAccount.bankWalletRequest != null &&
            offlineAccount.bankWalletRequest!.isNotEmpty) {
          if (offlineAccount.bankWalletRequest! == "Y") {
            _isBankToWalletController.add(true);
          }
        }
/*
        if (offlineAccount.icardRequest != null &&
            offlineAccount.icardRequest!.isNotEmpty) {
          if (offlineAccount.icardRequest! == "Y") {
            _isCardRequestController.add(true);
          }
        }
        */

        if (offlineAccount.signatoryDetails?.first.attachments != null) {
          var _idCardAttachment = offlineAccount
              .signatoryDetails!.first.attachments!
              .where((i) => i.type == 'IdentityCard')
              .toList();

          var _idCard2Attachment = offlineAccount
              .signatoryDetails!.first.attachments!
              .where((i) => i.type == 'IdentityCard2')
              .toList();

          var _passportAttachment = offlineAccount
              .signatoryDetails!.first.attachments!
              .where((i) => i.type == 'PassportPhoto')
              .toList();

          var _admissionLetterAttachment = offlineAccount
              .signatoryDetails!.first.attachments!
              .where((i) => i.type == 'AdmissionLetter')
              .toList();

          var _utilityBillAttachment = offlineAccount
              .signatoryDetails!.first.attachments!
              .where((i) => i.type == 'UtilityBill')
              .toList();

          var _residentPermitAttachment = offlineAccount
              .signatoryDetails!.first.attachments!
              .where((i) => i.type == 'ResidentPermit')
              .toList();

          var _signatoryAttachment = offlineAccount
              .signatoryDetails!.first.attachments!
              .where((i) => i.type == 'Signatory')
              .toList();

          if (_idCard2Attachment.isNotEmpty) {
            _uploadIdImageController2
                .add(_idCard2Attachment.first.encodedImage);
          }

          if (_idCardAttachment.isNotEmpty) {
            _uploadIdImageController.add(_idCardAttachment.first.encodedImage);
          }

          if (_admissionLetterAttachment.isNotEmpty) {
            uploadAdmissionLetterController
                .add(_admissionLetterAttachment.first.encodedImage);
          }

          if (_passportAttachment.isNotEmpty) {
            _uploadPassportController
                .add(_passportAttachment.first.encodedImage);
          }

          if (_admissionLetterAttachment.isNotEmpty) {
            uploadAdmissionLetterController
                .add(_admissionLetterAttachment.first.encodedImage);
          }

          if (_utilityBillAttachment.isNotEmpty) {
            _uploadUtilityBillController
                .add(_utilityBillAttachment.first.encodedImage);
          }

          if (_residentPermitAttachment.isNotEmpty) {
            _uploadResidentPermitController
                .add(_residentPermitAttachment.first.encodedImage);
          }

          if (_signatoryAttachment.isNotEmpty) {
            _uploadSignatureController
                .add(_signatoryAttachment.first.encodedImage);
          }
        }
      } else {
        _subjectOfflineDetailsResponse
            .addError('Unable to retrieve account, try again later');
      }
    }).catchError((error) {
      _subjectOfflineDetailsResponse.addError('$error');
    });
  }
/*
  getOfflineAccountDetailsByRefId(String? referenceId) async {
    _isEditModeController.add(true);

    await _accountsRepository
        .getOfflineAccountByRefId(referenceId)
        .then((offlineAccount) {
      if (offlineAccount != null) {
        // print("REPORT");
        inspect(offlineAccount);
        _idController.add(offlineAccount.id);
        _subjectOfflineDetailsResponse.add("Account retrieved successfully.");
        if (offlineAccount.accountType == 'SA') {
          _accountTypeController.add('SAVINGS ACCOUNT');
        } else {
          _accountTypeController.add('CURRENT ACCOUNT');
        }

        _accountHolderTypeController.add('INDIVIDUAL');

        if (offlineAccount.riskRank != null &&
            offlineAccount.riskRank!.isNotEmpty) {
          _riskRankController.add(offlineAccount.riskRank);
        }
        if (offlineAccount.mmda != null && offlineAccount.mmda!.isNotEmpty) {
          _mmdaController.add(offlineAccount.mmda);
        }

        if (offlineAccount.accountCategory != null &&
            offlineAccount.accountCategory!.isNotEmpty) {
          _accountCategoryController.add(offlineAccount.accountCategory);
        }

        if (offlineAccount.tin != null && offlineAccount.tin!.isNotEmpty) {
          _tinController.add(offlineAccount.tin);
        }

        if (offlineAccount.title != null && offlineAccount.title!.isNotEmpty) {
          _titleController.add(offlineAccount.title);
        }

        if (offlineAccount.surname != null &&
            offlineAccount.surname!.isNotEmpty) {
          _surnameController.add(offlineAccount.surname);
        }
        if (offlineAccount.firstName != null &&
            offlineAccount.firstName!.isNotEmpty) {
          _firstNameController.add(offlineAccount.firstName);
        }

        if (offlineAccount.otherName != null &&
            offlineAccount.otherName!.isNotEmpty) {
          _otherNameController.add(offlineAccount.otherName);
        }

        if (offlineAccount.mothersMaidenName != null &&
            offlineAccount.mothersMaidenName!.isNotEmpty) {
          _mothersMaidenNameController.add(offlineAccount.mothersMaidenName);
        }

        if (offlineAccount.dateOfBirth != null &&
            offlineAccount.dateOfBirth!.isNotEmpty) {
          _dateOfBirthController.add(offlineAccount.dateOfBirth);
        }

        if (offlineAccount.stateOfOrigin != null &&
            offlineAccount.stateOfOrigin!.isNotEmpty) {
          _stateOfResidenceController.add(offlineAccount.stateOfOrigin);
        }
        if (offlineAccount.placeOfBirth != null &&
            offlineAccount.placeOfBirth!.isNotEmpty) {
          _placeOfBirthController.add(offlineAccount.placeOfBirth);
        }
        _countryOfOriginController.add('GHANA');

        if (offlineAccount.email != null && offlineAccount.email!.isNotEmpty) {
          _emailController.add(offlineAccount.email);
        }

        if (offlineAccount.phone != null && offlineAccount.phone!.isNotEmpty) {
          _phoneNumberController.add(offlineAccount.phone);
        }

        if (offlineAccount.nextOfKin != null &&
            offlineAccount.nextOfKin!.isNotEmpty) {
          _nextOfKinController.add(offlineAccount.nextOfKin);
        }

        if (offlineAccount.address1 != null &&
            offlineAccount.address1!.isNotEmpty) {
          _address1Controller.add(offlineAccount.address1);
        }

        if (offlineAccount.address2 != null &&
            offlineAccount.address2!.isNotEmpty) {
          _address2Controller.add(offlineAccount.address2);
        }

        if (offlineAccount.stateOfResidence != null &&
            offlineAccount.stateOfResidence!.isNotEmpty) {
          _stateOfResidenceController.add(offlineAccount.stateOfResidence);
        }
        if (offlineAccount.cityOfResidence != null &&
            offlineAccount.cityOfResidence!.isNotEmpty) {
          _cityOfResidenceController.add(offlineAccount.cityOfResidence);
        }

        if (offlineAccount.gender != null &&
            offlineAccount.gender!.isNotEmpty) {
          if (offlineAccount.gender == 'M') {
            _genderController.add('MALE');
          } else {
            _genderController.add('FEMALE');
          }
        }

        if (offlineAccount.occupation != null &&
            offlineAccount.occupation!.isNotEmpty) {
          occupationController.add(offlineAccount.occupation);
        }

        if (offlineAccount.maritalStatus != null &&
            offlineAccount.maritalStatus!.isNotEmpty) {
          _maritalStatusController.add(offlineAccount.maritalStatus);
        }

        if (offlineAccount.idType != null &&
            offlineAccount.idType!.isNotEmpty) {
          _idTypeController.add(offlineAccount.idType);
        }

        if (offlineAccount.idIssuer != null &&
            offlineAccount.idIssuer!.isNotEmpty) {
          _idIssuerController.add(offlineAccount.idIssuer);
        }

        if (offlineAccount.idNumber != null &&
            offlineAccount.idNumber!.isNotEmpty) {
          _idNumberController.add(offlineAccount.idNumber);
        }
        if (offlineAccount.idPlaceOfIssue != null &&
            offlineAccount.idPlaceOfIssue!.isNotEmpty) {
          _idPlaceOfIssueController.add(offlineAccount.idPlaceOfIssue);
        }

        if (offlineAccount.idIssueDate != null &&
            offlineAccount.idIssueDate!.isNotEmpty) {
          _idIssueDateController.add(offlineAccount.idIssueDate);
        }
        if (offlineAccount.idExpiryDate != null &&
            offlineAccount.idExpiryDate!.isNotEmpty) {
          _idExpiryDateController.add(offlineAccount.idExpiryDate);
        }

//        var isZMobile = offlineAccount.isZMobile  == "Y" ?  true: false;
//        var isZPrompt = offlineAccount.isZPrompt  == "Y" ?  true: false;
//        var isStatementViaEmail = offlineAccount.isStatementViaEmail  == "Y" ?  true: false;
//        var isUSSD = offlineAccount.isUSSD  == "Y" ?  true: false;
//        var isBankToWallet = offlineAccount.isBankToWallet  == "Y" ?  true: false;
//        var isScanToPay = offlineAccount.isScanToPay  == "Y" ?  true: false;
        _isZMobileController.add(offlineAccount.isZMobile);
        _isZPromptController.add(offlineAccount.isZPrompt);
        _isStatementViaEmailController.add(offlineAccount.isStatementViaEmail);
        _isUssdController.add(offlineAccount.isUSSD);
        _isBankToWalletController.add(offlineAccount.isBankToWallet);

        _isCardRequestController.add(offlineAccount.isCardRequest);
        cardTypeController.add(offlineAccount.cardType);
        _requestingBranchController.add(offlineAccount.requestingBranch);
        _destinationBranchController.add(offlineAccount.destinationBranch);
        _preferredNameOnCardController.add(offlineAccount.preferredNameOnCard);
        _isScanToPayController.add(offlineAccount.isScanToPay);

        if (offlineAccount.idCard != null &&
            offlineAccount.idCard!.isNotEmpty) {
          _uploadIdImageController.add(offlineAccount.idCard);
        }

/*
         if (offlineAccount.idCard2 != null &&
            offlineAccount.idCard2!.isNotEmpty) {
          _uploadIdImageController2.add(offlineAccount.idCard2);
        }
        */

        if (offlineAccount.passport != null &&
            offlineAccount.passport!.isNotEmpty) {
          _uploadPassportController.add(offlineAccount.passport);
        }

/*
         if (offlineAccount.admissionLetter != null &&
            offlineAccount.admissionLetter!.isNotEmpty) {
          uploadAdmissionLetterController.add(offlineAccount.passport);
        }
        */

        if (offlineAccount.utility != null &&
            offlineAccount.utility!.isNotEmpty) {
          _uploadUtilityBillController.add(offlineAccount.utility);
        }
        if (offlineAccount.signature != null &&
            offlineAccount.signature!.isNotEmpty) {
          _uploadSignatureController.add(offlineAccount.signature);
        }
      } else {
        _subjectOfflineDetailsResponse
            .addError('Unable to retrieve account, try again later');
      }
    }).catchError((error) {
      _subjectOfflineDetailsResponse.addError('$error');
    });
  }

*/

  getAccountsDetailsByReferenceId(String? referenceId) async {
    // _countryOfIDCountryIssueController

    _referenceIdController.add(referenceId);

    await _accountsRepository
        .getAccountsDetailsByReference(referenceId)
        .then((accountResponse) async {
      print("RESPONSE");
      inspect(accountResponse);

      subjectAccountsDetailsResponse.add(accountResponse);
      if (accountResponse.status!) {
//        if (accountResponse.data.refId != null &&
//            accountResponse.data.refId.isNotEmpty) {
//          _referenceIdController.add(accountResponse.data.refId);
//        }

        if (accountResponse.data!.accountType != null &&
            accountResponse.data!.accountType!.isNotEmpty) {
          if (accountResponse.data!.accountType == 'SA') {
            _accountTypeController.add('SAVINGS ACCOUNT');
          } else {
            _accountTypeController.add('CURRENT ACCOUNT');
          }
        }
        _accountHolderTypeController.add('INDIVIDUAL');
        if (accountResponse.data!.riskRank != null &&
            accountResponse.data!.riskRank!.isNotEmpty) {
          _riskRankController.add(accountResponse.data!.riskRank);
        }

        if (accountResponse.data?.signatoryDetails?.first.mmda != null &&
            accountResponse.data!.signatoryDetails!.first.mmda!.isNotEmpty) {
          try {
            List<StateEntity> states = await DBProvider.db.getStates();

/*
            var mmda = states
                .firstWhere(
                    (x) => x.srn.toString() == accountResponse.data!.state)
                .mmda
                .toString(); //hotfix: to solve issue of mmda  filter from state on edit

            // if (mmda != null)
            */
            print("REPORT " +
                accountResponse.data!.signatoryDetails!.first.mmda!);

            _mmdaController
                .add(accountResponse.data?.signatoryDetails?.first.mmda!);
          } catch (err) {
            _mmdaController.add(accountResponse.data!.classCode);
          }
        }
        if (accountResponse.data?.signatoryDetails?.first.placeOfBirth !=
                null &&
            accountResponse
                .data!.signatoryDetails!.first.placeOfBirth!.isNotEmpty) {}
        if (accountResponse.data!.classCode != null &&
            accountResponse.data!.classCode!.isNotEmpty) {
          print('log class code ${accountResponse.data!.classCode}');

          try {
            List<AccountClassEntity> accountClasses =
                await DBProvider.db.getAccountClasses();

            var accountCategory = accountClasses
                .firstWhere(
                    (x) => x.id.toString() == accountResponse.data!.classCode)
                .name
                .toString(); //hotfix: to solve issue of account category filter from account type on edit

            // if (accountCategory != null)
            _accountCategoryController.add(accountCategory);
          } catch (err) {
            _accountCategoryController.add(accountResponse.data!.classCode);
          }
        }
        if (accountResponse.data!.tin != null &&
            accountResponse.data!.tin.isNotEmpty) {
          //     print("TIN " + accountResponse.data!.tin);
          _tinController.add(accountResponse.data!.tin);
        }

        if (accountResponse.data!.title != null &&
            accountResponse.data!.title!.isNotEmpty) {
          _titleController.add(accountResponse.data!.title);
        }
        if (accountResponse.data!.signatoryDetails?.first.lastName != null &&
            accountResponse
                .data!.signatoryDetails!.first.lastName!.isNotEmpty) {
          _surnameController.add(CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.lastName!));
        }
        if (accountResponse.data!.signatoryDetails?.first.firstName != null &&
            accountResponse
                .data!.signatoryDetails!.first.firstName!.isNotEmpty) {
          _firstNameController.add(CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.firstName!));
        }

        if (accountResponse.data!.signatoryDetails?.first.tin != null &&
            accountResponse.data!.signatoryDetails!.first.tin!.isNotEmpty) {
          _admissionNoController
              .add(accountResponse.data!.signatoryDetails!.first.tin!);
        }

        if (accountResponse.data!.signatoryDetails?.first.middleName != null &&
            accountResponse
                .data!.signatoryDetails!.first.middleName!.isNotEmpty) {
          _otherNameController.add(CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.middleName!));
        }

//        if (accountResponse.data.signatoryDetails?.first?.middleName != null &&
//            accountResponse.data.signatoryDetails.first.middleName.isNotEmpty) {
//          _otherNameController.add(CryptoHelper.decrypt(
//              accountResponse.data.signatoryDetails.first.middleName));
//        }

        if (accountResponse.data!.signatoryDetails?.first.nextOfKinPhone !=
                null &&
            accountResponse
                .data!.signatoryDetails!.first.nextOfKinPhone!.isNotEmpty) {
          String dd = CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.nextOfKinPhone!);

          _nextOfKinPhoneController.add(CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.nextOfKinPhone!));
        }

        if (accountResponse
                    .data!.signatoryDetails?.first.nextOfKinRelationship !=
                null &&
            accountResponse.data!.signatoryDetails!.first.nextOfKinRelationship!
                .isNotEmpty) {
          String dd = CryptoHelper.decrypt(accountResponse
              .data!.signatoryDetails!.first.nextOfKinRelationship!);

          _nextOfKinRelationshipController.add(CryptoHelper.decrypt(
              accountResponse
                  .data!.signatoryDetails!.first.nextOfKinRelationship!));
        }

        if (accountResponse
                    .data!.signatoryDetails?.first.cerpacRPplaceofIssue !=
                null &&
            accountResponse.data!.signatoryDetails!.first.cerpacRPplaceofIssue!
                .isNotEmpty) {
          String dd = CryptoHelper.decrypt(accountResponse
              .data!.signatoryDetails!.first.cerpacRPplaceofIssue!);

          _nextOfKinAddressController.add(CryptoHelper.decrypt(accountResponse
              .data!.signatoryDetails!.first.cerpacRPplaceofIssue!));
        }

        if (accountResponse.data!.signatoryDetails?.first.nextOfKinGender !=
                null &&
            accountResponse
                .data!.signatoryDetails!.first.nextOfKinGender!.isNotEmpty) {
          _nextOfKinGenderController.add(
              accountResponse.data!.signatoryDetails!.first.nextOfKinGender!);
        }

        if (accountResponse.data!.monthlyIncome != null &&
            accountResponse.data!.monthlyIncome!.isNotEmpty) {
          _monthlyIncomeController.add(accountResponse.data!.monthlyIncome!);
        }

        if (accountResponse.data!.signatoryDetails?.first.homeTown != null &&
            accountResponse
                .data!.signatoryDetails!.first.homeTown!.isNotEmpty) {
          _homeTownController
              .add(accountResponse.data!.signatoryDetails!.first.homeTown!);
        }

        if (accountResponse.data!.signatoryDetails?.first.motherMaidenName !=
                null &&
            accountResponse
                .data!.signatoryDetails!.first.motherMaidenName!.isNotEmpty) {
          _mothersMaidenNameController.add(CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.motherMaidenName!));
        }

        if (accountResponse.data!.signatoryDetails?.first.dateOfBirth != null &&
            accountResponse
                .data!.signatoryDetails!.first.dateOfBirth!.isNotEmpty) {
          _dateOfBirthController.add(CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.dateOfBirth!));
        }

//        if (accountResponse.data.signatoryDetails?.first?.dateOfBirth != null &&
//            accountResponse
//                .data.signatoryDetails.first.dateOfBirth.isNotEmpty) {
//          _dateOfBirthController.add(CryptoHelper.decrypt(
//              accountResponse.data.signatoryDetails.first.dateOfBirth));
//        }

        if (accountResponse.data!.signatoryDetails?.first.stateOfOrigin !=
                null &&
            accountResponse
                .data!.signatoryDetails!.first.stateOfOrigin!.isNotEmpty) {
          //    print("REPORT " + accountResponse.data!.signatoryDetails!.first.stateOfOrigin!);
          _placeOfBirthController.add(
              accountResponse.data!.signatoryDetails!.first.stateOfOrigin!);
        }

        if (accountResponse.data!.signatoryDetails?.first.stateOfOrigin !=
                null &&
            accountResponse
                .data!.signatoryDetails!.first.stateOfOrigin!.isNotEmpty) {
          //    print("REPORT " + accountResponse.data!.signatoryDetails!.first.stateOfOrigin!);
          _placeOfBirthController.add(
              accountResponse.data!.signatoryDetails!.first.stateOfOrigin!);
        }

        //   _countryOfOriginController.add('GHANA');

        if (accountResponse.data!.countryOfOrigin != null &&
            accountResponse.data!.countryOfOrigin!.isNotEmpty) {
          //     print("TIN " + accountResponse.data!.tin);
          countryOfResident = accountResponse.data!.countryOfOrigin;
          _countryOfOriginController.add(accountResponse.data!.countryOfOrigin);
        }

        if (accountResponse.data!.signatoryDetails?.first.emailAddress !=
                null &&
            accountResponse
                .data!.signatoryDetails!.first.emailAddress!.isNotEmpty) {
          _emailController.add(CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.emailAddress!));
        }

        if (accountResponse.data!.signatoryDetails?.first.phoneNumber != null &&
            accountResponse
                .data!.signatoryDetails!.first.phoneNumber!.isNotEmpty) {
          String bgd = CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.phoneNumber!);
          _phoneNumberController.add(CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.phoneNumber!));
        }

        if (accountResponse.data!.signatoryDetails?.first.nextOfKin != null &&
            accountResponse
                .data!.signatoryDetails!.first.nextOfKin!.isNotEmpty) {
          String ggds = CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.nextOfKin!);

          _nextOfKinController.add(CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.nextOfKin!));
        }

        if (accountResponse.data!.signatoryDetails?.first.addressLine1 !=
                null &&
            accountResponse
                .data!.signatoryDetails!.first.addressLine1!.isNotEmpty) {
          _address1Controller.add(CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.addressLine1!));
        }

        if (accountResponse.data!.signatoryDetails?.first.addressLine2 !=
                null &&
            accountResponse
                .data!.signatoryDetails!.first.addressLine2!.isNotEmpty) {
          _address2Controller.add(CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.addressLine2!));
        }
        _countryOfResidenceController.add('GHANA');

        if (accountResponse.data!.signatoryDetails?.first.state != null &&
            accountResponse.data!.signatoryDetails!.first.state!.isNotEmpty) {
          _stateOfResidenceController
              .add(accountResponse.data!.signatoryDetails!.first.state);
        }

        if (accountResponse.data!.cardType != null &&
            accountResponse.data!.cardType!.isNotEmpty) {
          cardTypeController.add(accountResponse.data!.cardType);
        }

        if (accountResponse.data!.requestingBranch != null &&
            accountResponse.data!.requestingBranch!.isNotEmpty) {
          _requestingBranchController
              .add(accountResponse.data!.requestingBranch);
        }

        if (accountResponse.data!.employmentTypes != null &&
            accountResponse.data!.employmentTypes!.isNotEmpty) {
          _employmentTypeController.add(accountResponse.data!.employmentTypes);
        }

        List<AccountPurposes>? acctPurposes = accountResponse.data!.acctPurpose;
        if (acctPurposes != null) {
          for (AccountPurposes acct in acctPurposes) {
            switch (acct.accountPurpose!.toLowerCase()) {
              case 'salary processing':
                _salaryProcessingController.add(true);
                break;
              case 'access to banking services':
                _bankingServiceController.add(true);
                break;
              case 'business/transactional':
                _businessController.add(true);
                break;
              case 'facilitation of a single transaction':
                _singleTransactionController.add(true);
                break;
              case 'security/safekeeping':
                _safeKeepingController.add(true);
                break;
              case 'savings & investment':
                _savingAndInvestmentController.add(true);
                break;
              case 'receipt of inflows for personal upkeep':
                _receiptController.add(true);
                break;
              case 'other':
                _othersController.add(true);
                break;
              default:
                {
                  if (acct.accountPurpose!.toLowerCase().contains("other-")) {
                    List otherP = acct.accountPurpose!.split('-');
                    othersPurposeController.add(otherP[1]);
                  }
                }
            }
          }
        }

        List<SourceOfFundsObj>? sourceFunds =
            accountResponse.data!.sourceOfFunds;
        if (sourceFunds != null) {
          for (SourceOfFundsObj srcF in sourceFunds) {
            switch (srcF.sourceOfFunds!.toLowerCase()) {
              case 'salary':
                _salaryController.add(true);
                break;
              case 'rental income':
                _rentalIncomeController.add(true);
                break;
              case 'personal savings':
                _personalSavingController.add(true);
                break;
              case 'family & friends':
                _familyFriendController.add(true);
                break;
              case 'dividends':
                _dividendsController.add(true);
                break;
              case 'commissions':
                _commissionController.add(true);
                break;
              case 'business proceeds':
                _businessProceedController.add(true);
                break;
              case 'other':
                _otherSourceController.add(true);
                break;
              default:
                {
                  if (srcF.sourceOfFunds!.toLowerCase().contains("other-")) {
                    List otherP = srcF.sourceOfFunds!.split('-');
                    enterOtherSourceController.add(otherP[1]);
                  }
                }
            }
          }
        }

        List<TransactionTypes>? transTypes = accountResponse.data!.transTypes;
        if (transTypes != null) {
          for (TransactionTypes trans in transTypes) {
            if (trans.transactionType!.toLowerCase() == "deposit") {
              _anticipatedNoTranController.add(trans.transactionCount);
              _anticipatedAmountController.add(trans.expectedAmount);
            } else {
              _anticipatedWithdrawTranController.add(trans.transactionCount);
              _anticipatedAmountWithdrawController.add(trans.expectedAmount);
            }
          }
        }
        if (accountResponse.data!.destinationBranch != null &&
            accountResponse.data!.destinationBranch!.isNotEmpty) {
          _destinationBranchController
              .add(accountResponse.data!.destinationBranch);
        }

        if (accountResponse.data!.preferredNameOnCard != null &&
            accountResponse.data!.preferredNameOnCard!.isNotEmpty) {
          _preferredNameOnCardController
              .add(accountResponse.data!.preferredNameOnCard);
        }

        if (accountResponse.data!.signatoryDetails?.first.city != null &&
            accountResponse.data!.signatoryDetails!.first.city!.isNotEmpty) {
          _cityOfResidenceController
              .add(accountResponse.data!.signatoryDetails!.first.city);
        }
        if (accountResponse.data!.signatoryDetails?.first.sex != null &&
            accountResponse.data!.signatoryDetails!.first.sex!.isNotEmpty) {
          if (accountResponse.data!.signatoryDetails!.first.sex == 'M') {
            _genderController.add('MALE');
          } else {
            _genderController.add('FEMALE');
          }
        }
        if (accountResponse.data!.signatoryDetails?.first.occupation != null &&
            accountResponse
                .data!.signatoryDetails!.first.occupation!.isNotEmpty) {
          if (accountResponse.data!.signatoryDetails!.first.occupation!
              .contains("OTHER (PLEASE SPECIFY)")) {
            List<String> occupationList = accountResponse
                .data!.signatoryDetails!.first.occupation!
                .split("-");
            occupationController.add(occupationList[0]);
            if (occupationList.length > 1) {
              othersOccupationController.add(occupationList[1]);
            }
          } else {
            occupationController
                .add(accountResponse.data!.signatoryDetails!.first.occupation);
          }
        }

        if (accountResponse.data!.signatoryDetails?.first.maritalStatus !=
                null &&
            accountResponse
                .data!.signatoryDetails!.first.maritalStatus!.isNotEmpty) {
          _maritalStatusController
              .add(accountResponse.data!.signatoryDetails!.first.maritalStatus);
        }

        if (accountResponse.data!.signatoryDetails?.first.meansOfId != null &&
            accountResponse
                .data!.signatoryDetails!.first.meansOfId!.isNotEmpty) {
          _idTypeController
              .add(accountResponse.data!.signatoryDetails!.first.meansOfId);
        }
        if (accountResponse.data!.signatoryDetails?.first.idIssuer != null &&
            accountResponse
                .data!.signatoryDetails!.first.idIssuer!.isNotEmpty) {
          _idIssuerController
              .add(accountResponse.data!.signatoryDetails!.first.idIssuer);

          _idIssuerOthersController
              .add(accountResponse.data!.signatoryDetails!.first.idIssuer);
        }
        if (accountResponse.data!.signatoryDetails?.first.idNumber != null &&
            accountResponse
                .data!.signatoryDetails!.first.idNumber!.isNotEmpty) {
          _idNumberController
              .add(accountResponse.data!.signatoryDetails!.first.idNumber);
        }
        if (accountResponse.data!.signatoryDetails?.first.idPlaceOfIssue !=
                null &&
            accountResponse
                .data!.signatoryDetails!.first.idPlaceOfIssue!.isNotEmpty) {
          _idPlaceOfIssueController.add(
              accountResponse.data!.signatoryDetails!.first.idPlaceOfIssue);
        }

        if (accountResponse.data!.signatoryDetails?.first.foreignAddress1 !=
                null &&
            accountResponse
                .data!.signatoryDetails!.first.foreignAddress1!.isNotEmpty) {
          _countryOfIDCountryIssueController.add(
              accountResponse.data!.signatoryDetails!.first.foreignAddress1);
        }

        if (accountResponse.data!.signatoryDetails?.first.idIssueDate != null &&
            accountResponse
                .data!.signatoryDetails!.first.idIssueDate!.isNotEmpty) {
          _idIssueDateController
              .add(accountResponse.data!.signatoryDetails!.first.idIssueDate);
        }
        if (accountResponse.data!.signatoryDetails?.first.idExpiryDate !=
                null &&
            accountResponse
                .data!.signatoryDetails!.first.idExpiryDate!.isNotEmpty) {
          _idExpiryDateController
              .add(accountResponse.data!.signatoryDetails!.first.idExpiryDate);
        }
        if (accountResponse
                    .data!.signatoryDetails?.first.useEmailForStatement !=
                null &&
            accountResponse.data!.signatoryDetails!.first.useEmailForStatement!
                .isNotEmpty) {
          if (accountResponse
                  .data!.signatoryDetails!.first.useEmailForStatement ==
              "Y") {
            _isScanToPayController.add(true);
          }
        }

        if (accountResponse.data?.alertZRequest != null &&
            accountResponse.data!.alertZRequest!.isNotEmpty) {
          if (accountResponse.data!.alertZRequest == "Y") {
            _isZMobileController.add(true);
          }
        }
        if (accountResponse.data?.tokenRequest != null &&
            accountResponse.data!.tokenRequest!.isNotEmpty) {
          if (accountResponse.data!.tokenRequest == "Y") {
            _isZPromptController.add(true);
          }
        }
        if (accountResponse.data?.ibankRequest != null &&
            accountResponse.data!.ibankRequest!.isNotEmpty) {
          if (accountResponse.data!.ibankRequest == "Y") {
            _isStatementViaEmailController.add(true);
          }
        }

        //Todo get the right details
        if (accountResponse.data?.tokenRequest != null &&
            accountResponse.data!.tokenRequest!.isNotEmpty) {
          if (accountResponse.data!.tokenRequest == "Y") {
            _isUssdController.add(true);
          }
        }
        if (accountResponse.data?.ibankRequest != null &&
            accountResponse.data!.ibankRequest!.isNotEmpty) {
          if (accountResponse.data!.ibankRequest == "Y") {
            _isBankToWalletController.add(true);
          }
        }

//----------E-product List--------------------------------------------

        if (accountResponse.data!.uSSDRequest != null &&
            accountResponse.data!.uSSDRequest!.isNotEmpty) {
          if (accountResponse.data!.uSSDRequest! == "Y") {
            _isUssdController.add(true);
          }
        }

        if (accountResponse.data!.scanToPayRequest != null &&
            accountResponse.data!.scanToPayRequest!.isNotEmpty) {
          if (accountResponse.data!.scanToPayRequest! == "Y") {
            _isScanToPayController.add(true);
          }
        }

        if (accountResponse.data!.zMobileRequest != null &&
            accountResponse.data!.zMobileRequest!.isNotEmpty) {
          if (accountResponse.data!.zMobileRequest! == "Y") {
            _isZMobileController.add(true);
          }
        }

        if (accountResponse.data!.zPromptRequest != null &&
            accountResponse.data!.zPromptRequest!.isNotEmpty) {
          if (accountResponse.data!.zPromptRequest! == "Y") {
            _isZPromptController.add(true);
          }
        }

        if (accountResponse.data!.statementByEmailRequest != null &&
            accountResponse.data!.statementByEmailRequest!.isNotEmpty) {
          if (accountResponse.data!.statementByEmailRequest! == "Y") {
            _isStatementViaEmailController.add(true);
          }
        }

        if (accountResponse.data!.bankWalletRequest != null &&
            accountResponse.data!.bankWalletRequest!.isNotEmpty) {
          if (accountResponse.data!.bankWalletRequest! == "Y") {
            _isBankToWalletController.add(true);
          }
        }

        if (accountResponse.data!.icardRequest != null &&
            accountResponse.data!.icardRequest!.isNotEmpty) {
          if (accountResponse.data!.icardRequest! == "Y") {
            _isCardRequestController.add(true);
          }
        }

        if (accountResponse.data!.signatoryDetails?.first.attachments != null) {
          var _idCardAttachment = accountResponse
              .data!.signatoryDetails!.first.attachments!
              .where((i) => i.type == 'IdentityCard')
              .toList();

          var _idCard2Attachment = accountResponse
              .data!.signatoryDetails!.first.attachments!
              .where((i) => i.type == 'IdentityCard2')
              .toList();

          var _passportAttachment = accountResponse
              .data!.signatoryDetails!.first.attachments!
              .where((i) => i.type == 'PassportPhoto')
              .toList();

          var _admissionLetterAttachment = accountResponse
              .data!.signatoryDetails!.first.attachments!
              .where((i) => i.type == 'AdmissionLetter')
              .toList();

          var _utilityBillAttachment = accountResponse
              .data!.signatoryDetails!.first.attachments!
              .where((i) => i.type == 'UtilityBill')
              .toList();

          var _residentPermitAttachment = accountResponse
              .data!.signatoryDetails!.first.attachments!
              .where((i) => i.type == 'ResidentPermit')
              .toList();

          var _signatoryAttachment = accountResponse
              .data!.signatoryDetails!.first.attachments!
              .where((i) => i.type == 'Signatory')
              .toList();

          if (_idCard2Attachment.isNotEmpty) {
            _uploadIdImageController2
                .add(_idCard2Attachment.first.encodedImage);
          }

          if (_idCardAttachment.isNotEmpty) {
            _uploadIdImageController.add(_idCardAttachment.first.encodedImage);
          }

          if (_admissionLetterAttachment.isNotEmpty) {
            uploadAdmissionLetterController
                .add(_admissionLetterAttachment.first.encodedImage);
          }

          if (_passportAttachment.isNotEmpty) {
            _uploadPassportController
                .add(_passportAttachment.first.encodedImage);
          }

          if (_admissionLetterAttachment.isNotEmpty) {
            uploadAdmissionLetterController
                .add(_admissionLetterAttachment.first.encodedImage);
          }

          if (_utilityBillAttachment.isNotEmpty) {
            _uploadUtilityBillController
                .add(_utilityBillAttachment.first.encodedImage);
          }

          if (_residentPermitAttachment.isNotEmpty) {
            _uploadResidentPermitController
                .add(_residentPermitAttachment.first.encodedImage);
          }

          if (_signatoryAttachment.isNotEmpty) {
            _uploadSignatureController
                .add(_signatoryAttachment.first.encodedImage);
          }
        }
      } else {
        _subjectAccountsDetailsResponse.addError(accountResponse.message!);
      }
    }).catchError((error) {
      print(error);
      //  _subjectAccountsDetailsResponse.addError(error);
    });
  }
}

//Note: This creates a global instance of Bloc that's automatically exported and can be accessed anywhere in the app
//final bloc = Bloc();
