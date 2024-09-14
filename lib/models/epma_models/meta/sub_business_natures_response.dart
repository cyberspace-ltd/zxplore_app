// To parse this JSON data, do
//
//     final subBusinessNatureResponse = subBusinessNatureResponseFromJson(jsonString);

import 'dart:convert';

SubBusinessNatureResponse subBusinessNatureResponseFromJson(String str) => SubBusinessNatureResponse.fromJson(json.decode(str));

String subBusinessNatureResponseToJson(SubBusinessNatureResponse data) => json.encode(data.toJson());

class SubBusinessNatureResponse {
    int code;
    bool status;
    String message;
    List<SubBusinessNatureDatum> data;

    SubBusinessNatureResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory SubBusinessNatureResponse.fromJson(Map<String, dynamic> json) => SubBusinessNatureResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<SubBusinessNatureDatum>.from(json["data"].map((x) => SubBusinessNatureDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class SubBusinessNatureDatum {
    String subBusinessNatureId;
    String subBusinessNatureName;

    SubBusinessNatureDatum({
        required this.subBusinessNatureId,
        required this.subBusinessNatureName,
    });

    factory SubBusinessNatureDatum.fromJson(Map<String, dynamic> json) => SubBusinessNatureDatum(
        subBusinessNatureId: json["subBusinessNatureId"],
        subBusinessNatureName: json["subBusinessNatureName"],
    );

    Map<String, dynamic> toJson() => {
        "subBusinessNatureId": subBusinessNatureId,
        "subBusinessNatureName": subBusinessNatureName,
    };
}
