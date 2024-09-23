
// To parse this JSON data, do
//
//     final editForeignAccount = editForeignAccountFromJson(jsonString);

import 'dart:convert';

EditForeignAccount editForeignAccountFromJson(String str) => EditForeignAccount.fromJson(json.decode(str));

String editForeignAccountToJson(EditForeignAccount data) => json.encode(data.toJson());

class EditForeignAccount {
   int? foreignAccountId;
  String? requestId;
  int? rowVersion;
  String? itemStage;
  bool? hasRelatedAccount;
  String? relatedAccount;
  bool? maintainMandate;
  bool? offShoreUsd;
  bool? offShoreGbp;
  bool? offShoreEur;
  bool? onShoreUsd;
  bool? onShoreGbp;
  bool? onShoreEur;
  bool? accountPurposeSalary;
  bool? accountPurposeBusiness;
  bool? accountPurposeOther;
  String? accountPurposeOtherSpecify;
  bool? fundSourceSalary;
  bool? fundSourceBusinessIncome;
  bool? fundSourceOther;
  String? fundSourceOtherSpecify;
  String? fundSourceSenderInvester;
  bool? inflowFrequencyWeekly;
  bool? inflowFrequencyFortnightly;
  bool? inflowFrequencyMonthly;
  bool? inflowFrequencyQuarterly;
  bool? inflowFrequencyOther;
  String? inflowFrequencyOtherSpecify;
  String? actionFlag;

    EditForeignAccount({
         this.foreignAccountId,
         this.requestId,
         this.rowVersion,
         this.itemStage,
         this.hasRelatedAccount,
         this.relatedAccount,
         this.maintainMandate=false,
         this.offShoreUsd,
         this.offShoreGbp,
         this.offShoreEur,
         this.onShoreUsd,
         this.onShoreGbp,
         this.onShoreEur,
         this.accountPurposeSalary,
         this.accountPurposeBusiness,
         this.accountPurposeOther,
         this.accountPurposeOtherSpecify,
         this.fundSourceSalary,
         this.fundSourceBusinessIncome,
         this.fundSourceOther,
         this.fundSourceOtherSpecify,
         this.fundSourceSenderInvester,
         this.inflowFrequencyWeekly,
         this.inflowFrequencyFortnightly,
         this.inflowFrequencyMonthly,
         this.inflowFrequencyQuarterly,
         this.inflowFrequencyOther,
         this.inflowFrequencyOtherSpecify,
         this.actionFlag,
    });

    factory EditForeignAccount.fromJson(Map<String, dynamic> json) => EditForeignAccount(
        foreignAccountId: json["foreignAccountId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        hasRelatedAccount: json["hasRelatedAccount"],
        relatedAccount: json["relatedAccount"],
        maintainMandate: json["maintainMandate"],
        offShoreUsd: json["offShoreUSD"],
        offShoreGbp: json["offShoreGBP"],
        offShoreEur: json["offShoreEUR"],
        onShoreUsd: json["onShoreUSD"],
        onShoreGbp: json["onShoreGBP"],
        onShoreEur: json["onShoreEUR"],
        accountPurposeSalary: json["accountPurposeSalary"],
        accountPurposeBusiness: json["accountPurposeBusiness"],
        accountPurposeOther: json["accountPurposeOther"],
        accountPurposeOtherSpecify: json["accountPurposeOtherSpecify"],
        fundSourceSalary: json["fundSourceSalary"],
        fundSourceBusinessIncome: json["fundSourceBusinessIncome"],
        fundSourceOther: json["fundSourceOther"],
        fundSourceOtherSpecify: json["fundSourceOtherSpecify"],
        fundSourceSenderInvester: json["fundSourceSenderInvester"],
        inflowFrequencyWeekly: json["inflowFrequencyWeekly"],
        inflowFrequencyFortnightly: json["inflowFrequencyFortnightly"],
        inflowFrequencyMonthly: json["inflowFrequencyMonthly"],
        inflowFrequencyQuarterly: json["inflowFrequencyQuarterly"],
        inflowFrequencyOther: json["inflowFrequencyOther"],
        inflowFrequencyOtherSpecify: json["inflowFrequencyOtherSpecify"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toJson() => {
        "foreignAccountId": foreignAccountId,
        "requestId": requestId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "hasRelatedAccount": hasRelatedAccount,
        "relatedAccount": relatedAccount,
        "maintainMandate": maintainMandate,
        "offShoreUSD": offShoreUsd,
        "offShoreGBP": offShoreGbp,
        "offShoreEUR": offShoreEur,
        "onShoreUSD": onShoreUsd,
        "onShoreGBP": onShoreGbp,
        "onShoreEUR": onShoreEur,
        "accountPurposeSalary": accountPurposeSalary,
        "accountPurposeBusiness": accountPurposeBusiness,
        "accountPurposeOther": accountPurposeOther,
        "accountPurposeOtherSpecify": accountPurposeOtherSpecify,
        "fundSourceSalary": fundSourceSalary,
        "fundSourceBusinessIncome": fundSourceBusinessIncome,
        "fundSourceOther": fundSourceOther,
        "fundSourceOtherSpecify": fundSourceOtherSpecify,
        "fundSourceSenderInvester": fundSourceSenderInvester,
        "inflowFrequencyWeekly": inflowFrequencyWeekly,
        "inflowFrequencyFortnightly": inflowFrequencyFortnightly,
        "inflowFrequencyMonthly": inflowFrequencyMonthly,
        "inflowFrequencyQuarterly": inflowFrequencyQuarterly,
        "inflowFrequencyOther": inflowFrequencyOther,
        "inflowFrequencyOtherSpecify": inflowFrequencyOtherSpecify,
        "actionFlag": actionFlag,
    };
}

