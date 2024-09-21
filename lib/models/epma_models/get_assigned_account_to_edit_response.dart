// To parse this JSON data, do
//
//     final getAssignedAccountToEditResponse = getAssignedAccountToEditResponsefromJson(jsonString);

import 'dart:convert';

GetAssignedAccountToEditResponse getAssignedAccountToEditResponsefromJson(String str) => GetAssignedAccountToEditResponse.fromJson(json.decode(str));

String getAssignedAccountToEditResponseToMap(GetAssignedAccountToEditResponse data) => json.encode(data.toMap());

class GetAssignedAccountToEditResponse {
    int? code;
    bool? status;
    String? message;
    AssignedAccountToEditData? data;

    GetAssignedAccountToEditResponse({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory GetAssignedAccountToEditResponse.fromJson(Map<String, dynamic> json) => GetAssignedAccountToEditResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : AssignedAccountToEditData.fromJson(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toMap(),
    };
}

class AssignedAccountToEditData {
    int? assignedAcctId;
    String? reqId;
    dynamic itemStage;
    String? accountName;
    String? accountClass;
    String? accountType;
    String? accountNo;
    String? recon;
    String? actionFlag;
    bool? isNewRequest;

    AssignedAccountToEditData({
        this.assignedAcctId,
        this.reqId,
        this.itemStage,
        this.accountName,
        this.accountClass,
        this.accountType,
        this.accountNo,
        this.recon,
        this.actionFlag,
        this.isNewRequest,
    });

    factory AssignedAccountToEditData.fromJson(Map<String, dynamic> json) => AssignedAccountToEditData(
        assignedAcctId: json["assignedAcctId"],
        reqId: json["reqId"],
        itemStage: json["itemStage"],
        accountName: json["accountName"],
        accountClass: json["accountClass"],
        accountType: json["accountType"],
        accountNo: json["accountNo"],
        recon: json["recon"],
        actionFlag: json["actionFlag"],
        isNewRequest: json["isNewRequest"],
    );

    Map<String, dynamic> toMap() => {
        "assignedAcctId": assignedAcctId,
        "reqId": reqId,
        "itemStage": itemStage,
        "accountName": accountName,
        "accountClass": accountClass,
        "accountType": accountType,
        "accountNo": accountNo,
        "recon": recon,
        "actionFlag": actionFlag,
        "isNewRequest": isNewRequest,
    };
}
