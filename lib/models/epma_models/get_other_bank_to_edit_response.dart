 
import 'dart:convert';

// EditOtherBankAccount editOtherBankAccountFromJson(String? str) => EditOtherBankAccount.fromJson(json.decode(str??''));

// String? editOtherBankAccountToJson(EditOtherBankAccount data) => json.encode(data.toJson());

// class EditOtherBankAccount {
//     int? otherAccountsId;
//     String? requestId;
//     String? itemStage;
//     int? rowVersion;
//     String? bank;
//     String? branch;
//     String? address;
//     String? accountName;
//     String? accountNumber;
//     String? actionFlag;

//     EditOtherBankAccount({
//          this.otherAccountsId,
//          this.requestId,
//          this.itemStage,
//          this.rowVersion,
//          this.bank,
//          this.branch,
//          this.address,
//          this.accountName,
//          this.accountNumber,
//          this.actionFlag,
//     });

//     factory EditOtherBankAccount.fromJson(Map<String, dynamic> json) => EditOtherBankAccount(
//         otherAccountsId: json["otherAccountsId"],
//         requestId: json["requestId"],
//         itemStage: json["itemStage"],
//         rowVersion: json["rowVersion"],
//         bank: json["bank"],
//         branch: json["branch"],
//         address: json["address"],
//         accountName: json["accountName"],
//         accountNumber: json["accountNumber"],
//         actionFlag: json["actionFlag"],
//     );

//     Map<String, dynamic> toJson() => {
//         "otherAccountsId": otherAccountsId,
//         "requestId": requestId,
//         "itemStage": itemStage,
//         "rowVersion": rowVersion,
//         "bank": bank,
//         "branch": branch,
//         "address": address,
//         "accountName": accountName,
//         "accountNumber": accountNumber,
//         "actionFlag": actionFlag,
//     };
// }


 
GetOtherBankAccountToEditResponse getOtherBankAccountToEditFromJson(String? str) => GetOtherBankAccountToEditResponse.fromJson(json.decode(str!));

String? getOtherBankAccountToEditToJson(GetOtherBankAccountToEditResponse data) => json.encode(data.toJson());

class GetOtherBankAccountToEditResponse {
    int? code;
    bool? status;
    String? message;
    OtherBankAccountData? data;

    GetOtherBankAccountToEditResponse({
         this.code,
         this.status,
         this.message,
         this.data,
    });

    factory GetOtherBankAccountToEditResponse.fromJson(Map<String, dynamic> json) => GetOtherBankAccountToEditResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: OtherBankAccountData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class OtherBankAccountData {
    int? otherAccountsId;
    String? reqId;
    String? itemStage;
    int? rowVersion;
    String? bank;
    String? branch;
    String? address;
    String? accountName;
    String? accountNumber;
    String? actionFlag;

    OtherBankAccountData({
         this.otherAccountsId,
         this.reqId,
         this.itemStage,
         this.rowVersion,
         this.bank,
         this.branch,
         this.address,
         this.accountName,
         this.accountNumber,
         this.actionFlag,
    });

    factory OtherBankAccountData.fromJson(Map<String, dynamic> json) => OtherBankAccountData(
        otherAccountsId: json["otherAccountsId"],
        reqId: json["reqId"],
        itemStage: json["itemStage"],
        rowVersion: json["rowVersion"],
        bank: json["bank"],
        branch: json["branch"],
        address: json["address"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toJson() => {
        "otherAccountsId": otherAccountsId,
        "reqId": reqId,
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


 
// DeleteOtherBankAccount deleteOtherBankAccountFromJson(String? str) => DeleteOtherBankAccount.fromJson(json.decode(str!));

// String? deleteOtherBankAccountToJson(DeleteOtherBankAccount data) => json.encode(data.toJson());

// class DeleteOtherBankAccount {
//     int? otherAccountsId;
//     String? requestId;
//     int? rowVersion;

//     DeleteOtherBankAccount({
//          this.otherAccountsId,
//          this.requestId,
//          this.rowVersion,
//     });

//     factory DeleteOtherBankAccount.fromJson(Map<String, dynamic> json) => DeleteOtherBankAccount(
//         otherAccountsId: json["otherAccountsId"],
//         requestId: json["requestId"],
//         rowVersion: json["rowVersion"],
//     );

//     Map<String, dynamic> toJson() => {
//         "otherAccountsId": otherAccountsId,
//         "requestId": requestId,
//         "rowVersion": rowVersion,
//     };
// }


