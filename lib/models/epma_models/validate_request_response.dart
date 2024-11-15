// To parse this JSON data, do
//
//     final ValidateRequestResponse = ValidateRequestResponseFromMap(jsonString);

import 'dart:convert';

ValidateRequestResponse ValidateRequestResponseFromMap(String str) => ValidateRequestResponse.fromMap(json.decode(str));

String ValidateRequestResponseToMap(ValidateRequestResponse data) => json.encode(data.toMap());

class ValidateRequestResponse {
    int? code;
    bool? status;
    String? message;
    VallidationData? data;

    ValidateRequestResponse({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory ValidateRequestResponse.fromMap(Map<String, dynamic> json) => ValidateRequestResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : VallidationData.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toMap(),
    };
}

class VallidationData {
    bool? isValid;
    String? message;

    VallidationData({
        this.isValid,
        this.message,
    });

    factory VallidationData.fromMap(Map<String, dynamic> json) => VallidationData(
        isValid: json["isValid"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "isValid": isValid,
        "message": message,
    };
}
