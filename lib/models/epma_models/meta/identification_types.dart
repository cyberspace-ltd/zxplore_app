// To parse this JSON data, do
//
//     final identificationTypesResponse = identificationTypesResponseFromJson(jsonString);

import 'dart:convert';

IdentificationTypesResponse identificationTypesResponseFromJson(String str) => IdentificationTypesResponse.fromJson(json.decode(str));

String identificationTypesResponseToJson(IdentificationTypesResponse data) => json.encode(data.toJson());

class IdentificationTypesResponse {
    int code;
    bool status;
    String message;
    List<IdentificationTypesDatum> data;

    IdentificationTypesResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory IdentificationTypesResponse.fromJson(Map<String, dynamic> json) => IdentificationTypesResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<IdentificationTypesDatum>.from(json["data"].map((x) => IdentificationTypesDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class IdentificationTypesDatum {
    int? identificationTypeId;
    String? identificationTypeName;

    IdentificationTypesDatum({
          this.identificationTypeId,
          this.identificationTypeName,
    });

    factory IdentificationTypesDatum.fromJson(Map<String, dynamic> json) => IdentificationTypesDatum(
        identificationTypeId: json["identificationTypeId"],
        identificationTypeName: json["identificationTypeName"],
    );

    Map<String, dynamic> toJson() => {
        "identificationTypeId": identificationTypeId,
        "identificationTypeName": identificationTypeName,
    };
}
