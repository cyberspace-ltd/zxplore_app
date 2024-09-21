// To parse this JSON data, do
//
//     final viewAccountRequestResponse = viewAccountRequestResponseFromMap(jsonString);

import 'dart:convert';

ViewAccountRequestResponse viewAccountRequestResponseFromMap(String str) => ViewAccountRequestResponse.fromMap(json.decode(str));

String viewAccountRequestResponseToMap(ViewAccountRequestResponse data) => json.encode(data.toMap());

class ViewAccountRequestResponse {
    int? code;
    bool? status;
    String? message;
    ViewAccountRequestData? data;

    ViewAccountRequestResponse({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory ViewAccountRequestResponse.fromMap(Map<String?, dynamic> json) => ViewAccountRequestResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : ViewAccountRequestData.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toMap(),
    };
}

class ViewAccountRequestData {
    String? reqId;
    String? formType;
    int? stageId;
    int? rowVersion;
    int? branchId;
    String? createDate;
    int? userId;
    int? empId;
    bool? isCurrent;
    String? fullName;
    String? rimClass;
    int? rimNo;
    int? kycScore;
    String? complianceFeedBack;
    bool? kycFalsePositive;
    bool? kycScoreCompleted;
    int? rsmId;
    String? rsmName;
    int? authCode;
    String? actionFlag;
    List<FormIndividual>? formIndividual;
    List<ProductsService>? productsServices;
    List<AccountPurpose>? accountPurposes;
    List<FundingSource>? fundingSources;
    List<OtherInformation>? otherInformations;
    List<OtherAccount>? otherAccounts;
    List<ForeignAccount>? foreignAccounts;
    List<DueDiligence>? dueDiligences;
    List<DocumentsObtainedIndividual>? documentsObtainedIndividuals;
    List<AcctReqWkfHistory>? acctReqWkfHistory;
    List<AccountType>? accountType;
    List<NextOfKin>? nextOfKin;
    List<Referee>? referees;
    List<AssignedAcct>? assignedAccts;
    List<Child>? children;
    List<StakeHolder>? stakeHolders;
    List<RelatedBusiness>? relatedBusiness;
    List<TaxJurisdiction>? taxJurisdiction;
    List<DocumentsAttached>? documentsAttached;
    RequestStages? requestStages;
    ZenithBranch? zenithBranch;

   ViewAccountRequestData({
        this.reqId,
        this.formType,
        this.stageId,
        this.rowVersion,
        this.branchId,
        this.createDate,
        this.userId,
        this.empId,
        this.isCurrent,
        this.fullName,
        this.rimClass,
        this.rimNo,
        this.kycScore,
        this.complianceFeedBack,
        this.kycFalsePositive,
        this.kycScoreCompleted,
        this.rsmId,
        this.rsmName,
        this.authCode,
        this.actionFlag,
        this.formIndividual,
        this.productsServices,
        this.accountPurposes,
        this.fundingSources,
        this.otherInformations,
        this.otherAccounts,
        this.foreignAccounts,
        this.dueDiligences,
        this.documentsObtainedIndividuals,
        this.acctReqWkfHistory,
        this.accountType,
        this.nextOfKin,
        this.referees,
        this.assignedAccts,
        this.children,
        this.stakeHolders,
        this.relatedBusiness,
        this.taxJurisdiction,
        this.documentsAttached,
        this.requestStages,
        this.zenithBranch,
    });

    factory ViewAccountRequestData.fromMap(Map<String, dynamic> json) => ViewAccountRequestData(
        reqId: json["reqId"],
        formType: json["formType"],
        stageId: json["stageId"],
        rowVersion: json["rowVersion"],
        branchId: json["branchId"],
        createDate: json["createDate"],
        userId: json["userId"],
        empId: json["empId"],
        isCurrent: json["isCurrent"],
        fullName: json["fullName"],
        rimClass: json["rimClass"],
        rimNo: json["rimNo"],
        kycScore: json["kycScore"],
        complianceFeedBack: json["complianceFeedBack"],
        kycFalsePositive: json["kycFalsePositive"],
        kycScoreCompleted: json["kycScoreCompleted"],
        rsmId: json["rsmId"],
        rsmName: json["rsmName"],
        authCode: json["authCode"],
        actionFlag: json["actionFlag"],
        formIndividual: json["formIndividual"] == null ? [] : List<FormIndividual>.from(json["formIndividual"]!.map((x) => FormIndividual.fromMap(x))),
        productsServices: json["productsServices"] == null ? [] : List<ProductsService>.from(json["productsServices"]!.map((x) => ProductsService.fromMap(x))),
        accountPurposes: json["accountPurposes"] == null ? [] : List<AccountPurpose>.from(json["accountPurposes"]!.map((x) => AccountPurpose.fromMap(x))),
        fundingSources: json["fundingSources"] == null ? [] : List<FundingSource>.from(json["fundingSources"]!.map((x) => FundingSource.fromMap(x))),
        otherInformations: json["otherInformations"] == null ? [] : List<OtherInformation>.from(json["otherInformations"]!.map((x) => OtherInformation.fromMap(x))),
        otherAccounts: json["otherAccounts"] == null ? [] : List<OtherAccount>.from(json["otherAccounts"]!.map((x) => OtherAccount.fromMap(x))),
        foreignAccounts: json["foreignAccounts"] == null ? [] : List<ForeignAccount>.from(json["foreignAccounts"]!.map((x) => ForeignAccount.fromMap(x))),
        dueDiligences: json["dueDiligences"] == null ? [] : List<DueDiligence>.from(json["dueDiligences"]!.map((x) => DueDiligence.fromMap(x))),
        documentsObtainedIndividuals: json["documentsObtainedIndividuals"] == null ? [] : List<DocumentsObtainedIndividual>.from(json["documentsObtainedIndividuals"]!.map((x) => DocumentsObtainedIndividual.fromMap(x))),
        acctReqWkfHistory: json["acctReqWkfHistory"] == null ? [] : List<AcctReqWkfHistory>.from(json["acctReqWkfHistory"]!.map((x) => AcctReqWkfHistory.fromMap(x))),
        accountType: json["accountType"] == null ? [] : List<AccountType>.from(json["accountType"]!.map((x) => AccountType.fromMap(x))),
        nextOfKin: json["nextOfKin"] == null ? [] : List<NextOfKin>.from(json["nextOfKin"]!.map((x) => NextOfKin.fromMap(x))),
        referees: json["referees"] == null ? [] : List<Referee>.from(json["referees"]!.map((x) => Referee.fromMap(x))),
        assignedAccts: json["assignedAccts"] == null ? [] : List<AssignedAcct>.from(json["assignedAccts"]!.map((x) => AssignedAcct.fromMap(x))),
        children: json["children"] == null ? [] : List<Child>.from(json["children"]!.map((x) => Child.fromMap(x))),
        stakeHolders: json["stakeHolders"] == null ? [] : List<StakeHolder>.from(json["stakeHolders"]!.map((x) => StakeHolder.fromMap(x))),
        relatedBusiness: json["relatedBusiness"] == null ? [] : List<RelatedBusiness>.from(json["relatedBusiness"]!.map((x) => RelatedBusiness.fromMap(x))),
        taxJurisdiction: json["taxJurisdiction"] == null ? [] : List<TaxJurisdiction>.from(json["taxJurisdiction"]!.map((x) => TaxJurisdiction.fromMap(x))),
        documentsAttached: json["documentsAttached"] == null ? [] : List<DocumentsAttached>.from(json["documentsAttached"]!.map((x) => DocumentsAttached.fromMap(x))),
        requestStages: json["requestStages"] == null ? null : RequestStages.fromMap(json["requestStages"]),
        zenithBranch: json["zenithBranch"] == null ? null : ZenithBranch.fromMap(json["zenithBranch"]),
    );

    Map<String, dynamic> toMap() => {
        "reqId": reqId,
        "formType": formType,
        "stageId": stageId,
        "rowVersion": rowVersion,
        "branchId": branchId,
        "createDate": createDate,
        "userId": userId,
        "empId": empId,
        "isCurrent": isCurrent,
        "fullName": fullName,
        "rimClass": rimClass,
        "rimNo": rimNo,
        "kycScore": kycScore,
        "complianceFeedBack": complianceFeedBack,
        "kycFalsePositive": kycFalsePositive,
        "kycScoreCompleted": kycScoreCompleted,
        "rsmId": rsmId,
        "rsmName": rsmName,
        "authCode": authCode,
        "actionFlag": actionFlag,
        "formIndividual": formIndividual == null ? [] : List<dynamic>.from(formIndividual!.map((x) => x.toMap())),
        "productsServices": productsServices == null ? [] : List<dynamic>.from(productsServices!.map((x) => x.toMap())),
        "accountPurposes": accountPurposes == null ? [] : List<dynamic>.from(accountPurposes!.map((x) => x.toMap())),
        "fundingSources": fundingSources == null ? [] : List<dynamic>.from(fundingSources!.map((x) => x.toMap())),
        "otherInformations": otherInformations == null ? [] : List<dynamic>.from(otherInformations!.map((x) => x.toMap())),
        "otherAccounts": otherAccounts == null ? [] : List<dynamic>.from(otherAccounts!.map((x) => x.toMap())),
        "foreignAccounts": foreignAccounts == null ? [] : List<dynamic>.from(foreignAccounts!.map((x) => x.toMap())),
        "dueDiligences": dueDiligences == null ? [] : List<dynamic>.from(dueDiligences!.map((x) => x.toMap())),
        "documentsObtainedIndividuals": documentsObtainedIndividuals == null ? [] : List<dynamic>.from(documentsObtainedIndividuals!.map((x) => x.toMap())),
        "acctReqWkfHistory": acctReqWkfHistory == null ? [] : List<dynamic>.from(acctReqWkfHistory!.map((x) => x.toMap())),
        "accountType": accountType == null ? [] : List<dynamic>.from(accountType!.map((x) => x.toMap())),
        "nextOfKin": nextOfKin == null ? [] : List<dynamic>.from(nextOfKin!.map((x) => x.toMap())),
        "referees": referees == null ? [] : List<dynamic>.from(referees!.map((x) => x.toMap())),
        "assignedAccts": assignedAccts == null ? [] : List<dynamic>.from(assignedAccts!.map((x) => x.toMap())),
        "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toMap())),
        "stakeHolders": stakeHolders == null ? [] : List<dynamic>.from(stakeHolders!.map((x) => x.toMap())),
        "relatedBusiness": relatedBusiness == null ? [] : List<dynamic>.from(relatedBusiness!.map((x) => x.toMap())),
        "taxJurisdiction": taxJurisdiction == null ? [] : List<dynamic>.from(taxJurisdiction!.map((x) => x.toMap())),
        "documentsAttached": documentsAttached == null ? [] : List<dynamic>.from(documentsAttached!.map((x) => x.toMap())),
        "requestStages": requestStages?.toMap(),
        "zenithBranch": zenithBranch?.toMap(),
    };
}

class AccountPurpose {
    int? accountPurposesId;
    String? reqId;
    int? rowVersion;
    String? itemStage;
    bool? salaryProcessing;
    bool? toOtainLoan;
    bool? businessTransactional;
    bool? savingsInvestment;
    bool? conductSingleTransaction;
    bool? secutirySafeKeeping;
    bool? accessToBankingServices;
    bool? thirdPartyPayment;
    bool? recieptOfInflows;
    bool? others;
    String? othersSpecify;
    String? actionFlag;

    AccountPurpose({
        this.accountPurposesId,
        this.reqId,
        this.rowVersion,
        this.itemStage,
        this.salaryProcessing,
        this.toOtainLoan,
        this.businessTransactional,
        this.savingsInvestment,
        this.conductSingleTransaction,
        this.secutirySafeKeeping,
        this.accessToBankingServices,
        this.thirdPartyPayment,
        this.recieptOfInflows,
        this.others,
        this.othersSpecify,
        this.actionFlag,
    });

    factory AccountPurpose.fromMap(Map<String, dynamic> json) => AccountPurpose(
        accountPurposesId: json["accountPurposesId"],
        reqId: json["reqId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        salaryProcessing: json["salaryProcessing"],
        toOtainLoan: json["toOtainLoan"],
        businessTransactional: json["businessTransactional"],
        savingsInvestment: json["savingsInvestment"],
        conductSingleTransaction: json["conductSingleTransaction"],
        secutirySafeKeeping: json["secutirySafeKeeping"],
        accessToBankingServices: json["accessToBankingServices"],
        thirdPartyPayment: json["thirdPartyPayment"],
        recieptOfInflows: json["recieptOfInflows"],
        others: json["others"],
        othersSpecify: json["othersSpecify"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toMap() => {
        "accountPurposesId": accountPurposesId,
        "reqId": reqId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "salaryProcessing": salaryProcessing,
        "toOtainLoan": toOtainLoan,
        "businessTransactional": businessTransactional,
        "savingsInvestment": savingsInvestment,
        "conductSingleTransaction": conductSingleTransaction,
        "secutirySafeKeeping": secutirySafeKeeping,
        "accessToBankingServices": accessToBankingServices,
        "thirdPartyPayment": thirdPartyPayment,
        "recieptOfInflows": recieptOfInflows,
        "others": others,
        "othersSpecify": othersSpecify,
        "actionFlag": actionFlag,
    };
}

class AccountType {
    int? accountTypeId;
    String? reqId;
    String? itemStage;
    int? rowVersion;
    bool? current;
    bool? savings;
    bool? chequeSave;
    bool? thumbsUp;
    bool? zeca;
    bool? zecaPlus;
    String? anticipatedDepositeTrans;
    int? anticipatedDepositeAmount;
    String? anticipatedWithdrawTrans;
    int? anticipatedWithdrawAmount;
    bool? foriegnTransactionExpected;
    String? actionFlag;

    AccountType({
        this.accountTypeId,
        this.reqId,
        this.itemStage,
        this.rowVersion,
        this.current,
        this.savings,
        this.chequeSave,
        this.thumbsUp,
        this.zeca,
        this.zecaPlus,
        this.anticipatedDepositeTrans,
        this.anticipatedDepositeAmount,
        this.anticipatedWithdrawTrans,
        this.anticipatedWithdrawAmount,
        this.foriegnTransactionExpected,
        this.actionFlag,
    });

    factory AccountType.fromMap(Map<String, dynamic> json) => AccountType(
        accountTypeId: json["accountTypeId"],
        reqId: json["reqId"],
        itemStage: json["itemStage"],
        rowVersion: json["rowVersion"],
        current: json["current"],
        savings: json["savings"],
        chequeSave: json["chequeSave"],
        thumbsUp: json["thumbsUp"],
        zeca: json["zeca"],
        zecaPlus: json["zecaPlus"],
        anticipatedDepositeTrans: json["anticipatedDepositeTrans"],
        anticipatedDepositeAmount: json["anticipatedDepositeAmount"],
        anticipatedWithdrawTrans: json["anticipatedWithdrawTrans"],
        anticipatedWithdrawAmount: json["anticipatedWithdrawAmount"],
        foriegnTransactionExpected: json["foriegnTransactionExpected"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toMap() => {
        "accountTypeId": accountTypeId,
        "reqId": reqId,
        "itemStage": itemStage,
        "rowVersion": rowVersion,
        "current": current,
        "savings": savings,
        "chequeSave": chequeSave,
        "thumbsUp": thumbsUp,
        "zeca": zeca,
        "zecaPlus": zecaPlus,
        "anticipatedDepositeTrans": anticipatedDepositeTrans,
        "anticipatedDepositeAmount": anticipatedDepositeAmount,
        "anticipatedWithdrawTrans": anticipatedWithdrawTrans,
        "anticipatedWithdrawAmount": anticipatedWithdrawAmount,
        "foriegnTransactionExpected": foriegnTransactionExpected,
        "actionFlag": actionFlag,
    };
}

class AcctReqWkfHistory {
    int? acctReqWkfHistoryId;
    String? reqId;
    String? action;
    String? designation;
    String? comment;
    int? userId;
    String? userFullName;
    String? createDate;

    AcctReqWkfHistory({
        this.acctReqWkfHistoryId,
        this.reqId,
        this.action,
        this.designation,
        this.comment,
        this.userId,
        this.userFullName,
        this.createDate,
    });

    factory AcctReqWkfHistory.fromMap(Map<String, dynamic> json) => AcctReqWkfHistory(
        acctReqWkfHistoryId: json["acctReqWkfHistoryId"],
        reqId: json["reqId"],
        action: json["action"],
        designation: json["designation"],
        comment: json["comment"],
        userId: json["userId"],
        userFullName: json["userFullName"],
        createDate: json["createDate"],
    );

    Map<String, dynamic> toMap() => {
        "acctReqWkfHistoryId": acctReqWkfHistoryId,
        "reqId": reqId,
        "action": action,
        "designation": designation,
        "comment": comment,
        "userId": userId,
        "userFullName": userFullName,
        "createDate": createDate,
    };
}

class AssignedAcct {
    int? assignedAcctId;
    String? reqId;
    String? itemStage;
    String? accountName;
    int? rimNo;
    String? accountClass;
    String? currency;
    String? accountType;
    String? accountSeries;
    String? accountNo;
    String? createDate;
    int? authCode;
    String? recon;
    int? reconStatus;
    String? actionFlag;

    AssignedAcct({
        this.assignedAcctId,
        this.reqId,
        this.itemStage,
        this.accountName,
        this.rimNo,
        this.accountClass,
        this.currency,
        this.accountType,
        this.accountSeries,
        this.accountNo,
        this.createDate,
        this.authCode,
        this.recon,
        this.reconStatus,
        this.actionFlag,
    });

    factory AssignedAcct.fromMap(Map<String, dynamic> json) => AssignedAcct(
        assignedAcctId: json["assignedAcctId"],
        reqId: json["reqId"],
        itemStage: json["itemStage"],
        accountName: json["accountName"],
        rimNo: json["rimNo"],
        accountClass: json["accountClass"],
        currency: json["currency"],
        accountType: json["accountType"],
        accountSeries: json["accountSeries"],
        accountNo: json["accountNo"],
        createDate: json["createDate"],
        authCode: json["authCode"],
        recon: json["recon"],
        reconStatus: json["reconStatus"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toMap() => {
        "assignedAcctId": assignedAcctId,
        "reqId": reqId,
        "itemStage": itemStage,
        "accountName": accountName,
        "rimNo": rimNo,
        "accountClass": accountClass,
        "currency": currency,
        "accountType": accountType,
        "accountSeries": accountSeries,
        "accountNo": accountNo,
        "createDate": createDate,
        "authCode": authCode,
        "recon": recon,
        "reconStatus": reconStatus,
        "actionFlag": actionFlag,
    };
}

class Child {
    int? chidId;
    String? reqId;
    int? rowVersion;
    String? itemStage;
    String? surname;
    String? otherNames;
    String? birthDate;
    String? nationalityCode;
    String? genderCode;
    String? countryOrigCode;
    int? age;
    String? school;
    String? motherName;
    int? maturityAge;
    String? createDate;
    String? actionFlag;
    Gender? gender;
    Nationality? nationality;
    Nationality? originCountry;

    Child({
        this.chidId,
        this.reqId,
        this.rowVersion,
        this.itemStage,
        this.surname,
        this.otherNames,
        this.birthDate,
        this.nationalityCode,
        this.genderCode,
        this.countryOrigCode,
        this.age,
        this.school,
        this.motherName,
        this.maturityAge,
        this.createDate,
        this.actionFlag,
        this.gender,
        this.nationality,
        this.originCountry,
    });

    factory Child.fromMap(Map<String, dynamic> json) => Child(
        chidId: json["chidId"],
        reqId: json["reqId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        surname: json["surname"],
        otherNames: json["otherNames"],
        birthDate: json["birthDate"],
        nationalityCode: json["nationalityCode"],
        genderCode: json["genderCode"],
        countryOrigCode: json["countryOrigCode"],
        age: json["age"],
        school: json["school"],
        motherName: json["motherName"],
        maturityAge: json["maturityAge"],
        createDate: json["createDate"],
        actionFlag: json["actionFlag"],
        gender: json["gender"] == null ? null : Gender.fromMap(json["gender"]),
        nationality: json["nationality"] == null ? null : Nationality.fromMap(json["nationality"]),
        originCountry: json["originCountry"] == null ? null : Nationality.fromMap(json["originCountry"]),
    );

    Map<String, dynamic> toMap() => {
        "chidId": chidId,
        "reqId": reqId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "surname": surname,
        "otherNames": otherNames,
        "birthDate": birthDate,
        "nationalityCode": nationalityCode,
        "genderCode": genderCode,
        "countryOrigCode": countryOrigCode,
        "age": age,
        "school": school,
        "motherName": motherName,
        "maturityAge": maturityAge,
        "createDate": createDate,
        "actionFlag": actionFlag,
        "gender": gender?.toMap(),
        "nationality": nationality?.toMap(),
        "originCountry": originCountry?.toMap(),
    };
}

class Gender {
    String? genderCode;
    String? genderName;

    Gender({
        this.genderCode,
        this.genderName,
    });

    factory Gender.fromMap(Map<String, dynamic> json) => Gender(
        genderCode: json["genderCode"],
        genderName: json["genderName"],
    );

    Map<String, dynamic> toMap() => {
        "genderCode": genderCode,
        "genderName": genderName,
    };
}

class Nationality {
    String? countryCode;
    String? countryName;
    bool? isActive;
    int? adRmNatId;

    Nationality({
        this.countryCode,
        this.countryName,
        this.isActive,
        this.adRmNatId,
    });

    factory Nationality.fromMap(Map<String, dynamic> json) => Nationality(
        countryCode: json["countryCode"],
        countryName: json["countryName"],
        isActive: json["isActive"],
        adRmNatId: json["adRmNatId"],
    );

    Map<String, dynamic> toMap() => {
        "countryCode": countryCode,
        "countryName": countryName,
        "isActive": isActive,
        "adRmNatId": adRmNatId,
    };
}

class DocumentsAttached {
    int? documentsAttachedId;
    String? reqId;
    String? fileName;
    String? fileImage;
    String? fileExtension;
    int? documentTypeId;
    String? createDate;
    int? rowVersion;
    int? empId;
    String? empFullName;
    DocumentType? documentType;

    DocumentsAttached({
        this.documentsAttachedId,
        this.reqId,
        this.fileName,
        this.fileImage,
        this.fileExtension,
        this.documentTypeId,
        this.createDate,
        this.rowVersion,
        this.empId,
        this.empFullName,
        this.documentType,
    });

    factory DocumentsAttached.fromMap(Map<String, dynamic> json) => DocumentsAttached(
        documentsAttachedId: json["documentsAttachedId"],
        reqId: json["reqId"],
        fileName: json["fileName"],
        fileImage: json["fileImage"],
        fileExtension: json["fileExtension"],
        documentTypeId: json["documentTypeId"],
        createDate: json["createDate"],
        rowVersion: json["rowVersion"],
        empId: json["empId"],
        empFullName: json["empFullName"],
        documentType: json["documentType"] == null ? null : DocumentType.fromMap(json["documentType"]),
    );

    Map<String, dynamic> toMap() => {
        "documentsAttachedId": documentsAttachedId,
        "reqId": reqId,
        "fileName": fileName,
        "fileImage": fileImage,
        "fileExtension": fileExtension,
        "documentTypeId": documentTypeId,
        "createDate": createDate,
        "rowVersion": rowVersion,
        "empId": empId,
        "empFullName": empFullName,
        "documentType": documentType?.toMap(),
    };
}

class DocumentType {
    String? documentTypeCode;
    String? documentTypeName;

    DocumentType({
        this.documentTypeCode,
        this.documentTypeName,
    });

    factory DocumentType.fromMap(Map<String, dynamic> json) => DocumentType(
        documentTypeCode: json["documentTypeCode"],
        documentTypeName: json["documentTypeName"],
    );

    Map<String, dynamic> toMap() => {
        "documentTypeCode": documentTypeCode,
        "documentTypeName": documentTypeName,
    };
}

class DocumentsObtainedIndividual {
    int? documentsObtainedIndividualId;
    String? reqId;
    String? identification;
    String? identificationSubmissionDate;
    String? referenceLetter;
    String? referenceLetterSubmissionDate;
    String? passportPhotograph;
    String? passportPhotographSubmissionDate;
    String? mandateCard;
    String? mandateCardSubmissionDate;
    String? residencePermit;
    String? residencePermitSubmissionDate;
    String? utilityBill;
    String? utilityBillSubmissionDate;
    String? locationSketch;
    String? locationSketchSubmissionDate;
    String? enhanceDueDiligence;
    String? enhanceDueDiligenceSubmissionDate;
    String? attestation;
    String? attestationSubmissionDate;
    String? longroductionLetter;
    String? longroductionLetterSubmissionDate;
    String? nonCitizenCard;
    String? nonCitizenCardSubmissionDate;
    String? visitationReport;
    String? visitationReportSubmissionDate;
    String? otherDocumentsProvided;
    String? otherDocumentsProvidedSubmissionDate;
    String? otherDocumentsDeferred;
    String? otherDocumentsDeferredSubmissionDate;
    String? actionFlag;
    int? rowVersion;

    DocumentsObtainedIndividual({
        this.documentsObtainedIndividualId,
        this.reqId,
        this.identification,
        this.identificationSubmissionDate,
        this.referenceLetter,
        this.referenceLetterSubmissionDate,
        this.passportPhotograph,
        this.passportPhotographSubmissionDate,
        this.mandateCard,
        this.mandateCardSubmissionDate,
        this.residencePermit,
        this.residencePermitSubmissionDate,
        this.utilityBill,
        this.utilityBillSubmissionDate,
        this.locationSketch,
        this.locationSketchSubmissionDate,
        this.enhanceDueDiligence,
        this.enhanceDueDiligenceSubmissionDate,
        this.attestation,
        this.attestationSubmissionDate,
        this.longroductionLetter,
        this.longroductionLetterSubmissionDate,
        this.nonCitizenCard,
        this.nonCitizenCardSubmissionDate,
        this.visitationReport,
        this.visitationReportSubmissionDate,
        this.otherDocumentsProvided,
        this.otherDocumentsProvidedSubmissionDate,
        this.otherDocumentsDeferred,
        this.otherDocumentsDeferredSubmissionDate,
        this.actionFlag,
        this.rowVersion,
    });

    factory DocumentsObtainedIndividual.fromMap(Map<String, dynamic> json) => DocumentsObtainedIndividual(
        documentsObtainedIndividualId: json["documentsObtainedIndividualId"],
        reqId: json["reqId"],
        identification: json["identification"],
        identificationSubmissionDate: json["identificationSubmissionDate"],
        referenceLetter: json["referenceLetter"],
        referenceLetterSubmissionDate: json["referenceLetterSubmissionDate"],
        passportPhotograph: json["passportPhotograph"],
        passportPhotographSubmissionDate: json["passportPhotographSubmissionDate"],
        mandateCard: json["mandateCard"],
        mandateCardSubmissionDate: json["mandateCardSubmissionDate"],
        residencePermit: json["residencePermit"],
        residencePermitSubmissionDate: json["residencePermitSubmissionDate"],
        utilityBill: json["utilityBill"],
        utilityBillSubmissionDate: json["utilityBillSubmissionDate"],
        locationSketch: json["locationSketch"],
        locationSketchSubmissionDate: json["locationSketchSubmissionDate"],
        enhanceDueDiligence: json["enhanceDueDiligence"],
        enhanceDueDiligenceSubmissionDate: json["enhanceDueDiligenceSubmissionDate"],
        attestation: json["attestation"],
        attestationSubmissionDate: json["attestationSubmissionDate"],
        longroductionLetter: json["longroductionLetter"],
        longroductionLetterSubmissionDate: json["longroductionLetterSubmissionDate"],
        nonCitizenCard: json["nonCitizenCard"],
        nonCitizenCardSubmissionDate: json["nonCitizenCardSubmissionDate"],
        visitationReport: json["visitationReport"],
        visitationReportSubmissionDate: json["visitationReportSubmissionDate"],
        otherDocumentsProvided: json["otherDocumentsProvided"],
        otherDocumentsProvidedSubmissionDate: json["otherDocumentsProvidedSubmissionDate"],
        otherDocumentsDeferred: json["otherDocumentsDeferred"],
        otherDocumentsDeferredSubmissionDate: json["otherDocumentsDeferredSubmissionDate"],
        actionFlag: json["actionFlag"],
        rowVersion: json["rowVersion"],
    );

    Map<String, dynamic> toMap() => {
        "documentsObtainedIndividualId": documentsObtainedIndividualId,
        "reqId": reqId,
        "identification": identification,
        "identificationSubmissionDate": identificationSubmissionDate,
        "referenceLetter": referenceLetter,
        "referenceLetterSubmissionDate": referenceLetterSubmissionDate,
        "passportPhotograph": passportPhotograph,
        "passportPhotographSubmissionDate": passportPhotographSubmissionDate,
        "mandateCard": mandateCard,
        "mandateCardSubmissionDate": mandateCardSubmissionDate,
        "residencePermit": residencePermit,
        "residencePermitSubmissionDate": residencePermitSubmissionDate,
        "utilityBill": utilityBill,
        "utilityBillSubmissionDate": utilityBillSubmissionDate,
        "locationSketch": locationSketch,
        "locationSketchSubmissionDate": locationSketchSubmissionDate,
        "enhanceDueDiligence": enhanceDueDiligence,
        "enhanceDueDiligenceSubmissionDate": enhanceDueDiligenceSubmissionDate,
        "attestation": attestation,
        "attestationSubmissionDate": attestationSubmissionDate,
        "longroductionLetter": longroductionLetter,
        "longroductionLetterSubmissionDate": longroductionLetterSubmissionDate,
        "nonCitizenCard": nonCitizenCard,
        "nonCitizenCardSubmissionDate": nonCitizenCardSubmissionDate,
        "visitationReport": visitationReport,
        "visitationReportSubmissionDate": visitationReportSubmissionDate,
        "otherDocumentsProvided": otherDocumentsProvided,
        "otherDocumentsProvidedSubmissionDate": otherDocumentsProvidedSubmissionDate,
        "otherDocumentsDeferred": otherDocumentsDeferred,
        "otherDocumentsDeferredSubmissionDate": otherDocumentsDeferredSubmissionDate,
        "actionFlag": actionFlag,
        "rowVersion": rowVersion,
    };
}

class DueDiligence {
    int? dueDiligenceId;
    String? reqId;
    String? fatcaStatus;
    String? actionFlag;
    int? rowVersion;

    DueDiligence({
        this.dueDiligenceId,
        this.reqId,
        this.fatcaStatus,
        this.actionFlag,
        this.rowVersion,
    });

    factory DueDiligence.fromMap(Map<String, dynamic> json) => DueDiligence(
        dueDiligenceId: json["dueDiligenceId"],
        reqId: json["reqId"],
        fatcaStatus: json["fatcaStatus"],
        actionFlag: json["actionFlag"],
        rowVersion: json["rowVersion"],
    );

    Map<String, dynamic> toMap() => {
        "dueDiligenceId": dueDiligenceId,
        "reqId": reqId,
        "fatcaStatus": fatcaStatus,
        "actionFlag": actionFlag,
        "rowVersion": rowVersion,
    };
}

class ForeignAccount {
    int? foreignAccountId;
    String? reqId;
    int? rowVersion;
    String? itemStage;
    bool? hasRelatedAccount;
    String? relatedAccount;
    bool? malongainMandate;
    bool? offShoreUsd;
    bool? offShoreGbp;
    bool? offShoreEur;
    bool? onShoreUsd;
    bool? onShoreGbp;
    bool? onShoreEur;
    bool? accountPurposeSalary;
    bool? accountPurposeBusiness;
    bool? accountPurposeOther;
    String? accountPurposeOtherSpecify;
    bool? fundSourceSalary;
    bool? fundSourceBusinessIncome;
    bool? fundSourceOther;
    String? fundSourceOtherSpecify;
    String? fundSourceSenderInvester;
    bool? inflowFrequencyWeekly;
    bool? inflowFrequencyFortnightly;
    bool? inflowFrequencyMonthly;
    bool? inflowFrequencyQuarterly;
    bool? inflowFrequencyOther;
    String? inflowFrequencyOtherSpecify;
    String? actionFlag;

    ForeignAccount({
        this.foreignAccountId,
        this.reqId,
        this.rowVersion,
        this.itemStage,
        this.hasRelatedAccount,
        this.relatedAccount,
        this.malongainMandate,
        this.offShoreUsd,
        this.offShoreGbp,
        this.offShoreEur,
        this.onShoreUsd,
        this.onShoreGbp,
        this.onShoreEur,
        this.accountPurposeSalary,
        this.accountPurposeBusiness,
        this.accountPurposeOther,
        this.accountPurposeOtherSpecify,
        this.fundSourceSalary,
        this.fundSourceBusinessIncome,
        this.fundSourceOther,
        this.fundSourceOtherSpecify,
        this.fundSourceSenderInvester,
        this.inflowFrequencyWeekly,
        this.inflowFrequencyFortnightly,
        this.inflowFrequencyMonthly,
        this.inflowFrequencyQuarterly,
        this.inflowFrequencyOther,
        this.inflowFrequencyOtherSpecify,
        this.actionFlag,
    });

    factory ForeignAccount.fromMap(Map<String, dynamic> json) => ForeignAccount(
        foreignAccountId: json["foreignAccountId"],
        reqId: json["reqId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        hasRelatedAccount: json["hasRelatedAccount"],
        relatedAccount: json["relatedAccount"],
        malongainMandate: json["malongainMandate"],
        offShoreUsd: json["offShoreUSD"],
        offShoreGbp: json["offShoreGBP"],
        offShoreEur: json["offShoreEUR"],
        onShoreUsd: json["onShoreUSD"],
        onShoreGbp: json["onShoreGBP"],
        onShoreEur: json["onShoreEUR"],
        accountPurposeSalary: json["accountPurposeSalary"],
        accountPurposeBusiness: json["accountPurposeBusiness"],
        accountPurposeOther: json["accountPurposeOther"],
        accountPurposeOtherSpecify: json["accountPurposeOtherSpecify"],
        fundSourceSalary: json["fundSourceSalary"],
        fundSourceBusinessIncome: json["fundSourceBusinessIncome"],
        fundSourceOther: json["fundSourceOther"],
        fundSourceOtherSpecify: json["fundSourceOtherSpecify"],
        fundSourceSenderInvester: json["fundSourceSenderInvester"],
        inflowFrequencyWeekly: json["inflowFrequencyWeekly"],
        inflowFrequencyFortnightly: json["inflowFrequencyFortnightly"],
        inflowFrequencyMonthly: json["inflowFrequencyMonthly"],
        inflowFrequencyQuarterly: json["inflowFrequencyQuarterly"],
        inflowFrequencyOther: json["inflowFrequencyOther"],
        inflowFrequencyOtherSpecify: json["inflowFrequencyOtherSpecify"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toMap() => {
        "foreignAccountId": foreignAccountId,
        "reqId": reqId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "hasRelatedAccount": hasRelatedAccount,
        "relatedAccount": relatedAccount,
        "malongainMandate": malongainMandate,
        "offShoreUSD": offShoreUsd,
        "offShoreGBP": offShoreGbp,
        "offShoreEUR": offShoreEur,
        "onShoreUSD": onShoreUsd,
        "onShoreGBP": onShoreGbp,
        "onShoreEUR": onShoreEur,
        "accountPurposeSalary": accountPurposeSalary,
        "accountPurposeBusiness": accountPurposeBusiness,
        "accountPurposeOther": accountPurposeOther,
        "accountPurposeOtherSpecify": accountPurposeOtherSpecify,
        "fundSourceSalary": fundSourceSalary,
        "fundSourceBusinessIncome": fundSourceBusinessIncome,
        "fundSourceOther": fundSourceOther,
        "fundSourceOtherSpecify": fundSourceOtherSpecify,
        "fundSourceSenderInvester": fundSourceSenderInvester,
        "inflowFrequencyWeekly": inflowFrequencyWeekly,
        "inflowFrequencyFortnightly": inflowFrequencyFortnightly,
        "inflowFrequencyMonthly": inflowFrequencyMonthly,
        "inflowFrequencyQuarterly": inflowFrequencyQuarterly,
        "inflowFrequencyOther": inflowFrequencyOther,
        "inflowFrequencyOtherSpecify": inflowFrequencyOtherSpecify,
        "actionFlag": actionFlag,
    };
}

class FormIndividual {
    int? formId;
    String? reqId;
    int? stageId;
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
    bool? setupIbank;
    bool? setupZPrompt;
    bool? setupStatementViaEmail;
    bool? setupEmailIndemnity;
    bool? isPhysicallyChallanged;
    String? pepReason;
    String? customerClassificationId;
    String? actionFlag;
    String? fullName;
    Region? region;
    AltCitizenship? country;
    AltCitizenship? idCountry;
    AltCitizenship? citizenship;
    AltCitizenship? altCitizenship;
    AltCitizenship? permanentResidenceCountry;
    IdentificationType? identificationType;
    Gender? gender;
    EmploymentType? employmentType;
    AltCitizenship? residencePermitIssuePlace;
    BusinessNature? businessNature;
    SubBusinessNature? subBusinessNature;
    CustomerClassification? customerClassification;
    String? gpsAddress;

    FormIndividual({
        this.formId,
        this.reqId,
        this.stageId,
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
        this.setupIbank,
        this.setupZPrompt,
        this.setupStatementViaEmail,
        this.setupEmailIndemnity,
        this.isPhysicallyChallanged,
        this.pepReason,
        this.customerClassificationId,
        this.actionFlag,
        this.fullName,
        this.region,
        this.country,
        this.idCountry,
        this.citizenship,
        this.altCitizenship,
        this.permanentResidenceCountry,
        this.identificationType,
        this.gender,
        this.employmentType,
        this.residencePermitIssuePlace,
        this.businessNature,
        this.subBusinessNature,
        this.customerClassification,
        this.gpsAddress,
    });

    factory FormIndividual.fromMap(Map<String, dynamic> json) => FormIndividual(
        formId: json["formId"],
        reqId: json["reqId"],
        stageId: json["stageId"],
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
        employerAddress: json["EmployerAddress"],
        employerEmail: json["employerEmail"],
        employerTel: json["employerTel"],
        monthlyIncome: json["monthlyIncome"],
        accountOwnership: json["accountOwnership"],
        accountOwnershipOther: json["accountOwnershipOther"],
        customerResidentInGhana: json["customerResidentInGhana"],
        customerIsPep: json["customerIsPEP"],
        setupIbank: json["setupIbank"],
        setupZPrompt: json["setupZPrompt"],
        setupStatementViaEmail: json["setupStatementViaEmail"],
        setupEmailIndemnity: json["setupEmailIndemnity"],
        isPhysicallyChallanged: json["isPhysicallyChallanged"],
        pepReason: json["pepReason"],
        customerClassificationId: json["customerClassificationId"],
        actionFlag: json["actionFlag"],
        fullName: json["fullName"],
        region: json["region"] == null ? null : Region.fromMap(json["region"]),
        country: json["country"] == null ? null : AltCitizenship.fromMap(json["country"]),
        idCountry: json["idCountry"] == null ? null : AltCitizenship.fromMap(json["idCountry"]),
        citizenship: json["citizenship"] == null ? null : AltCitizenship.fromMap(json["citizenship"]),
        altCitizenship: json["altCitizenship"] == null ? null : AltCitizenship.fromMap(json["altCitizenship"]),
        permanentResidenceCountry: json["permanentResidenceCountry"] == null ? null : AltCitizenship.fromMap(json["permanentResidenceCountry"]),
        identificationType: json["identificationType"] == null ? null : IdentificationType.fromMap(json["identificationType"]),
        gender: json["gender"] == null ? null : Gender.fromMap(json["gender"]),
        employmentType: json["employmentType"] == null ? null : EmploymentType.fromMap(json["employmentType"]),
        residencePermitIssuePlace: json["residencePermitIssuePlace"] == null ? null : AltCitizenship.fromMap(json["residencePermitIssuePlace"]),
        businessNature: json["businessNature"] == null ? null : BusinessNature.fromMap(json["businessNature"]),
        subBusinessNature: json["subBusinessNature"] == null ? null : SubBusinessNature.fromMap(json["subBusinessNature"]),
        customerClassification: json["customerClassification"] == null ? null : CustomerClassification.fromMap(json["customerClassification"]),
        gpsAddress: json["gpsAddress"],
    );

    Map<String, dynamic> toMap() => {
        "formId": formId,
        "reqId": reqId,
        "stageId": stageId,
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
        "EmployerAddress": employerAddress,
        "employerEmail": employerEmail,
        "employerTel": employerTel,
        "monthlyIncome": monthlyIncome,
        "accountOwnership": accountOwnership,
        "accountOwnershipOther": accountOwnershipOther,
        "customerResidentInGhana": customerResidentInGhana,
        "customerIsPEP": customerIsPep,
        "setupIbank": setupIbank,
        "setupZPrompt": setupZPrompt,
        "setupStatementViaEmail": setupStatementViaEmail,
        "setupEmailIndemnity": setupEmailIndemnity,
        "isPhysicallyChallanged": isPhysicallyChallanged,
        "pepReason": pepReason,
        "customerClassificationId": customerClassificationId,
        "actionFlag": actionFlag,
        "fullName": fullName,
        "region": region?.toMap(),
        "country": country?.toMap(),
        "idCountry": idCountry?.toMap(),
        "citizenship": citizenship?.toMap(),
        "altCitizenship": altCitizenship?.toMap(),
        "permanentResidenceCountry": permanentResidenceCountry?.toMap(),
        "identificationType": identificationType?.toMap(),
        "gender": gender?.toMap(),
        "employmentType": employmentType?.toMap(),
        "residencePermitIssuePlace": residencePermitIssuePlace?.toMap(),
        "businessNature": businessNature?.toMap(),
        "subBusinessNature": subBusinessNature?.toMap(),
        "customerClassification": customerClassification?.toMap(),
        "gpsAddress": gpsAddress,
    };
}

class AltCitizenship {
    String? countryCode;
    String? countryName;

    AltCitizenship({
        this.countryCode,
        this.countryName,
    });

    factory AltCitizenship.fromMap(Map<String, dynamic> json) => AltCitizenship(
        countryCode: json["countryCode"],
        countryName: json["countryName"],
    );

    Map<String, dynamic> toMap() => {
        "countryCode": countryCode,
        "countryName": countryName,
    };
}

class BusinessNature {
    String? businessNatureId;
    String? sironCode;
    String? businessNatureName;

    BusinessNature({
        this.businessNatureId,
        this.sironCode,
        this.businessNatureName,
    });

    factory BusinessNature.fromMap(Map<String, dynamic> json) => BusinessNature(
        businessNatureId: json["businessNatureId"],
        sironCode: json["sironCode"],
        businessNatureName: json["businessNatureName"],
    );

    Map<String, dynamic> toMap() => {
        "businessNatureId": businessNatureId,
        "sironCode": sironCode,
        "businessNatureName": businessNatureName,
    };
}

class CustomerClassification {
    String? customerClassificationId;
    String? description;

    CustomerClassification({
        this.customerClassificationId,
        this.description,
    });

    factory CustomerClassification.fromMap(Map<String, dynamic> json) => CustomerClassification(
        customerClassificationId: json["customerClassificationId"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "customerClassificationId": customerClassificationId,
        "description": description,
    };
}

class EmploymentType {
    String? employmentTypeCode;
    String? employmentTypeName;

    EmploymentType({
        this.employmentTypeCode,
        this.employmentTypeName,
    });

    factory EmploymentType.fromMap(Map<String, dynamic> json) => EmploymentType(
        employmentTypeCode: json["employmentTypeCode"],
        employmentTypeName: json["employmentTypeName"],
    );

    Map<String, dynamic> toMap() => {
        "employmentTypeCode": employmentTypeCode,
        "employmentTypeName": employmentTypeName,
    };
}

class IdentificationType {
    int? identificationTypeId;
    String? identificationTypeName;

    IdentificationType({
        this.identificationTypeId,
        this.identificationTypeName,
    });

    factory IdentificationType.fromMap(Map<String, dynamic> json) => IdentificationType(
        identificationTypeId: json["identificationTypeId"],
        identificationTypeName: json["identificationTypeName"],
    );

    Map<String, dynamic> toMap() => {
        "identificationTypeId": identificationTypeId,
        "identificationTypeName": identificationTypeName,
    };
}

class Region {
    String? regionCode;
    String? regionName;

    Region({
        this.regionCode,
        this.regionName,
    });

    factory Region.fromMap(Map<String, dynamic> json) => Region(
        regionCode: json["regionCode"],
        regionName: json["regionName"],
    );

    Map<String, dynamic> toMap() => {
        "regionCode": regionCode,
        "regionName": regionName,
    };
}

class SubBusinessNature {
    String? subBusinessNatureId;
    String? subBusinessNatureName;

    SubBusinessNature({
        this.subBusinessNatureId,
        this.subBusinessNatureName,
    });

    factory SubBusinessNature.fromMap(Map<String, dynamic> json) => SubBusinessNature(
        subBusinessNatureId: json["subBusinessNatureId"],
        subBusinessNatureName: json["subBusinessNatureName"],
    );

    Map<String, dynamic> toMap() => {
        "subBusinessNatureId": subBusinessNatureId,
        "subBusinessNatureName": subBusinessNatureName,
    };
}

class FundingSource {
    int? fundingSourcesId;
    String? reqId;
    int? rowVersion;
    String? itemStage;
    bool? commissions;
    bool? dividends;
    bool? businessIncome;
    bool? personalSavings;
    bool? trustFund;
    bool? salary;
    bool? familyFriends;
    bool? rentalIncome;
    bool? inheritanceGift;
    bool? others;
    String? othersSpecify;
    String? actionFlag;

    FundingSource({
        this.fundingSourcesId,
        this.reqId,
        this.rowVersion,
        this.itemStage,
        this.commissions,
        this.dividends,
        this.businessIncome,
        this.personalSavings,
        this.trustFund,
        this.salary,
        this.familyFriends,
        this.rentalIncome,
        this.inheritanceGift,
        this.others,
        this.othersSpecify,
        this.actionFlag,
    });

    factory FundingSource.fromMap(Map<String, dynamic> json) => FundingSource(
        fundingSourcesId: json["fundingSourcesId"],
        reqId: json["reqId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        commissions: json["commissions"],
        dividends: json["dividends"],
        businessIncome: json["businessIncome"],
        personalSavings: json["personalSavings"],
        trustFund: json["trustFund"],
        salary: json["salary"],
        familyFriends: json["familyFriends"],
        rentalIncome: json["rentalIncome"],
        inheritanceGift: json["inheritanceGift"],
        others: json["others"],
        othersSpecify: json["othersSpecify"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toMap() => {
        "fundingSourcesId": fundingSourcesId,
        "reqId": reqId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "commissions": commissions,
        "dividends": dividends,
        "businessIncome": businessIncome,
        "personalSavings": personalSavings,
        "trustFund": trustFund,
        "salary": salary,
        "familyFriends": familyFriends,
        "rentalIncome": rentalIncome,
        "inheritanceGift": inheritanceGift,
        "others": others,
        "othersSpecify": othersSpecify,
        "actionFlag": actionFlag,
    };
}

class NextOfKin {
    int? nextOfKinId;
    String? reqId;
    int? rowVersion;
    String? itemStage;
    String? fullName;
    String? telNo;
    String? relationship;
    String? genderCode;
    String? residentialAddress;
    String? actionFlag;
    Gender? gender;

    NextOfKin({
        this.nextOfKinId,
        this.reqId,
        this.rowVersion,
        this.itemStage,
        this.fullName,
        this.telNo,
        this.relationship,
        this.genderCode,
        this.residentialAddress,
        this.actionFlag,
        this.gender,
    });

    factory NextOfKin.fromMap(Map<String, dynamic> json) => NextOfKin(
        nextOfKinId: json["nextOfKinId"],
        reqId: json["reqId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        fullName: json["fullName"],
        telNo: json["telNo"],
        relationship: json["relationship"],
        genderCode: json["genderCode"],
        residentialAddress: json["residentialAddress"],
        actionFlag: json["actionFlag"],
        gender: json["gender"] == null ? null : Gender.fromMap(json["gender"]),
    );

    Map<String, dynamic> toMap() => {
        "nextOfKinId": nextOfKinId,
        "reqId": reqId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "fullName": fullName,
        "telNo": telNo,
        "relationship": relationship,
        "genderCode": genderCode,
        "residentialAddress": residentialAddress,
        "actionFlag": actionFlag,
        "gender": gender?.toMap(),
    };
}

class OtherAccount {
    int? otherAccountsId;
    String? reqId;
    String? itemStage;
    int? rowVersion;
    String? bank;
    String? branch;
    String? address;
    String? accountName;
    String? accountNumber;
    String? actionFlag;

    OtherAccount({
        this.otherAccountsId,
        this.reqId,
        this.itemStage,
        this.rowVersion,
        this.bank,
        this.branch,
        this.address,
        this.accountName,
        this.accountNumber,
        this.actionFlag,
    });

    factory OtherAccount.fromMap(Map<String, dynamic> json) => OtherAccount(
        otherAccountsId: json["otherAccountsId"],
        reqId: json["reqId"],
        itemStage: json["itemStage"],
        rowVersion: json["rowVersion"],
        bank: json["bank"],
        branch: json["branch"],
        address: json["address"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toMap() => {
        "otherAccountsId": otherAccountsId,
        "reqId": reqId,
        "itemStage": itemStage,
        "rowVersion": rowVersion,
        "bank": bank,
        "branch": branch,
        "address": address,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "actionFlag": actionFlag,
    };
}

class OtherInformation {
    int? otherInformationId;
    String? reqId;
    String? majorProducts;
    String? keyCustomers;
    String? businessCountryCodeOne;
    String? businessCountryCodeTwo;
    String? businessCountryCodeThree;
    String? businessCountryCodeFour;
    int? rowVersion;
    String? actionFlag;

    OtherInformation({
        this.otherInformationId,
        this.reqId,
        this.majorProducts,
        this.keyCustomers,
        this.businessCountryCodeOne,
        this.businessCountryCodeTwo,
        this.businessCountryCodeThree,
        this.businessCountryCodeFour,
        this.rowVersion,
        this.actionFlag,
    });

    factory OtherInformation.fromMap(Map<String, dynamic> json) => OtherInformation(
        otherInformationId: json["otherInformationId"],
        reqId: json["reqId"],
        majorProducts: json["majorProducts"],
        keyCustomers: json["keyCustomers"],
        businessCountryCodeOne: json["businessCountryCodeOne"],
        businessCountryCodeTwo: json["businessCountryCodeTwo"],
        businessCountryCodeThree: json["businessCountryCodeThree"],
        businessCountryCodeFour: json["businessCountryCodeFour"],
        rowVersion: json["rowVersion"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toMap() => {
        "otherInformationId": otherInformationId,
        "reqId": reqId,
        "majorProducts": majorProducts,
        "keyCustomers": keyCustomers,
        "businessCountryCodeOne": businessCountryCodeOne,
        "businessCountryCodeTwo": businessCountryCodeTwo,
        "businessCountryCodeThree": businessCountryCodeThree,
        "businessCountryCodeFour": businessCountryCodeFour,
        "rowVersion": rowVersion,
        "actionFlag": actionFlag,
    };
}

class ProductsService {
    int? productsServicesId;
    String? reqId;
    String? itemStage;
    int? rowVersion;
    bool? adps;
    bool? easyPay;
    bool? emailNotification;
    bool? internetBanking;
    bool? smsBanking;
    bool? visaCard;
    bool? masterCard;
    bool? zMobile;
    bool? zPrompt;
    String? actionFlag;

    ProductsService({
        this.productsServicesId,
        this.reqId,
        this.itemStage,
        this.rowVersion,
        this.adps,
        this.easyPay,
        this.emailNotification,
        this.internetBanking,
        this.smsBanking,
        this.visaCard,
        this.masterCard,
        this.zMobile,
        this.zPrompt,
        this.actionFlag,
    });

    factory ProductsService.fromMap(Map<String, dynamic> json) => ProductsService(
        productsServicesId: json["productsServicesId"],
        reqId: json["reqId"],
        itemStage: json["itemStage"],
        rowVersion: json["rowVersion"],
        adps: json["adps"],
        easyPay: json["easyPay"],
        emailNotification: json["emailNotification"],
        internetBanking: json["internetBanking"],
        smsBanking: json["smsBanking"],
        visaCard: json["visaCard"],
        masterCard: json["masterCard"],
        zMobile: json["zMobile"],
        zPrompt: json["zPrompt"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toMap() => {
        "productsServicesId": productsServicesId,
        "reqId": reqId,
        "itemStage": itemStage,
        "rowVersion": rowVersion,
        "adps": adps,
        "easyPay": easyPay,
        "emailNotification": emailNotification,
        "internetBanking": internetBanking,
        "smsBanking": smsBanking,
        "visaCard": visaCard,
        "masterCard": masterCard,
        "zMobile": zMobile,
        "zPrompt": zPrompt,
        "actionFlag": actionFlag,
    };
}

class Referee {
    int? refereeId;
    String? reqId;
    int? rowVersion;
    String? itemStage;
    String? name;
    String? address;
    String? accountName;
    String? bankers;
    String? accountNo;
    String? actionFlag;

    Referee({
        this.refereeId,
        this.reqId,
        this.rowVersion,
        this.itemStage,
        this.name,
        this.address,
        this.accountName,
        this.bankers,
        this.accountNo,
        this.actionFlag,
    });

    factory Referee.fromMap(Map<String, dynamic> json) => Referee(
        refereeId: json["refereeId"],
        reqId: json["reqId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        name: json["name"],
        address: json["address"],
        accountName: json["accountName"],
        bankers: json["bankers"],
        accountNo: json["accountNo"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toMap() => {
        "refereeId": refereeId,
        "reqId": reqId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "name": name,
        "address": address,
        "accountName": accountName,
        "bankers": bankers,
        "accountNo": accountNo,
        "actionFlag": actionFlag,
    };
}

class RelatedBusiness {
    int? relatedBusinessId;
    String? reqId;
    int? rowVersion;
    String? itemStage;
    String? name;
    String? address;
    String? relationshipNature;
    String? actionFlag;

    RelatedBusiness({
        this.relatedBusinessId,
        this.reqId,
        this.rowVersion,
        this.itemStage,
        this.name,
        this.address,
        this.relationshipNature,
        this.actionFlag,
    });

    factory RelatedBusiness.fromMap(Map<String, dynamic> json) => RelatedBusiness(
        relatedBusinessId: json["relatedBusinessId"],
        reqId: json["reqId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        name: json["name"],
        address: json["address"],
        relationshipNature: json["relationshipNature"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toMap() => {
        "relatedBusinessId": relatedBusinessId,
        "reqId": reqId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "name": name,
        "address": address,
        "relationshipNature": relationshipNature,
        "actionFlag": actionFlag,
    };
}

class RequestStages {
    int? stageId;
    String? stageDesc;

    RequestStages({
        this.stageId,
        this.stageDesc,
    });

    factory RequestStages.fromMap(Map<String, dynamic> json) => RequestStages(
        stageId: json["stageId"],
        stageDesc: json["stageDesc"],
    );

    Map<String, dynamic> toMap() => {
        "stageId": stageId,
        "stageDesc": stageDesc,
    };
}

class StakeHolder {
    int? stakeHolderId;
    String? reqId;
    int? rowVersion;
    String? itemStage;
    int? rimNo;
    String? firstName;
    String? middleName;
    String? lastName;
    String? otherName;
    String? motherName;
    String? birthDate;
    String? birthPlace;
    String? genderCode;
    int? identificationTypeId;
    String? identificationNo;
    String? idCountryCode;
    String? idIssueAuthority;
    String? idIssueDate;
    String? idExpiryDate;
    String? niaVerificationNo;
    bool? hasPermanentResidence;
    String? residencePermitNo;
    String? residencePermitPlaceCode;
    String? residencePermitIssueDate;
    String? residencePermitExpiryDate;
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
    IdentificationType? identificationType;
    AltCitizenship? country;
    Gender? gender;
    Region? region;
    AltCitizenship? permanentResidenceCountry;
    AltCitizenship? idCountry;
    String? gpsAddress;

    StakeHolder({
        this.stakeHolderId,
        this.reqId,
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
        this.identificationType,
        this.country,
        this.gender,
        this.region,
        this.permanentResidenceCountry,
        this.idCountry,
        this.gpsAddress,
    });

    factory StakeHolder.fromMap(Map<String, dynamic> json) => StakeHolder(
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
        birthDate: json["birthDate"],
        birthPlace: json["birthPlace"],
        genderCode: json["genderCode"],
        identificationTypeId: json["identificationTypeId"],
        identificationNo: json["identificationNo"],
        idCountryCode: json["idCountryCode"],
        idIssueAuthority: json["idIssueAuthority"],
        idIssueDate: json["idIssueDate"],
        idExpiryDate: json["idExpiryDate"],
        niaVerificationNo: json["niaVerificationNo"],
        hasPermanentResidence: json["hasPermanentResidence"],
        residencePermitNo: json["residencePermitNo"],
        residencePermitPlaceCode: json["residencePermitPlaceCode"],
        residencePermitIssueDate: json["residencePermitIssueDate"],
        residencePermitExpiryDate: json["residencePermitExpiryDate"],
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
        identificationType: json["identificationType"] == null ? null : IdentificationType.fromMap(json["identificationType"]),
        country: json["country"] == null ? null : AltCitizenship.fromMap(json["country"]),
        gender: json["gender"] == null ? null : Gender.fromMap(json["gender"]),
        region: json["region"] == null ? null : Region.fromMap(json["region"]),
        permanentResidenceCountry: json["permanentResidenceCountry"] == null ? null : AltCitizenship.fromMap(json["permanentResidenceCountry"]),
        idCountry: json["idCountry"] == null ? null : AltCitizenship.fromMap(json["idCountry"]),
        gpsAddress: json["gpsAddress"],
    );

    Map<String, dynamic> toMap() => {
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
        "birthDate": birthDate,
        "birthPlace": birthPlace,
        "genderCode": genderCode,
        "identificationTypeId": identificationTypeId,
        "identificationNo": identificationNo,
        "idCountryCode": idCountryCode,
        "idIssueAuthority": idIssueAuthority,
        "idIssueDate": idIssueDate,
        "idExpiryDate": idExpiryDate,
        "niaVerificationNo": niaVerificationNo,
        "hasPermanentResidence": hasPermanentResidence,
        "residencePermitNo": residencePermitNo,
        "residencePermitPlaceCode": residencePermitPlaceCode,
        "residencePermitIssueDate": residencePermitIssueDate,
        "residencePermitExpiryDate": residencePermitExpiryDate,
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
        "identificationType": identificationType?.toMap(),
        "country": country?.toMap(),
        "gender": gender?.toMap(),
        "region": region?.toMap(),
        "permanentResidenceCountry": permanentResidenceCountry?.toMap(),
        "idCountry": idCountry?.toMap(),
        "gpsAddress": gpsAddress,
    };
}

class TaxJurisdiction {
    int? taxJurisdictionId;
    String? reqId;
    String? taxResidencyCountryCode;
    String? taxNumber;
    String? taxNumberIssueCountryCode;
    int? rowVersion;
    String? actionFlag;
    String? commonReportingStandardId;
    List<ReportingStandard>? reportingStandard;

    TaxJurisdiction({
        this.taxJurisdictionId,
        this.reqId,
        this.taxResidencyCountryCode,
        this.taxNumber,
        this.taxNumberIssueCountryCode,
        this.rowVersion,
        this.actionFlag,
        this.commonReportingStandardId,
        this.reportingStandard,
    });

    factory TaxJurisdiction.fromMap(Map<String, dynamic> json) => TaxJurisdiction(
        taxJurisdictionId: json["taxJurisdictionId"],
        reqId: json["reqId"],
        taxResidencyCountryCode: json["taxResidencyCountryCode"],
        taxNumber: json["taxNumber"],
        taxNumberIssueCountryCode: json["taxNumberIssueCountryCode"],
        rowVersion: json["rowVersion"],
        actionFlag: json["actionFlag"],
        commonReportingStandardId: json["commonReportingStandardId"],
        reportingStandard: json["reportingStandard"] == null ? [] : List<ReportingStandard>.from(json["reportingStandard"]!.map((x) => ReportingStandard.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "taxJurisdictionId": taxJurisdictionId,
        "reqId": reqId,
        "taxResidencyCountryCode": taxResidencyCountryCode,
        "taxNumber": taxNumber,
        "taxNumberIssueCountryCode": taxNumberIssueCountryCode,
        "rowVersion": rowVersion,
        "actionFlag": actionFlag,
        "commonReportingStandardId": commonReportingStandardId,
        "reportingStandard": reportingStandard == null ? [] : List<dynamic>.from(reportingStandard!.map((x) => x.toMap())),
    };
}

class ReportingStandard {
    String? commonReportingStandardId;
    String? description;

    ReportingStandard({
        this.commonReportingStandardId,
        this.description,
    });

    factory ReportingStandard.fromMap(Map<String, dynamic> json) => ReportingStandard(
        commonReportingStandardId: json["commonReportingStandardId"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "commonReportingStandardId": commonReportingStandardId,
        "description": description,
    };
}

class ZenithBranch {
    int? branchId;
    String? branchName;

    ZenithBranch({
        this.branchId,
        this.branchName,
    });

    factory ZenithBranch.fromMap(Map<String, dynamic> json) => ZenithBranch(
        branchId: json["branchId"],
        branchName: json["branchName"],
    );

    Map<String, dynamic> toMap() => {
        "branchId": branchId,
        "branchName": branchName,
    };
}
