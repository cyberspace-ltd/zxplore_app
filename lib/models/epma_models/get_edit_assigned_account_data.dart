// To parse this JSON data, do
//
//     final editAccount = editAccountFromMap(jsonString);

import 'dart:convert';

EditAccount editAccountFromMap(String str) => EditAccount.fromMap(json.decode(str));

String editAccountToMap(EditAccount data) => json.encode(data.toMap());

class EditAccount {
    int? assignedAcctId;
    String? requestId;
    String? accountName;
    String? accountClass;
    String? accountType;
    String? accountNo;
    String? recon;
    String? actionFlag;
    bool? isNewRequest;

    EditAccount({
        this.assignedAcctId,
        this.requestId,
        this.accountName,
        this.accountClass,
        this.accountType,
        this.accountNo,
        this.recon,
        this.actionFlag,
        this.isNewRequest,
    });

    factory EditAccount.fromMap(Map<String, dynamic> json) => EditAccount(
        assignedAcctId: json["assignedAcctId"],
        requestId: json["requestId"],
        accountName: json["accountName"],
        accountClass: json["accountClass"],
        accountType: json["accountType"],
        accountNo: json["accountNo"],
        recon: json["recon"],
        actionFlag: json["actionFlag"],
        isNewRequest: json["isNewRequest"],
    );

    Map<String, dynamic> toMap() => {
        "assignedAcctId": assignedAcctId,
        "requestId": requestId,
        "accountName": accountName,
        "accountClass": accountClass,
        "accountType": accountType,
        "accountNo": accountNo,
        "recon": recon,
        "actionFlag": actionFlag,
        "isNewRequest": isNewRequest,
    };
}
