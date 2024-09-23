

// To parse this JSON data, do
//
//     final GetRefereeToEditResponse = GetRefereeToEditResponseFromJson(jsonString);

import 'dart:convert';

GetRefereeToEditResponse GetRefereeToEditResponseFromJson(String str) => GetRefereeToEditResponse.fromJson(json.decode(str));

String GetRefereeToEditResponseToJson(GetRefereeToEditResponse data) => json.encode(data.toJson());

class GetRefereeToEditResponse {
    int? code;
    bool? status;
    String? message;
    RefereeData? data;

    GetRefereeToEditResponse({
          this.code,
          this.status,
          this.message,
          this.data,
    });

    factory GetRefereeToEditResponse.fromJson(Map<String, dynamic> json) => GetRefereeToEditResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: RefereeData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class RefereeData {
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

    RefereeData({
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

    factory RefereeData.fromJson(Map<String, dynamic> json) => RefereeData(
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

    Map<String, dynamic> toJson() => {
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




