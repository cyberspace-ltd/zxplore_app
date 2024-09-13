// To parse this JSON data, do
//
//     final accountSeriesResponse = accountSeriesResponseFromJson(jsonString);

import 'dart:convert';

AccountSeriesResponse accountSeriesResponseFromJson(String str) => AccountSeriesResponse.fromJson(json.decode(str));

String accountSeriesResponseToJson(AccountSeriesResponse data) => json.encode(data.toJson());

class AccountSeriesResponse {
    int code;
    bool status;
    String message;
    List<AccountSeriesDatum> data;

    AccountSeriesResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory AccountSeriesResponse.fromJson(Map<String, dynamic> json) => AccountSeriesResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<AccountSeriesDatum>.from(json["data"].map((x) => AccountSeriesDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AccountSeriesDatum {
    String? accountSeries;
    String? accountSeriesName;

    AccountSeriesDatum({
          this.accountSeries,
          this.accountSeriesName,
    });

    factory AccountSeriesDatum.fromJson(Map<String, dynamic> json) => AccountSeriesDatum(
        accountSeries: json["accountSeries"],
        accountSeriesName: json["accountSeriesName"],
    );

    Map<String, dynamic> toJson() => {
        "accountSeries": accountSeries,
        "accountSeriesName": accountSeriesName,
    };
}
