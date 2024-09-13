// To parse this JSON data, do
//
//     final createAccountResponse = createAccountResponseFromMap(jsonString);

import 'dart:convert';

CreateAccountResponse createAccountResponseFromMap(String str) => CreateAccountResponse.fromMap(json.decode(str));

String createAccountResponseToMap(CreateAccountResponse data) => json.encode(data.toMap());

class CreateAccountResponse {
    int? code;
    bool? status;
    String? message;
    String? data;

    CreateAccountResponse({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory CreateAccountResponse.fromMap(Map<String, dynamic> json) => CreateAccountResponse(
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
