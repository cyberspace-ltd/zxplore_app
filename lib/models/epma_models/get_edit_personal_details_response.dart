 // To parse this JSON data, do
//
//     final personalDetailsResponse = personalDetailsResponseFromMap(jsonString);

import 'dart:convert';

PersonalDetailsResponse personalDetailsResponseFromMap(String str) => PersonalDetailsResponse.fromMap(json.decode(str));

String personalDetailsResponseToMap(PersonalDetailsResponse data) => json.encode(data.toMap());

class PersonalDetailsResponse {
    int? code;
    bool? status;
    String? message;
    Data? data;

    PersonalDetailsResponse({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory PersonalDetailsResponse.fromMap(Map<String, dynamic> json) => PersonalDetailsResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toMap(),
    };
}

class Data {
    int? formId;
    String? reqId;
    int? rowVersion;
    String? itemStage;
    String? surname;
    String? firstName;
    String? otherNames;
    String? maidenName;
    String? genderCode;
    String? birthDate;
    String? birthPlace;
    int? identificationTypeId;
    String? identificationNo;
    String? idCountryCode;
    String? idIssueAuthority;
    String? idIssueDate;
    String? idExpiryDate;
    String? niaVerificationNo;
    String? ssnitNo;
    String? tin;
    String? citizenshipCode;
    String? altCitizenshipCode;
    String? countryOrigCode;
    String? homeTown;
    bool? hasPermanentResidence;
    String? residencePermitNo;
    String? residencePermitPlaceCode;
    String? permitIssueDate;
    String? permitExpiryDate;
    String? iddCode;
    String? telNo;
    String? mobileNo;
    String? emailAddress;
    String? residentialAddress;
    String? residentialAddress2;
    String? districtAssemblyArea;
    String? city;
    String? regionCode;
    String? permanentResidentialAddress;
    String? permanentResidentialCity;
    String? permanentResidentialCountryCode;
    String? mailingAddress;
    String? motherMaidenName;
    String? maritalStatus;
    String? spouseName;
    String? spouseOccupation;
    String? businessNatureId;
    String? subBusinessNatureId;
    String? employmentTypeCode;
    String? employerName;
    String? timeWithEmployer;
    String? employerAddress;
    String? employerEmail;
    String? employerTel;
    int? monthlyIncome;
    bool? accountOwnership;
    String? accountOwnershipOther;
    bool? customerResidentInGhana;
    bool? customerIsPep;
    String? pepReason;
    String? customerClassificationId;
    bool? setupIbank;
    bool? setupZPrompt;
    bool? setupStatementViaEmail;
    bool? setupEmailIndemnity;
    bool? isPhysicallyChallanged;
    String? actionFlag;
    bool? isNewRequest;
    String? gpsAddress;

    Data({
        this.formId,
        this.reqId,
        this.rowVersion,
        this.itemStage,
        this.surname,
        this.firstName,
        this.otherNames,
        this.maidenName,
        this.genderCode,
        this.birthDate,
        this.birthPlace,
        this.identificationTypeId,
        this.identificationNo,
        this.idCountryCode,
        this.idIssueAuthority,
        this.idIssueDate,
        this.idExpiryDate,
        this.niaVerificationNo,
        this.ssnitNo,
        this.tin,
        this.citizenshipCode,
        this.altCitizenshipCode,
        this.countryOrigCode,
        this.homeTown,
        this.hasPermanentResidence,
        this.residencePermitNo,
        this.residencePermitPlaceCode,
        this.permitIssueDate,
        this.permitExpiryDate,
        this.iddCode,
        this.telNo,
        this.mobileNo,
        this.emailAddress,
        this.residentialAddress,
        this.residentialAddress2,
        this.districtAssemblyArea,
        this.city,
        this.regionCode,
        this.permanentResidentialAddress,
        this.permanentResidentialCity,
        this.permanentResidentialCountryCode,
        this.mailingAddress,
        this.motherMaidenName,
        this.maritalStatus,
        this.spouseName,
        this.spouseOccupation,
        this.businessNatureId,
        this.subBusinessNatureId,
        this.employmentTypeCode,
        this.employerName,
        this.timeWithEmployer,
        this.employerAddress,
        this.employerEmail,
        this.employerTel,
        this.monthlyIncome,
        this.accountOwnership,
        this.accountOwnershipOther,
        this.customerResidentInGhana,
        this.customerIsPep,
        this.pepReason,
        this.customerClassificationId,
        this.setupIbank,
        this.setupZPrompt,
        this.setupStatementViaEmail,
        this.setupEmailIndemnity,
        this.isPhysicallyChallanged,
        this.actionFlag,
        this.isNewRequest,
        this.gpsAddress,
    });

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        formId: json["formId"],
        reqId: json["reqId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        surname: json["surname"],
        firstName: json["firstName"],
        otherNames: json["otherNames"],
        maidenName: json["maidenName"],
        genderCode: json["genderCode"],
        birthDate: json["birthDate"],
        birthPlace: json["birthPlace"],
        identificationTypeId: json["identificationTypeId"],
        identificationNo: json["identificationNo"],
        idCountryCode: json["idCountryCode"],
        idIssueAuthority: json["idIssueAuthority"],
        idIssueDate: json["idIssueDate"],
        idExpiryDate: json["idExpiryDate"],
        niaVerificationNo: json["niaVerificationNo"],
        ssnitNo: json["ssnitNo"],
        tin: json["tin"],
        citizenshipCode: json["citizenshipCode"],
        altCitizenshipCode: json["altCitizenshipCode"],
        countryOrigCode: json["countryOrigCode"],
        homeTown: json["homeTown"],
        hasPermanentResidence: json["hasPermanentResidence"],
        residencePermitNo: json["residencePermitNo"],
        residencePermitPlaceCode: json["residencePermitPlaceCode"],
        permitIssueDate: json["permitIssueDate"],
        permitExpiryDate: json["permitExpiryDate"],
        iddCode: json["iddCode"],
        telNo: json["telNo"],
        mobileNo: json["mobileNo"],
        emailAddress: json["emailAddress"],
        residentialAddress: json["residentialAddress"],
        residentialAddress2: json["residentialAddress2"],
        districtAssemblyArea: json["districtAssemblyArea"],
        city: json["city"],
        regionCode: json["regionCode"],
        permanentResidentialAddress: json["permanentResidentialAddress"],
        permanentResidentialCity: json["permanentResidentialCity"],
        permanentResidentialCountryCode: json["permanentResidentialCountryCode"],
        mailingAddress: json["mailingAddress"],
        motherMaidenName: json["motherMaidenName"],
        maritalStatus: json["maritalStatus"],
        spouseName: json["spouseName"],
        spouseOccupation: json["spouseOccupation"],
        businessNatureId: json["businessNatureId"],
        subBusinessNatureId: json["subBusinessNatureId"],
        employmentTypeCode: json["employmentTypeCode"],
        employerName: json["employerName"],
        timeWithEmployer: json["timeWithEmployer"],
        employerAddress: json["employerAddress"],
        employerEmail: json["employerEmail"],
        employerTel: json["employerTel"],
        monthlyIncome: json["monthlyIncome"],
        accountOwnership: json["accountOwnership"],
        accountOwnershipOther: json["accountOwnershipOther"],
        customerResidentInGhana: json["customerResidentInGhana"],
        customerIsPep: json["customerIsPEP"],
        pepReason: json["pepReason"],
        customerClassificationId: json["customerClassificationId"],
        setupIbank: json["setupIbank"],
        setupZPrompt: json["setupZPrompt"],
        setupStatementViaEmail: json["setupStatementViaEmail"],
        setupEmailIndemnity: json["setupEmailIndemnity"],
        isPhysicallyChallanged: json["isPhysicallyChallanged"],
        actionFlag: json["actionFlag"],
        isNewRequest: json["isNewRequest"],
        gpsAddress: json["gpsAddress"],
    );

    Map<String, dynamic> toMap() => {
        "formId": formId,
        "reqId": reqId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "surname": surname,
        "firstName": firstName,
        "otherNames": otherNames,
        "maidenName": maidenName,
        "genderCode": genderCode,
        "birthDate": birthDate,
        "birthPlace": birthPlace,
        "identificationTypeId": identificationTypeId,
        "identificationNo": identificationNo,
        "idCountryCode": idCountryCode,
        "idIssueAuthority": idIssueAuthority,
        "idIssueDate": idIssueDate,
        "idExpiryDate": idExpiryDate,
        "niaVerificationNo": niaVerificationNo,
        "ssnitNo": ssnitNo,
        "tin": tin,
        "citizenshipCode": citizenshipCode,
        "altCitizenshipCode": altCitizenshipCode,
        "countryOrigCode": countryOrigCode,
        "homeTown": homeTown,
        "hasPermanentResidence": hasPermanentResidence,
        "residencePermitNo": residencePermitNo,
        "residencePermitPlaceCode": residencePermitPlaceCode,
        "permitIssueDate": permitIssueDate,
        "permitExpiryDate": permitExpiryDate,
        "iddCode": iddCode,
        "telNo": telNo,
        "mobileNo": mobileNo,
        "emailAddress": emailAddress,
        "residentialAddress": residentialAddress,
        "residentialAddress2": residentialAddress2,
        "districtAssemblyArea": districtAssemblyArea,
        "city": city,
        "regionCode": regionCode,
        "permanentResidentialAddress": permanentResidentialAddress,
        "permanentResidentialCity": permanentResidentialCity,
        "permanentResidentialCountryCode": permanentResidentialCountryCode,
        "mailingAddress": mailingAddress,
        "motherMaidenName": motherMaidenName,
        "maritalStatus": maritalStatus,
        "spouseName": spouseName,
        "spouseOccupation": spouseOccupation,
        "businessNatureId": businessNatureId,
        "subBusinessNatureId": subBusinessNatureId,
        "employmentTypeCode": employmentTypeCode,
        "employerName": employerName,
        "timeWithEmployer": timeWithEmployer,
        "employerAddress": employerAddress,
        "employerEmail": employerEmail,
        "employerTel": employerTel,
        "monthlyIncome": monthlyIncome,
        "accountOwnership": accountOwnership,
        "accountOwnershipOther": accountOwnershipOther,
        "customerResidentInGhana": customerResidentInGhana,
        "customerIsPEP": customerIsPep,
        "pepReason": pepReason,
        "customerClassificationId": customerClassificationId,
        "setupIbank": setupIbank,
        "setupZPrompt": setupZPrompt,
        "setupStatementViaEmail": setupStatementViaEmail,
        "setupEmailIndemnity": setupEmailIndemnity,
        "isPhysicallyChallanged": isPhysicallyChallanged,
        "actionFlag": actionFlag,
        "isNewRequest": isNewRequest,
        "gpsAddress": gpsAddress,
    };
}
