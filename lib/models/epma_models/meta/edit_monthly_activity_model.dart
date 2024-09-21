


// To parse this JSON data, do
//
//     final editMonthlyActivity = editMonthlyActivityFromJson(json String?);

import 'dart:convert';

EditMonthlyActivity editMonthlyActivityFromJson( String? str) => EditMonthlyActivity.fromJson(json.decode(str??''));

 String? editMonthlyActivityToJson(EditMonthlyActivity data) => json.encode(data.toJson());

class EditMonthlyActivity {
     int? accountTypeId;
     String? requestId;
     String? itemStage;
     int? rowVersion;
     bool? current;
     bool? savings;
     bool? chequeSave;
     bool? thumbsUp;
     bool? zeca;
     bool? zecaPlus;
     String? anticipatedDepositeTrans;
     int? anticipatedDepositeAmount;
     String? anticipatedWithdrawTrans;
     int? anticipatedWithdrawAmount;
     bool? foriegnTransactionExpected;
     String? actionFlag;

    EditMonthlyActivity({
          this.accountTypeId,
          this.requestId,
          this.itemStage,
          this.rowVersion,
          this.current,
          this.savings,
          this.chequeSave,
          this.thumbsUp,
          this.zeca,
          this.zecaPlus,
          this.anticipatedDepositeTrans,
          this.anticipatedDepositeAmount,
          this.anticipatedWithdrawTrans,
          this.anticipatedWithdrawAmount,
          this.foriegnTransactionExpected,
          this.actionFlag,
    });

    factory EditMonthlyActivity.fromJson(Map<String, dynamic> json) => EditMonthlyActivity(
        accountTypeId: json["accountTypeId"],
        requestId: json["requestId"],
        itemStage: json["itemStage"],
        rowVersion: json["rowVersion"],
        current: json["current"],
        savings: json["savings"],
        chequeSave: json["chequeSave"],
        thumbsUp: json["thumbsUp"],
        zeca: json["zeca"],
        zecaPlus: json["zecaPlus"],
        anticipatedDepositeTrans: json["anticipatedDepositeTrans"],
        anticipatedDepositeAmount: json["anticipatedDepositeAmount"],
        anticipatedWithdrawTrans: json["anticipatedWithdrawTrans"],
        anticipatedWithdrawAmount: json["anticipatedWithdrawAmount"],
        foriegnTransactionExpected: json["foriegnTransactionExpected"],
        actionFlag: json["actionFlag"],
    );

    Map< String?, dynamic> toJson() => {
        "accountTypeId": accountTypeId,
        "requestId": requestId,
        "itemStage": itemStage,
        "rowVersion": rowVersion,
        "current": current,
        "savings": savings,
        "chequeSave": chequeSave,
        "thumbsUp": thumbsUp,
        "zeca": zeca,
        "zecaPlus": zecaPlus,
        "anticipatedDepositeTrans": anticipatedDepositeTrans,
        "anticipatedDepositeAmount": anticipatedDepositeAmount,
        "anticipatedWithdrawTrans": anticipatedWithdrawTrans,
        "anticipatedWithdrawAmount": anticipatedWithdrawAmount,
        "foriegnTransactionExpected": foriegnTransactionExpected,
        "actionFlag": actionFlag,
    };
}

