
// To parse this JSON data, do
//
//     final addStakeholder = addStakeholderFromJson(jsonString?);

import 'dart:convert';

AddStakeholder addStakeholderFromJson(String str) => AddStakeholder.fromJson(json.decode(str));

String addStakeholderToJson(AddStakeholder data) => json.encode(data.toJson());

class AddStakeholder {
    int? stakeHolderId;
    String? requestId;
    int? rowVersion;
    String? itemStage;
    int? rimNo;
    String? firstName;
    String? middleName;
    String? lastName;
    String? otherName;
    String? motherName;
    DateTime? birthDate;
    String? birthPlace;
    String? genderCode;
    int? identificationTypeId;
    String? identificationNo;
    String? idCountryCode;
    String? idIssueAuthority;
    DateTime? idIssueDate;
    DateTime? idExpiryDate;
    String? niaVerificationNo;
    bool? hasPermanentResidence;
    String? residencePermitNo;
    String? residencePermitPlaceCode;
    DateTime? residencePermitIssueDate;
    DateTime? residencePermitExpiryDate;
    String? countryCode;
    String? homeTown;
    String? occupation;
    String? jobTitle;
    String? residentialAddress;
    String? residentialAddress2;
    String? regionCode;
    String? city;
    String? permanentResidentialAddress;
    String? permanentResidentialCountryCode;
    String? permanentResidentialCity;
    String? districtAssemblyArea;
    String? businessPhoneNo;
    String? emailAddress;
    bool? isDirector;
    bool? isSignatory;
    bool? isPrincipalOfficer;
    int? relAuthCode;
    String? actionFlag;
    String? tin;
    bool? setupZPrompt;
    bool? setupStatementViaEmail;
    bool? setupEmailIndemnity;
    bool? isNewRequest;
    String? gpsAddress;

    AddStakeholder({
         this.stakeHolderId,
         this.requestId,
         this.rowVersion,
         this.itemStage,
         this.rimNo,
         this.firstName,
         this.middleName,
         this.lastName,
         this.otherName,
         this.motherName,
         this.birthDate,
         this.birthPlace,
         this.genderCode,
         this.identificationTypeId,
         this.identificationNo,
         this.idCountryCode,
         this.idIssueAuthority,
         this.idIssueDate,
         this.idExpiryDate,
         this.niaVerificationNo,
         this.hasPermanentResidence,
         this.residencePermitNo,
         this.residencePermitPlaceCode,
         this.residencePermitIssueDate,
         this.residencePermitExpiryDate,
         this.countryCode,
         this.homeTown,
         this.occupation,
         this.jobTitle,
         this.residentialAddress,
         this.residentialAddress2,
         this.regionCode,
         this.city,
         this.permanentResidentialAddress,
         this.permanentResidentialCountryCode,
         this.permanentResidentialCity,
         this.districtAssemblyArea,
         this.businessPhoneNo,
         this.emailAddress,
         this.isDirector,
         this.isSignatory,
         this.isPrincipalOfficer,
         this.relAuthCode,
         this.actionFlag,
         this.tin,
         this.setupZPrompt,
         this.setupStatementViaEmail,
         this.setupEmailIndemnity,
         this.isNewRequest,
         this.gpsAddress,
    });

    factory AddStakeholder.fromJson(Map<String, dynamic> json) => AddStakeholder(
        stakeHolderId: json["stakeHolderId"],
        requestId: json["requestId"],
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
        gpsAddress: json["gpsAddress"],
    );

    Map<String, dynamic> toJson() => {
        "stakeHolderId": stakeHolderId,
        "requestId": requestId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "rimNo": rimNo,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "otherName": otherName,
        "motherName": motherName,
        "birthDate": birthDate?.toIso8601String(),
        "birthPlace": birthPlace,
        "genderCode": genderCode,
        "identificationTypeId": identificationTypeId,
        "identificationNo": identificationNo,
        "idCountryCode": idCountryCode,
        "idIssueAuthority": idIssueAuthority,
        "idIssueDate": idIssueDate?.toIso8601String(),
        "idExpiryDate": idExpiryDate?.toIso8601String(),
        "niaVerificationNo": niaVerificationNo,
        "hasPermanentResidence": hasPermanentResidence,
        "residencePermitNo": residencePermitNo,
        "residencePermitPlaceCode": residencePermitPlaceCode,
        "residencePermitIssueDate": residencePermitIssueDate?.toIso8601String(),
        "residencePermitExpiryDate": residencePermitExpiryDate?.toIso8601String(),
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
        "gpsAddress": gpsAddress,
    };
}

 
EditStakeholder editStakeholderFromJson(String str) => EditStakeholder.fromJson(json.decode(str));

String editStakeholderToJson(EditStakeholder data) => json.encode(data.toJson());

class EditStakeholder {
    int? stakeHolderId;
    String? requestId;
    int? rowVersion;
    String? itemStage;
    int? rimNo;
    String? firstName;
    String? middleName;
    String? lastName;
    String? otherName;
    String? motherName;
    DateTime? birthDate;
    String? birthPlace;
    String? genderCode;
    int? identificationTypeId;
    String? identificationNo;
    String? idCountryCode;
    String? idIssueAuthority;
    DateTime? idIssueDate;
    DateTime? idExpiryDate;
    String? niaVerificationNo;
    bool? hasPermanentResidence;
    String? residencePermitNo;
    String? residencePermitPlaceCode;
    DateTime? residencePermitIssueDate;
    DateTime? residencePermitExpiryDate;
    String? countryCode;
    String? homeTown;
    String? occupation;
    String? jobTitle;
    String? residentialAddress;
    String? residentialAddress2;
    String? regionCode;
    String? city;
    String? permanentResidentialAddress;
    String? permanentResidentialCountryCode;
    String? permanentResidentialCity;
    String? districtAssemblyArea;
    String? businessPhoneNo;
    String? emailAddress;
    bool? isDirector;
    bool? isSignatory;
    bool? isPrincipalOfficer;
    int? relAuthCode;
    String? actionFlag;
    String? tin;
    bool? setupZPrompt;
    bool? setupStatementViaEmail;
    bool? setupEmailIndemnity;
    bool? isNewRequest;
    String? gpsAddress;

    EditStakeholder({
         this.stakeHolderId,
         this.requestId,
         this.rowVersion,
         this.itemStage,
         this.rimNo,
         this.firstName,
         this.middleName,
         this.lastName,
         this.otherName,
         this.motherName,
         this.birthDate,
         this.birthPlace,
         this.genderCode,
         this.identificationTypeId,
         this.identificationNo,
         this.idCountryCode,
         this.idIssueAuthority,
         this.idIssueDate,
         this.idExpiryDate,
         this.niaVerificationNo,
         this.hasPermanentResidence,
         this.residencePermitNo,
         this.residencePermitPlaceCode,
         this.residencePermitIssueDate,
         this.residencePermitExpiryDate,
         this.countryCode,
         this.homeTown,
         this.occupation,
         this.jobTitle,
         this.residentialAddress,
         this.residentialAddress2,
         this.regionCode,
         this.city,
         this.permanentResidentialAddress,
         this.permanentResidentialCountryCode,
         this.permanentResidentialCity,
         this.districtAssemblyArea,
         this.businessPhoneNo,
         this.emailAddress,
         this.isDirector,
         this.isSignatory,
         this.isPrincipalOfficer,
         this.relAuthCode,
         this.actionFlag,
         this.tin,
         this.setupZPrompt,
         this.setupStatementViaEmail,
         this.setupEmailIndemnity,
         this.isNewRequest,
         this.gpsAddress,
    });

    factory EditStakeholder.fromJson(Map<String, dynamic> json) => EditStakeholder(
        stakeHolderId: json["stakeHolderId"],
        requestId: json["requestId"],
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
        gpsAddress: json["gpsAddress"],
    );

    Map<String?, dynamic> toJson() => {
        "stakeHolderId": stakeHolderId,
        "requestId": requestId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "rimNo": rimNo,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "otherName": otherName,
        "motherName": motherName,
        "birthDate": birthDate?.toIso8601String(),
        "birthPlace": birthPlace,
        "genderCode": genderCode,
        "identificationTypeId": identificationTypeId,
        "identificationNo": identificationNo,
        "idCountryCode": idCountryCode,
        "idIssueAuthority": idIssueAuthority,
        "idIssueDate": idIssueDate?.toIso8601String(),
        "idExpiryDate": idExpiryDate?.toIso8601String(),
        "niaVerificationNo": niaVerificationNo,
        "hasPermanentResidence": hasPermanentResidence,
        "residencePermitNo": residencePermitNo,
        "residencePermitPlaceCode": residencePermitPlaceCode,
        "residencePermitIssueDate": residencePermitIssueDate?.toIso8601String(),
        "residencePermitExpiryDate": residencePermitExpiryDate?.toIso8601String(),
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
        "gpsAddress": gpsAddress,
    };
}


