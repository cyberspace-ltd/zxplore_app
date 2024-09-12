// To parse this JSON data, do
//
//     final pendingRequestAllResponse = pendingRequestAllResponseFromJson(jsonString?);

import 'dart:convert';

PendingRequestAllResponse pendingRequestAllResponseFromJson(String str) => PendingRequestAllResponse.fromJson(json.decode(str));

String? pendingRequestAllResponseToJson(PendingRequestAllResponse data) => json.encode(data.toJson());

class PendingRequestAllResponse {
    int code;
    bool status;
    String? message;
    List<PendingRequestsDatum>? data;

    PendingRequestAllResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory PendingRequestAllResponse.fromJson(Map<String, dynamic> json) => PendingRequestAllResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<PendingRequestsDatum>.from(json["data"].map((x) => PendingRequestsDatum.fromJson(x))),
    );

    Map<String?, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class PendingRequestsDatum {
    String? reqId;
    String? formType;
    String? fullName;
    String? stage;
    String? branch;
    DateTime createDate;

    PendingRequestsDatum({
        required this.reqId,
        required this.formType,
        required this.fullName,
        required this.stage,
        required this.branch,
        required this.createDate,
    });

    factory PendingRequestsDatum.fromJson(Map<String?, dynamic> json) => PendingRequestsDatum(
        reqId: json["reqId"],
        formType: json["formType"],
        fullName: json["fullName"],
        stage: json["stage"],
        branch: json["branch"],
        createDate: DateTime.parse(json["createDate"]),
    );

    Map<String?, dynamic> toJson() => {
        "reqId": reqId,
        "formType": formType,
        "fullName": fullName,
        "stage": stage,
        "branch": branch,
        "createDate": createDate.toIso8601String(),
    };
}
