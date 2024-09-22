// To parse this JSON data, do
//
//     final addOtherBankAccount = addOtherBankAccountFromJson(jsonString?);

import 'dart:convert';

AddOtherBankAccount addOtherBankAccountFromJson(String? str) => AddOtherBankAccount.fromJson(json.decode(str??''));

String? addOtherBankAccountToJson(AddOtherBankAccount data) => json.encode(data.toJson());

class AddOtherBankAccount {
    int? otherAccountsId;
    String? requestId;
    String? itemStage;
    int? rowVersion;
    String? bank;
    String? branch;
    String? address;
    String? accountName;
    String? accountNumber;
    String? actionFlag;

    AddOtherBankAccount({
         this.otherAccountsId,
         this.requestId,
         this.itemStage,
         this.rowVersion,
         this.bank,
         this.branch,
         this.address,
         this.accountName,
         this.accountNumber,
         this.actionFlag,
    });

    factory AddOtherBankAccount.fromJson(Map<String, dynamic> json) => AddOtherBankAccount(
        otherAccountsId: json["otherAccountsId"],
        requestId: json["requestId"],
        itemStage: json["itemStage"],
        rowVersion: json["rowVersion"],
        bank: json["bank"],
        branch: json["branch"],
        address: json["address"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        actionFlag: json["actionFlag"],
    );

    Map<String?, dynamic> toJson() => {
        "otherAccountsId": otherAccountsId,
        "requestId": requestId,
        "itemStage": itemStage,
        "rowVersion": rowVersion,
        "bank": bank,
        "branch": branch,
        "address": address,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "actionFlag": actionFlag,
    };
}

 

EditOtherBankAccount editOtherBankAccountFromJson(String? str) => EditOtherBankAccount.fromJson(json.decode(str??''));

String? editOtherBankAccountToJson(EditOtherBankAccount data) => json.encode(data.toJson());

class EditOtherBankAccount {
    int? otherAccountsId;
    String? requestId;
    String? itemStage;
    int? rowVersion;
    String? bank;
    String? branch;
    String? address;
    String? accountName;
    String? accountNumber;
    String? actionFlag;

    EditOtherBankAccount({
         this.otherAccountsId,
         this.requestId,
         this.itemStage,
         this.rowVersion,
         this.bank,
         this.branch,
         this.address,
         this.accountName,
         this.accountNumber,
         this.actionFlag,
    });

    factory EditOtherBankAccount.fromJson(Map<String, dynamic> json) => EditOtherBankAccount(
        otherAccountsId: json["otherAccountsId"],
        requestId: json["requestId"],
        itemStage: json["itemStage"],
        rowVersion: json["rowVersion"],
        bank: json["bank"],
        branch: json["branch"],
        address: json["address"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        actionFlag: json["actionFlag"],
    );

    Map<String?, dynamic> toJson() => {
        "otherAccountsId": otherAccountsId,
        "requestId": requestId,
        "itemStage": itemStage,
        "rowVersion": rowVersion,
        "bank": bank,
        "branch": branch,
        "address": address,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "actionFlag": actionFlag,
    };
}
