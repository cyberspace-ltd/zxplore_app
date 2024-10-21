// To parse this JSON data, do
//
//     final epmaLoginResponse = epmaLoginResponseFromJson(jsonString);

import 'dart:convert';

EpmaLoginResponse epmaLoginResponseFromJson(String str) => EpmaLoginResponse.fromJson(json.decode(str));

String epmaLoginResponseToJson(EpmaLoginResponse data) => json.encode(data.toJson());

class EpmaLoginResponse {
    int code;
    bool status;
    String message;
    String data;

    EpmaLoginResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory EpmaLoginResponse.fromJson(Map<String, dynamic> json) => EpmaLoginResponse(
        code: json["code"]??-1,
        status: json["status"]??false,
        message: json["message"]??'',
        data: json["data"]??'',
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data,
    };
}
