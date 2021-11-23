import 'dart:async';
import 'dart:convert';
import 'package:location/location.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/category.dart';
import 'package:zxplore_app/data/database.dart';
import 'package:zxplore_app/data/entities/account_class_entity.dart';
import 'package:zxplore_app/data/entities/offline_form_entity.dart';
import 'package:zxplore_app/data/entities/state_entity.dart';
import 'package:zxplore_app/models/account_details_response.dart';
import 'package:zxplore_app/models/bvn_response.dart';
import 'package:zxplore_app/models/form_model.dart';
import 'package:zxplore_app/models/save_account_response.dart';
import 'package:zxplore_app/models/verify_id_response.dart';
import 'package:zxplore_app/repositories/accounts_repository.dart';
import 'package:zxplore_app/utils/const.dart';
import 'package:zxplore_app/utils/secure_storage.dart';
import 'package:zxplore_app/utils/zxplore_crypto_helper.dart';

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

  final _accountTypeController = BehaviorSubject<String?>();

  final _accountHolderTypeController = BehaviorSubject<String?>();

  final _riskRankController = BehaviorSubject<String?>();

  final _accountCategoryController = BehaviorSubject<String?>();

  //Personal Information

  final _tinController = BehaviorSubject<String?>();

  final _titleController = BehaviorSubject<String?>();

  final _surnameController = BehaviorSubject<String?>();

  final _firstNameController = BehaviorSubject<String?>();

  final _otherNameController = BehaviorSubject<String?>();

  final _mothersMaidenNameController = BehaviorSubject<String?>();

  final _dateOfBirthController = BehaviorSubject<String?>();

//  final _stateOfOriginController = BehaviorSubject<String>();
  final _placeOfBirthController = BehaviorSubject<String?>();

  final _countryOfOriginController = BehaviorSubject<String?>();

  //Contact Details

  final _emailController = BehaviorSubject<String?>();

  final _latitudeController = BehaviorSubject<String>();

  final _longitudeController = BehaviorSubject<String>();

  final _phoneNumberController = BehaviorSubject<String?>();

  final _nextOfKinController = BehaviorSubject<String?>();

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

  final _uploadPassportController = BehaviorSubject<String?>();

  final _uploadUtilityBillController = BehaviorSubject<String?>();

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

  Stream<String> get accountType =>
      _accountTypeController.stream.transform(validateAccountType);

  Stream<String> get accountHolderType =>
      _accountHolderTypeController.stream.transform(validateAccountHolderType);

  Stream<String> get riskRankType =>
      _riskRankController.stream.transform(validateRiskRank);

  Stream<String> get accountCategoryType =>
      _accountCategoryController.stream.transform(validateAccountCategory);

  Stream<String?> get tin => _tinController.stream;

  Stream<String> get title => _titleController.stream.transform(validateTitle);

  Stream<String> get surname =>
      _surnameController.stream.transform(validateSurname);

  Stream<String> get firstName =>
      _firstNameController.stream.transform(validateFirstName);

  Stream<String> get otherName =>
      _otherNameController.stream.transform(validateOtherName);

  Stream<String> get mothersMaidenName =>
      _mothersMaidenNameController.stream.transform(validateMothersMaidenName);

  Stream<String> get dateOfBirth =>
      _dateOfBirthController.stream.transform(validateDateOfBirth);

  Stream<String> get placeOfBirth =>
      _placeOfBirthController.stream.transform(validatePlaceOfBirth);

  Stream<String> get mmda => _mmdaController.stream.transform(validateMMDA);

  Stream<String> get countryOfOrigin =>
      _countryOfOriginController.stream.transform(validateCountryOfOrigin);

  Stream<String> get phoneNumber =>
      _phoneNumberController.stream.transform(validatePhoneNumber);

  Stream<String> get nextOfKin =>
      _nextOfKinController.stream.transform(validateNextOfKin);

  Stream<String> get email => _emailController.stream.transform(validateEmail);

  BehaviorSubject<LocationData> get subjectLocationResponse => _subjectLocation;

  Stream<Category> get currentFormCategory =>
      _currentFormCategoryController.stream;

  Stream<String> get latitude => _latitudeController.stream;

  Stream<String> get longitude => _longitudeController.stream;

  Stream<String> get address1 =>
      _address1Controller.stream.transform(validateAddress1);

  Stream<String?> get address2 => _address2Controller.stream;

  Stream<String> get countryOfResidence => _countryOfResidenceController.stream
      .transform(validateCountryOfResidence);

  Stream<String> get stateOfResidence =>
      _stateOfResidenceController.stream.transform(validateStateOfResidence);

  Stream<String> get cityOfResidence =>
      _cityOfResidenceController.stream.transform(validateCityOfResidence);

  Stream<String> get gender =>
      _genderController.stream.transform(validateGender);

  Stream<String> get occupation =>
      occupationController.stream.transform(validateOccupation);

  Stream<String> get occupationCategory =>
      occupationCategoryController.stream.transform(validateOccupation);

  Stream<String> get otherOccupation =>
      othersOccupationController.stream.transform(validateOccupation);

  Stream<String> get maritalStatus =>
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

  Stream<String?> get passport => _uploadPassportController.stream;

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

  Function(String) get changeAccountType => _accountTypeController.sink.add;

  Function(String) get changeLatitude => _latitudeController.sink.add;

  Function(Category) get changeFormCategory =>
      _currentFormCategoryController.sink.add;

  Function(String) get changeLongitude => _longitudeController.sink.add;

  Function(String?) get changeHolderType =>
      _accountHolderTypeController.sink.add;

  Function(String?) get changeRiskRank => _riskRankController.sink.add;

  Function(String) get changeAccountCategory =>
      _accountCategoryController.sink.add;

  Function(String) get changeTin => _tinController.sink.add;

  Function(String?) get changeTitle => _titleController.sink.add;

  Function(String) get changeSurname => _surnameController.sink.add;

  Function(String) get changeFirstName => _firstNameController.sink.add;

  Function(String) get changeOtherName => _otherNameController.sink.add;

  Function(String) get changeMothersMaidenName =>
      _mothersMaidenNameController.sink.add;

  Function(String) get changeDateOfBirth => _dateOfBirthController.sink.add;

  Function(String) get changePlaceOfBirth => _placeOfBirthController.sink.add;

  Function(String) get changeMMDA => _mmdaController.sink.add;

  Function(String?) get changeCountryOfOrigin =>
      _countryOfOriginController.sink.add;

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePhone => _phoneNumberController.sink.add;

  Function(String) get changeNextOfKin => _nextOfKinController.sink.add;

  Function(String) get changeAddress1 => _address1Controller.sink.add;

  Function(String) get changeAddress2 => _address2Controller.sink.add;

  Function(String?) get changeCountryOfResidence =>
      _countryOfResidenceController.sink.add;

  Function(String) get changeStateOfResidence =>
      _stateOfResidenceController.sink.add;

  updateStateRegion(String? value) {
    _stateOfResidenceController.sink.add(value);
  }

  Function(String) get changeCityOfResidence =>
      _cityOfResidenceController.sink.add;

  Function(String?) get changeGender => _genderController.sink.add;

  Function(String) get changeOccupation => occupationController.sink.add;

  Function(String) get changeOccupationCategory =>
      occupationCategoryController.sink.add;

  Function(String) get changeOtherOccupation =>
      othersOccupationController.sink.add;
  Function(String?) get changeMaritalStatus =>
      _maritalStatusController.sink.add;

  Function(String) get changeIdType => _idTypeController.sink.add;

  Function(String) get changeIdIssuer => _idIssuerController.sink.add;

  Function(String) get changeIdOtherIssuer =>
      _idIssuerOthersController.sink.add;

  Function(String) get changeIdNumber => _idNumberController.sink.add;

  Function(String?) get changePlaceOfIssue =>
      _idPlaceOfIssueController.sink.add;

  Function(String) get changeIssueDate => _idIssueDateController.sink.add;

  Function(String) get changeExpiryDate => _idExpiryDateController.sink.add;

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

  Function(String) get changeRequestingBranch =>
      _requestingBranchController.sink.add;

  Function(String) get changeDestinationBranch =>
      _destinationBranchController.sink.add;

  Function(String) get changePreferredNameOnCard =>
      _preferredNameOnCardController.sink.add;

  Function(bool) get changeMaritalStatusValue =>
      _isMaritalStatusChangeController.sink.add;

//  Function(bool) get changeIsRequestHardwareToken =>
//      _isRequestHardwareTokenController.sink.add;
//
//  Function(bool) get changeIsRequestInternetBanking =>
//      _isRequestInternetBankingController.sink.add;

  Function(String?) get changeSignature => _uploadSignatureController.sink.add;

  setAccountType(String value) {
    _accountTypeController.sink.add(value);
  }

  setAccountHolderType(String value) {
    _accountHolderTypeController.sink.add(value);
  }

  setRiskRankType(String value) {
    _riskRankController.sink.add(value);
  }

  setAccountCategory(String value) {
    _accountCategoryController.sink.add(value);
  }

  setDateOfBirth(String value) {
    _dateOfBirthController.sink.add(value);
  }

  setUploadIdForm(String value) {
    _uploadIdImageController.sink.add(value);
  }

  setUploadPassportForm(String value) {
    _uploadPassportController.sink.add(value);
  }

  setUploadUtilityBillForm(String value) {
    _uploadUtilityBillController.sink.add(value);
  }

  setSignature(String? value) {
    _uploadSignatureController.sink.add(value);
    changeSignature(value);
  }

  setOccupation(String value) {
    occupationController.sink.add(value);
    changeOccupation;
  }

  setOccupationCategory(String value) {
    occupationCategoryController.sink.add(value);
    changeOccupationCategory;
  }

  setCardType(String value) {
    cardTypeController.sink.add(value);
    changeCardType;
  }

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
    final validUploadPassportInBase64 = _uploadPassportController.valueOrNull;
    final validUploadUtilityBillInBase64 =
        _uploadUtilityBillController.valueOrNull;

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

  submit() async {
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

    var validEmail = _emailController.valueOrNull;
    double validLatitude = double.parse(_latitudeController.value);
    double validLongitude = double.parse(_longitudeController.value);
    final validPhone = _phoneNumberController.valueOrNull;
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

    var validIdType = _idTypeController.valueOrNull;
    var validIdIssuer = _idIssuerController.valueOrNull;
    if (validIdIssuer == "OTHERS") {
      validIdIssuer = _idIssuerOthersController.valueOrNull;
    }
    var validIdNumber = _idNumberController.valueOrNull;
    var validIdPlaceOfIssue = _idPlaceOfIssueController.valueOrNull != null
        ? _idPlaceOfIssueController.valueOrNull
        : '';
    var validIdIssueDate = _idIssueDateController.valueOrNull;
    var validIdExpiryDate = _idExpiryDateController.valueOrNull;
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
    final validUploadPassportInBase64 = _uploadPassportController.valueOrNull;
    final validUploadUtilityBillInBase64 =
        _uploadUtilityBillController.valueOrNull;

    final validUploadSignatureInBase64 = _uploadSignatureController.valueOrNull;

    if (validAccountType == null) {
      _accountTypeController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not selected an account type.");
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

    if (regex.hasMatch(validNextOfKin)) {
      _nextOfKinController.addError("Field is required");
      _subjectSaveAccountResponse
          .addError("You have not filled in a valid next of kin");

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
      // _idPlaceOfIssueController.addError("Field is required");
      // _subjectSaveAccountResponse
      //     .addError("You have not selected a valid id place of issue");
      // return;
    } else if (validIdPlaceOfIssue == null &&
        validAccountCategory == easy_classic) {
      validIdPlaceOfIssue = "";
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
//    if (validIdIssueDate == null && validAccountCategory != easy_classic  &&
//        (validIdType != STUDENT_ID ||
//        validIdType != OTHERS ||
//        validIdType != SSNIT_CARD)) {
//      _idIssueDateController.addError("Field is required");
//      _subjectSaveAccountResponse
//          .addError("You have not selected a valid issue date");
//
//      return;
//    } else if (validIdIssueDate == null &&
//        validAccountCategory == easy_classic) {
//      validIdIssueDate = "";
//    }

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
    Attachment _passportAttachment;
    Attachment _utilityBillAttachment;
    Attachment _signatoryAttachment;

    if (validUploadIdImageInBase64 != null) {
      _idCardAttachment = new Attachment(
          encodedImage: validUploadIdImageInBase64, type: 'IdentityCard');
      _attachments.add(_idCardAttachment);
    }

    if (validUploadPassportInBase64 != null) {
      _passportAttachment = new Attachment(
          encodedImage: validUploadPassportInBase64, type: 'PassportPhoto');
      _attachments.add(_passportAttachment);
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
      idIssueDate: validIdIssueDate,
      idExpiryDate: validIdExpiryDate,
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
    );

    String json = jsonEncode(_accountForm);

    sendAccountsToApi(json);
    print('Final Object: $json');

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

  BehaviorSubject<String?> get uploadUtilityBillController =>
      _uploadUtilityBillController;

  BehaviorSubject<String?> get uploadPassportController =>
      _uploadPassportController;

  BehaviorSubject<String?> get uploadSignatureController =>
      _uploadSignatureController;

  sendAccountsToApi(String encodedAccount) async {
    try {
      SaveAccountResponse response =
          await _accountsRepository.attemptSubmitAccountToApi(encodedAccount);

      var offlineId = _idController.valueOrNull;
      if (offlineId != null) {
        await _accountsRepository.deleteOfflineAccount(offlineId);
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
    _surnameController.close();
    _firstNameController.close();
    _otherNameController.close();
    _mothersMaidenNameController.close();
    _dateOfBirthController.close();
    _placeOfBirthController.close();
    _mmdaController.close();
    _countryOfOriginController.close();
    _emailController.close();
    _phoneNumberController.close();
    _nextOfKinController.close();
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
    _uploadPassportController.close();
    _uploadUtilityBillController.close();
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
  }

  final PublishSubject<String> _subjectOfflineDetailsResponse =
      PublishSubject<String>();

  PublishSubject<String> get subjectOfflineDetailsResponse =>
      _subjectOfflineDetailsResponse;

  getOfflineAccountDetailsByRefId(String? referenceId) async {
    _isEditModeController.add(true);

    await _accountsRepository
        .getOfflineAccountByRefId(referenceId)
        .then((offlineAccount) {
      if (offlineAccount != null) {
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

        if (offlineAccount.passport != null &&
            offlineAccount.passport!.isNotEmpty) {
          _uploadPassportController.add(offlineAccount.passport);
        }
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

  getAccountsDetailsByReferenceId(String? referenceId) async {
    _referenceIdController.add(referenceId);

    await _accountsRepository
        .getAccountsDetailsByReference(referenceId)
        .then((accountResponse) async {
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

            var mmda = states
                .firstWhere(
                    (x) => x.srn.toString() == accountResponse.data!.state)
                .mmda
                .toString(); //hotfix: to solve issue of mmda  filter from state on edit

            // if (mmda != null)
            _mmdaController.add(mmda);
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
          _tinController.add(CryptoHelper.decrypt(accountResponse.data!.tin));
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
          _stateOfResidenceController
              .add(accountResponse.data!.signatoryDetails!.first.stateOfOrigin);
        }
        _countryOfOriginController.add('GHANA');

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
          _phoneNumberController.add(CryptoHelper.decrypt(
              accountResponse.data!.signatoryDetails!.first.phoneNumber!));
        }

        if (accountResponse.data!.signatoryDetails?.first.nextOfKin != null &&
            accountResponse
                .data!.signatoryDetails!.first.nextOfKin!.isNotEmpty) {
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
          occupationController
              .add(accountResponse.data!.signatoryDetails!.first.occupation);
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

        if (accountResponse.data!.signatoryDetails?.first.attachments != null) {
          var _idCardAttachment = accountResponse
              .data!.signatoryDetails!.first.attachments!
              .where((i) => i.type == 'IdentityCard')
              .toList();

          var _passportAttachment = accountResponse
              .data!.signatoryDetails!.first.attachments!
              .where((i) => i.type == 'PassportPhoto')
              .toList();

          var _utilityBillAttachment = accountResponse
              .data!.signatoryDetails!.first.attachments!
              .where((i) => i.type == 'UtilityBill')
              .toList();

          var _signatoryAttachment = accountResponse
              .data!.signatoryDetails!.first.attachments!
              .where((i) => i.type == 'Signatory')
              .toList();

          if (_idCardAttachment.isNotEmpty) {
            _uploadIdImageController.add(_idCardAttachment.first.encodedImage);
          }

          if (_passportAttachment.isNotEmpty) {
            _uploadPassportController
                .add(_passportAttachment.first.encodedImage);
          }

          if (_utilityBillAttachment.isNotEmpty) {
            _uploadUtilityBillController
                .add(_utilityBillAttachment.first.encodedImage);
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
      _subjectAccountsDetailsResponse.addError(error);
    });
  }
}

//Note: This creates a global instance of Bloc that's automatically exported and can be accessed anywhere in the app
//final bloc = Bloc();
