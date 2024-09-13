// To parse this JSON data, do
//
//     final searchOptionResponse = searchOptionResponseFromJson(jsonString);

import 'dart:convert';

SearchOptionResponse searchOptionResponseFromJson(String str) => SearchOptionResponse.fromJson(json.decode(str));

String searchOptionResponseToJson(SearchOptionResponse data) => json.encode(data.toJson());

class SearchOptionResponse {
    int code;
    bool status;
    String message;
    List<SearchOptionDatum> data;

    SearchOptionResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory SearchOptionResponse.fromJson(Map<String, dynamic> json) => SearchOptionResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<SearchOptionDatum>.from(json["data"].map((x) => SearchOptionDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class SearchOptionDatum {
    String searchOptionValue;
    String searchOptionName;

    SearchOptionDatum({
        required this.searchOptionValue,
        required this.searchOptionName,
    });

    factory SearchOptionDatum.fromJson(Map<String, dynamic> json) => SearchOptionDatum(
        searchOptionValue: json["searchOptionValue"],
        searchOptionName: json["searchOptionName"],
    );

    Map<String, dynamic> toJson() => {
        "searchOptionValue": searchOptionValue,
        "searchOptionName": searchOptionName,
    };
}
