// To parse this JSON data, do
//
//     final ProcessRequestResponse = ProcessRequestResponseFromMap(jsonString);

import 'dart:convert';

ProcessRequestResponse ProcessRequestResponseFromMap(String str) => ProcessRequestResponse.fromMap(json.decode(str));

String ProcessRequestResponseToMap(ProcessRequestResponse data) => json.encode(data.toMap());

class ProcessRequestResponse {
    int? code;
    bool? status;
    String? message;
    List<String>? data;

    ProcessRequestResponse({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory ProcessRequestResponse.fromMap(Map<String, dynamic> json) => ProcessRequestResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<String>.from(json["data"]!.map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    };
}
