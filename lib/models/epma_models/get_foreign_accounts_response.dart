
// To parse this JSON data, do
//
//     final GetForeignAccountToEditResponse = GetForeignAccountToEditResponseFromJson(jsonString);

import 'dart:convert';

GetForeignAccountToEditResponse GetForeignAccountToEditResponseFromJson(String str) => GetForeignAccountToEditResponse.fromJson(json.decode(str));

String GetForeignAccountToEditResponseToJson(GetForeignAccountToEditResponse data) => json.encode(data.toJson());

class GetForeignAccountToEditResponse {
    int code;
    bool status;
    String message;
    Data data;

    GetForeignAccountToEditResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetForeignAccountToEditResponse.fromJson(Map<String, dynamic> json) => GetForeignAccountToEditResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int foreignAccountId;
    String reqId;
    int rowVersion;
    String itemStage;
    bool hasRelatedAccount;
    String relatedAccount;
    bool maintainMandate;
    bool offShoreUsd;
    bool offShoreGbp;
    bool offShoreEur;
    bool onShoreUsd;
    bool onShoreGbp;
    bool onShoreEur;
    bool accountPurposeSalary;
    bool accountPurposeBusiness;
    bool accountPurposeOther;
    String accountPurposeOtherSpecify;
    bool fundSourceSalary;
    bool fundSourceBusinessIncome;
    bool fundSourceOther;
    String fundSourceOtherSpecify;
    String fundSourceSenderInvester;
    bool inflowFrequencyWeekly;
    bool inflowFrequencyFortnightly;
    bool inflowFrequencyMonthly;
    bool inflowFrequencyQuarterly;
    bool inflowFrequencyOther;
    String inflowFrequencyOtherSpecify;
    String actionFlag;

    Data({
        required this.foreignAccountId,
        required this.reqId,
        required this.rowVersion,
        required this.itemStage,
        required this.hasRelatedAccount,
        required this.relatedAccount,
        required this.maintainMandate,
        required this.offShoreUsd,
        required this.offShoreGbp,
        required this.offShoreEur,
        required this.onShoreUsd,
        required this.onShoreGbp,
        required this.onShoreEur,
        required this.accountPurposeSalary,
        required this.accountPurposeBusiness,
        required this.accountPurposeOther,
        required this.accountPurposeOtherSpecify,
        required this.fundSourceSalary,
        required this.fundSourceBusinessIncome,
        required this.fundSourceOther,
        required this.fundSourceOtherSpecify,
        required this.fundSourceSenderInvester,
        required this.inflowFrequencyWeekly,
        required this.inflowFrequencyFortnightly,
        required this.inflowFrequencyMonthly,
        required this.inflowFrequencyQuarterly,
        required this.inflowFrequencyOther,
        required this.inflowFrequencyOtherSpecify,
        required this.actionFlag,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        foreignAccountId: json["foreignAccountId"],
        reqId: json["reqId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        hasRelatedAccount: json["hasRelatedAccount"],
        relatedAccount: json["relatedAccount"],
        maintainMandate: json["maintainMandate"],
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

    Map<String, dynamic> toJson() => {
        "foreignAccountId": foreignAccountId,
        "reqId": reqId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "hasRelatedAccount": hasRelatedAccount,
        "relatedAccount": relatedAccount,
        "maintainMandate": maintainMandate,
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



