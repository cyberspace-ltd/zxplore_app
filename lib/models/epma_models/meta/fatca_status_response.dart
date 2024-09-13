// To parse this JSON data, do
//
//     final fatcaStatusResponse = fatcaStatusResponseFromJson(jsonString);

import 'dart:convert';

FatcaStatusResponse fatcaStatusResponseFromJson(String str) => FatcaStatusResponse.fromJson(json.decode(str));

String fatcaStatusResponseToJson(FatcaStatusResponse data) => json.encode(data.toJson());

class FatcaStatusResponse {
    int code;
    bool status;
    String message;
    List<FatcaStatusDatum> data;

    FatcaStatusResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory FatcaStatusResponse.fromJson(Map<String, dynamic> json) => FatcaStatusResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<FatcaStatusDatum>.from(json["data"].map((x) => FatcaStatusDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class FatcaStatusDatum {
    String fatcaStatusValue;
    String fatcaStatusName;

    FatcaStatusDatum({
        required this.fatcaStatusValue,
        required this.fatcaStatusName,
    });

    factory FatcaStatusDatum.fromJson(Map<String, dynamic> json) => FatcaStatusDatum(
        fatcaStatusValue: json["fatcaStatusValue"],
        fatcaStatusName: json["fatcaStatusName"],
    );

    Map<String, dynamic> toJson() => {
        "fatcaStatusValue": fatcaStatusValue,
        "fatcaStatusName": fatcaStatusName,
    };
}
