// To parse this JSON data, do
//
//     final editFundingSource = editFundingSourceFromJson(json String?);

import 'dart:convert';

EditFundingSource editFundingSourceFromJson( String? str) => EditFundingSource.fromJson(json.decode(str!));

 String? editFundingSourceToJson(EditFundingSource data) => json.encode(data.toJson());

class EditFundingSource {
     int? fundingSourcesId;
     String? requestId;
     int? rowVersion;
     String? itemStage;
     bool? commissions;
     bool? dividends;
     bool? businessIncome;
     bool? personalSavings;
     bool? trustFund;
     bool? salary;
     bool? familyFriends;
     bool? rentalIncome;
     bool? inheritanceGift;
     bool? others;
     String? othersSpecify;
     String? actionFlag;

    EditFundingSource({
          this.fundingSourcesId,
          this.requestId,
          this.rowVersion,
          this.itemStage,
          this.commissions,
          this.dividends,
          this.businessIncome,
          this.personalSavings,
          this.trustFund,
          this.salary,
          this.familyFriends,
          this.rentalIncome,
          this.inheritanceGift,
          this.others,
          this.othersSpecify,
          this.actionFlag,
    });

    factory EditFundingSource.fromJson(Map<String, dynamic> json) => EditFundingSource(
        fundingSourcesId: json["fundingSourcesId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        commissions: json["commissions"],
        dividends: json["dividends"],
        businessIncome: json["businessIncome"],
        personalSavings: json["personalSavings"],
        trustFund: json["trustFund"],
        salary: json["salary"],
        familyFriends: json["familyFriends"],
        rentalIncome: json["rentalIncome"],
        inheritanceGift: json["inheritanceGift"],
        others: json["others"],
        othersSpecify: json["othersSpecify"],
        actionFlag: json["actionFlag"],
    );

    Map< String, dynamic> toJson() => {
        "fundingSourcesId": fundingSourcesId,
        "requestId": requestId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "commissions": commissions,
        "dividends": dividends,
        "businessIncome": businessIncome,
        "personalSavings": personalSavings,
        "trustFund": trustFund,
        "salary": salary,
        "familyFriends": familyFriends,
        "rentalIncome": rentalIncome,
        "inheritanceGift": inheritanceGift,
        "others": others,
        "othersSpecify": othersSpecify,
        "actionFlag": actionFlag,
    };
}
