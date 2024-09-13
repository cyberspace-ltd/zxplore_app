// To parse this JSON data, do
//
//     final anticipatedAmountsResponse = anticipatedAmountsResponseFromJson(jsonString);

import 'dart:convert';

AnticipatedAmountsResponse anticipatedAmountsResponseFromJson(String str) => AnticipatedAmountsResponse.fromJson(json.decode(str));

String anticipatedAmountsResponseToJson(AnticipatedAmountsResponse data) => json.encode(data.toJson());

class AnticipatedAmountsResponse {
    int code;
    bool status;
    String message;
    List<AnticipatedAmountsDatum> data;

    AnticipatedAmountsResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory AnticipatedAmountsResponse.fromJson(Map<String, dynamic> json) => AnticipatedAmountsResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<AnticipatedAmountsDatum>.from(json["data"].map((x) => AnticipatedAmountsDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AnticipatedAmountsDatum {
    int amountValue;
    String amountName;

    AnticipatedAmountsDatum({
        required this.amountValue,
        required this.amountName,
    });

    factory AnticipatedAmountsDatum.fromJson(Map<String, dynamic> json) => AnticipatedAmountsDatum(
        amountValue: json["amountValue"],
        amountName: json["amountName"],
    );

    Map<String, dynamic> toJson() => {
        "amountValue": amountValue,
        "amountName": amountName,
    };
}
