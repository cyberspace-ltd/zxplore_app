


// To parse this JSON data, do
//
//     final GetNextOfKinToEditResponse = GetNextOfKinToEditResponseFromJson(jsonString);

import 'dart:convert';

GetNextOfKinToEditResponse GetNextOfKinToEditResponseFromJson(String str) => GetNextOfKinToEditResponse.fromJson(json.decode(str));

String GetNextOfKinToEditResponseToJson(GetNextOfKinToEditResponse data) => json.encode(data.toJson());

class GetNextOfKinToEditResponse {
    int? code;
    bool? status;
    String? message;
    NextOfKinData? data;

    GetNextOfKinToEditResponse({
          this.code,
          this.status,
          this.message,
          this.data,
    });

    factory GetNextOfKinToEditResponse.fromJson(Map<String, dynamic> json) => GetNextOfKinToEditResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: NextOfKinData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class NextOfKinData {
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

    NextOfKinData({
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
    });

    factory NextOfKinData.fromJson(Map<String, dynamic> json) => NextOfKinData(
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
    );

    Map<String, dynamic> toJson() => {
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
    };
}





