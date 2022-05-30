// To parse this JSON data, do
//
//     final accountDetailsResponse = accountDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:zxplore_app/models/account_purposes.dart';
import 'package:zxplore_app/models/transaction_type.dart';

AccountDetailsResponse accountDetailsResponseFromJson(String str) =>
    AccountDetailsResponse.fromJson(json.decode(str));

String accountDetailsResponseToJson(AccountDetailsResponse data) =>
    json.encode(data.toJson());

class AccountDetailsResponse {
  bool? status;
  String? message;
  AccountDetailsData? data;

  AccountDetailsResponse({this.status, this.message, this.data});

  factory AccountDetailsResponse.fromJson(Map<String, dynamic> json) =>
      new AccountDetailsResponse(
        status: json["status"],
        message: json["message"],
        data: AccountDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class AccountDetailsData {
  String? accountType;
  dynamic accountNumber;
  String? accountHolderType;
  String? classCode;
  String? branchNumber;
  String? phoneNumber;
  String? rsmId;
  String? accountName;
  dynamic tin;
  dynamic registrationNumber;
  String? sex;
  String? title;
  String? dateOfBirth;
  String? dateOfIncorporation;
  String? businessNature;
  String? sector;
  String? industry;
  String? riskRank;
  String? addressLine1;
  String? city;
  String? state;
  String? countryOfOrigin;
  List<AccountDetailsSignatoryDetail>? signatoryDetails;
  String? refId;
  String? alertZRequest;
  String? masterCardRequest;
  String? visaCardRequest;
  String? verveCardRequest;
  String? tokenRequest;
  String? ibankRequest;
  String? icardRequest;
  String? cardType;
  String? requestingBranch;
  String? destinationBranch;
  String? preferredNameOnCard;

    String? scanToPayRequest;
  String? zMobileRequest;
  String? zPromptRequest;
  String? statementByEmailRequest;
  String? uSSDRequest;
  String? bankWalletRequest;

  List<TransactionTypes>? transTypes;
  List<AccountPurposes>? acctPurpose;
  List<SourceOfFundsObj>? sourceOfFunds;
  String? employmentTypes;
    String? monthlyIncome;



  AccountDetailsData({
    this.scanToPayRequest,
    this.zMobileRequest,
    this.zPromptRequest,
    this.statementByEmailRequest,
    this.uSSDRequest,
    this.bankWalletRequest,

    this.accountType,
    this.accountNumber,
    this.accountHolderType,
    this.classCode,
    this.branchNumber,
    this.phoneNumber,
    this.rsmId,
    this.accountName,
    this.tin,
    this.registrationNumber,
    this.sex,
    this.title,
    this.dateOfBirth,
    this.dateOfIncorporation,
    this.businessNature,
    this.sector,
    this.industry,
    this.riskRank,
    this.addressLine1,
    this.city,
    this.state,
    this.countryOfOrigin,
    this.signatoryDetails,
    this.refId,
    this.alertZRequest,
    this.masterCardRequest,
    this.visaCardRequest,
    this.verveCardRequest,
    this.tokenRequest,
    this.ibankRequest,
    this.icardRequest,
    this.cardType,
    this.requestingBranch,
    this.destinationBranch,
    this.preferredNameOnCard,

    this.acctPurpose,
    this.employmentTypes,
    this.monthlyIncome,
    this.sourceOfFunds,
    this.transTypes
  });

  factory AccountDetailsData.fromJson(Map<String, dynamic> json) =>
      new AccountDetailsData(
        accountType: json["AccountType"],
        accountNumber: json["AccountNumber"],
        accountHolderType: json["AccountHolderType"],
        classCode: json["ClassCode"],
        branchNumber: json["BranchNumber"],
        phoneNumber: json["PhoneNumber"],
        rsmId: json["RSMId"],
        accountName: json["AccountName"],
        tin: json["TIN"],
        registrationNumber: json["RegistrationNumber"],
        sex: json["Sex"],
        title: json["Title"],
        dateOfBirth: json["DateOfBirth"],
        dateOfIncorporation: json["DateOfIncorporation"],
        businessNature: json["BusinessNature"],
        sector: json["Sector"],
        industry: json["Industry"],
        riskRank: json["RiskRank"],
        addressLine1: json["AddressLine1"],

           scanToPayRequest: json["ScanToPayRequest"],
        zMobileRequest: json["ZMobileRequest"],
        zPromptRequest: json["ZPromptRequest"],
        statementByEmailRequest: json["StatementByEmailRequest"],
        uSSDRequest: json["USSDRequest"],
        bankWalletRequest: json["BankWalletRequest"],



        city: json["City"],
        state: json["State"],
        countryOfOrigin: json["CountryOfOrigin"],
        signatoryDetails: new List<AccountDetailsSignatoryDetail>.from(
            json["SignatoryDetails"]
                .map((x) => AccountDetailsSignatoryDetail.fromJson(x))),
        refId: json["Ref_Id"],
        alertZRequest: json["AlertZRequest"],
        masterCardRequest: json["MasterCardRequest"],
        visaCardRequest: json["VisaCardRequest"],
        verveCardRequest: json["VerveCardRequest"],
        tokenRequest: json["TokenRequest"],
        ibankRequest: json["IbankRequest"],
        icardRequest: json["CardRequest"],
        cardType: json["CardType"],
        requestingBranch: json["RequestingBranch"],
        destinationBranch: json["DestinationBranch"],
        preferredNameOnCard: json["PreferredNameOnCard"],

        monthlyIncome: json["MonthlyIncome"],
        employmentTypes: json["EmploymentTypes"],
        acctPurpose : List<AccountPurposes>.from(json['AccountPurposes'].map((x) => AccountPurposes.fromJson(x))) ,
        transTypes : List<TransactionTypes>.from(json['TransactionTypes'].map((x) => TransactionTypes.fromJson(x))) ,
        sourceOfFunds : List<SourceOfFundsObj>.from(json['SourceOfFunds'].map((x) => SourceOfFundsObj.fromJson(x))) ,



      );

  Map<String, dynamic> toJson() => {
        "AccountType": accountType,
        "AccountNumber": accountNumber,
        "AccountHolderType": accountHolderType,
        "ClassCode": classCode,
        "BranchNumber": branchNumber,
        "PhoneNumber": phoneNumber,
        "RSMId": rsmId,
        "AccountName": accountName,
        "TIN": tin,
        "RegistrationNumber": registrationNumber,
        "Sex": sex,
        "Title": title,
        "DateOfBirth": dateOfBirth,
        "DateOfIncorporation": dateOfIncorporation,
        "BusinessNature": businessNature,
        "Sector": sector,
        "Industry": industry,
        "RiskRank": riskRank,
        "AddressLine1": addressLine1,
      
              "ScanToPayRequest": scanToPayRequest,
        "ZMobileRequest": zMobileRequest,
        "ZPromptRequest": zPromptRequest,
        "StatementByEmailRequest": statementByEmailRequest,
        "USSDRequest": uSSDRequest,
        "BankWalletRequest": bankWalletRequest,


        "City": city,
        "State": state,
        "CountryOfOrigin": countryOfOrigin,
        "SignatoryDetails":
            new List<dynamic>.from(signatoryDetails!.map((x) => x.toJson())),
        "Ref_Id": refId,
        "AlertZRequest": alertZRequest,
        "MasterCardRequest": masterCardRequest,
        "VisaCardRequest": visaCardRequest,
        "VerveCardRequest": verveCardRequest,
        "TokenRequest": tokenRequest,
        "IbankRequest": ibankRequest,
        "CardRequest": icardRequest,
        "CardType": cardType,
        "RequestingBranch": requestingBranch,
        "DestinationBranch": destinationBranch,
        "PreferredNameOnCard": preferredNameOnCard,

        "MonthlyIncome": monthlyIncome,  
        "EmploymentTypes": employmentTypes,  
        "AccountPurposes": new List<dynamic>.from(acctPurpose!.map((x) => x.toJson())),
        "TransactionTypes": new List<dynamic>.from(transTypes!.map((x) => x.toJson())),
        "SourceOfFundsObj": new List<dynamic>.from(sourceOfFunds!.map((x) => x.toJson())),
        
      };
}

class AccountDetailsSignatoryDetail {
  String? firstName;
  String? middleName;
  String? lastName;
  String? sex;
  String? dateOfBirth;
  String? motherMaidenName;
  String? title;
  String? stateOfOrigin;
  String? countryOfOrigin;
  String? meansOfId;
  String? idNumber;
  String? idIssuer;
  String? idPlaceOfIssue;
  String? idIssueDate;
  String? idExpiryDate;
  String? occupation;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? emailAddress;
  String? placeOfBirth;
  String? mmda;
  String? phoneNumber;
  dynamic fax;
  dynamic tin;
  dynamic permitType;
  dynamic cerpacRpIdNo;
  dynamic cerpacRPplaceofIssue;
  dynamic cerpacRpIssueAuth;
  dynamic visaNo;
  dynamic arrivalDate;
  dynamic permitValidFrom;
  dynamic permitValidTo;
  dynamic foreignAddress1;
  dynamic foreignAddress2;
  String? studentLevel;
  dynamic yearOfGraduation;
  dynamic faculty;
  dynamic department;
  String? amlCustType;
  String? amlCustNature;
  String? amlCustNatureBusiness;
  String? useEmailForStatement;
  dynamic passportUrl;
  dynamic signatureUrl;
  dynamic utilityUrl;
  String? maritalStatus;

  String? nextOfKin;
  String? nextOfKinPhone;
  String? nextOfKinRelationship;
  String? nextOfKinGender;
  String? homeTown;


List<AccountDetailsAttachment>? attachments;

  AccountDetailsSignatoryDetail({
    this.firstName,
    this.middleName,
    this.lastName,
    this.sex,
    this.dateOfBirth,
    this.motherMaidenName,
    this.title,
    this.stateOfOrigin,
    this.countryOfOrigin,
    this.meansOfId,
    this.idNumber,
    this.idIssuer,
    this.idPlaceOfIssue,
    this.idIssueDate,
    this.idExpiryDate,
    this.occupation,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.emailAddress,
    this.phoneNumber,
    this.fax,
    this.tin,
    this.placeOfBirth,
    this.mmda,
    this.permitType,
    this.cerpacRpIdNo,
    this.cerpacRPplaceofIssue,
    this.cerpacRpIssueAuth,
    this.visaNo,
    this.arrivalDate,
    this.permitValidFrom,
    this.permitValidTo,
    this.foreignAddress1,
    this.foreignAddress2,
    this.studentLevel,
    this.yearOfGraduation,
    this.faculty,
    this.department,
    this.amlCustType,
    this.amlCustNature,
    this.amlCustNatureBusiness,
    this.useEmailForStatement,
    this.passportUrl,
    this.signatureUrl,
    this.utilityUrl,
    this.maritalStatus,
    this.attachments,


    this.nextOfKin,
    this.nextOfKinGender,
    this.nextOfKinPhone,
    this.nextOfKinRelationship,
    this.homeTown,
  //  this.monthlyIncome
  });

  factory AccountDetailsSignatoryDetail.fromJson(Map<String, dynamic> json) =>
      new AccountDetailsSignatoryDetail(
        firstName: json["FirstName"],
        middleName: json["MiddleName"],
        lastName: json["LastName"],
        sex: json["Sex"],
        dateOfBirth: json["DateOfBirth"],
        motherMaidenName: json["MotherMaidenName"],
        title: json["Title"],
        stateOfOrigin: json["StateOfOrigin"],
        countryOfOrigin: json["CountryOfOrigin"],
        meansOfId: json["MeansOfId"],
        idNumber: json["IdNumber"],
        idIssuer: json["IdIssuer"],
        idPlaceOfIssue: json["IdPlaceOfIssue"],
        idIssueDate: json["IdIssueDate"],
        idExpiryDate: json["IdExpiryDate"],
        occupation: json["Occupation"],
        addressLine1: json["AddressLine1"],
        addressLine2: json["AddressLine2"],
        city: json["City"],
        state: json["State"],
        emailAddress: json["EmailAddress"],
        phoneNumber: json["PhoneNumber"],
        fax: json["Fax"],
        tin: json["TIN"],
        placeOfBirth: json["PlaceOfBirth"],
        mmda: json["MMDA"],
        permitType: json["PermitType"],
        cerpacRpIdNo: json["CerpacRPIdNo"],
        cerpacRPplaceofIssue: json["CerpacRPplaceofIssue"],
        cerpacRpIssueAuth: json["CerpacRPIssueAuth"],
        visaNo: json["VisaNo"],
        arrivalDate: json["ArrivalDate"],
        permitValidFrom: json["PermitValidFrom"],
        permitValidTo: json["PermitValidTo"],
        foreignAddress1: json["ForeignAddress1"],
        foreignAddress2: json["ForeignAddress2"],
        studentLevel: json["StudentLevel"],
        yearOfGraduation: json["YearOfGraduation"],
        faculty: json["Faculty"],
        department: json["Department"],
        amlCustType: json["AmlCustType"],
        amlCustNature: json["AmlCustNature"],
        amlCustNatureBusiness: json["AmlCustNatureBusiness"],
        useEmailForStatement: json["UseEmailForStatement"],
        passportUrl: json["PassportUrl"],
        signatureUrl: json["SignatureUrl"],
        utilityUrl: json["UtilityUrl"],
        maritalStatus: json["MaritalStatus"],

        nextOfKin: json["NextOfKin"],
        nextOfKinPhone: json["NextOfKinPhone"],
        nextOfKinRelationship: json["NextOfKinRelationship"],
        nextOfKinGender: json["NextOfKinGender"],
        homeTown:json["HomeTown"],

    //     monthlyIncome:json["MonthlyIncome"],

        attachments: new List<AccountDetailsAttachment>.from(json["Attachments"]
            .map((x) => AccountDetailsAttachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "FirstName": firstName,
        "MiddleName": middleName,
        "LastName": lastName,
        "Sex": sex,
        "DateOfBirth": dateOfBirth,
        "MotherMaidenName": motherMaidenName,
        "Title": title,
        "StateOfOrigin": stateOfOrigin,
        "CountryOfOrigin": countryOfOrigin,
        "MeansOfId": meansOfId,
        "IdNumber": idNumber,
        "IdIssuer": idIssuer,
        "IdPlaceOfIssue": idPlaceOfIssue,
        "IdIssueDate": idIssueDate,
        "IdExpiryDate": idExpiryDate,
        "Occupation": occupation,
        "AddressLine1": addressLine1,
        "AddressLine2": addressLine2,
        "City": city,
        "State": state,
        "EmailAddress": emailAddress,
        "PhoneNumber": phoneNumber,
        "Fax": fax,
        "TIN": tin,
        "PlaceOfBirth": placeOfBirth,
        "MMDA": mmda,
        "PermitType": permitType,
        "CerpacRPIdNo": cerpacRpIdNo,
        "CerpacRPplaceofIssue": cerpacRPplaceofIssue,
        "CerpacRPIssueAuth": cerpacRpIssueAuth,
        "VisaNo": visaNo,
        "ArrivalDate": arrivalDate,
        "PermitValidFrom": permitValidFrom,
        "PermitValidTo": permitValidTo,
        "ForeignAddress1": foreignAddress1,
        "ForeignAddress2": foreignAddress2,
        "StudentLevel": studentLevel,
        "YearOfGraduation": yearOfGraduation,
        "Faculty": faculty,
        "Department": department,
        "AmlCustType": amlCustType,
        "AmlCustNature": amlCustNature,
        "AmlCustNatureBusiness": amlCustNatureBusiness,
        "UseEmailForStatement": useEmailForStatement,
        "PassportUrl": passportUrl,
        "SignatureUrl": signatureUrl,
        "UtilityUrl": utilityUrl,
        "MaritalStatus": maritalStatus,
   //     "MonthlyIncome" : monthlyIncome,
        "NextOfKin": nextOfKin,
        "NextOfKinPhone": nextOfKinPhone,
        "NextOfKinRelationship": nextOfKinRelationship,
        "NextOfKinGender": nextOfKinGender,
        "HomeTown": homeTown,

        "Attachments":
            new List<dynamic>.from(attachments!.map((x) => x.toJson())),
      };
}

class AccountDetailsAttachment {
  String? encodedImage;
  String? type;

  AccountDetailsAttachment({this.encodedImage, this.type});

  factory AccountDetailsAttachment.fromJson(Map<String, dynamic> json) =>
      new AccountDetailsAttachment(
        encodedImage: json["EncodedImage"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {"EncodedImage": encodedImage, "Type": type};
}
