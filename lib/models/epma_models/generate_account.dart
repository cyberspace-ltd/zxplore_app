// To parse this JSON data, do
//
//     final generateAccount = generateAccountFromMap(jsonString);

import 'dart:convert';

GenerateAccount generateAccountFromMap(String str) => GenerateAccount.fromMap(json.decode(str));

String generateAccountToMap(GenerateAccount data) => json.encode(data.toMap());

class GenerateAccount {
    int? assignedAcctId;
    String? requestId;
    String? accountName;
    String? accountClass;
    String? accountType;
    String? accountSeries;
    String? recon;
    String? actionFlag;

    GenerateAccount({
        this.assignedAcctId,
        this.requestId,
        this.accountName,
        this.accountClass,
        this.accountType,
        this.accountSeries,
        this.recon,
        this.actionFlag,
    });

    factory GenerateAccount.fromMap(Map<String, dynamic> json) => GenerateAccount(
        assignedAcctId: json["assignedAcctId"],
        requestId: json["requestId"],
        accountName: json["accountName"],
        accountClass: json["accountClass"],
        accountType: json["accountType"],
        accountSeries: json["accountSeries"],
        recon: json["recon"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toMap() => {
        "assignedAcctId": assignedAcctId,
        "requestId": requestId,
        "accountName": accountName,
        "accountClass": accountClass,
        "accountType": accountType,
        "accountSeries": accountSeries,
        "recon": recon,
        "actionFlag": actionFlag,
    };
}
