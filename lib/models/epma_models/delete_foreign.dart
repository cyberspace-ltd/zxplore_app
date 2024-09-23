// To parse this JSON data, do
//
//     final deleteForeignAccount = deleteForeignAccountFromJson(jsonString);

import 'dart:convert';

DeleteForeignAccount deleteForeignAccountFromJson(String str) => DeleteForeignAccount.fromJson(json.decode(str));

String deleteForeignAccountToJson(DeleteForeignAccount data) => json.encode(data.toJson());

class DeleteForeignAccount {
    int? foreignAccountId;
    String? requestId;
    int? rowVersion;

    DeleteForeignAccount({
        required this.foreignAccountId,
        required this.requestId,
        required this.rowVersion,
    });

    factory DeleteForeignAccount.fromJson(Map<String, dynamic> json) => DeleteForeignAccount(
        foreignAccountId: json["foreignAccountId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
    );

    Map<String, dynamic> toJson() => {
        "foreignAccountId": foreignAccountId,
        "requestId": requestId,
        "rowVersion": rowVersion,
    };
}