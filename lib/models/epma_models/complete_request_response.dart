// To parse this JSON data, do
//
//     final completeRequestRsponse = completeRequestRsponseFromMap(jsonString);

import 'dart:convert';

CompleteRequestRsponse completeRequestRsponseFromMap(String str) => CompleteRequestRsponse.fromMap(json.decode(str));

String completeRequestRsponseToMap(CompleteRequestRsponse data) => json.encode(data.toMap());

class CompleteRequestRsponse {
    int? code;
    bool? status;
    String? message;
    String? data;

    CompleteRequestRsponse({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory CompleteRequestRsponse.fromMap(Map<String, dynamic> json) => CompleteRequestRsponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data,
    };
}
