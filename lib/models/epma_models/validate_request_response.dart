// To parse this JSON data, do
//
//     final validateRequestRsponse = validateRequestRsponseFromMap(jsonString);

import 'dart:convert';

ValidateRequestRsponse validateRequestRsponseFromMap(String str) => ValidateRequestRsponse.fromMap(json.decode(str));

String validateRequestRsponseToMap(ValidateRequestRsponse data) => json.encode(data.toMap());

class ValidateRequestRsponse {
    int? code;
    bool? status;
    String? message;
    VallidationData? data;

    ValidateRequestRsponse({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory ValidateRequestRsponse.fromMap(Map<String, dynamic> json) => ValidateRequestRsponse(
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
