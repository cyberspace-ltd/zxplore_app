import 'dart:convert';

AccountsResponse accountsResponseFromJson(String str) =>
    AccountsResponse.fromJson(json.decode(str));

String accountsResponseToJson(AccountsResponse data) =>
    json.encode(data.toJson());

class AccountsResponse {
  bool? status;
  String? message;
  List<Account>? data;

  AccountsResponse({this.status, this.message, this.data});

  factory AccountsResponse.fromJson(Map<String, dynamic> json) =>
      AccountsResponse(
        status: json["status"],
        message: json["message"],
        data: List<Account>.from(json["data"].map((x) => Account.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Account {
  String? accountType;
  String? refId;
  String? batchId;
  String? accountNumber;
  String? accountHolderType;
  int? classCode;
  int? branchNumber;
  int? rsmId;
  String? accountName;
  String? title;
  String? addressLine1;
  String? city;
  String? state;
  String? status;
  String? phoneNumber;
  String? dateCreated;

  Account({
    this.accountType,
    this.refId,
    this.batchId,
    this.accountNumber,
    this.accountHolderType,
    this.classCode,
    this.branchNumber,
    this.rsmId,
    this.accountName,
    this.title,
    this.addressLine1,
    this.city,
    this.state,
    this.status,
    this.phoneNumber,
    this.dateCreated,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        accountType: json["AccountType"],
        refId: json["Ref_Id"],
        batchId: json["BatchID"],
        accountNumber: json["AccountNumber"],
        accountHolderType: json["AccountHolderType"],
        classCode: json["ClassCode"],
        branchNumber: json["BranchNumber"],
        rsmId: json["RSMId"],
        accountName: json["AccountName"],
        title: json["Title"],
        addressLine1: json["AddressLine1"],
        city: json["City"],
        state: json["State"],
        status: json["Status"],
        phoneNumber: json["PhoneNumber"],
        dateCreated: json["DateCreated"],
      );

  Map<String, dynamic> toJson() => {
        "AccountType": accountType,
        "Ref_Id": refId,
        "BatchID": batchId,
        "AccountNumber": accountNumber,
        "AccountHolderType": accountHolderType,
        "ClassCode": classCode,
        "BranchNumber": branchNumber,
        "RSMId": rsmId,
        "AccountName": accountName,
        "Title": title,
        "AddressLine1": addressLine1,
        "City": city,
        "State": state,
        "Status": status,
        "PhoneNumber": phoneNumber,
        "DateCreated": dateCreated,
      };
}
