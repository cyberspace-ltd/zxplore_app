
// To parse this JSON data, do
//
//     final addReferee = addRefereeFromJson(jsonString);

import 'dart:convert';

AddReferee addRefereeFromJson(String str) => AddReferee.fromJson(json.decode(str));

String addRefereeToJson(AddReferee data) => json.encode(data.toJson());

class AddReferee {
    int? refereeId;
    String? requestId;
    int? rowVersion;
    String? itemStage;
    String? name;
    String? address;
    String? accountName;
    String? bankers;
    String? accountNo;
    String? actionFlag;

    AddReferee({
          this.refereeId,
          this.requestId,
          this.rowVersion,
          this.itemStage,
          this.name,
          this.address,
          this.accountName,
          this.bankers,
          this.accountNo,
          this.actionFlag,
    });

    factory AddReferee.fromJson(Map<String, dynamic> json) => AddReferee(
        refereeId: json["refereeId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        name: json["name"],
        address: json["address"],
        accountName: json["accountName"],
        bankers: json["bankers"],
        accountNo: json["accountNo"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toJson() => {
        "refereeId": refereeId,
        "requestId": requestId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "name": name,
        "address": address,
        "accountName": accountName,
        "bankers": bankers,
        "accountNo": accountNo,
        "actionFlag": actionFlag,
    };
}

 

EditReferee editRefereeFromJson(String str) => EditReferee.fromJson(json.decode(str));

String editRefereeToJson(EditReferee data) => json.encode(data.toJson());

class EditReferee {
    int? refereeId;
    String? requestId;
    int? rowVersion;
    String? itemStage;
    String? name;
    String? address;
    String? accountName;
    String? bankers;
    String? accountNo;
    String? actionFlag;

    EditReferee({
          this.refereeId,
          this.requestId,
          this.rowVersion,
          this.itemStage,
          this.name,
          this.address,
          this.accountName,
          this.bankers,
          this.accountNo,
          this.actionFlag,
    });

    factory EditReferee.fromJson(Map<String, dynamic> json) => EditReferee(
        refereeId: json["refereeId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        name: json["name"],
        address: json["address"],
        accountName: json["accountName"],
        bankers: json["bankers"],
        accountNo: json["accountNo"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toJson() => {
        "refereeId": refereeId,
        "requestId": requestId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "name": name,
        "address": address,
        "accountName": accountName,
        "bankers": bankers,
        "accountNo": accountNo,
        "actionFlag": actionFlag,
    };
}
