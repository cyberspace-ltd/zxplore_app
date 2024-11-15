// To parse this JSON data, do
//
//     final accountClassResponse = accountClassResponseFromJson(jsonString);

import 'dart:convert';

AccountClassResponse accountClassResponseFromJson(String str) => AccountClassResponse.fromJson(json.decode(str));

String accountClassResponseToJson(AccountClassResponse data) => json.encode(data.toJson());

class AccountClassResponse {
    int code;
    bool status;
    String message;
    List<AccountClassDatum> data;

    AccountClassResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory AccountClassResponse.fromJson(Map<String, dynamic> json) => AccountClassResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<AccountClassDatum>.from(json["data"].map((x) => AccountClassDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AccountClassDatum {
    String? accountClass;
    String? accountClassName;

    AccountClassDatum({
        required this.accountClass,
        required this.accountClassName,
    });

    factory AccountClassDatum.fromJson(Map<String, dynamic> json) => AccountClassDatum(
        accountClass: json["accountClass"],
        accountClassName: json["accountClassName"],
    );

    Map<String, dynamic> toJson() => {
        "accountClass": accountClass,
        "accountClassName": accountClassName,
    };
}
