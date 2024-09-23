
// To parse this JSON data, do
//
//     final getDueDiligenceToEdit = getDueDiligenceToEditFromJson(jsonString);

import 'dart:convert';

GetDueDiligenceToEdit getDueDiligenceToEditFromJson(String str) => GetDueDiligenceToEdit.fromJson(json.decode(str));

String getDueDiligenceToEditToJson(GetDueDiligenceToEdit data) => json.encode(data.toJson());

class GetDueDiligenceToEdit {
    int? code;
    bool? status;
    String? message;
    DueDiligenceData? data;

    GetDueDiligenceToEdit({
           this.code,
           this.status,
           this.message,
           this.data,
    });

    factory GetDueDiligenceToEdit.fromJson(Map<String, dynamic> json) => GetDueDiligenceToEdit(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: DueDiligenceData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class DueDiligenceData {
    int? dueDiligenceId;
    String? reqId;
    String? fatcaStatus;
    String? actionFlag;
    int? rowVersion;

    DueDiligenceData({
           this.dueDiligenceId,
           this.reqId,
           this.fatcaStatus,
           this.actionFlag,
           this.rowVersion,
    });

    factory DueDiligenceData.fromJson(Map<String, dynamic> json) => DueDiligenceData(
        dueDiligenceId: json["dueDiligenceId"],
        reqId: json["reqId"],
        fatcaStatus: json["fatcaStatus"],
        actionFlag: json["actionFlag"],
        rowVersion: json["rowVersion"],
    );

    Map<String, dynamic> toJson() => {
        "dueDiligenceId": dueDiligenceId,
        "reqId": reqId,
        "fatcaStatus": fatcaStatus,
        "actionFlag": actionFlag,
        "rowVersion": rowVersion,
    };
}

