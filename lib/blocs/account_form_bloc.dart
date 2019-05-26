import 'dart:async';
import 'dart:convert';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/models/bvn_response.dart';
import 'package:zxplore_app/models/form_model.dart';
import 'package:zxplore_app/models/save_account_response.dart';
import 'package:zxplore_app/repositories/accounts_repository.dart';
import 'package:zxplore_app/utils/secure_storage.dart';
import 'package:zxplore_app/utils/zxplore_crypto_helper.dart';

import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class AccountFormBloc extends BlocBase with Validators {
  //Account Information
  final AccountsRepository _accountsRepository = AccountsRepository();

  final _accountTypeController = BehaviorSubject<String>();

  final _accountHolderTypeController = BehaviorSubject<String>();

  final _riskRankController = BehaviorSubject<String>();

  final _accountCategoryController = BehaviorSubject<String>();

  //Personal Information

  final _bvnController = BehaviorSubject<String>();

  final _titleController = BehaviorSubject<String>();

  final _surnameController = BehaviorSubject<String>();

  final _firstNameController = BehaviorSubject<String>();

  final _otherNameController = BehaviorSubject<String>();

  final _mothersMaidenNameController = BehaviorSubject<String>();

  final _dateOfBirthController = BehaviorSubject<String>();

  final _stateOfOriginController = BehaviorSubject<String>();

  final _countryOfOriginController = BehaviorSubject<String>();

  //Contact Details

  final _emailController = BehaviorSubject<String>();

  final _phoneNumberController = BehaviorSubject<String>();

  final _nextOfKinController = BehaviorSubject<String>();

  final _address1Controller = BehaviorSubject<String>();

  final _address2Controller = BehaviorSubject<String>();

  final _countryOfResidenceController = BehaviorSubject<String>();

  final _stateOfResidenceController = BehaviorSubject<String>();

  final _cityOfResidenceController = BehaviorSubject<String>();

  final _genderController = BehaviorSubject<String>();

  final occupationController = BehaviorSubject<String>();

  final _maritalStatusController = BehaviorSubject<String>();

  //Means of Identification
  final _idTypeController = BehaviorSubject<String>();

  final _idIssuerController = BehaviorSubject<String>();

  final _idNumberController = BehaviorSubject<String>();

  final _idPlaceOfIssueController = BehaviorSubject<String>();

  final _idIssueDateController = BehaviorSubject<String>();

  final _idExpiryDateController = BehaviorSubject<String>();

  final _isSendEmailController = BehaviorSubject<bool>();

  final _isReceiveSmsController = BehaviorSubject<bool>();

  final _isRequestHardwareTokenController = BehaviorSubject<bool>();

  final _isRequestInternetBankingController = BehaviorSubject<bool>();

  final _uploadIdImageController = BehaviorSubject<String>();

  final _uploadPassportController = BehaviorSubject<String>();

  final _uploadUtilityBillController = BehaviorSubject<String>();

  final _uploadSignatureController = BehaviorSubject<String>();

  final PublishSubject<SaveAccountResponse> _subjectSaveAccountResponse =
      PublishSubject<SaveAccountResponse>();

  // Add data to stream

  final PublishSubject<BvnResponse> bvnVerificationResponse =
  PublishSubject<BvnResponse>();

  Stream<String> get accountType =>
      _accountTypeController.stream.transform(validateAccountType);

  Stream<String> get accountHolderType =>
      _accountHolderTypeController.stream.transform(validateAccountHolderType);

  Stream<String> get riskRankType =>
      _riskRankController.stream.transform(validateRiskRank);

  Stream<String> get accountCategoryType =>
      _accountCategoryController.stream.transform(validateAccountCategory);

  Stream<String> get bvn => _bvnController.stream;

  Stream<String> get title => _titleController.stream.transform(validateTitle);

  Stream<String> get surname =>
      _surnameController.stream.transform(validateSurname);

  Stream<String> get firstName =>
      _firstNameController.stream.transform(validateFirstName);

  Stream<String> get otherName => _otherNameController.stream;

  Stream<String> get mothersMaidenName =>
      _mothersMaidenNameController.stream.transform(validateMothersMaidenName);

  Stream<String> get dateOfBirth =>
      _dateOfBirthController.stream.transform(validateDateOfBirth);

  Stream<String> get stateOfOrigin =>
      _stateOfOriginController.stream.transform(validateStateOfOrigin);

  Stream<String> get countryOfOrigin =>
      _countryOfOriginController.stream.transform(validateCountryOfOrigin);

  Stream<String> get phoneNumber =>
      _phoneNumberController.stream.transform(validatePhoneNumber);

  Stream<String> get nextOfKin =>
      _nextOfKinController.stream.transform(validateNextOfKin);

  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get address1 =>
      _address1Controller.stream.transform(validateAddress1);

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

  Stream<String> get maritalStatus =>
      _maritalStatusController.stream.transform(validateMaritalStatus);

  Stream<String> get idType =>
      _idTypeController.stream.transform(validateIdType);

  Stream<String> get idIssuer =>
      _idIssuerController.stream.transform(validateIdIssuer);

  Stream<String> get idNumber =>
      _idNumberController.stream.transform(validateIdNumber);

  Stream<String> get idPlaceOfIssue =>
      _idPlaceOfIssueController.stream.transform(validateIdPlaceOfIssue);

  Stream<String> get idIssueDate =>
      _idIssueDateController.stream.transform(validateIdIssueDate);

  Stream<String> get idExpiryDate =>
      _idExpiryDateController.stream.transform(validateIdExpiryDate);

  Stream<bool> get isSendEmail => _isSendEmailController.stream;

  Stream<bool> get isReceiveSmsAlert => _isReceiveSmsController.stream;

  Stream<bool> get isRequestHardwareToken =>
      _isRequestHardwareTokenController.stream;

  Stream<bool> get isRequestInternetBanking =>
      _isRequestInternetBankingController.stream;

  Stream<String> get idCard => _uploadIdImageController.stream;

  Stream<String> get passport => _uploadPassportController.stream;

  Stream<String> get signature => _uploadSignatureController.stream;

//  Stream<bool> get submitValid => Observable.combineLatest4(
//      accountType,
//      accountHolderType,
//      riskRankType,
//      accountCategoryType,
//      (a, ac, r, act) => true);

  Stream<bool> get submitValid =>
      Observable.combineLatest2(phoneNumber, signature, (e, p) => true);

  // change data

  Function(String) get changeAccountType => _accountTypeController.sink.add;

  Function(String) get changeHolderType =>
      _accountHolderTypeController.sink.add;

  Function(String) get changeRiskRank => _riskRankController.sink.add;

  Function(String) get changeAccountCategory =>
      _accountCategoryController.sink.add;

  Function(String) get changeBvn => _bvnController.sink.add;

  Function(String) get changeTitle => _titleController.sink.add;

  Function(String) get changeSurname => _surnameController.sink.add;

  Function(String) get changeFirstName => _firstNameController.sink.add;

  Function(String) get changeOtherName => _otherNameController.sink.add;

  Function(String) get changeMothersMaidenName =>
      _mothersMaidenNameController.sink.add;

  Function(String) get changeDateOfBirth => _dateOfBirthController.sink.add;

  Function(String) get changeStateOfOrigin => _stateOfOriginController.sink.add;

  Function(String) get changeCountryOfOrigin =>
      _countryOfOriginController.sink.add;

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePhone => _phoneNumberController.sink.add;

  Function(String) get changeNextOfKin => _nextOfKinController.sink.add;

  Function(String) get changeAddress1 => _address1Controller.sink.add;

  Function(String) get changeAddress2 => _address2Controller.sink.add;

  Function(String) get changeCountryOfResidence =>
      _countryOfResidenceController.sink.add;

  Function(String) get changeStateOfResidence =>
      _stateOfResidenceController.sink.add;

  Function(String) get changeCityOfResidence =>
      _cityOfResidenceController.sink.add;

  Function(String) get changeGender => _genderController.sink.add;

  Function(String) get changeOccupation => occupationController.sink.add;

  Function(String) get changeMaritalStatus => _maritalStatusController.sink.add;

  Function(String) get changeIdType => _idTypeController.sink.add;

  Function(String) get changeIdIssuer => _idIssuerController.sink.add;

  Function(String) get changeIdNumber => _idNumberController.sink.add;

  Function(String) get changePlaceOfIssue => _idPlaceOfIssueController.sink.add;

  Function(String) get changeIssueDate => _idIssueDateController.sink.add;

  Function(String) get changeExpiryDate => _idExpiryDateController.sink.add;

  Function(bool) get changeIsSendEmail => _isSendEmailController.sink.add;

  Function(bool) get changeIsReceiveSms => _isReceiveSmsController.sink.add;

  Function(bool) get changeIsRequestHardwareToken =>
      _isRequestHardwareTokenController.sink.add;

  Function(bool) get changeIsRequestInternetBanking =>
      _isRequestInternetBankingController.sink.add;

  Function(String) get changeSignature => _uploadSignatureController.sink.add;

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

  setSignature(String value) {
    _uploadSignatureController.sink.add(value);
    changeSignature(value);
  }

  setOccupation(String value) {
    occupationController.sink.add(value);
    changeOccupation;
  }

  submit() async {
    var validAccountType = _accountTypeController.value;
    final validAccountHolderType = _accountHolderTypeController.value;
    final validAccountRiskRank = _riskRankController.value;
    final validAccountCategory = _accountCategoryController.value;

    var validBvn = _bvnController.value;
    final validTitle = _titleController.value;
    final validSurname = _surnameController.value;
    final validFirstName = _firstNameController.value;
    var validOtherName = _otherNameController.value;
    final validMothersMaidenName = _mothersMaidenNameController.value;
    final validDateOfBirth = _dateOfBirthController.value;
    final validStateOfOrigin = _stateOfOriginController.value;
    final validCountryOfOrigin = _countryOfOriginController.value;

    var validEmail = _emailController.value;
    final validPhone = _phoneNumberController.value;
    final validNextOfKin = _nextOfKinController.value;
    final validAddress1 = _address1Controller.value;
    var validAddress2 = _address2Controller.value;
    final validCountryOfResidence = _countryOfResidenceController.value;
    final validStateOfResidence = _stateOfResidenceController.value;
    final validCityOfResidence = _cityOfResidenceController.value;
    final validGender = _genderController.value;
    final validOccupation = occupationController.value;
    final validMaritalStatus = _maritalStatusController.value;

    final validIdType = _idTypeController.value;
    final validIdIssuer = _idIssuerController.value;
    final validIdNumber = _idNumberController.value;
    final validIdPlaceOfIssue = _idPlaceOfIssueController.value;
    final validIdIssueDate = _idIssueDateController.value;
    final validIdExpiryDate = _idExpiryDateController.value;
    final validIsSendEmail = _isSendEmailController.value;
    final validIsReceiveSms = _isReceiveSmsController.value;
    final validIsRequestHardwareToken = _isRequestHardwareTokenController.value;
    final validIsRequestInternetBanking =
        _isRequestInternetBankingController.value;

    final validUploadIdImageInBase64 = _uploadIdImageController.value;
    final validUploadPassportInBase64 = _uploadPassportController.value;
    final validUploadUtilityBillInBase64 = _uploadUtilityBillController.value;

    final validUploadSignatureInBase64 = _uploadSignatureController.value;

    if (validAccountType == null) {
      _accountTypeController.addError("Field is required");
      return;
    }

    if (validAccountHolderType == null) {
      _accountHolderTypeController.addError("Field is required");
      return;
    }

    if (validAccountRiskRank == null) {
      _riskRankController.addError("Field is required");
      return;
    }

    if (validAccountCategory == null) {
      _accountCategoryController.addError("Field is required");
      return;
    }

    if (validTitle == null) {
      _titleController.addError("Field is required");
      return;
    }

    if (validSurname == null) {
      _surnameController.addError("Field is required");
      return;
    }
    if (validFirstName == null) {
      _firstNameController.addError("Field is required");
      return;
    }

    if (validMothersMaidenName == null) {
      _mothersMaidenNameController.addError("Field is required");
      return;
    }

    if (validDateOfBirth == null) {
      _dateOfBirthController.addError("Field is required");
      return;
    }

    if (validStateOfOrigin == null) {
      _stateOfOriginController.addError("Field is required");
      return;
    }

    if (validCountryOfOrigin == null) {
      _countryOfOriginController.addError("Field is required");
      return;
    }

    if (validPhone == null) {
      _phoneNumberController.addError("Field is required");
      return;
    }

    if (validNextOfKin == null) {
      _nextOfKinController.addError("Field is required");
      return;
    }

    if (validAddress1 == null) {
      _address1Controller.addError("Field is required");
      return;
    }

    if (validCountryOfResidence == null) {
      _countryOfResidenceController.addError("Field is required");
      return;
    }
    if (validStateOfResidence == null) {
      _stateOfResidenceController.addError("Field is required");
      return;
    }

    if (validCityOfResidence == null) {
      _cityOfResidenceController.addError("Field is required");
      return;
    }

    if (validGender == null) {
      _genderController.addError("Field is required");
      return;
    }

    if (validOccupation == null) {
      occupationController.addError("Field is required");
      return;
    }

    if (validMaritalStatus == null) {
      _maritalStatusController.addError("Field is required");
      return;
    }
    if (validIdType == null) {
      _idTypeController.addError("Field is required");
      return;
    }

    if (validIdIssuer == null) {
      _idIssuerController.addError("Field is required");
      return;
    }

    if (validIdNumber == null) {
      _idNumberController.addError("Field is required");
      return;
    }

    if (validIdNumber == null) {
      _idNumberController.addError("Field is required");
      return;
    }

    if (validIdPlaceOfIssue == null) {
      _idPlaceOfIssueController.addError("Field is required");
      return;
    }

    if (validIdIssueDate == null) {
      _idIssueDateController.addError("Field is required");
      return;
    }

    if (validIdExpiryDate == null) {
      _idExpiryDateController.addError("Field is required");
      return;
    }

    validAccountType = validAccountType.startsWith('S') ? "SA" : "CA";

    validOtherName = validOtherName != null ? validOtherName : "";

    validAddress2 = validAddress2 != null ? validAddress2 : "";

    validEmail = validEmail != null ? validEmail : "";

    validBvn = validBvn != null ? validBvn : "";

    var validSexAcronym = validGender.startsWith('M') ? "M" : "F";

    var validBranchNumber = await SecureStorage.getBranchNumber();
    var employeeId = await SecureStorage.getEmployeeId();

    var encryptedAccountName =
        CryptoHelper.encrypt('$validFirstName $validOtherName $validSurname');

    var currentTimeStamp = new DateTime.now().millisecondsSinceEpoch;

    var referenceId = '$employeeId${currentTimeStamp.toString().substring(7)}';

    var isAlertRequest = validIsReceiveSms == true ? "Y" : "N";
    var isTokenRequest = validIsRequestHardwareToken == true ? "Y" : "N";
    var isIBankRequest = validIsRequestInternetBanking == true ? "Y" : "N";
    var isEmailStatement = validIsSendEmail == true ? "Y" : "N";

    List<Attachment> _attachments = new List();

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
        stateOfOrigin: validStateOfOrigin,
        countryOfOrigin: validCountryOfOrigin,
        meansOfId: validIdType,
        idNumber: validIdNumber,
        idIssuer: validIdIssuer,
        idPlaceOfIssue: validIdPlaceOfIssue,
        idIssueDate: validIdIssueDate,
        idExpiryDate: validIdExpiryDate,
        occupation: validOccupation,
        addressLine1: CryptoHelper.encrypt(validAddress1),
        addressLine2: (validAddress2.isNotEmpty)
            ? CryptoHelper.encrypt(validAddress2)
            : '',
        city: validCityOfResidence,
        state: validStateOfResidence,
        emailAddress:
            (validEmail.isNotEmpty) ? CryptoHelper.encrypt(validEmail) : '',
        phoneNumber: CryptoHelper.encrypt(validPhone),
        amlCustType: '10',
        amlCustNatureBusiness: '4',
        amlCustNature: '14',
        useEmailForStatement: isEmailStatement,
        bvn: (validBvn.isNotEmpty) ? CryptoHelper.encrypt(validBvn) : '',
        maritalStatus: validMaritalStatus,
        nextOfKin: CryptoHelper.encrypt(validNextOfKin),
        attachments: _attachments);

    List<SignatoryDetail> _signatoryDetails = new List();
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
        riskRank: validAccountRiskRank,
        addressLine1: CryptoHelper.encrypt(validAddress1),
        city: validCityOfResidence,
        state: validStateOfResidence,
        countryOfOrigin: validCountryOfOrigin,
        signatoryDetails: _signatoryDetails,
        refId: referenceId,
        alertZRequest: isAlertRequest,
        masterCardRequest: 'N',
        visaCardRequest: 'N',
        verveCardRequest: 'N',
        tokenRequest: isTokenRequest,
        ibankRequest: isIBankRequest);

    String json = jsonEncode(_accountForm);

    sendAccountsToApi(json);
//    print('Final Object: $json');

//    print(
//        'Account type is $validAccountType, and Account Holder is $validAccountHolderType, '
//        'valid Risk rank $validAccountRiskRank, valid category  = $validAccountCategory, upload id (base 64) - $validUploadIdImageInBase64');
  }

  PublishSubject<SaveAccountResponse> get subjectSaveAccountResponse =>
      _subjectSaveAccountResponse;

  sendAccountsToApi(String encodedAccount) async {
    try {
      SaveAccountResponse response =
          await _accountsRepository.attemptSubmitAccountToApi(encodedAccount);
      _subjectSaveAccountResponse.sink.add(response);
    } catch (error) {
      _subjectSaveAccountResponse.sink.addError(error);
    }
  }

  verifyBvn() async {
    var encodedBVN = CryptoHelper.encrypt(_bvnController.value);

    await _accountsRepository.verifyBvn(encodedBVN).then((bvnResponse) {
      bvnVerificationResponse.add(bvnResponse);

      if (bvnResponse?.responseCode == '00') {
        if (bvnResponse.lastName != null && bvnResponse.lastName.isNotEmpty)
          _surnameController.add(CryptoHelper.decrypt(bvnResponse.lastName));
        if (bvnResponse.firstName != null && bvnResponse.firstName.isNotEmpty)
          _firstNameController.add(CryptoHelper.decrypt(bvnResponse.firstName));
        if (bvnResponse.middleName != null && bvnResponse.middleName.isNotEmpty)
          _otherNameController
              .add(CryptoHelper.decrypt(bvnResponse.middleName));
        if (bvnResponse.email != null && bvnResponse.email.isNotEmpty)
          _emailController.add(CryptoHelper.decrypt(bvnResponse.email));

        if (bvnResponse.title != null && bvnResponse.title.isNotEmpty)
          _titleController.add(bvnResponse.title);

        if (bvnResponse.dateOfBirth != null &&
            bvnResponse.dateOfBirth.isNotEmpty)
          _dateOfBirthController
              .add(CryptoHelper.decrypt(bvnResponse.dateOfBirth));

        if (bvnResponse.gender != null && bvnResponse.gender.isNotEmpty)
          _genderController.add(bvnResponse.gender);

        if (bvnResponse.phoneNumber != null &&
            bvnResponse.phoneNumber.isNotEmpty) {
          var decryptedPhone = CryptoHelper.decrypt(bvnResponse.phoneNumber);
          if (decryptedPhone != null && decryptedPhone.startsWith('0')) {
            decryptedPhone = decryptedPhone.replaceFirst('0', '');
            _phoneNumberController.add(decryptedPhone);
          }
        }
        if (bvnResponse.stateOfOrigin != null &&
            bvnResponse.stateOfOrigin.isNotEmpty)
          _stateOfOriginController.add(bvnResponse.stateOfOrigin.toUpperCase());

        if (bvnResponse.maritalStatus != null &&
            bvnResponse.maritalStatus.isNotEmpty)
          _maritalStatusController.add(bvnResponse.maritalStatus);

        if (bvnResponse.residentialAddress != null &&
            bvnResponse.residentialAddress.isNotEmpty)
          _address1Controller
              .add(CryptoHelper.decrypt(bvnResponse.residentialAddress));

        if (bvnResponse.stateOfResidence != null &&
            bvnResponse.stateOfResidence.isNotEmpty)
          _stateOfResidenceController.add(bvnResponse.stateOfResidence);
      } else {
        bvnVerificationResponse
            .addError('Could not verify the BVN provided. ');
      }
    }).catchError((error) {
      bvnVerificationResponse.addError(error);
    });
  }

  @override
  dispose() {
    _subjectSaveAccountResponse.close();
    _accountTypeController.close();
    _accountHolderTypeController.close();
    _riskRankController.close();
    _accountCategoryController.close();
    _bvnController.close();
    _titleController.close();
    _surnameController.close();
    _firstNameController.close();
    _otherNameController.close();
    _mothersMaidenNameController.close();
    _dateOfBirthController.close();
    _stateOfOriginController.close();
    _countryOfOriginController.close();
    _emailController.close();
    _phoneNumberController.close();
    _nextOfKinController.close();
    _address1Controller.close();
    _address2Controller.close();
    _countryOfResidenceController.close();
    _stateOfResidenceController.close();
    _cityOfResidenceController.close();
    _genderController.close();
    occupationController.close();
    _maritalStatusController.close();
    _idTypeController.close();
    _idIssuerController.close();
    _idNumberController.close();
    _idPlaceOfIssueController.close();
    _idIssueDateController.close();
    _idExpiryDateController.close();
    _isSendEmailController.close();
    _isReceiveSmsController.close();
    _isRequestHardwareTokenController.close();
    _isRequestInternetBankingController.close();
    _uploadIdImageController.close();
    _uploadPassportController.close();
    _uploadUtilityBillController.close();
    _uploadSignatureController.close();
    bvnVerificationResponse.close();
  }
}

//Note: This creates a global instance of Bloc that's automatically exported and can be accessed anywhere in the app
//final bloc = Bloc();
