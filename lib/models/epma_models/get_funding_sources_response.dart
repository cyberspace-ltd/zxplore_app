// 


// To parse this JSON data, do
//
//     final GetFundingSourceToEditResponse = GetFundingSourceToEditResponseFromJson(jsonString?);

import 'dart:convert';

GetFundingSourceToEditResponse GetFundingSourceToEditResponseFromJson(String? str) => GetFundingSourceToEditResponse.fromJson(json.decode(str!));

String? GetFundingSourceToEditResponseToJson(GetFundingSourceToEditResponse data) => json.encode(data.toJson());

class GetFundingSourceToEditResponse {
    int? code;
    bool? status;
    String? message;
    GetFundingSourceData data;

    GetFundingSourceToEditResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetFundingSourceToEditResponse.fromJson(Map<String?, dynamic> json) => GetFundingSourceToEditResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: GetFundingSourceData.fromJson(json["data"]),
    );

    Map<String?, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class GetFundingSourceData {
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

    GetFundingSourceData({
        required this.fundingSourcesId,
        required this.reqId,
        required this.rowVersion,
        required this.itemStage,
        required this.commissions,
        required this.dividends,
        required this.businessIncome,
        required this.personalSavings,
        required this.trustFund,
        required this.salary,
        required this.familyFriends,
        required this.rentalIncome,
        required this.inheritanceGift,
        required this.others,
        required this.othersSpecify,
        required this.actionFlag,
    });

    factory GetFundingSourceData.fromJson(Map<String?, dynamic> json) => GetFundingSourceData(
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

    Map<String?, dynamic> toJson() => {
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
