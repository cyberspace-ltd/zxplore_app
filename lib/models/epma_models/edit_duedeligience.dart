


// To parse this JSON data, do
//
//     final editDueDiligence = editDueDiligenceFromJson(jsonString);

import 'dart:convert';

EditDueDiligence editDueDiligenceFromJson(String str) => EditDueDiligence.fromJson(json.decode(str));

String editDueDiligenceToJson(EditDueDiligence data) => json.encode(data.toJson());

class EditDueDiligence {
    int? dueDiligenceId;
    String? requestId;
    String? fatcaStatus;
    String? actionFlag;
    int? rowVersion;

    EditDueDiligence({
        required this.dueDiligenceId,
        required this.requestId,
        required this.fatcaStatus,
        required this.actionFlag,
        required this.rowVersion,
    });

    factory EditDueDiligence.fromJson(Map<String, dynamic> json) => EditDueDiligence(
        dueDiligenceId: json["dueDiligenceId"],
        requestId: json["requestId"],
        fatcaStatus: json["fatcaStatus"],
        actionFlag: json["actionFlag"],
        rowVersion: json["rowVersion"],
    );

    Map<String, dynamic> toJson() => {
        "dueDiligenceId": dueDiligenceId,
        "requestId": requestId,
        "fatcaStatus": fatcaStatus,
        "actionFlag": actionFlag,
        "rowVersion": rowVersion,
    };
}


