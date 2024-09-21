
// To parse this JSON data, do
//
//     final editAccountPurpose = editAccountPurposeFromJson(json String?);

import 'dart:convert';

EditAccountPurpose editAccountPurposeFromJson( String? str) => EditAccountPurpose.fromJson(json.decode(str??''));

 String? editAccountPurposeToJson(EditAccountPurpose data) => json.encode(data.toJson());

class EditAccountPurpose {
     int? accountPurposesId;
     int? rowVersion;
     String? requestId;
     String? othersSpecify;
     String? actionFlag;
     String? itemStage;
     bool? salaryProcessing;
     bool? toOtainLoan;
     bool? businessTransactional;
     bool? savingsInvestment;
     bool? conductSingleTransaction;
     bool? secutirySafeKeeping;
     bool? accessToBankingServices;
     bool? thirdPartyPayment;
     bool? recieptOfInflows;
     bool? others;
   

    EditAccountPurpose({
          this.accountPurposesId,
          this.requestId,
          this.rowVersion,
          this.itemStage,
          this.salaryProcessing,
          this.toOtainLoan,
          this.businessTransactional,
          this.savingsInvestment,
          this.conductSingleTransaction,
          this.secutirySafeKeeping,
          this.accessToBankingServices,
          this.thirdPartyPayment,
          this.recieptOfInflows,
          this.others,
          this.othersSpecify,
          this.actionFlag,
    });

    factory EditAccountPurpose.fromJson(Map< String?, dynamic> json) => EditAccountPurpose(
        accountPurposesId: json["accountPurposesId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        salaryProcessing: json["salaryProcessing"],
        toOtainLoan: json["toOtainLoan"],
        businessTransactional: json["businessTransactional"],
        savingsInvestment: json["savingsInvestment"],
        conductSingleTransaction: json["conductSingleTransaction"],
        secutirySafeKeeping: json["secutirySafeKeeping"],
        accessToBankingServices: json["accessToBankingServices"],
        thirdPartyPayment: json["thirdPartyPayment"],
        recieptOfInflows: json["recieptOfInflows"],
        others: json["others"],
        othersSpecify: json["othersSpecify"],
        actionFlag: json["actionFlag"],
    );

    Map< String, dynamic> toJson() => {
        "accountPurposesId": accountPurposesId,
        "requestId": requestId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "salaryProcessing": salaryProcessing,
        "toOtainLoan": toOtainLoan,
        "businessTransactional": businessTransactional,
        "savingsInvestment": savingsInvestment,
        "conductSingleTransaction": conductSingleTransaction,
        "secutirySafeKeeping": secutirySafeKeeping,
        "accessToBankingServices": accessToBankingServices,
        "thirdPartyPayment": thirdPartyPayment,
        "recieptOfInflows": recieptOfInflows,
        "others": others,
        "othersSpecify": othersSpecify,
        "actionFlag": actionFlag,
    };
}

