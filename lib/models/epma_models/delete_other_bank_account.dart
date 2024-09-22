// To parse this JSON data, do
//
//     final deleteOtherBankAccount = deleteOtherBankAccountFromJson(jsonString);

import 'dart:convert';

DeleteOtherBankAccount deleteOtherBankAccountFromJson(String str) => DeleteOtherBankAccount.fromJson(json.decode(str));

String deleteOtherBankAccountToJson(DeleteOtherBankAccount data) => json.encode(data.toJson());

class DeleteOtherBankAccount {
    int otherAccountsId;
    String requestId;
    int rowVersion;

    DeleteOtherBankAccount({
        required this.otherAccountsId,
        required this.requestId,
        required this.rowVersion,
    });

    factory DeleteOtherBankAccount.fromJson(Map<String, dynamic> json) => DeleteOtherBankAccount(
        otherAccountsId: json["otherAccountsId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
    );

    Map<String, dynamic> toJson() => {
        "otherAccountsId": otherAccountsId,
        "requestId": requestId,
        "rowVersion": rowVersion,
    };
}