// To parse this JSON data, do
//
//     final countryResponse = countryResponseFromJson(jsonString);

import 'dart:convert';

CountryResponse countryResponseFromJson(String str) => CountryResponse.fromJson(json.decode(str));

String countryResponseToJson(CountryResponse data) => json.encode(data.toJson());

class CountryResponse {
    int code;
    bool status;
    String message;
    List<CountryDatum> data;

    CountryResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory CountryResponse.fromJson(Map<String, dynamic> json) => CountryResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<CountryDatum>.from(json["data"].map((x) => CountryDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CountryDatum {
    String? countryCode;
    String? countryName;

    CountryDatum({
          this.countryCode,
          this.countryName,
    });

    factory CountryDatum.fromJson(Map<String, dynamic> json) => CountryDatum(
        countryCode: json["countryCode"],
        countryName: json["countryName"],
    );

    Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "countryName": countryName,
    };
}
