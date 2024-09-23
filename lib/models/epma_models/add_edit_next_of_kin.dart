
// To parse this JSON data, do
//
//     final addNextOfKin = addNextOfKinFromJson(jsonString?);

import 'dart:convert';

AddNextOfKin addNextOfKinFromJson(String? str) => AddNextOfKin.fromJson(json.decode(str??''));

String addNextOfKinToJson(AddNextOfKin data) => json.encode(data.toJson());

class AddNextOfKin {
    int? nextOfKinId;
    String? requestId;
    int? rowVersion;
    String? itemStage;
    String? fullName;
    String? telNo;
    String? relationship;
    String? genderCode;
    String? residentialAddress;
    String? actionFlag;

    AddNextOfKin({
        required this.nextOfKinId,
        required this.requestId,
        required this.rowVersion,
        required this.itemStage,
        required this.fullName,
        required this.telNo,
        required this.relationship,
        required this.genderCode,
        required this.residentialAddress,
        required this.actionFlag,
    });

    factory AddNextOfKin.fromJson(Map<String, dynamic> json) => AddNextOfKin(
        nextOfKinId: json["nextOfKinId"],
        requestId: json["requestId"],
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
        "requestId": requestId,
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



// To parse this JSON data, do
//
//     final editNextOfKin = editNextOfKinFromJson(jsonString?);

// import 'dart:convert';

EditNextOfKin editNextOfKinFromJson(String str) => EditNextOfKin.fromJson(json.decode(str??''));

String editNextOfKinToJson(EditNextOfKin data) => json.encode(data.toJson());

class EditNextOfKin {
    int nextOfKinId;
    String? requestId;
    int? rowVersion;
    String? itemStage;
    String? fullName;
    String? telNo;
    String? relationship;
    String? genderCode;
    String? residentialAddress;
    String? actionFlag;

    EditNextOfKin({
        required this.nextOfKinId,
        required this.requestId,
        required this.rowVersion,
        required this.itemStage,
        required this.fullName,
        required this.telNo,
        required this.relationship,
        required this.genderCode,
        required this.residentialAddress,
        required this.actionFlag,
    });

    factory EditNextOfKin.fromJson(Map<String, dynamic> json) => EditNextOfKin(
        nextOfKinId: json["nextOfKinId"],
        requestId: json["requestId"],
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
        "requestId": requestId,
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