// To parse this JSON data, do
//
//     final renewTokenResponse = renewTokenResponseFromJson(jsonString);

import 'dart:convert';

RenewTokenResponse renewTokenResponseFromJson(String str) => RenewTokenResponse.fromJson(json.decode(str));

String renewTokenResponseToJson(RenewTokenResponse data) => json.encode(data.toJson());

class RenewTokenResponse {
    int code;
    bool status;
    String message;
    dynamic data;

    RenewTokenResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory RenewTokenResponse.fromJson(Map<String, dynamic> json) => RenewTokenResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data,
    };
}
