// To parse this JSON data, do
//
//     final accountTypesResponse = accountTypesResponseFromJson(jsonString);

import 'dart:convert';

AccountTypesResponse accountTypesResponseFromJson(String str) => AccountTypesResponse.fromJson(json.decode(str));

String accountTypesResponseToJson(AccountTypesResponse data) => json.encode(data.toJson());

class AccountTypesResponse {
    int code;
    bool status;
    String message;
    List<AccountTypesDatum> data;

    AccountTypesResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory AccountTypesResponse.fromJson(Map<String, dynamic> json) => AccountTypesResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<AccountTypesDatum>.from(json["data"].map((x) => AccountTypesDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AccountTypesDatum {
    String? accountTypeValue;
    String? accountTypeName;

    AccountTypesDatum({
          this.accountTypeValue,
          this.accountTypeName,
    });

    factory AccountTypesDatum.fromJson(Map<String, dynamic> json) => AccountTypesDatum(
        accountTypeValue: json["accountTypeValue"],
        accountTypeName: json["accountTypeName"],
    );

    Map<String, dynamic> toJson() => {
        "accountTypeValue": accountTypeValue,
        "accountTypeName": accountTypeName,
    };
}
