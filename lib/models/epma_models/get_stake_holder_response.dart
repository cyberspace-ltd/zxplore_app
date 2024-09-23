
// To parse this JSON data, do
//
//     final GetStakeHolderToEditResponse = GetStakeHolderToEditResponseFromJson(jsonString);

import 'dart:convert';

import 'package:zxplore_app/models/country_model.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';

GetStakeHolderToEditResponse GetStakeHolderToEditResponseFromJson(String str) => GetStakeHolderToEditResponse.fromJson(json.decode(str));

String GetStakeHolderToEditResponseToJson(GetStakeHolderToEditResponse data) => json.encode(data.toJson());

class GetStakeHolderToEditResponse {
    int code;
    bool status;
    String message;
    StakeHolderData data;

    GetStakeHolderToEditResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetStakeHolderToEditResponse.fromJson(Map<String, dynamic> json) => GetStakeHolderToEditResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: StakeHolderData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}


class StakeHolderData {
    int stakeHolderId;
    String reqId;
    int rowVersion;
    String itemStage;
    int rimNo;
    String firstName;
    String middleName;
    String lastName;
    String otherName;
    String motherName;
    DateTime birthDate;
    String birthPlace;
    String genderCode;
    int identificationTypeId;
    String identificationNo;
    String idCountryCode;
    String idIssueAuthority;
    DateTime idIssueDate;
    DateTime idExpiryDate;
    String niaVerificationNo;
    bool hasPermanentResidence;
    String residencePermitNo;
    String residencePermitPlaceCode;
    DateTime residencePermitIssueDate;
    DateTime residencePermitExpiryDate;
    String countryCode;
    String homeTown;
    String occupation;
    String jobTitle;
    String residentialAddress;
    String residentialAddress2;
    String regionCode;
    String city;
    String permanentResidentialAddress;
    String permanentResidentialCountryCode;
    String permanentResidentialCity;
    String districtAssemblyArea;
    String businessPhoneNo;
    String emailAddress;
    bool isDirector;
    bool isSignatory;
    bool isPrincipalOfficer;
    int relAuthCode;
    String actionFlag;
    String tin;
    bool setupZPrompt;
    bool setupStatementViaEmail;
    bool setupEmailIndemnity;
    bool isNewRequest;
    IdentificationType identificationType;
    Country country;
    Gender gender;
    Region region;
    Country permanentResidenceCountry;
    Country idCountry;
    String gpsAddress;

    StakeHolderData({
        required this.stakeHolderId,
        required this.reqId,
        required this.rowVersion,
        required this.itemStage,
        required this.rimNo,
        required this.firstName,
        required this.middleName,
        required this.lastName,
        required this.otherName,
        required this.motherName,
        required this.birthDate,
        required this.birthPlace,
        required this.genderCode,
        required this.identificationTypeId,
        required this.identificationNo,
        required this.idCountryCode,
        required this.idIssueAuthority,
        required this.idIssueDate,
        required this.idExpiryDate,
        required this.niaVerificationNo,
        required this.hasPermanentResidence,
        required this.residencePermitNo,
        required this.residencePermitPlaceCode,
        required this.residencePermitIssueDate,
        required this.residencePermitExpiryDate,
        required this.countryCode,
        required this.homeTown,
        required this.occupation,
        required this.jobTitle,
        required this.residentialAddress,
        required this.residentialAddress2,
        required this.regionCode,
        required this.city,
        required this.permanentResidentialAddress,
        required this.permanentResidentialCountryCode,
        required this.permanentResidentialCity,
        required this.districtAssemblyArea,
        required this.businessPhoneNo,
        required this.emailAddress,
        required this.isDirector,
        required this.isSignatory,
        required this.isPrincipalOfficer,
        required this.relAuthCode,
        required this.actionFlag,
        required this.tin,
        required this.setupZPrompt,
        required this.setupStatementViaEmail,
        required this.setupEmailIndemnity,
        required this.isNewRequest,
        required this.identificationType,
        required this.country,
        required this.gender,
        required this.region,
        required this.permanentResidenceCountry,
        required this.idCountry,
        required this.gpsAddress,
    });

    factory StakeHolderData.fromJson(Map<String, dynamic> json) => StakeHolderData(
        stakeHolderId: json["stakeHolderId"],
        reqId: json["reqId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        rimNo: json["rimNo"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        otherName: json["otherName"],
        motherName: json["motherName"],
        birthDate: DateTime.parse(json["birthDate"]),
        birthPlace: json["birthPlace"],
        genderCode: json["genderCode"],
        identificationTypeId: json["identificationTypeId"],
        identificationNo: json["identificationNo"],
        idCountryCode: json["idCountryCode"],
        idIssueAuthority: json["idIssueAuthority"],
        idIssueDate: DateTime.parse(json["idIssueDate"]),
        idExpiryDate: DateTime.parse(json["idExpiryDate"]),
        niaVerificationNo: json["niaVerificationNo"],
        hasPermanentResidence: json["hasPermanentResidence"],
        residencePermitNo: json["residencePermitNo"],
        residencePermitPlaceCode: json["residencePermitPlaceCode"],
        residencePermitIssueDate: DateTime.parse(json["residencePermitIssueDate"]),
        residencePermitExpiryDate: DateTime.parse(json["residencePermitExpiryDate"]),
        countryCode: json["countryCode"],
        homeTown: json["homeTown"],
        occupation: json["occupation"],
        jobTitle: json["jobTitle"],
        residentialAddress: json["residentialAddress"],
        residentialAddress2: json["residentialAddress2"],
        regionCode: json["regionCode"],
        city: json["city"],
        permanentResidentialAddress: json["permanentResidentialAddress"],
        permanentResidentialCountryCode: json["permanentResidentialCountryCode"],
        permanentResidentialCity: json["permanentResidentialCity"],
        districtAssemblyArea: json["districtAssemblyArea"],
        businessPhoneNo: json["businessPhoneNo"],
        emailAddress: json["emailAddress"],
        isDirector: json["isDirector"],
        isSignatory: json["isSignatory"],
        isPrincipalOfficer: json["isPrincipalOfficer"],
        relAuthCode: json["relAuthCode"],
        actionFlag: json["actionFlag"],
        tin: json["tin"],
        setupZPrompt: json["setupZPrompt"],
        setupStatementViaEmail: json["setupStatementViaEmail"],
        setupEmailIndemnity: json["setupEmailIndemnity"],
        isNewRequest: json["isNewRequest"],
        identificationType: IdentificationType.fromJson(json["identificationType"]),
        country: Country.fromJson(json["country"]),
        gender: Gender.fromJson(json["gender"]),
        region: Region.fromJson(json["region"]),
        permanentResidenceCountry: Country.fromJson(json["permanentResidenceCountry"]),
        idCountry: Country.fromJson(json["idCountry"]),
        gpsAddress: json["gpsAddress"],
    );

    Map<String, dynamic> toJson() => {
        "stakeHolderId": stakeHolderId,
        "reqId": reqId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "rimNo": rimNo,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "otherName": otherName,
        "motherName": motherName,
        "birthDate": birthDate.toIso8601String(),
        "birthPlace": birthPlace,
        "genderCode": genderCode,
        "identificationTypeId": identificationTypeId,
        "identificationNo": identificationNo,
        "idCountryCode": idCountryCode,
        "idIssueAuthority": idIssueAuthority,
        "idIssueDate": idIssueDate.toIso8601String(),
        "idExpiryDate": idExpiryDate.toIso8601String(),
        "niaVerificationNo": niaVerificationNo,
        "hasPermanentResidence": hasPermanentResidence,
        "residencePermitNo": residencePermitNo,
        "residencePermitPlaceCode": residencePermitPlaceCode,
        "residencePermitIssueDate": residencePermitIssueDate.toIso8601String(),
        "residencePermitExpiryDate": residencePermitExpiryDate.toIso8601String(),
        "countryCode": countryCode,
        "homeTown": homeTown,
        "occupation": occupation,
        "jobTitle": jobTitle,
        "residentialAddress": residentialAddress,
        "residentialAddress2": residentialAddress2,
        "regionCode": regionCode,
        "city": city,
        "permanentResidentialAddress": permanentResidentialAddress,
        "permanentResidentialCountryCode": permanentResidentialCountryCode,
        "permanentResidentialCity": permanentResidentialCity,
        "districtAssemblyArea": districtAssemblyArea,
        "businessPhoneNo": businessPhoneNo,
        "emailAddress": emailAddress,
        "isDirector": isDirector,
        "isSignatory": isSignatory,
        "isPrincipalOfficer": isPrincipalOfficer,
        "relAuthCode": relAuthCode,
        "actionFlag": actionFlag,
        "tin": tin,
        "setupZPrompt": setupZPrompt,
        "setupStatementViaEmail": setupStatementViaEmail,
        "setupEmailIndemnity": setupEmailIndemnity,
        "isNewRequest": isNewRequest,
        "identificationType": identificationType.toJson(),
        "country": country.toJson(),
        "gender": gender.toJson(),
        "region": region.toJson(),
        "permanentResidenceCountry": permanentResidenceCountry.toJson(),
        "idCountry": idCountry.toJson(),
        "gpsAddress": gpsAddress,
    };
}
 
 



// // To parse this JSON data, do
// //
// //     final getSearchStakeHolderById = getSearchStakeHolderByIdFromJson(jsonString);

// import 'dart:convert';

// GetSearchStakeHolderById getSearchStakeHolderByIdFromJson(String str) => GetSearchStakeHolderById.fromJson(json.decode(str));

// String getSearchStakeHolderByIdToJson(GetSearchStakeHolderById data) => json.encode(data.toJson());

// class GetSearchStakeHolderById {
//     int code;
//     bool status;
//     String message;
//     Data data;

//     GetSearchStakeHolderById({
//         required this.code,
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     factory GetSearchStakeHolderById.fromJson(Map<String, dynamic> json) => GetSearchStakeHolderById(
//         code: json["code"],
//         status: json["status"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "code": code,
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//     };
// }

// class Data {
//     int stakeHolderId;
//     String reqId;
//     int rowVersion;
//     String itemStage;
//     int rimNo;
//     String firstName;
//     String middleName;
//     String lastName;
//     String otherName;
//     String motherName;
//     DateTime birthDate;
//     String birthPlace;
//     String genderCode;
//     int identificationTypeId;
//     String identificationNo;
//     String idCountryCode;
//     String idIssueAuthority;
//     DateTime idIssueDate;
//     DateTime idExpiryDate;
//     String niaVerificationNo;
//     bool hasPermanentResidence;
//     String residencePermitNo;
//     String residencePermitPlaceCode;
//     DateTime residencePermitIssueDate;
//     DateTime residencePermitExpiryDate;
//     String countryCode;
//     String homeTown;
//     String occupation;
//     String jobTitle;
//     String residentialAddress;
//     String residentialAddress2;
//     String regionCode;
//     String city;
//     String permanentResidentialAddress;
//     String permanentResidentialCountryCode;
//     String permanentResidentialCity;
//     String districtAssemblyArea;
//     String businessPhoneNo;
//     String emailAddress;
//     bool isDirector;
//     bool isSignatory;
//     bool isPrincipalOfficer;
//     int relAuthCode;
//     String actionFlag;
//     String tin;
//     bool setupZPrompt;
//     bool setupStatementViaEmail;
//     bool setupEmailIndemnity;
//     bool isNewRequest;
//     IdentificationType identificationType;
//     Country country;
//     Gender gender;
//     Region region;
//     Country permanentResidenceCountry;
//     Country idCountry;
//     String gpsAddress;

//     Data({
//         required this.stakeHolderId,
//         required this.reqId,
//         required this.rowVersion,
//         required this.itemStage,
//         required this.rimNo,
//         required this.firstName,
//         required this.middleName,
//         required this.lastName,
//         required this.otherName,
//         required this.motherName,
//         required this.birthDate,
//         required this.birthPlace,
//         required this.genderCode,
//         required this.identificationTypeId,
//         required this.identificationNo,
//         required this.idCountryCode,
//         required this.idIssueAuthority,
//         required this.idIssueDate,
//         required this.idExpiryDate,
//         required this.niaVerificationNo,
//         required this.hasPermanentResidence,
//         required this.residencePermitNo,
//         required this.residencePermitPlaceCode,
//         required this.residencePermitIssueDate,
//         required this.residencePermitExpiryDate,
//         required this.countryCode,
//         required this.homeTown,
//         required this.occupation,
//         required this.jobTitle,
//         required this.residentialAddress,
//         required this.residentialAddress2,
//         required this.regionCode,
//         required this.city,
//         required this.permanentResidentialAddress,
//         required this.permanentResidentialCountryCode,
//         required this.permanentResidentialCity,
//         required this.districtAssemblyArea,
//         required this.businessPhoneNo,
//         required this.emailAddress,
//         required this.isDirector,
//         required this.isSignatory,
//         required this.isPrincipalOfficer,
//         required this.relAuthCode,
//         required this.actionFlag,
//         required this.tin,
//         required this.setupZPrompt,
//         required this.setupStatementViaEmail,
//         required this.setupEmailIndemnity,
//         required this.isNewRequest,
//         required this.identificationType,
//         required this.country,
//         required this.gender,
//         required this.region,
//         required this.permanentResidenceCountry,
//         required this.idCountry,
//         required this.gpsAddress,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         stakeHolderId: json["stakeHolderId"],
//         reqId: json["reqId"],
//         rowVersion: json["rowVersion"],
//         itemStage: json["itemStage"],
//         rimNo: json["rimNo"],
//         firstName: json["firstName"],
//         middleName: json["middleName"],
//         lastName: json["lastName"],
//         otherName: json["otherName"],
//         motherName: json["motherName"],
//         birthDate: DateTime.parse(json["birthDate"]),
//         birthPlace: json["birthPlace"],
//         genderCode: json["genderCode"],
//         identificationTypeId: json["identificationTypeId"],
//         identificationNo: json["identificationNo"],
//         idCountryCode: json["idCountryCode"],
//         idIssueAuthority: json["idIssueAuthority"],
//         idIssueDate: DateTime.parse(json["idIssueDate"]),
//         idExpiryDate: DateTime.parse(json["idExpiryDate"]),
//         niaVerificationNo: json["niaVerificationNo"],
//         hasPermanentResidence: json["hasPermanentResidence"],
//         residencePermitNo: json["residencePermitNo"],
//         residencePermitPlaceCode: json["residencePermitPlaceCode"],
//         residencePermitIssueDate: DateTime.parse(json["residencePermitIssueDate"]),
//         residencePermitExpiryDate: DateTime.parse(json["residencePermitExpiryDate"]),
//         countryCode: json["countryCode"],
//         homeTown: json["homeTown"],
//         occupation: json["occupation"],
//         jobTitle: json["jobTitle"],
//         residentialAddress: json["residentialAddress"],
//         residentialAddress2: json["residentialAddress2"],
//         regionCode: json["regionCode"],
//         city: json["city"],
//         permanentResidentialAddress: json["permanentResidentialAddress"],
//         permanentResidentialCountryCode: json["permanentResidentialCountryCode"],
//         permanentResidentialCity: json["permanentResidentialCity"],
//         districtAssemblyArea: json["districtAssemblyArea"],
//         businessPhoneNo: json["businessPhoneNo"],
//         emailAddress: json["emailAddress"],
//         isDirector: json["isDirector"],
//         isSignatory: json["isSignatory"],
//         isPrincipalOfficer: json["isPrincipalOfficer"],
//         relAuthCode: json["relAuthCode"],
//         actionFlag: json["actionFlag"],
//         tin: json["tin"],
//         setupZPrompt: json["setupZPrompt"],
//         setupStatementViaEmail: json["setupStatementViaEmail"],
//         setupEmailIndemnity: json["setupEmailIndemnity"],
//         isNewRequest: json["isNewRequest"],
//         identificationType: IdentificationType.fromJson(json["identificationType"]),
//         country: Country.fromJson(json["country"]),
//         gender: Gender.fromJson(json["gender"]),
//         region: Region.fromJson(json["region"]),
//         permanentResidenceCountry: Country.fromJson(json["permanentResidenceCountry"]),
//         idCountry: Country.fromJson(json["idCountry"]),
//         gpsAddress: json["gpsAddress"],
//     );

//     Map<String, dynamic> toJson() => {
//         "stakeHolderId": stakeHolderId,
//         "reqId": reqId,
//         "rowVersion": rowVersion,
//         "itemStage": itemStage,
//         "rimNo": rimNo,
//         "firstName": firstName,
//         "middleName": middleName,
//         "lastName": lastName,
//         "otherName": otherName,
//         "motherName": motherName,
//         "birthDate": birthDate.toIso8601String(),
//         "birthPlace": birthPlace,
//         "genderCode": genderCode,
//         "identificationTypeId": identificationTypeId,
//         "identificationNo": identificationNo,
//         "idCountryCode": idCountryCode,
//         "idIssueAuthority": idIssueAuthority,
//         "idIssueDate": idIssueDate.toIso8601String(),
//         "idExpiryDate": idExpiryDate.toIso8601String(),
//         "niaVerificationNo": niaVerificationNo,
//         "hasPermanentResidence": hasPermanentResidence,
//         "residencePermitNo": residencePermitNo,
//         "residencePermitPlaceCode": residencePermitPlaceCode,
//         "residencePermitIssueDate": residencePermitIssueDate.toIso8601String(),
//         "residencePermitExpiryDate": residencePermitExpiryDate.toIso8601String(),
//         "countryCode": countryCode,
//         "homeTown": homeTown,
//         "occupation": occupation,
//         "jobTitle": jobTitle,
//         "residentialAddress": residentialAddress,
//         "residentialAddress2": residentialAddress2,
//         "regionCode": regionCode,
//         "city": city,
//         "permanentResidentialAddress": permanentResidentialAddress,
//         "permanentResidentialCountryCode": permanentResidentialCountryCode,
//         "permanentResidentialCity": permanentResidentialCity,
//         "districtAssemblyArea": districtAssemblyArea,
//         "businessPhoneNo": businessPhoneNo,
//         "emailAddress": emailAddress,
//         "isDirector": isDirector,
//         "isSignatory": isSignatory,
//         "isPrincipalOfficer": isPrincipalOfficer,
//         "relAuthCode": relAuthCode,
//         "actionFlag": actionFlag,
//         "tin": tin,
//         "setupZPrompt": setupZPrompt,
//         "setupStatementViaEmail": setupStatementViaEmail,
//         "setupEmailIndemnity": setupEmailIndemnity,
//         "isNewRequest": isNewRequest,
//         "identificationType": identificationType.toJson(),
//         "country": country.toJson(),
//         "gender": gender.toJson(),
//         "region": region.toJson(),
//         "permanentResidenceCountry": permanentResidenceCountry.toJson(),
//         "idCountry": idCountry.toJson(),
//         "gpsAddress": gpsAddress,
//     };
// }

  

 

 






