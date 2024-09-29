// To parse this JSON data, do
//
//     final GetAccountPurposeToEditResponse = GetAccountPurposeToEditResponseFromJson(jsonString);

import 'dart:convert';

GetAccountPurposeToEditResponse GetAccountPurposeToEditResponseFromJson(String str) => GetAccountPurposeToEditResponse.fromJson(json.decode(str));

String GetAccountPurposeToEditResponseToJson(GetAccountPurposeToEditResponse data) => json.encode(data.toJson());

class GetAccountPurposeToEditResponse {
    int? code;
    bool? status;
    String? message;
    Data? data;

    GetAccountPurposeToEditResponse({
         this.code,
         this.status,
         this.message,
         this.data,
    });

    factory GetAccountPurposeToEditResponse.fromJson(Map<String, dynamic> json) => GetAccountPurposeToEditResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
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

    Data({
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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

    Map<String, dynamic> toJson() => {
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
