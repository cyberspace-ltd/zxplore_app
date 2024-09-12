// To parse this JSON data, do
//
//     final maritalStatusResponse = maritalStatusResponseFromJson(jsonString);

import 'dart:convert';

MaritalStatusResponse maritalStatusResponseFromJson(String str) => MaritalStatusResponse.fromJson(json.decode(str));

String maritalStatusResponseToJson(MaritalStatusResponse data) => json.encode(data.toJson());

class MaritalStatusResponse {
    int code;
    bool status;
    String message;
    List<MaritalStatusDatum> data;

    MaritalStatusResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory MaritalStatusResponse.fromJson(Map<String, dynamic> json) => MaritalStatusResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<MaritalStatusDatum>.from(json["data"].map((x) => MaritalStatusDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class MaritalStatusDatum {
    String maritalStatusCode;
    String maritalStatusDesc;

    MaritalStatusDatum({
        required this.maritalStatusCode,
        required this.maritalStatusDesc,
    });

    factory MaritalStatusDatum.fromJson(Map<String, dynamic> json) => MaritalStatusDatum(
        maritalStatusCode: json["maritalStatusCode"],
        maritalStatusDesc: json["maritalStatusDesc"],
    );

    Map<String, dynamic> toJson() => {
        "maritalStatusCode": maritalStatusCode,
        "maritalStatusDesc": maritalStatusDesc,
    };
}
