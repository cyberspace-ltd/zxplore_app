// To parse this JSON data, do
//
//     final gendersResponse = gendersResponseFromJson(jsonString);

import 'dart:convert';

GendersResponse gendersResponseFromJson(String str) => GendersResponse.fromJson(json.decode(str));

String gendersResponseToJson(GendersResponse data) => json.encode(data.toJson());

class GendersResponse {
    int code;
    bool status;
    String message;
    List<GendersDatum> data;

    GendersResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory GendersResponse.fromJson(Map<String, dynamic> json) => GendersResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<GendersDatum>.from(json["data"].map((x) => GendersDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GendersDatum {
    String? genderCode;
    String? genderName;

    GendersDatum({
          this.genderCode,
          this.genderName,
    });

    factory GendersDatum.fromJson(Map<String, dynamic> json) => GendersDatum(
        genderCode: json["genderCode"],
        genderName: json["genderName"],
    );

    Map<String, dynamic> toJson() => {
        "genderCode": genderCode,
        "genderName": genderName,
    };
}
