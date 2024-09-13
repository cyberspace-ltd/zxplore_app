// To parse this JSON data, do
//
//     final anticipatedTransactionsResponse = anticipatedTransactionsResponseFromJson(jsonString);

import 'dart:convert';

AnticipatedTransactionsResponse anticipatedTransactionsResponseFromJson(String str) => AnticipatedTransactionsResponse.fromJson(json.decode(str));

String anticipatedTransactionsResponseToJson(AnticipatedTransactionsResponse data) => json.encode(data.toJson());

class AnticipatedTransactionsResponse {
    int code;
    bool status;
    String message;
    List<AnticipatedTransactionsDatum> data;

    AnticipatedTransactionsResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory AnticipatedTransactionsResponse.fromJson(Map<String, dynamic> json) => AnticipatedTransactionsResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<AnticipatedTransactionsDatum>.from(json["data"].map((x) => AnticipatedTransactionsDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AnticipatedTransactionsDatum {
    String transactionValue;
    String transactionName;

    AnticipatedTransactionsDatum({
        required this.transactionValue,
        required this.transactionName,
    });

    factory AnticipatedTransactionsDatum.fromJson(Map<String, dynamic> json) => AnticipatedTransactionsDatum(
        transactionValue: json["transactionValue"],
        transactionName: json["transactionName"],
    );

    Map<String, dynamic> toJson() => {
        "transactionValue": transactionValue,
        "transactionName": transactionName,
    };
}
