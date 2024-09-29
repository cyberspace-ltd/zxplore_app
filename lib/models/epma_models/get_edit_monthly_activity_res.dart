// To parse this JSON data, do
//
//     final getMonthlyActivityToEdit = getMonthlyActivityToEditFromJson(jsonString);

import 'dart:convert';

GetMonthlyActivityToEditResponse getMonthlyActivityToEditFromJson(String str) => GetMonthlyActivityToEditResponse.fromJson(json.decode(str));

String getMonthlyActivityToEditToJson(GetMonthlyActivityToEditResponse data) => json.encode(data.toJson());

class GetMonthlyActivityToEditResponse {
    int? code;
    bool?status;
    String? message;
    Data? data;

    GetMonthlyActivityToEditResponse({
         this.code,
         this.status,
         this.message,
         this.data,
    });

    factory GetMonthlyActivityToEditResponse.fromJson(Map<String, dynamic> json) => GetMonthlyActivityToEditResponse(
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
    int? accountTypeId;
    String? reqId;
     String?  itemStage;
    int? rowVersion;
     bool?  current;
     bool?  savings;
     bool?  chequeSave;
     bool?  thumbsUp;
     bool?  zeca;
     bool?  zecaPlus;
     String?  anticipatedDepositeTrans;
    int? anticipatedDepositeAmount;
     String?  anticipatedWithdrawTrans;
    int? anticipatedWithdrawAmount;
    bool? foriegnTransactionExpected;
     String?  actionFlag;

    Data({
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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

    Map<String, dynamic> toJson() => {
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
