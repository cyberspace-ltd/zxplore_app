// To parse this JSON data, do
//
//     final businessNaturesResponse = businessNaturesResponseFromJson(jsonString);

import 'dart:convert';

BusinessNaturesResponse businessNaturesResponseFromJson(String str) => BusinessNaturesResponse.fromJson(json.decode(str));

String businessNaturesResponseToJson(BusinessNaturesResponse data) => json.encode(data.toJson());

class BusinessNaturesResponse {
    int code;
    bool status;
    String message;
    List<BusinessNaturesDatum> data;

    BusinessNaturesResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory BusinessNaturesResponse.fromJson(Map<String, dynamic> json) => BusinessNaturesResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<BusinessNaturesDatum>.from(json["data"].map((x) => BusinessNaturesDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class BusinessNaturesDatum {
    String? businessNatureId;
    String? sironCode;
    String? businessNatureName;

    BusinessNaturesDatum({
          this.businessNatureId,
          this.sironCode,
          this.businessNatureName,
    });

    factory BusinessNaturesDatum.fromJson(Map<String, dynamic> json) => BusinessNaturesDatum(
        businessNatureId: json["businessNatureId"],
        sironCode: json["sironCode"],
        businessNatureName: json["businessNatureName"],
    );

    Map<String, dynamic> toJson() => {
        "businessNatureId": businessNatureId,
        "sironCode": sironCode,
        "businessNatureName": businessNatureName,
    };
}
